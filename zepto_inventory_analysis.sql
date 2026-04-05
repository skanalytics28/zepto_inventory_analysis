drop table if exists zepto;
--If you try to run your CREATE TABLE zepto (...) statement and the table already exists, SQL will throw an error.
--Thus its a good practice to write this statement to delete pre existing table in the beginning

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availibileQuantity INTEGER,
discountedSellingPrivce NUMERIC(8,2) ,
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--Data Exploration

--to check is all the rows are imported by counting number 0f rows
SELECT COUNT(*) FROM zepto;

--sample data
SELECT * FROM zepto
LIMIT 10 ;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrivce IS NULL
OR
weightInGms IS NULL
OR
availibileQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--fortunately no null values

ALTER TABLE zepto
RENAME COLUMN discountedSellingPrivce TO discountedSellingPrice ;

ALTER TABLE zepto
RENAME COLUMN availibileQuantity TO availableQuantity  ;

--different product categories 
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

--products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--product names present multiple times
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name 
HAVING count(sku_id) > 1
ORDER BY count(sku_id)DESC;
--Many products having same name occupy a unique row(unique sku - stock keeping unit) due to difference in batch size,category,price,discount,etc. - common in ecommerce platforms to improve product visibility and to offer variety of products
--thus number of total rows = 3732 but number of rows with unique names = 1681

--data cleaning
--checking for products where price is zero (zero is not a null value)
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice=0;
--surprisingly, there is one such product which is not possible so we delete that row
DELETE FROM zepto 
WHERE mrp=0;

--units of mrp
SELECT * FROM zepto
LIMIT 1 ;
--price of 1 kg cannot be 2500 rs thus currency is paise not rupees so we convert it to rupees, 1 rupee =100 paise
UPDATE zepto 
SET mrp=mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM zepto


--Business insights questions
-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
--useful for customers looking for bargains and for businesses to know which products are being heavily promoted (Companies often promote certain products by offering huge discounts)
--some products have more than 50 percent discount


--Q2.What are the Products with High MRP but Out of Stock
--(which is a missed revenue opportunity)
SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;
--companies might want to restock if customers buy these products frequently


--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
--(Expensve products with less discount)
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;
--we can see that these are not premium products and people buy these irrespective of discounts


-- Q5. Identify the top 5 categories offering the highest average discount percentage.
--(useful for marketing teams to understand where price cuts ae happening the most)
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;
--helps customers to compare value for money of products and helps businesses to set internal pricing strategies

--Q7.Group the products into categories like Low, Medium, Bulk.(based on their weight in grams)
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;
--such segmentation helps in packaging, delivery planning and bulk order strategies.

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;
--for warehouse planning and identifying bulky product categories.
