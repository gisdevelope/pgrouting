-------------------------------------------------------------------------------
-- Legacy FUNCTIONs that were ment to be used by 
-- Temporarly while the rewrite of 2.0
-- These FUNCTIONs wer used on the plpgsql functions


-- FILE intended to be used on 3.0
-------------------------------------------------------------------------------

-- I do not know yet if they will create a conflict when putting the legacy

-- Deprecated signature on 2.1.0
CREATE OR REPLACE FUNCTION pgr_dijkstra(
    edges_sql TEXT,
    start_vid INTEGER,
    end_vid INTEGER,
    directed BOOLEAN,
    has_rcost BOOLEAN)
RETURNS SETOF pgr_costresult AS
$BODY$
    SELECT seq-1 , node::integer, edge::integer, cost
    FROM pgr_dijkstra($1, ARRAY[$2]::BIGINT[], ARRAY[$3]::BIGINT[], directed);
$BODY$
LANGUAGE sql VOLATILE
COST 100
ROWS 1000;




-- Deprecated signature on 2.1.0
CREATE OR REPLACE FUNCTION pgr_drivingDistance(edges_sql text, source INTEGER, distance FLOAT8, directed BOOLEAN, has_rcost BOOLEAN)
RETURNS SETOF pgr_costresult AS
$BODY$
    SELECT seq - 1, node::integer, edge::integer, agg_cost
    FROM pgr_drivingDistance($1, ARRAY[$2]::BIGINT[], $3, $4);
$BODY$
LANGUAGE sql VOLATILE
COST 100
ROWS 1000;




-- Deprecated signature on 2.1.0
CREATE OR REPLACE FUNCTION pgr_ksp(edges_sql text, start_vid integer, end_vid integer, k integer, has_rcost boolean)
RETURNS SETOF pgr_costresult3 AS
$BODY$
    SELECT ((row_number() over()) -1)::integer,  (path_id - 1)::integer, node::integer, edge::integer, cost
    FROM _pgr_ksp($1::text, $2, $3, $4, TRUE, FALSE) WHERE path_id <= k;
$BODY$
LANGUAGE sql VOLATILE
COST 100
ROWS 1000



-- Deprecated on 2.2.0
CREATE OR REPLACE FUNCTION pgr_apspJohnson(edges_sql text)
RETURNS SETOF pgr_costResult AS
$BODY$
    SELECT (row_number() over () - 1)::integer, start_vid::integer, end_vid::integer, agg_cost 
    FROM  pgr_johnson($1, TRUE);
$BODY$
LANGUAGE sql VOLATILE
COST 100
ROWS 1000;




-- Deprecated on 2.2.0
CREATE OR REPLACE FUNCTION pgr_apspWarshall(edges_sql text, directed boolean, has_rcost boolean)
    RETURNS SETOF pgr_costResult AS
$BODY$
    SELECT (row_number() over () -1)::integer, start_vid::integer, end_vid::integer, agg_cost
    FROM  pgr_floydWarshall($1, $2);
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100
ROWS 1000;

