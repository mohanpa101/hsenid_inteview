#!/bin/bash
##SampleLogLines
#192.168.2.20 - - [28/Jul/2006:10:27:10 -0300] "GET /cgi-bin/try/ HTTP/1.0" 404 3395
#127.0.0.1 - - [28/Jul/2006:10:22:04 -0300] "GET / HTTP/1.0" 401 2216

#Getting malicous_ips from apache access log (Default Log Pattern) check sample logs above
cat access.log | grep 401"\|"404 | awk '{print $1}' | sort | uniq -c | awk '{if ($1 > 100)print $2}' >> malicous_ips

while IFS="" read -r p || [ -n "$p" ]
do
   echp "Require not ip $p" >> malicous_ip.conf
done < malicous_ip


#Add  malicous_ips conf file path to apache config as 'Include malicous_ip.conf'
#restart apache
systemctl restart httpd

