# zepto_inventory_analysis
Developed a SQL-based inventory analytics system using PostgreSQL to clean, transform, and analyze e-commerce product data (3,700+ records). Generated business insights on pricing strategy, discount optimization, and inventory valuation using aggregations, CASE statements, and window functions.

# Zepto Inventory Analysis

**Project Summary:**  
Analyzed Zepto inventory data using SQL and Power BI to extract actionable insights on product pricing, discounts, stock status, and inventory value to support operational and marketing decisions.

## Overview
This project analyzes Zepto’s inventory dataset using PostgreSQL and Power BI. The goal is to understand product-level inventory trends, discount strategies, and stock distribution to support data-driven business decisions.

**Workflow:**
- Data loading and exploration (PostgreSQL)  
- Data cleaning and preprocessing (SQL)  
- SQL-based analysis to extract business insights  
- Interactive dashboard creation (Power BI)  

## Dataset
The dataset **`zepto_inventory_data.csv`** contains product-level inventory information, including:  
- Product details: Name, Category, Weight  
- Pricing: MRP, DiscountPercent, DiscountedSellingPrice  
- Stock information: AvailableQuantity, OutOfStock  
- Quantity metrics: Quantity purchased or default 1  

## Tools & Technologies
- **PostgreSQL** → Data storage and SQL queries for analysis  
- **Power BI** → Interactive dashboards and visualizations  

## Project Workflow

### 1. Data Loading & Cleaning
- Imported the dataset into PostgreSQL.  
- Checked for missing or invalid values and removed products with zero price.  
- Corrected column names for consistency and converted pricing from paise to rupees.  

### 2. Exploratory Data Analysis (EDA)
- Analyzed categories, stock status, and duplicate SKUs.  
- Calculated derived metrics:  
  - Price per gram  
  - Weight-based categories (Low, Medium, Bulk)  
- Examined inventory weight and value distribution across categories.  

### 3. SQL Analysis (`zepto_inventory_analysis.sql`)
Key queries performed:  
- Top 10 products with highest discount percentage  
- High-MRP products that are out of stock  
- Estimated revenue per category  
- Expensive products with low discount  
- Top 5 categories by average discount  
- Price per gram for products above 100g  
- Total inventory weight per category  

### 4. Power BI Dashboard (`zepto_inventory_analysis_dashboard.pbix`)
The dashboard provides an interactive view of inventory and pricing:  

**Key Metrics (Cards):**  
- Total products  
- Total inventory value  
- Total quantity  
- Average discount  

**Visual Insights (Bar Charts):**  
1. Average discount by category  
2. Product weight by category  
3. Inventory value by category  
4. Stock status distribution  

**Filters / Slicers:**  
- Category  
- Stock status  
- MRP range  

## Key Insights & Results
- Certain products offer high discounts, useful for marketing and promotions.  
- Some high-value products are out of stock, representing missed revenue opportunities.  
- Inventory distribution highlights bulky vs low-weight products, aiding warehouse planning.  
- Price-per-gram analysis helps evaluate value-for-money for customers and informs internal pricing strategies.  

## How to Run the Project
1. **PostgreSQL**  
   - Import `zepto_inventory_data.csv` into PostgreSQL.  
   - Run queries from `zepto_inventory_analysis.sql` to create and analyze the inventory table.  

2. **Power BI**  
   - Open `zepto_inventory_analysis_dashboard.pbix` in Power BI Desktop.  
   - Use slicers to filter by category, stock status, or MRP range for interactive analysis.  

## Project Structure

| Folder / Location | File Name | Description |
|------------------|-----------|-------------|
| data | zepto_inventory_data.csv | Raw inventory dataset |
| sql | zepto_inventory_analysis.sql | SQL queries for analysis |
| dashboard | zepto_inventory_analysis_dashboard.pbix | Power BI dashboard |
| root | README.md | Project documentation |

## Conclusion
This project demonstrates an end-to-end inventory data analytics workflow using SQL and Power BI to generate actionable insights on pricing, discounts, stock levels, and inventory value.  

## Credits
- Inspiration for SQL - https://www.youtube.com/watch?v=x8dfQkKTyP0
- Dataset: Kaggle - https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv  
- Tools: PostgreSQL, Power BI


## Credits
- Dataset: Kaggle  
- Tools: PostgreSQL, Power BI
