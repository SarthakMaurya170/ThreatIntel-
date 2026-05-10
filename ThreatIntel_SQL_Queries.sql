CREATE TABLE attack_logs(
	log_id SERIAL PRIMARY KEY,
	attack_time VARCHAR(100) NOT NULL,
	honeypot_host VARCHAR(100),
	attacker_ip BIGINT NOT NULL,
	protocol VARCHAR(20),
	attack_type VARCHAR(50),
	target_port VARCHAR(20),
	country_code VARCHAR(10)
);

SELECT * FROM attack_logs;

--The "Honeypot Hits" (Identify the Top Targets) 
--Let's find out exactly what the attackers are looking for. Hackers scan the internet for specific open ports (like port 22 for SSH, or port 3306 for databases). This query groups the attacks by port and protocol to see what is being targeted the most.

SELECT 
	target_port,
	protocol,
	COUNT(*) AS total_attacks
FROM attack_logs
WHERE target_port IS NOT NULL AND target_port != ''
GROUP BY target_port, protocol
ORDER BY total_attacks DESC
LIMIT 10;


--Threat Actor Origins (Geographic Mapping)
--Where are these attacks coming from? This query acts as a basic threat intelligence feed, counting the volume of attacks originating from specific countries.

SELECT 
    country_code, 
    COUNT(*) AS total_attacks,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM attack_logs)), 2) AS percentage_of_total
FROM attack_logs
WHERE country_code IS NOT NULL AND country_code != ''
GROUP BY country_code
ORDER BY total_attacks DESC
LIMIT 5;


--The Apex Predators (Top Attacker per Country)
--Instead of just finding the country with the most attacks, let's find the single most aggressive IP address within each country.

WITH RankedAttackers AS (
	SELECT
		country_code,
		attacker_ip,
		COUNT(*) AS attack_volume,
		RANK() OVER(PARTITION BY country_code ORDER BY COUNT(*) DESC) as attacker_rank
	FROM attack_logs
	WHERE country_code IS NOT NULL AND country_code !=''
	GROUP BY country_code, attacker_ip
)

SELECT 
	country_code,
	attacker_ip AS top_attacker_ip,
	attack_volume
FROM RankedAttackers
WHERE attacker_rank = 1
ORDER BY attack_volume DESC
LIMIT 10;