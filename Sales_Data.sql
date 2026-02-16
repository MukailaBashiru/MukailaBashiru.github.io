SELECT *
FROM [dbo].[Order$]

DELETE FROM [dbo].[Order$]
WHERE [Order Number] IS NULL


SELECT *
FROM [dbo].[Customer$]


SELECT *
FROM [dbo].[Salesman$]



--1	write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.

---Customers are mapped to their respective salesman and return those who live in the same City with their salesman
SELECT S.[Name] AS Salesman, C.[Customer_Name], C.[city]
FROM [dbo].[Customer$] AS C
JOIN [dbo].[Salesman$] AS S
ON C.Salesman_ID = S.Salesman_id
WHERE C.City = S.city


--2	write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

SELECT O.[Order Number], O.[Purchase_Amount], C.[Customer_Name], C.[City]
FROM [dbo].[Order$] AS O
JOIN [dbo].[Customer$] C
ON O.[Customer ID] = C.[Customer_ID]
WHERE O.[Purchase_Amount] BETWEEN 500 AND 2000


--3	write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.

SELECT C.[Customer_Name], C.[city], S.[Name] AS Salesman, S.[commission]
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON C.[Salesman_ID] = S.[Salesman_id]


--4	write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city,
--Salesman, commission.  

SELECT C.[Customer_Name], C.[city], S.[Name] AS Salesman, S.[commission]
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON C.[Salesman_ID] = S.[Salesman_id]
WHERE S.[commission] > 0.12


--5	write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission
--of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission. 

SELECT C.[Customer_Name], C.[city], S.[Name] AS Salesman, S.[city], S.[commission]
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON C.[Salesman_ID] = S.[Salesman_id]
WHERE S.[commission] > 0.12 AND S.[city] != C.[city]


--6	write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission

