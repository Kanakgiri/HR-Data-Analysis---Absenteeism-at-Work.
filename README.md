# HR Data Analysis - Absenteeism at Work.

## Purposes Of The Project

The primary objective of this project is to identify patterns and factors that contribute to absenteeism at work. By analyzing variables such as reasons for absence, age, education, number of children, number of pets, height, weight, social drinking and smoking habits. Improve workplace policies and practices by incorporating insights from data analysis to foster a healthier, more engaged, and more productive workforce.


![Screenshot 2024-05-20 123155](https://github.com/Kanakgiri/HR-Data-Analysis---Absenteeism-at-Work./assets/171118310/f9806d9a-54d3-43e1-b6ef-a1e19dab745f)


## About Data

Data-set contains 741 rows, 21 columns about employee details such as reasons for absence - code, age, education, number of children, number of pets, height, weight, social drinking and smoking habits this is joined to another data-set containing Reasons for absence details.

## Tools Used

- Microsoft Excel
- Power BI
- MySQL Workbench

## Data Analysis Workflow

- Create a Database
- Develop SQL Queries
- Connect Power BI to Database
- Build a Dashboard in Power BI

## Approach Used

- Feature Engineering: This will help us generate some new columns from existing ones using Power Query.

A column `season_name` using the `month_of_absence` column is added. Another column `weight_type` using `body mass index` is added to identify healthy employees.

Employees who are Not Social Drinker and Smoker, whose BMI is less than 25 and absenteeism at work is less than average absenteeism are identified as healthiest employees.

```
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

```


## SQL Query

```
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

```
