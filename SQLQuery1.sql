
UPDATE dbo.Sales_Expenses
SET SalesAmount = 0
WHERE SalesAmount < 0;


DELETE FROM dbo.Sales_Expenses
WHERE Date IS NULL;


SELECT 
    SE.TransactionID,
    SE.Date,
    SE.Product,
    SE.SalesAmount,
    SE.ExpenseAmount,
    (SE.SalesAmount - SE.ExpenseAmount) AS NetProfit
FROM dbo.Sales_Expenses AS SE;


SELECT 
    C.CustomerName, 
    SUM(SE.SalesAmount) AS TotalSpent, 
    AVG(C.CustomerRating) AS AvgCustomerRating 
FROM [dbo].[Customers(1)] AS C
INNER JOIN [dbo].[Sales_Expenses] AS SE ON C.CustomerID = SE.CustomerID
GROUP BY C.CustomerName, C.CustomerID
ORDER BY TotalSpent DESC;



SELECT * FROM [dbo].[Customers(1)]

SELECT * FROM[dbo].[Employees(2)]

SELECT * FROM[dbo].[Inventory(1)]

SELECT * FROM[dbo].[Sales_Expenses]

SELECT * FROM[dbo].[Shipments]


SELECT 
    I.Product, 
    SUM(SE.SalesAmount) AS TotalSales, 
    I.StockQty 
FROM [dbo].[Sales_Expenses] AS SE
JOIN [dbo].[Inventory(1)] AS I ON SE.Product = I.Product
GROUP BY I.Product, I.StockQty
ORDER BY TotalSales DESC;


SELECT 
    ShippingMethod, 
    SUM(ShipmentCost) AS TotalShippingCost,
    AVG(DeliveryDays) AS AvgDeliveryDays
FROM [dbo].[Shipments]
GROUP BY ShippingMethod;


SELECT 
    Branch, 
    EmployeeName, 
    Salary, 
    PerformanceScore 
FROM [dbo].[Employees(2)]
ORDER BY PerformanceScore DESC, Salary DESC;


SELECT 
    Product, 
    StockQty, 
    StrategicStock, 
    (StrategicStock - StockQty) AS StockGap
FROM [dbo].[Inventory(1)]
WHERE StockQty < StrategicStock
ORDER BY StockGap DESC;

SELECT 
    SE.CustomerID, 
    SUM(SE.SalesAmount) AS TotalSales, 
    SUM(S.ShipmentCost) AS TotalShippingCost
FROM [dbo].[Sales_Expenses] AS SE
INNER JOIN [dbo].[Shipments] AS S ON SE.CustomerID = S.CustomerID
GROUP BY SE.CustomerID
ORDER BY TotalSales DESC;


SELECT 
    C.CustomerName,
    SUM(SE.SalesAmount) AS TotalPurchases,
    SUM(S.ShipmentCost) AS TotalShippingCosts,
    AVG(C.CustomerRating) AS AvgRating
FROM [dbo].[Customers(1)] AS C
JOIN [dbo].[Sales_Expenses] AS SE ON C.CustomerID = SE.CustomerID
JOIN [dbo].[Shipments] AS S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalPurchases DESC;




SELECT 
    E.Branch,
    E.EmployeeName,
    SUM(SE.SalesAmount) AS SalesGenerated
FROM [dbo].[Employees(2)] AS E
JOIN [dbo].[Sales_Expenses] AS SE ON E.Branch = 'Riyadh' -- 
GROUP BY E.Branch, E.EmployeeName
ORDER BY SalesGenerated DESC;



SELECT DISTINCT SE.Product
FROM [dbo].[Sales_Expenses] AS SE
LEFT JOIN [dbo].[Inventory(1)] AS I ON SE.Product = I.Product
WHERE I.Product IS NULL;



SELECT 
    C.CustomerName,
    SUM(SE.SalesAmount) AS TotalPurchases,
    SUM(S.ShipmentCost) AS TotalShippingCosts,
    AVG(C.CustomerRating) AS AvgRating
FROM [dbo].[Customers(1)] AS C
JOIN [dbo].[Sales_Expenses] AS SE ON C.CustomerID = SE.CustomerID
JOIN [dbo].[Shipments] AS S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalPurchases DESC;



SELECT 
    E.Branch,
    E.EmployeeName,
    SUM(SE.SalesAmount) AS SalesGenerated
FROM [dbo].[Employees(2)] AS E
JOIN [dbo].[Sales_Expenses] AS SE ON E.Branch = 'Riyadh' -- 
ORDER BY SalesGenerated DESC;



SELECT DISTINCT SE.Product
FROM [dbo].[Sales_Expenses] AS SE
LEFT JOIN [dbo].[Inventory(1)] AS I ON SE.Product = I.Product
WHERE I.Product IS NULL;


SELECT DISTINCT SE.Product
FROM [dbo].[Sales_Expenses] AS SE
LEFT JOIN [dbo].[Inventory(1)] AS I ON SE.Product = I.Product
WHERE I.Product IS NULL;



SELECT 
    ShippingMethod,
    AVG(DeliveryDays) AS AverageDeliveryDays,
    MAX(DeliveryDays) AS MaxDeliveryDays,
    MIN(DeliveryDays) AS MinDeliveryDays
FROM [dbo].[Shipments]
GROUP BY ShippingMethod;



SELECT 
    Department,
    EmployeeName,
    PerformanceScore
FROM [dbo].[Employees(2)]
WHERE PerformanceScore > 4.0 -- 
ORDER BY PerformanceScore DESC;



SELECT 
    Product,
    Warehouse,
    StockQty,
    UnitCost,
    (StockQty * UnitCost) AS InventoryValue
FROM [dbo].[Inventory(1)]
ORDER BY InventoryValue DESC;




CREATE VIEW vw_SalesAnalysis AS
SELECT 
    SE.*,
    (SE.SalesAmount - SE.ExpenseAmount) AS NetProfit
FROM [dbo].[Sales_Expenses] AS SE;
GO

CREATE VIEW vw_CustomerReport AS
SELECT 
    C.CustomerID,
    C.CustomerName,
    C.City,
    C.Industry,
    C.CustomerRating,
    SUM(SE.SalesAmount) OVER(PARTITION BY C.CustomerID) AS TotalSpentByCustomer
FROM [dbo].[Customers(1)] AS C
LEFT JOIN [dbo].[Sales_Expenses] AS SE ON C.CustomerID = SE.CustomerID;
GO


CREATE VIEW vw_InventoryValue AS
SELECT 
    *,
    (StockQty * UnitCost) AS InventoryValue
FROM [dbo].[Inventory(1)];
GO

































