-- 	1. 	Display snum,sname,city and comm of all salespeople.
    Select snum, sname, city, comm from salespeople;
-- 2.  Display all snum without duplicates from all orders.
	Select distinct snum from orders;
--   3. 	Display names and commissions of all salespeople in london.
	SELECT SNAME, COMM FROM SALESPEOPLE WHERE CITY = 'London';
-- 4. 	All customers with rating of 100.
	Select cname from cust where rating = 100;

	
-- 5. 	Produce orderno, amount and date form all rows in the order table.
	SELECT ONUM, AMT, ODATE FROM ORDERS;

-- 6. 	All customers in San Jose, who have rating more than 200.
	Select cname from cust where rating > 200;
-- 7. 	All customers who were either located in San Jose or had a rating above 200.
	SELECT * FROM CUST WHERE CITY = 'San Jose' OR RATING > 200;

-- 8. 	All orders for more than $1000.
	Select * from orders where amt > 1000;
 -- 9. 	Names and citires of all salespeople in london with commission above 0.10.
	SELECT SNAME, CITY FROM SALESPEOPLE WHERE CITY = 'London' AND COMM > 0.10;


-- 10. 	All customers excluding those with rating <= 100 unless they are located in Rome.
	SELECT * FROM CUST WHERE RATING > 100 OR CITY = 'Rome';

	
-- 11. 	All salespeople either in Barcelona or in london.
	Select sname, city from salespeople where city in ('Barcelona','London');
-- 12. 	All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
	Select sname, comm from salespeople where comm > 0.10 and comm < 0.12;
-- 13. 	All customers with NULL values in city column.
	Select cname from cust where city is null;
-- 14. 	All orders taken on Oct 3Rd   and Oct 4th  1994.
 	Select * from orders where odate in ('1994-10-03','1994-10-04');
-- 15. 	All customers serviced by peel or Motika.
	SELECT * FROM CUST WHERE SNUM IN (1001, 1004);

-- 16. 	All customers whose names begin with a letter from A to B.
	SELECT * FROM CUST WHERE CNAME >= 'A' AND CNAME < 'C';

-- 17. 	All orders except those with 0 or NULL value in amt field.
	Select onum from orders where amt != 0 or amt is not null;
-- 18. 	Count the number of salespeople currently listing orders in the order table.
	Select count(distinct snum) from orders;
-- 19. 	Largest order taken by each salesperson, datewise.
	Select odate, snum, max(amt) from orders group by odate, snum order by odate,snum;
	
	
	
-- 20. 	Largest order taken by each salesperson with order value more than $3000.
	Select odate, snum, max(amt) from orders where amt > 3000 group by odate, snum order by odate,snum;
-- 21. 	Which day had the hightest total amount ordered.
	Select odate, amt, snum, cnum from orders where amt = (select max(amt)  from orders)
-- 22. 	Count all orders for Oct 3rd.
SELECT COUNT(*)  FROM ORDERS WHERE ODATE = ('1994-10-03');


-- 23. 	Count the number of different non NULL city values in customers table.
	Select count(distinct city) from cust;
-- 24. 	Select each customer’s smallest order.
	Select cnum, min(amt) from orders group by cnum;
-- 25. 	First customer in alphabetical order whose name begins with G.
	Select min(cname) from cust where cname like 'G%';
-- 26. 	Get the output like “ For dd/mm/yy there are ___ orders.
	Select date_format(odate, '%d/%m/%y') as Order_Date, concat('For ', date_format(odate, '%d/%m/%y'), ' there are ',  count(*) , ' orders.') as Order_Summary from orders group by odate;

-- 27. 	Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
	Select onum, snum, amt, amt * 0.12 from orders order by snum;
-- 28. 	Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
Select city, max(rating) as Highest_Rating, 
concat('For the city ', city, ', the highest rating is : ', max(rating), '.') 
as Output_Message from cust group by city;

	
	