WITH FOT AS 
(
SELECT O.[Order Number], O.[Order Date], O.[Purchase_Amount], O.[Salesman_id]
	   , C.[Customer_Name], C.[Grade]
FROM [dbo].[Order$] AS O
LEFT JOIN [dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
)
SELECT FOT.[Order Number], FOT.[Order Date], FOT.[Purchase_Amount], FOT.[Customer_Name], FOT.[Grade]
	   , S.[Name] AS Salesman, S.[commission]
FROM FOT
LEFT JOIN [dbo].[Salesman$] AS S
ON FOT.[Salesman_id] = S.[Salesman_id]

--OR

SELECT O.[Order Number], O.[Order Date], O.[Purchase_Amount]
	   , C.[Customer_Name], C.[Grade]
	   , S.[Name] AS Salesman, S.[commission]
FROM [dbo].[Order$] AS O
LEFT JOIN [dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
LEFT JOIN [dbo].[Salesman$] AS S
ON O.[Salesman_id] = S.[Salesman_id]


--7	Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the
--relational rows are returned. 

WITH FOCT AS 
(
SELECT O.[Order Number], O.[Purchase_Amount], O.[Order Date], O.[Customer ID], O.[Salesman_id]
	   , C.[Customer_Name], C.[City] AS [Customer City], C.[Grade]
FROM [dbo].[Order$] AS O
JOIN [dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
)
SELECT FOCT.*
	   , S.[Name] AS Salesman, S.[city] AS [Salesman City], S.[commission]
FROM FOCT
JOIN [dbo].[Salesman$] AS S
ON FOCT.[Salesman_id] = S.[Salesman_id]

--OR

SELECT O.[Order Number], O.[Purchase_Amount], O.[Order Date], O.[Customer ID], O.[Salesman_id]
	   , C.[Customer_Name], C.[City] AS [Customer City], C.[Grade]
	   , S.[Name] AS Salesman, S.[city] AS [Salesman City], S.[commission]
FROM [dbo].[Order$] AS O
JOIN [dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
JOIN [dbo].[Salesman$] AS S
ON O.[Salesman_id] = S.[Salesman_id]


--8	write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.

SELECT C.[Customer_Name], C.[city], C.Grade
	   , S.[Name] AS Salesman, S.city
FROM [dbo].[Customer$] AS C
LEFT JOIN [dbo].[Salesman$] AS S
ON C.[Salesman_ID] = S.[Salesman_id]
ORDER BY C.Customer_ID

--9	write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity.
--The result should be ordered by ascending customer_id.

SELECT C.[Customer_Name], C.[city], C.Grade
	   , S.[Name] AS Salesman, S.city
FROM [dbo].[Customer$] AS C
LEFT JOIN [dbo].[Salesman$] AS S
ON C.[Salesman_ID] = S.[Salesman_id]
WHERE C.Grade < 300
ORDER BY C.Customer_ID

--10	Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order
--according to the order date to determine whether any of the existing customers have placed an order or not.

SELECT C.[Customer_Name], C.[city]
	   , O.[Order Number], O.[Order Date], O.[Purchase_Amount]
FROM [dbo].[Customer$] C
LEFT JOIN [dbo].[Order$] AS O
ON C.[Customer_ID] = O.[Customer ID]
ORDER BY O.[Order Date]


--11	SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission
--to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.

SELECT C.[Customer_Name], C.[City] AS [Customer City]
	   , O.[Order Number], O.[Order Date], O.[Purchase_Amount]
	   , S.[Name] AS Salesman, S.[commission]
FROM [dbo].[Customer$] AS C
LEFT JOIN [dbo].[Order$] AS O
ON O.[Customer ID] = C.[Customer_ID]
LEFT JOIN [dbo].[Salesman$] AS S
ON C.[Salesman_ID] = S.[Salesman_id]


--12	Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers
--or have not yet joined any of the customers.

SELECT S.*
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON  S.[Salesman_id] = C.[Salesman_ID]
ORDER BY S.[Name]


--13	write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.

SELECT S.*
	   , C.[Customer_Name], C.[City] AS [Customer City], C.[Grade]
	   , O.[Order Number], O.[Order Date], O.[Purchase_Amount]
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON  S.[Salesman_id] = C.[Salesman_ID]
LEFT JOIN [dbo].[Order$] AS O
ON C.[Customer_ID] = O.[Customer ID]



--14	Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer.The customer may
--have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.

SELECT DISTINCT S.*
FROM [dbo].[Salesman$] AS S
LEFT JOIN [dbo].[Customer$] AS C
ON  S.[Salesman_id] = C.[Salesman_ID]
LEFT JOIN [dbo].[Order$] AS O
ON C.[Customer_ID] = O.[Customer ID]
WHERE O.[Purchase_Amount] >= 2000 AND C.[Grade] IS NOT NULL



--15	For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list,
--create a report containing the customer name, city, order number, order date, and purchase amount

SELECT C.[Customer_Name], C.[City]
				, O.[Order Number], O.[Order Date], O.[Purchase_Amount]
FROM [dbo].[Customer$] AS C
FULL JOIN [dbo].[Order$] AS O
ON C.[Customer_ID] = O.[Customer ID]


--16	Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list
--who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.

SELECT C.[Customer_Name], C.[City]
				, O.[Order Number], O.[Order Date], O.[Purchase_Amount]
FROM [dbo].[Customer$] AS C
LEFT JOIN [dbo].[Order$] AS O
ON C.[Customer_ID] = O.[Customer ID]
WHERE C.[Grade] IS NOT NULL

UNION

SELECT C.[Customer_Name], C.[City]
				, O.[Order Number], O.[Order Date], O.[Purchase_Amount]
FROM [dbo].[Order$] AS O
LEFT JOIN  [dbo].[Customer$] AS C
ON O.[Customer ID] = C.[Customer_ID]
WHERE C.[Customer_ID] IS NULL



--17	Write a SQL query to combine each row of the salesman table with each row of the customer table.

SELECT *
FROM [dbo].[Salesman$]
CROSS JOIN [dbo].[Customer$]

--18	Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers
--and vice versa for that salesperson who belongs to that city.

SELECT *
FROM [dbo].[Salesman$]
CROSS JOIN [dbo].[Customer$]
WHERE [dbo].[Salesman$].city = [dbo].[Customer$].City


--19	Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer
--and vice versa for those salesmen who belong to a city and customers who require a grade.

SELECT *
FROM [dbo].[Salesman$]
CROSS JOIN [dbo].[Customer$]
WHERE [dbo].[Salesman$].city IS NOT NULL AND [dbo].[Customer$].[Grade] IS NOT NULL


--20	Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa
--for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.

SELECT *
FROM [dbo].[Salesman$]
CROSS JOIN [dbo].[Customer$]
WHERE [dbo].[Salesman$].city != [dbo].[Customer$].City AND [dbo].[Customer$].[Grade] IS NOT NULL

