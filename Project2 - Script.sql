							/* Name - DEBASHIS CHOWDHURY | ID No - 3674*/

/* A Seperate Database is created to create the tables mentioned in the questions */
Create Database Project2;


/* 1. Create a table “Station” to store information about weather observation stations: */
Create Table Station
(ID int,
City Char(20),
State Char(2),
Lat_N int,
Long_W int,
Constraint i_pk Primary Key(ID) );


/* 2. Insert the following records into the table: */
Insert Into Station(ID , City, State, Lat_N, Long_W)
Values (13, "Phoenix", "AZ", 33, 112),
	   (44, "Denver", "CO", 40, 105),
       (66, "Caribou", "ME", 47, 68);

       
/* 3. Execute a query to look at table STATION in undefined order. */
Select * From station;


/* 4. Execute a query to select Northern stations (Northern latitude > 39.7).*/
Select * From Station
Where Lat_N > 39.7 ;


/* 5. Create another table, ‘STATS’, to store normalized temperature and precipitation data:*/
Create Table Stats
(ID int,
S_Month int,
Temp_F float,
Rain_I float,
Constraint M_chk Check(S_Month Between 1 and 12),
Constraint T_chk Check(Temp_F Between '-80' and 150),
Constraint R_chk Check(Rain_I Between 0 and 100) );


/* 6. Populate the table STATS with some statistics for January and July: */
Insert Into Stats(ID, S_Month, Temp_F, Rain_I)
Values (13, 1, 57.4, .31),
	   (13, 7, 91.7, 5.15),
       (44, 1, 27.3, .18),
       (44, 7, 74.8, 2.11),
       (66, 1, 6.7, 2.1),
       (66, 7, 65.8,  4.52);
       
       
/* 7. Execute a query to display temperature stats (from STATS table) for each city (from Station table).*/
Select Stats.ID , S_Month, Temp_F, City
From Station,Stats
Where Station.ID = Stats.ID;


/* 8. Execute a query to look at the table STATS, ordered by month and greatest rainfall, with
columns rearranged. It should also show the corresponding cities.*/
Select Stats.ID , S_Month, Rain_I, City
From Station,Stats
Where Station.ID = Stats.ID
Order By Rain_I Desc , S_Month;


/* 9. Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude. */ 
Select Stats.ID, S_Month, City, Lat_N
From Stats,Station
Where Stats.ID = Station.ID
And S_Month = 7
Order By Temp_F Asc;

/* 10. Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.*/
Select Stats.ID, City, Max(Temp_F) as MxTmp, Min(Temp_F) as MnTmp, Round(Avg(Temp_F),2) as AvgTmp
From Stats, Station
Where Stats.ID = Station.ID
Group By City;

/* 11. Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.*/
Select Stats.ID, City, S_Month, Round(((Temp_F - 32)*5/9),2) as Temp_Cel, Round((Rain_I * 2.54),2) as Rain_Cent
From Stats, Station
Where Stats.ID = Station.ID
Order By City;


/* 12. Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.*/
update Stats
Set Rain_I = Rain_I + 0.01;

/* 13. Update Denver's July temperature reading as 74.9 */
Select Stats.ID, City,S_Month, Temp_F
From Stats, Station
Where Stats.ID = Station.ID;
/* Comment : To check the ID of Denver and also to visualise the table before update query*/

Update Stats
Set Temp_F = 74.9
Where ID = 44
And S_Month = 7;


