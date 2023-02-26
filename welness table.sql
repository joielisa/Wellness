--Lets examine the dailyactivity
SELECT *
FROM wellness_cap..dailyActivity_merged

--there are multiple columns in this table that are not set to the correct data type, so lets change that

ALTER TABLE dailyActivity_merged
ALTER COLUMN 
	ActivityDate date

ALTER TABLE dailyActivity_merged
ALTER COLUMN TotalSteps int

ALTER TABLE dailyActivity_merged
ALTER COLUMN TotalDistance decimal(18,2)

ALTER TABLE dailyActivity_merged
ALTER COLUMN TrackerDistance decimal(18,2)

ALTER TABLE dailyActivity_merged
ALTER COLUMN veryactivedistance decimal(18,2)

ALTER TABLE dailyActivity_merged
ALTER COLUMN moderatelyactivedistance decimal(18,2)

ALTER TABLE dailyActivity_merged
ALTER COLUMN lightactivedistance decimal(18,2)

ALTER TABLE dailyActivity_merged
ALTER COLUMN SedentaryMinutes INT

ALTER TABLE dailyActivity_merged
ALTER COLUMN VeryActiveMinutes INT

ALTER TABLE dailyActivity_merged
ALTER COLUMN FAIRLYActiveMinutes INT

ALTER TABLE dailyActivity_merged
ALTER COLUMN LIGHTLYActiveMinutes INT

ALTER TABLE DAILYACTIVITY_MERGED
ALTER COLUMN Calories INT
;

--confirmed data types are corrected

SELECT *
FROM wellness_cap..dailyActivity_merged

--determined the average steps, calories for each user over the 31 day period

SELECT Id,   AVG(totalsteps) as averagesteps, AVG(calories) AS avgcals
FROM wellness_cap..dailyActivity_merged
GROUP by Id

--let's see where the tracker and total distance are NOT the same

SELECT DISTINCT(Id)
FROM wellness_cap..dailyActivity_merged
WHERE TotalDistance != TrackerDistance
--FOUND 2 IDS THAT REFLECT DIFFERENCES

--SELECT id,TotalDistance, TrackerDistance, VeryActiveDistance+ModeratelyActiveDistance+LightActiveDistance as sumdistance
--FROM wellness_cap..dailyActivity_merged

--pull columns we want to look at in table
SELECT id, ActivityDate, TotalSteps, VeryActiveMinutes+FairlyActiveMinutes+FairlyActiveMinutes as activemins, Calories
FROM wellness_cap..dailyActivity_merged

--look at sleep table

SELECT count(distinct Id)
FROM wellness_cap..sleepDay_merged
--24 unique ids

SELECT count(distinct Id)
FROM wellness_cap..dailyActivity_merged
--33 unique ids

SELECT count(distinct Id)
FROM wellness_cap..heartrate_seconds_merged
--14 ids

--lets  make a table
DROP TABLE IF EXISTS  #activity
CREATE TABLE #activity (
id varchar(50),
date date,
steps int,
activemins int,
calories int
)
select *
from #activity

--put info into table
INSERT INTO #activity 

SELECT Id, ActivityDate, TotalSteps, VeryActiveMinutes+FairlyActiveMinutes+FairlyActiveMinutes as 
activemins, 
Calories
FROM wellness_cap..dailyActivity_merged 

select *
from #activity

--join my tables
SELECT *
FROM #activity act
LEFT JOIN wellness_cap..sleepDay_merged sleep ON
act.id = sleep.Id 


SELECT *
FROM wellness_cap..sleepDay_merged

ALTER TABLE sleepDay_merged
ALTER COLUMN TotalSleepRecords int


SELECT *
FROM wellness_cap..sleepDay_merged

SELECT count(distinct Id)
FROM wellness_cap..dailyActivity_merged