USE blinkitdb;
GO
SELECT *FROM blinkit_data

SELECT CAST(SUM(Sales) / 1000000 AS decimal(10,2)) AS Totatl_Sales_Millions
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT COUNT(*) AS No_of_Items FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating FROM blinkit_data

SELECT Item_Fat_Content, 
         CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
         CAST(Avg(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         COUNT(*) AS No_of_Items,
         CAST(Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC

SELECT top 5 Item_Type, 
         CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
         CAST(Avg(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         COUNT(*) AS No_of_Items,
         CAST(Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales_Thousands asc

SELECT Outlet_Location_Type, Item_Fat_Content, 
         CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales,
         CAST(Avg(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
         COUNT(*) AS No_of_Items,
         CAST(Avg(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales asc

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat],0) AS Low_Fat,
       ISNULL([Regular],0) AS Regular
FROM
(
  SELECT Outlet_Location_Type, Item_Fat_Content,
         CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
  FROM blinkit_data
  GROUP BY Outlet_Location_Type, Item_Fat_Content
  ) AS SourceTable
PIVOT
(
   SUM(Total_Sales)
   FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
Order By Outlet_Location_Type;
       
SELECT Outlet_Establishment_Year,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
Group By Outlet_Establishment_Year
Order By Total_Sales DESC

SELECT 
     Outlet_Size,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
From blinkit_data
Group By Outlet_Size
Order By Total_Sales DESC;

SELECT Outlet_Location_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
       CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
Group By Outlet_Location_Type
Order By Total_Sales DESC

SELECT Outlet_Type,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
       CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
From blinkit_data
Group By Outlet_Type
Order By Total_Sales DESC