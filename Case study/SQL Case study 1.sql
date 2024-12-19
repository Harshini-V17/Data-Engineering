use Oyo;

-- Frequency of Early Bookings Prior to Check-In Date
SELECT DATEDIFF(day, s.date_of_booking, s.check_in) AS Days_Prior, COUNT(s.booking_id) AS Frequency
FROM Oyo_Sales s
GROUP BY DATEDIFF(day, s.date_of_booking, s.check_in)
ORDER BY Days_Prior;

-- Frequency of Bookings by Number of Rooms in Hotel
SELECT s.no_of_rooms, COUNT(s.booking_id) AS Frequency
FROM Oyo_Sales s
GROUP BY s.no_of_rooms
ORDER BY no_of_rooms;

-- Net Revenue to the Company (Considering Cancellations)
SELECT SUM(CASE WHEN status != 'Cancelled' THEN amount - discount ELSE 0 END) AS Net_Revenue
FROM Oyo_Sales;

-- Gross Revenue to the Company
SELECT SUM(amount - discount) AS Gross_Revenue
FROM Oyo_Sales;	
