CREATE DATABASE airlines;
USE airlines;
SHOW TABLES;
-- 1 Display all data
SELECT * FROM maindata;
-- 2 Total Number of Flights
SELECT COUNT(*) AS Total_Flights
FROM maindata;
-- 3 Total Transported Passengers
SELECT SUM(`# Transported Passengers`) AS Total_Passengers
FROM maindata;
DESCRIBE maindata;
-- 4 Total Available Seats
SELECT SUM(`# Available Seats`) AS Total_Available_Seats
FROM maindata;

-- 5 Load Factor (%)
SELECT
ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor
FROM maindata;

-- 6 Load Factor by Year
SELECT
Year,
ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor
FROM maindata
GROUP BY Year
ORDER BY Year;

-- 7  Load Factor by Quarter
SELECT
QUARTER(STR_TO_DATE(CONCAT(Year,'-',`Month (#)`,'-',Day),'%Y-%m-%d')) AS Quarter,
ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor
FROM maindata
GROUP BY Quarter
ORDER BY Quarter;

-- 8 Load Factor by Month
SELECT
`Month (#)` AS Month,
ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor
FROM maindata
GROUP BY `Month (#)`
ORDER BY `Month (#)`;

-- 9 Load Factor by  Carrier
SELECT
`Carrier Name`,
ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor
FROM maindata
GROUP BY `Carrier Name`
ORDER BY Load_Factor DESC;

-- 10 Top 10 Carriers
SELECT
`Carrier Name`,
SUM(`# Transported Passengers`) AS Total_Passengers
FROM maindata
GROUP BY `Carrier Name`
ORDER BY Total_Passengers DESC
LIMIT 10;

-- 11 Top Routes
SELECT
CONCAT(`Origin City`,' - ',`Destination City`) AS Route,
COUNT(*) AS Total_Flights
FROM maindata
GROUP BY Route
ORDER BY Total_Flights DESC
LIMIT 10;

-- 12  Weekend vs Weekday
SELECT
CASE
WHEN DAYOFWEEK(
STR_TO_DATE(CONCAT(Year,'-',`Month (#)`,'-',Day),'%Y-%m-%d')
) IN (1,7)
THEN 'Weekend'
ELSE 'Weekday'
END AS Day_Type,

ROUND(
SUM(`# Transported Passengers`) * 100.0 /
SUM(`# Available Seats`),
2
) AS Load_Factor

FROM maindata
GROUP BY Day_Type;

-- 13 Flights by Distance Group
SELECT
Distance,
COUNT(*) AS Total_Flights
FROM maindata
GROUP BY Distance
ORDER BY Distance;

-- 14  Total Departures Performed
SELECT
SUM(`# Departures Performed`) AS Total_Departures
FROM maindata;

-- 15 Total Air Time
SELECT
SUM(`# Air Time`) AS Total_Air_Time
FROM maindata;
