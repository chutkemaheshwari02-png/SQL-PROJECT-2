
CREATE DATABASE CX_193_RIDES_PROJECT;

/*
1.BASIC
1.	Count total rides.
2.	List distinct service types.
3.	Calculate average distance per ride.
4.	Calculate total revenue.
5.	Count rides by payment method.
6.	Retrieve completed rides.
7.	Find longest ride by duration.
8.	Find highest fare ride.
9.	Count rides per date.
10.	Display rides where distance > 30 km.

*/

CREATE DATABASE Rides_Project;


SELECT * FROM Rides_project;


SELECT COUNT(Ride_ID) AS Total_Rides
FROM Rapido_Rides;

SELECT DISTINCT Service_Type
FROM Rapido_Project;


SELECT AVG(Distance_KM) AS Average_Distance
FROM Rapido_Rides;

SELECT SUM(Fare) AS Total_Revenue
FROM Rapido_Rides
WHERE Ride_Status = 'Completed';

SELECT
    Payment_Method,
    COUNT(Ride_ID) AS Total_Rides
FROM Rapido_Rides
GROUP BY Payment_Method;


SELECT *
FROM Rapido_Rides
WHERE Ride_Status = 'Completed';

SELECT *
FROM Rapido_Rides
ORDER BY Duration_Minutes DESC
LIMIT 1;

SELECT *
FROM Rapido_Rides
ORDER BY Fare DESC
LIMIT 1;

SELECT
    Ride_Date,
    COUNT(Ride_ID) AS Total_Rides
FROM Rapido_Rides
GROUP BY Ride_Date
ORDER BY Ride_Date;




/*
INTERMEDIATE

1.	Revenue by service type.
2.	Average fare per km by service.
3.	Rides grouped by hour of day.
4.	Count rides per route.
5.	Rank services by revenue.
6.	Payment method usage per service.
7.	Identify peak demand hours.
8.	Calculate average ride duration by service.
9.	Detect rides with high misc charges.
10.	Create a view for completed rides.
 
 ADVANCED

1.	Create CTE for route profitability.
2.	Window function to rank routes by revenue.
3.	Revenue trend analysis.
4.	Identify high-value customers (proxy by routes).
5.	Materialized view for performance reporting.
*/

SELECT
    Service_Type,
    SUM(Fare) AS Total_Revenue
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Service_Type;

SELECT
    Service_Type,
    AVG(Fare / NULLIF(Distance_KM, 0)) AS Avg_Fare_Per_KM
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Service_Type;

SELECT
    HOUR(Ride_Time) AS Ride_Hour,
    COUNT(*) AS Total_Rides
FROM Rapido_Rides
GROUP BY HOUR(Ride_Time)
ORDER BY Ride_Hour;

SELECT
    Pickup_Location,
    Drop_Location,
    COUNT(*) AS Total_Rides
FROM Rapido_Rides
GROUP BY Pickup_Location, Drop_Location; 

SELECT
    Service_Type,
    SUM(Fare) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Fare) DESC
    ) AS Revenue_Rank
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Service_Type;



SELECT
    HOUR(Ride_Time) AS Peak_Hour,
    COUNT(*) AS Total_Rides
FROM Rapido_Rides
GROUP BY HOUR(Ride_Time)
ORDER BY Total_Rides DESC
LIMIT 5;


SELECT
    Service_Type,
    AVG(Duration_Minutes) AS Avg_Duration
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Service_Type;

SELECT
    Ride_ID,
    Service_Type,
    Fare,
    Misc_Charges
FROM Rapido_Rides
WHERE Misc_Charges > 30;


CREATE VIEW Completed_Rides AS
SELECT *
FROM Rapido_Rides
WHERE Ride_Status = 'Completed';

SELECT * FROM Completed_Rides;


--ADVANCED 

WITH Route_Profit AS
(
    SELECT
        Pickup_Location,
        Drop_Location,
        SUM(Fare) AS Total_Revenue,
        SUM(Misc_Charges) AS Total_Charges
    FROM Rapido_Rides
    WHERE Ride_Status = 'Completed'
    GROUP BY Pickup_Location, Drop_Location
)
SELECT
    Pickup_Location,
    Drop_Location,
    Total_Revenue,
    Total_Charges,
    Total_Revenue - Total_Charges AS Net_Revenue
FROM Route_Profit
ORDER BY Net_Revenue DESC;


SELECT
    Pickup_Location,
    Drop_Location,
    SUM(Fare) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Fare) DESC
    ) AS Route_Rank
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Pickup_Location, Drop_Location;

SELECT
    Ride_Date,
    SUM(Fare) AS Daily_RevenueSELECT
    Customer_ID,
    COUNT(Ride_ID) AS Total_Rides,
    SUM(Fare) AS Customer_Revenue
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Customer_ID
HAVING SUM(Fare) > 300
ORDER BY Customer_Revenue DESC;


CREATE TABLE Ride_Performance AS
SELECT
    Service_Type,
    COUNT(*) AS Total_Rides,
    SUM(Fare) AS Total_Revenue,
    AVG(Fare) AS Average_Fare
FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Service_Type;



FROM Rapido_Rides
WHERE Ride_Status = 'Completed'
GROUP BY Ride_Date
ORDER BY Ride_Date;