-- 29. 	Display the totals of orders for each day and place the results in descending order.
	Select odate, count(onum) from orders group by odate order by count(onum);
-- 30. 	All combinations of salespeople and customers who shared a city. (ie same city).
	Select sname, cname from salespeople, cust where salespeople.city = cust.city;
-- 31. 	Name of all customers matched with the salespeople serving them.
	Select cname, sname from cust, salespeople where cust.snum = salespeople.snum;
-- 32. 	List each order number followed by the name of the customer who made the order.
	Select onum, cname from orders, cust where orders.cnum = cust.cnum;
-- 33. 	Names of salesperson and customer for each order after the order number.
	Select onum, sname, cname from orders, cust, salespeople where orders.cnum = cust.cnum and orders.snum = salespeople.snum;
-- 34. 	Produce all customer serviced by salespeople with a commission above 12%.
	Select cname, sname, comm from cust, salespeople where comm > 0.12 and cust.snum = salespeople.snum;
-- 35. 	Calculate the amount of the salesperson’s commission on each order with a rating above 100.
	Select sname, amt * comm from orders, cust, salespeople where rating > 100 and salespeople.snum = cust.snum and salespeople.snum = orders.snum and cust.cnum = orders.cnum
-- 36. 	Find all pairs of customers having the same rating.
	SELECT A.CNAME AS Customer1, B.CNAME AS Customer2, A.RATING FROM CUST A, CUST B WHERE A.RATING = B.RATING AND A.CNUM < B.CNUM;

-- 37. 	Find all pairs of customers having the same rating, each pair coming once only.
	Select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating and a.cnum != b.cnum and a.cnum < b.cnum;
-- 38. 	Policy is to assign three salesperson to each customers. Display all such combinations.
	SELECT C.CNAME AS Customer, S1.SNAME AS Salesperson1, S2.SNAME AS Salesperson2, S3.SNAME AS Salesperson3 FROM CUST C, SALESPEOPLE S1, SALESPEOPLE S2, SALESPEOPLE S3;

	
-- 39. 	Display all customers located in cities where salesman serres has customer.
	SELECT DISTINCT C1.CNAME, C1.CITY FROM CUST C1 WHERE C1.CITY IN ( SELECT DISTINCT C2.CITY FROM CUST C2 JOIN SALESPEOPLE S ON C2.SNUM = S.SNUM WHERE S.SNAME = 'Serres');

-- 40.  	Find all pairs of customers served by single salesperson.
	SELECT c1.cnum AS customer_1, c1.cname AS customer_1_name,c2.cnum AS customer_2, c2.cname AS customer_2_name,c1.snum AS salesperson_id FROM cust c1 JOIN cust c2  ON c1.snum = c2.snum  AND c1.cnum < c2.cnum ORDER BY c1.snum, c1.cnum, c2.cnum;

-- 41. 	Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
	Select a.sname, b.sname from salespeople a, salespeople b where a.snum > b.snum and a.city = b.city;
-- 42. 	Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
	Select c.cname, a.onum, b.onum from orders a, orders b, cust c where a.cnum = b.cnum and  a.onum > b.onum and c.cnum = a.cnum;
-- 43. 	Produce names and cities of all customers with the same rating as Hoffman.
	Select cname, city from cust where rating = (select rating from cust where cname = 'Hoffman') and cname != 'Hoffman';
-- 44. 	Extract all the orders of Motika.
	SELECT o.onum, o.amt, o.odate, o.cnum, c.cname, o.snum, s.sname FROM orders o JOIN salespeople s ON o.snum = s.snum JOIN cust c ON o.cnum = c.cnum WHERE s.sname = 'Motika';

-- 45. 	All orders credited to the same salesperson who services Hoffman.
	SELECT o.onum, o.amt, o.odate, o.cnum, c.cname, o.snum, s.sname
