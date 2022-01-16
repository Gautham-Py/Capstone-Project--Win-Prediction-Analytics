create table Win_analytic (
 		Client_Category  varchar(100),
	    Solution_Type    varchar(100),
		Sector 			 varchar(100),
		Location 		 varchar(100),
	    Deal_Status_Code int,
	    Log_Deal_Cost		 decimal,
		Vp_Manager       varchar(200));

select * from win_analytic;

/* Total_Deals  done by pair */

select vp_manager, count(deal_status_code) as Total_Deals from win_analytic
group by vp_manager
order by Total_Deals desc;

/* Table1 */
Create Table Table1
as (select vp_manager, count(deal_status_code) as Total_Deals from win_analytic
    group by vp_manager
    order by Total_Deals desc);


/* Total_Deals  Won by pair */

select vp_manager, count(deal_status_code) as Total_Wins from win_analytic
where deal_status_code = 1
group by vp_manager
order by Total_Wins desc;

/* Table2 */
Create Table Table2
as (select vp_manager, count(deal_status_code) as Total_Wins from win_analytic
    where deal_status_code = 1
    group by vp_manager
    order by Total_Wins desc);
	
	
/* inner join */

select table1.vp_manager, total_deals, table2.total_wins from table1
inner join table2
on table1.vp_manager = table2.vp_manager
order by Total_deals desc;

/* Table3 */	
Create Table Table3
as (select table1.vp_manager, total_deals, table2.total_wins from table1
    inner join table2
    on table1.vp_manager = table2.vp_manager
    order by Total_deals desc);	
	
/*Drop 1 & 2 */

select * from table3;

/* Add win_percent column */
alter table table3
add column win_percent float;

/* calculate win% */
update table3
set win_percent = (100.0 * (total_wins+0.0 )/(total_deals+0.0) ) ;

/* Add Consistency column */
alter table table3
add column Consistency float;

/* Calculate Consistency( total won bids = 3755) */
update table3
set Consistency = (total_wins+0.0)/ 3755;										

/* Add Efficiency column */
alter table table3
add column Efficiency float;

/* Calculate Efficiency */
update table3
set Efficiency = win_percent * Consistency;

/* Top 5 Reccomendation */

select * from table3
order by efficiency desc
limit 5;

										
										
										