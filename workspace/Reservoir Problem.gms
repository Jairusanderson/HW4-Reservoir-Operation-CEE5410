Sets t month /m1*m6/
    l network locations /res "Reservoir", hdpr "Hydropower", irr "Irrigation", spill "Spill", At_a "at a" /;
    

Parameters inflow(t) res inflow (vol)
    /m1 2, m2 2, m3 3, m4 4, m5 3, m6 2/
    hbpr(t) Hydropower ben. ($ per unit)
    /m1 1.6, m2 1.7, m3 1.8, m4 1.9, m5 2.0, m6 2.0/
    Irrb(t) Irrigation ben ($ per unit)
    /m1 1, m2 1.2, m3 1.9, m4 2.0, m5 2.2, m6 2.2/;
    
Table
    Ben (l,t) ben for diffreent location
        m1  m2  m3  m4  m5  m6
hdpr  1.6 1.7 1.8 1.9 2.0 2.0
irr     1  1.2 1.9 2.0 2.2 2.2 ; 
    

Scalars

Hydropower Capacity (volume) /4/
Maxstor Max res storage (vol) /9/
initial Storage Res (vol) /5/
flow req. minimum flow at A (vol) /1/;


Variables
    x(l,t) Diff types of flow or storage in the network at the location 1 at time t
    totalBen Total Benefits ($);
    
Positive Variables x;
Equations
Profit Total Profit ($) and objective function value
lFlow_Const (l,t) Flow Constraints that must be less than or equal to (vol)
gFlow_Const (l,t) Flow constraints that must be greater than or equal to (Vol)
intresMB intial Reservoir Mass balance (Vol)
ResMB(t) Reservoir mass balance for time steps greath than month 1
RiverMB(l,t) River mass balance for all time steps
Sustained The Final Reservoir storage is not less than the intial storage;

 Profit.. totalBen =E= sum( (l,t), x(l,t)*x(l,t));
 lFlow_Const(l,t).. x(l,t) =L= Ben(l,t);
 gFlow_Const(l,t).. x(l,t) =G= Ben(l,t);
 intresMB.. inflow(res,'m1') + Initial - x(spill,m1) - x(hdpr,m1) =E= x(res,m1);
 ResMB(t)$( ORD (t) ge 2).. x(res,t)=E= x(res,t-1) + Flowin(l,t)-x(spill,t)-x(hdpr,t) =E= x(res,t);
 RiverMB(l,t).. x(spill,t) + x(hdpr,t) =E= x(irr,time +x(At_a,t);
 Sustained.. x(res,m6) =G= initial;
 


* 5. DEFINE the MODEL from the EQUATIONS
MODEL Reservoir /ALL/;
* 6. SOLVE the MODEL

SOLVE Reservoir USING LP MAXIMIZING totalBen;