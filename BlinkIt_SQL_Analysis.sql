create database BlinkIt;

use BlinkIt;

# View total number of records in blinkit
SELECT COUNT(*) AS total_rows FROM blinkit;

# Inspect the first 5 rows to understand the structure
SELECT * FROM blinkit LIMIT 5;

# Check for missing values in the Item_Weight column
SELECT COUNT(*) AS Missing_Weight_Count 
FROM blinkit 
WHERE Item_Weight IS NULL;

# Identify unique types of items available in the inventory
SELECT DISTINCT Item_Type FROM blinkit ORDER BY Item_Type;

# Check for inconsistent naming in Fat Content (e.g., LF vs Low Fat)
SELECT DISTINCT Item_Fat_Content FROM blinkit;

# Calculate Total Sales Revenue from blinkit
SELECT SUM(Item_Outlet_Sales) AS Total_Revenue FROM blinkit;

# Calculate Average Sales per transaction
SELECT AVG(Item_Outlet_Sales) AS Average_Sales FROM blinkit;

# Find the highest MRP (Maximum Retail Price) among all items
SELECT MAX(Item_MRP) AS Max_Price FROM blinkit;

# Find the Total Sales contributed by 'Low Fat' vs 'Regular' items
SELECT Item_Fat_Content, SUM(Item_Outlet_Sales) AS Total_Sales
FROM blinkit
GROUP BY Item_Fat_Content;

# Identify Top 5 Outlets by Total Sales
SELECT Outlet_Identifier, SUM(Item_Outlet_Sales) AS Outlet_Revenue
FROM blinkit
GROUP BY Outlet_Identifier
ORDER BY Outlet_Revenue DESC
LIMIT 5;

# Compare Performance across different Outlet Sizes (Small, Medium, High)
SELECT Outlet_Size, SUM(Item_Outlet_Sales) AS Sales_By_Size
FROM blinkit
WHERE Outlet_Size IS NOT NULL
GROUP BY Outlet_Size
ORDER BY Sales_By_Size DESC;

# Revenue contribution by Location Tier (Tier 1, Tier 2, etc.)
SELECT Outlet_Location_Type, SUM(Item_Outlet_Sales) AS Revenue_By_Location
FROM blinkit
GROUP BY Outlet_Location_Type;

# Rank items by Sales within their respective Item Categories
SELECT 
    Item_Identifier, 
    Item_Type, 
    Item_Outlet_Sales,
    RANK() OVER (PARTITION BY Item_Type ORDER BY Item_Outlet_Sales DESC) AS Sales_Rank
FROM blinkit;

# Calculate the percentage contribution of each Item_Type to total revenue
SELECT 
    Item_Type, 
    SUM(Item_Outlet_Sales) AS Category_Sales,
    (SUM(Item_Outlet_Sales) / (SELECT SUM(Item_Outlet_Sales) FROM blinkit) * 100) AS Sales_Percentage
FROM blinkit
GROUP BY Item_Type
ORDER BY Sales_Percentage DESC;

# Find items with Visibility higher than the average visibility
SELECT Item_Identifier, Item_Visibility 
FROM blinkit 
WHERE Item_Visibility > (SELECT AVG(Item_Visibility) FROM blinkit);

# Create a View for High-Performance Items (Sales > 2000) for easy reporting
CREATE VIEW Top_Item_Sellers AS
SELECT Item_Identifier, Item_Type, Item_Outlet_Sales
FROM blinkit
WHERE Item_Outlet_Sales > 2000;

# Select from the newly created view
SELECT * FROM Top_Item_Sellers;

# Final summary count of items by Outlet Type
SELECT Outlet_Type, COUNT(*) AS Total_Items
FROM blinkit
GROUP BY Outlet_Type;









