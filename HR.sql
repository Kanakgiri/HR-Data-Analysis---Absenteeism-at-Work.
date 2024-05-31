create database work;

-- Create a Join table

SELECT * FROM
    absenteeism_at_work
        JOIN
    compensation ON absenteeism_at_work.ID = compensation.ID
        JOIN
    reasons ON absenteeism_at_work.`Reason for absence` = reasons.number;

-- Find the Healthiest for bonus
select count(ID) as healthy from
(SELECT 
    *
FROM
    absenteeism_at_work
WHERE
    `Social drinker` = 0
        AND `Social smoker` = 0
        AND `Body mass index` < 25
        AND `Absenteeism time in hours` < (SELECT 
            AVG(`Absenteeism time in hours`)
        FROM
            absenteeism_at_work)) as a;

-- compensation rate increase for non-smokers

SELECT 
    COUNT(ID) AS non_smokers
FROM
    absenteeism_at_work
WHERE
    `Social smoker` = 0;

-- Query for Powerbi

SELECT 
    *,
    CASE
        WHEN `Month of absence` IN (12 , 1, 2) THEN 'winter'
        WHEN `Month of absence` IN (3 , 4, 5) THEN 'spring'
        WHEN `Month of absence` IN (6 , 7, 8) THEN 'summer'
        WHEN `Month of absence` IN (9 , 10, 11) THEN 'fall'
        ELSE 'Unknown'
    END AS season_name,
    CASE
        WHEN `Body mass index` < 19 THEN 'Underweight'
        WHEN `Body mass index` BETWEEN 19 AND 25 THEN 'Healthyweight'
        WHEN `Body mass index` BETWEEN 25 AND 30 THEN 'Overweight'
        WHEN `Body mass index` > 30 THEN 'Obese'
        ELSE 'Unknown'
    END AS weight_type
FROM
    absenteeism_at_work
        JOIN
    compensation ON absenteeism_at_work.ID = compensation.ID
        JOIN
    reasons ON absenteeism_at_work.`Reason for absence` = reasons.number;