FROM orders o
JOIN salespeople s ON o.snum = s.snum
JOIN cust c ON o.cnum = c.cnum
WHERE o.snum = (SELECT snum FROM cust WHERE cname = 'Hoffman');

-- 46. 	All orders that are greater than the average for Oct 4.
	SELECT onum, amt, odate, cnum, snum
FROM orders
WHERE odate = '1994-10-04' 
AND amt > (SELECT AVG(amt) FROM orders WHERE odate = '1994-10-04');

	
-- 47. 	Find average commission of salespeople in london.
	Select avg(comm) from salespeople where city = 'London';
-- 48. 	Find all orders attributed to salespeople servicing customers in london.
	Select snum, cnum from orders where cnum in (select cnum from cust where city = 'London');
-- 49. 	Extract commissions of all salespeople servicing customers in London.
	Select comm from salespeople where snum in (select snum from cust where city = 'London');
-- 50. 	Find all customers whose cnum is 1000 above the snum of serres.
	Select cnum, cname from cust where cnum > ( select snum+1000  from salespeople where sname = 'Serres');
-- 51. 	Count the customers with rating  above San Jose’s average.
	Select cnum, rating from cust where rating > ( select avg(rating)  from cust where city = 'San Jose');
-- 52.	Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
SELECT o.onum, o.amt, o.odate, o.cnum, c.cname, o.snum FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE c.cname = 'Cisnerous';
-- 53.	Produce the names and rating of all customers who have above average orders.
SELECT DISTINCT c.cname, c.rating FROM cust c JOIN orders o ON c.cnum = o.cnum WHERE o.amt > (SELECT AVG(amt) FROM orders);

-- 54.	Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT o.snum, s.sname, SUM(o.amt) AS total_sales FROM orders o JOIN salespeople s ON o.snum = s.snum GROUP BY o.snum, s.sname HAVING SUM(o.amt) > (SELECT MAX(amt) FROM orders);

-- 55.	Find all customers with order on 3rd Oct.
SELECT DISTINCT c.cnum, c.cname, c.city, c.rating, o.odate FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE o.odate = '1994-10-03';

-- 56.	Find names and numbers of all salesperson who have more than one customer.
SELECT s.snum, s.sname, COUNT(c.cnum) AS customer_count FROM salespeople s JOIN cust c ON s.snum = c.snum GROUP BY s.snum, s.sname HAVING COUNT(c.cnum) > 1;

-- 57.	Check if the correct salesperson was credited with each sale.
SELECT o.onum, o.amt, o.odate, o.cnum, c.cname, o.snum AS credited_snum, c.snum AS actual_snum, s.sname AS credited_sname, s2.sname AS actual_sname FROM orders o JOIN cust c ON o.cnum = c.cnum JOIN salespeople s ON o.snum = s.snum JOIN salespeople s2 ON c.snum = s2.snum WHERE o.snum <> c.snum;


-- 58.	Find all orders with above average amounts for their customers.
SELECT o.onum, o.amt, o.odate, o.cnum, c.cname FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE o.amt > ( SELECT AVG(o2.amt) FROM orders o2 WHERE o2.cnum = o.cnum);

-- 59.	Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT odate, SUM(amt) AS total_amount FROM orders GROUP BY odate HAVING SUM(amt) > (SELECT MAX(amt) FROM orders) + 2000;




-- 60.	Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT CNUM, CNAME FROM CUST C1 WHERE RATING = (SELECT MAX(RATING) FROM CUST C2 WHERE C1.CITY = C2.CITY);

-- 61.	Find all salespeople who have customers in their cities who they don’t service. ( Both way using Join and Correlated subquery.)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY FROM SALESPEOPLE S JOIN CUST C ON S.CITY = C.CITY WHERE S.SNUM <> C.SNUM;

-- 62.	Extract cnum,cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT CNUM, CNAME, CITY  FROM CUST WHERE EXISTS (SELECT 1 FROM CUST WHERE CITY = 'San Jose');

