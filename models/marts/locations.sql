with

locations as (

    select * from {{ ref('jaffle_shop_mesh_platform', 'stg_locations') }}

)

select * from locations