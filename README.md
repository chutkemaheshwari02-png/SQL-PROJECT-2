# SQL-PROJECT-2
Analysis using the SQL

THIS DATA BASE CONSIST  RAPIDO_RIDES (SERVICE SECTOR ;

SELECT
    Pickup_Location,
    Drop_Location,
    COUNT(*) AS Total_Rides
FROM Rapido_Rides
GROUP BY Pickup_Location, Drop_Location;