-- 63.	Find salespeople no. who have multiple customers.
SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(CNUM) > 1;

-- 64.	Find salespeople number, name and city who have multiple customers.
SELECT S.SNUM, S.SNAME, S.CITY FROM SALESPEOPLE S JOIN CUST C ON S.SNUM = C.SNUM GROUP BY S.SNUM, S.SNAME, S.CITY HAVING COUNT(C.CNUM) > 1;

-- 65.	Find salespeople who serve only one customer.
SELECT SNUM FROM CUST GROUP BY SNUM HAVING COUNT(CNUM) = 1;


-- 66.	Extract rows of all salespeople with more than one current order.
SELECT S.SNUM, S.SNAME, S.CITY FROM SALESPEOPLE S JOIN ORDERS O ON S.SNUM = O.SNUM GROUP BY S.SNUM, S.SNAME, S.CITY HAVING COUNT(O.ONUM) > 1;


-- 67.	Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE EXISTS (SELECT 1 FROM CUST C WHERE C.SNUM = S.SNUM AND C.RATING = 300);

-- 68.	Find all salespeople who have customers with a rating of 300. (use Join).
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY FROM SALESPEOPLE S JOIN CUST C ON S.SNUM = C.SNUM WHERE C.RATING = 300;

-- 69.	Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE EXISTS ( SELECT 1 FROM CUST C WHERE S.CITY = C.CITY AND S.SNUM <> C.SNUM);

-- 70.	Extract from customers table every customer assigned the a salesperson who currently has at least one other customer ( besides the customer being selected) with orders in order table.
SELECT C.CNUM, C.CNAME, C.CITY, C.SNUM FROM CUST C WHERE EXISTS (SELECT 1 FROM CUST C2 JOIN ORDERS O ON C2.CNUM = O.CNUM WHERE C.SNUM = C2.SNUM AND C.CNUM <> C2.CNUM);

-- 71.	Find salespeople with customers located in their cities ( using both ANY and IN).
SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE CITY = ANY (SELECT CITY FROM CUST)
UNION

SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE CITY IN (SELECT CITY FROM CUST);

-- 72.	Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE SNAME < ANY (SELECT CNAME FROM CUST)

UNION

SELECT SNUM, SNAME, CITY FROM SALESPEOPLE S WHERE EXISTS (SELECT 1 FROM CUST C WHERE S.SNAME < C.CNAME);

-- 73.	Select customers who have a greater rating than any customer in rome.
SELECT CNUM, CNAME, CITY, RATING FROM CUST WHERE RATING > ANY (SELECT RATING FROM CUST WHERE CITY = 'Rome');


-- 74.	Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
SELECT * FROM ORDERS  WHERE AMT > ANY (SELECT AMT FROM ORDERS WHERE ODATE = '1994-10-06');

-- 75.	Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
SELECT * FROM ORDERS WHERE AMT < ANY (SELECT AMT FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'San Jose')

UNION

SELECT * FROM ORDERS WHERE AMT < (SELECT MIN(O.AMT) FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'San Jose');


-- 76.	Select those customers whose ratings are higher than every customer in Paris. ( Using both ALL and NOT EXISTS).
SELECT * FROM CUST WHERE RATING > ALL (SELECT RATING FROM CUST WHERE CITY = 'Paris')
UNION
SELECT * FROM CUST C1 WHERE NOT EXISTS (SELECT 1 FROM CUST C2 WHERE C2.CITY = 'Paris' AND C1.RATING <= C2.RATING);

-- 77.	Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT * FROM CUST WHERE RATING >= ANY (SELECT RATING FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));

-- 78.	Find all salespeople who have no customers located in their city. ( Both using ANY and ALL)
SELECT * FROM SALESPEOPLE WHERE CITY <> ANY (SELECT CITY FROM CUST)

UNION

SELECT * FROM SALESPEOPLE WHERE CITY <> ALL (SELECT CITY FROM CUST);


