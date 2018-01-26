drop table Matrixm;
drop table Matrixn;
drop table resultantmatrix;

create table Matrixm
( rw int,
  col int,
  value double
)
row format delimited fields terminated by ',' stored as textfile;

create table Matrixn
( rw int,
  col int,
  value double
) 
row format delimited fields terminated by ',' stored as textfile;
load data local inpath '${hiveconf:M}' overwrite into table Matrixm;
load data local inpath '${hiveconf:N}' overwrite into table Matrixn;

create table resultantmatrix
(  rw int,
   col int,
   resvalue double   
);
INSERT INTO table resultantmatrix
SELECT mm.rw,mn.col,SUM(mm.value * mn.value) as resmatrix
FROM Matrixm as mm 
JOIN Matrixn as mn
ON mm.col=mn.rw
GROUP BY mm.rw,mn.col;
SELECT count(*),AVG(resvalue)
FROM resultantmatrix;

