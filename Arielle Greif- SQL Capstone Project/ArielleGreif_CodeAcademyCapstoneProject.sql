--Arielle Greif Code Academy Capstone Project--
--First and Last Touch Attribution Option--

-- Count number of campaigns --
SELECT COUNT (DISTINCT utm_campaign)
FROM page_visit
;


--Count number of sources --
SELECT COUNT (DISTINCT utm_sources)
FROM page_visits
;

--Select the campaigns and sources that are used in the schema page_visits--
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits
;

-- The pages on the CoolTShirt website --
SELECT DISTINCT page_name
FROM page_visits
;

-- How many first touches is each campaign responsible for?--
WITH first_touch AS
(
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id
)
SELECT pv.utm_campaign,
    COUNT(ft.first_touch_at)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
;

-- How many last touches is each campaign responsible for?--
WITH last_touch AS
(
    SELECT user_id,
       MAX(timestamp) as last_touch_at
       FROM page_visits
       GROUP BY user_id
)
SELECT pv.utm_campaign,
     COUNT(lst.last_touch_at)
FROM last_touch lst
JOIN page_visits pv
     ON lst.user_id = pv.user_id
     AND lst.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
;

-- How many visitors make a purchase?--
SELECT COUNT(*)
FROM page_visits
WHERE page_name = '4 - purchase'
;

--How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS
(
    SELECT user_id,
       MAX(timestamp) as last_touch_at
       FROM page_visits
       WHERE page_name = '4 - purchase'
       GROUP BY user_id
)
SELECT pv.utm_campaign,
     COUNT(lst.last_touch_at)
FROM last_touch lst
JOIN page_visits pv
     ON lst.user_id = pv.user_id
     AND lst.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
;
