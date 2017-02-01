#!/usr/bin/ruby

require 'open-uri'
require 'uri-handler'
require 'json'

require_relative 'commands.rb'
require_relative 'accessToken.rb'

url1 = "http://www.bitly.com"
url2 = "google.com"

link1 = "http://bit.ly/twitter"
link2 = "bit.ly/apple"

#result = expand(link1,link2)
#result = lookup(url1,url2)
#result = link_edit(url,"New Title","A note worth noting on my bitlink")
#result = link_lookup(link1,link2)
#result = link_save(url1,'An appropriate Title','A descriptive description of this link')

#result = clicks(link2,'month',2)
#puts result
#lots = []
#lots = result["data"]["link_clicks"]
#cnt = 0
#lots.each do |l|
#	cnt +=  l["clicks"]
#	puts cnt.to_s + " clicks since " + fix_date(l["dt"]).to_s
#end

result = link