-- 79.	Find all orders for amounts greater than any for the customers in London.
SELECT * FROM ORDERS WHERE AMT > ANY (SELECT AMT FROM ORDERS O JOIN CUST C ON O.CNUM = C.CNUM WHERE C.CITY = 'London');

-- 80.	Find all salespeople and customers located in london.
SELECT SNUM AS ID, SNAME AS NAME, CITY FROM SALESPEOPLE WHERE CITY = 'London'
UNION
SELECT CNUM AS ID, CNAME AS NAME, CITY FROM CUST WHERE CITY = 'London';

-- 81.	For every salesperson, dates on which highest and lowest orders were brought.
SELECT O.SNUM, (SELECT ODATE FROM ORDERS WHERE SNUM = O.SNUM ORDER BY AMT DESC LIMIT 1) AS HIGHEST_ORDER_DATE,(SELECT ODATE FROM ORDERS WHERE SNUM = O.SNUM ORDER BY AMT ASC LIMIT 1) AS LOWEST_ORDER_DATE FROM ORDERS O GROUP BY O.SNUM;

-- 82.	List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT S.*, CASE WHEN EXISTS (SELECT 1 FROM CUST C WHERE C.CITY = S.CITY) THEN 'Has Customers in City' ELSE 'No Customers in City' END AS CUSTOMER_STATUS FROM SALESPEOPLE S;


-- 83.	Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
SELECT S.SNUM, S.SNAME, S.CITY, CASE WHEN EXISTS (SELECT 1 FROM CUST C WHERE C.CITY = S.CITY) THEN CONCAT(S.SNAME, ' - Matched') ELSE CONCAT(S.SNAME, ' - Not Matched') END AS MATCH_STATUS FROM SALESPEOPLE S;
-- 84.	Create a union of two queries that shows the names, cities and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT CNAME, CITY, RATING, 'High Rating' AS STATUS FROM CUST WHERE RATING >= 200
UNION
SELECT CNAME, CITY, RATING, 'Low Rating' AS STATUS FROM CUST WHERE RATING < 200;

-- 85.	Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT S.SNUM AS ID, S.SNAME AS NAME FROM SALESPEOPLE S
UNION
SELECT C.CNUM AS ID, C.CNAME AS NAME FROM CUST C WHERE C.CNUM IN (SELECT CNUM FROM ORDERS GROUP BY CNUM HAVING COUNT(ONUM) > 1)ORDER BY NAME;

-- 86.	Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries, but eliminates and redundancies between either of them and the first.
SELECT SNUM AS ID FROM SALESPEOPLE WHERE CITY = 'San Jose'
UNION
SELECT CNUM AS ID FROM CUST WHERE CITY = 'San Jose'
UNION ALL
SELECT ONUM AS ID FROM ORDERS WHERE ODATE = '1994-10-03';


-- 87.	Produce all the salesperson in London who had at least one customer there.
SELECT DISTINCT S.* FROM SALESPEOPLE S JOIN CUST C ON S.SNUM = C.SNUM WHERE S.CITY = 'London' AND C.CITY = 'London';

-- 88.	Produce all the salesperson in London who did not have customers there.
SELECT * FROM SALESPEOPLE S WHERE S.CITY = 'London' AND S.SNUM NOT IN (SELECT SNUM FROM CUST WHERE CITY = 'London');

-- 89.	We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (User OUTER join and UNION)

SELECT S.SNUM, S.SNAME, S.CITY AS SALES_CITY, C.CNUM, C.CNAME, C.CITY AS CUSTOMER_CITY FROM SALESPEOPLE S LEFT OUTER JOIN CUST C ON S.SNUM = C.SNUM

UNION

SELECT S.SNUM, S.SNAME, S.CITY AS SALES_CITY, C.CNUM, C.CNAME, C.CITY AS CUSTOMER_CITY FROM SALESPEOPLE S RIGHT OUTER JOIN CUST C ON S.SNUM = C.SNUM;
