use Oyo;

-- 1. Querying Data by Using Joins, Subqueries & Subtotals

-- Average Revenue and Total Bookings per Each City
SELECT Oyo_City.city,COUNT(Oyo_Sales.booking_id) AS Total_Bookings,AVG(Oyo_Sales.amount - Oyo_Sales.discount) AS Avg_Revenue
FROM Oyo_Sales
INNER JOIN Oyo_City ON Oyo_Sales.hotel_id = Oyo_City.hotel_id
GROUP BY Oyo_City.city;

-- Highest Room Rate per City
SELECT city,MAX(room_rate) AS Max_Room_Rate
FROM (SELECT Oyo_City.city,(Oyo_Sales.amount - Oyo_Sales.discount) / Oyo_Sales.no_of_rooms AS Room_Rate
FROM Oyo_Sales
INNER JOIN Oyo_City ON Oyo_Sales.hotel_id = Oyo_City.hotel_id) AS RoomRates
GROUP BY city;

-- Bookings Made on the Same Day as Check-in by City
SELECT Oyo_City.city, COUNT(Oyo_Sales.booking_id) AS Same_Day_Bookings
FROM Oyo_Sales
INNER JOIN Oyo_City ON Oyo_Sales.hotel_id = Oyo_City.hotel_id
WHERE DATEDIFF(day, Oyo_Sales.date_of_booking, Oyo_Sales.check_in) = 0
GROUP BY Oyo_City.city;

-- 2. Manipulate Data by Using GROUP BY and HAVING Clause
-- List Of Cities with Over 100 Bookings
SELECT Oyo_City.city,COUNT(Oyo_Sales.booking_id) AS Total_Bookings
FROM Oyo_Sales
INNER JOIN Oyo_City ON Oyo_Sales.hotel_id = Oyo_City.hotel_id
GROUP BY Oyo_City.city
HAVING COUNT(Oyo_Sales.booking_id) > 100;

--Total Revenue Generated for Each Status of Bookings
SELECT status,SUM(amount - discount) AS Total_Revenue
FROM Oyo_Sales
GROUP BY status;

-- Total Number of Bookings Made Each Month
SELECT MONTH(date_of_booking) AS booking_month,COUNT(booking_id) AS Total_Bookings
FROM Oyo_Sales
GROUP BY MONTH(date_of_booking);

-- Average Discount Given for Bookings Exceeding $600 in Amount
SELECT customer_id, AVG(discount) AS Avg_Discount
FROM Oyo_Sales
WHERE amount > 600
GROUP BY customer_id
HAVING AVG(discount) > 100;

-- Count of Bookings for Each Room Quantity for Quantities Greater Than 1
SELECT no_of_rooms, COUNT(booking_id) AS booking_count
FROM Oyo_Sales
GROUP BY no_of_rooms
HAVING no_of_rooms > 1;