1.
SELECT burner.burn_sn, kind_burner.kind_id, burner.burn_ver, burner.burn_date_prod  
From burner, kind_burner
WHERE burner.kind_id = kind_burner.kind_id and kind_name = 'FiredNow';

BURN_SN,KIND_ID,BURN_VER,BURN_DATE_PROD
1010-12SN,1,V1,01/01/2022
1010-13SN,1,V1,01/10/2022
1010-14SN,1,V2,01/20/2022


2.
SELECT burner.burn_sn, registration.reg_data FROM burner, registration
WHERE  burner.burn_sn = registration.burn_sn AND 
to_number(to_char(reg_data,'MM')) = 6 AND to_number(to_char(reg_data,'YYYY')) = 2022 ;

BURN_SN,REG_DATA
3010-18SN,06/08/2022
3010-19SN,06/09/2022

3.
SELECT cust_name, cust_email FROM customer
WHERE cust_email IS NULL
ORDER BY cust_email DESC;

CUST_NAME,CUST_EMAIL
Yelena Prekrasnaja,
Maria Bolkonskaya,

4.
SELECT AVG(rep_cost) AS "AVG costB" FROM RepairB;

AVG costB
127.775

5.
SELECT kind_name , COUNT(*) AS "COUNT" FROM burner
LEFT JOIN kind_burner
ON burner.kind_id = kind_burner.kind_id
GROUP BY kind_name;

KIND_NAME,COUNT
FiredAlways,3
FiredAtCamp,3
FiredNow,3

6.
SELECT cust_name, cust_email FROM customer 
WHERE  cust_id in ( SELECT cust_id FROM RepairB WHERE rep_cost < 10)

no data found (Нет людей, для которых производился ремонт горелки на сумму менее 10 евро.)

7.
SELECT customer.cust_name, customer.cust_email FROM customer , RepairB  
WHERE  customer.cust_id = RepairB.cust_id and rep_cost < 10

no data found (Нет людей, для которых производился ремонт горелки на сумму менее 10 евро.)

8.
SELECT customer.cust_name, customer.cust_email FROM customer, registration, burner, kind_burner
      WHERE customer.cust_id = registration.cust_id and 
      registration.burn_sn = burner.burn_sn and
      burner.kind_id = kind_burner.kind_id and kind_name = 'FiredNow';

      CUST_NAME,CUST_EMAIL
Dmitri Rzevski,dmitri@gmail.com
Natasha Rostova,natasha@gmail.com
Pierre Bezukhov,pierre@gmail.com

9.
create view burner_view as
SELECT b.BURN_SN, b.BURN_VER, b.BURN_DATE_PROD, kb.KIND_NAME, reg.REG_DATA,
r.INVOICE_ID, r.REP_DATE, r.REP_DESC, r.REP_COST,
d.CUST_ID, d.CUST_NAME, d.CUST_TELL, d.CUST_EMAIL
FROM burner b
  LEFT JOIN kind_burner kb
  ON b.KIND_ID = kb.KIND_ID  
    LEFT JOIN registration reg
    ON b.BURN_SN = reg.BURN_SN  
        LEFT JOIN repairB r
        ON reg.BURN_SN = r.BURN_SN 
            LEFT JOIN customer d
            ON reg.CUST_ID = d.CUST_ID ;

            View created.

10.
SELECT * FROM burner_view
WHERE BURN_SN > '3010-18SN' ;

BURN_SN,BURN_VER,BURN_DATE_PROD,KIND_NAME,REG_DATA,INVOICE_ID,REP_DATE,REP_DESC,REP_COST,CUST_ID,CUST_NAME,CUST_TELL,CUST_EMAIL
3010-19SN,V3,03/14/2022,FiredAtCamp,06/09/2022,,,,,19,Vasilisa Mudraja,37211052911,vasilisa@mail.ru
4010-20SN,V4,03/20/2022,FiredAtCamp,,,,,,,,,

SELECT * FROM burner_view
WHERE BURN_SN > '2010-15SN' ;

BURN_SN,BURN_VER,BURN_DATE_PROD,KIND_NAME,REG_DATA,INVOICE_ID,REP_DATE,REP_DESC,REP_COST,CUST_ID,CUST_NAME,CUST_TELL,CUST_EMAIL
2010-16SN,V3,02/10/2022,FiredAlways,04/07/2022,,,,,16,Maria Bolkonskaya,37222187133,
2010-17SN,V1,02/11/2022,FiredAlways,04/21/2022,,,,,17,Nikolai Rostov,37221082033,nik@gmail.com
3010-18SN,V1,03/04/2022,FiredAtCamp,06/08/2022,,,,,18,Yelena Prekrasnaja,37221182133,
3010-19SN,V3,03/14/2022,FiredAtCamp,06/09/2022,,,,,19,Vasilisa Mudraja,37211052911,vasilisa@mail.ru
4010-20SN,V4,03/20/2022,FiredAtCamp,,,,,,,,,

