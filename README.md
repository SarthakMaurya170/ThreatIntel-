Cyber Threat Intelligence SOC 🛡️

##  Objective
The goal of this project was to ingest, clean, and analyze over 450,000 raw network attack logs to identify geographic threat origins, target port vulnerabilities, and botnet attack velocities. 

##  Tech Stack Used
* **Python (Pandas & Jupyter):** Extracted raw CSV logs, sanitized IP strings, and handled missing values.
* **PostgreSQL:** Engineered the database schema and utilized advanced SQL (CTEs, Window Functions, Subqueries) to extract threat intelligence.
* **Power BI:** Built a dark-themed Security Operations Center (SOC) dashboard utilizing DAX measures to visualize global threat actors.



## Key SQL Insights Extracted
1. **The Apex Predators:** Used `RANK() OVER(PARTITION BY...)` window functions to isolate the single most aggressive IP address originating from each country.
2. **Botnet Velocity:** Calculated the exact timestamp differences between sequential attacks from identical IPs to differentiate between manual hacking attempts and automated botnet scripts.
3. **Vulnerability Mapping:** Identified that legacy Telnet (Port 23) and SSH (Port 22) accounted for the overwhelming majority of brute-force attempts.

## Dataset
The raw data was sourced from the AWS Honeypot Attack Data logs available on Kaggle.
