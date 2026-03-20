

/*
A comparison of CTEs vs table subqueries vs temp tables
*/

-- Temp tables


-- Table subqueries

drop table if exists #patoemtnudate
-- CTEs

SELECT
    ps.AdmittedDate    
  , COUNT(*) AS NumberOfPatientsEachDay
  , SUM(ps.Tariff) AS TotalTariffEachDay
into #pat
FROM PatientStay ps
GROUP BY ps.AdmittedDate

SELECT
    cte.AdmittedDate
    , cte.NumberOfPatientsEachDay
    , cte.TotalTariffEachDay
    , SUM(cte.TotalTariffEachDay) OVER (ORDER BY cte.AdmittedDate) AS RunningTariff
    , SUM(cte.NumberOfPatientsEachDay) OVER (ORDER BY cte.AdmittedDate) AS CumulativePatients
FROM #pat cte
ORDER BY cte.AdmittedDate;





;
WITH
    cte
    AS
    (
        SELECT
            ps.AdmittedDate    
            , COUNT(*) AS NumberOfPatientsEachDay
            , SUM(ps.Tariff) AS TotalTariffEachDay
        FROM PatientStay ps
        GROUP BY ps.AdmittedDate
    )
SELECT
    cte.AdmittedDate
    , cte.NumberOfPatientsEachDay
    , cte.TotalTariffEachDay
    , SUM(cte.TotalTariffEachDay) OVER (ORDER BY cte.AdmittedDate) AS RunningTariff
    , SUM(cte.NumberOfPatientsEachDay) OVER (ORDER BY cte.AdmittedDate) AS CumulativePatients
FROM cte
ORDER BY cte.AdmittedDate;
 
 
 