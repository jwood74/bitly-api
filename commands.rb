def is_bitlink(url)
	link = url[0..13]
	return link.include? "bit.ly"
end

def fix_prefix(url)
	link = url[0..3]
	if link == 'http'
		return url
	else
		return 'http://' + url.to_s
	end
end

def fix_date(epoch)
	return Time.at(epoch).strftime("%d %b %Y %H:%M")
end

def expand(*bitlink)
	#Given a bitly URL or hash (or multiple), returns the target (long) URL.
	urls = ""
	bitlink.each do |u|
		if is_bitlink(u)
			urls << "&shortUrl=#{fix_prefix(u)}"
		end
	end
	link = "https://api-ssl.bitly.com/v3/expand?access_token=#{$token}#{urls}"
	result = open(link).read()
	return JSON.parse(result)
end

def info(*bitlink)
	#used to return the page title for given Bitlink
	urls = ""
	bitlink.each do |u|
		if is_bitlink(u)
			urls << "&shortUrl=#{fix_prefix(u)}"
		end
	end
	link = "https://api-ssl.bitly.com/v3/info?access_token=#{$token}#{urls}&expand_user=true"
	result = open(link).read()
	return JSON.parse(result)
end


def lookup(*url)
	urls = ""
	url.each do |u|
		if !is_bitlink(u)
			urls << "&url=#{fix_prefix(u).to_uri}"
		end
	end
	link = "https://api-ssl.bitly.com/v3/link/lookup?access_token=#{$token}#{urls}"
	result = open(link).read()
	return JSON.parse(result)
end


def shorten (url)
	if !is_bitlink(url)
		link = "https://api-ssl.bitly.com/v3/shorten?access_token=#{$token}&longUrl=#{fix_prefix(url).to_uri}"
		result = open(link).read()
		return JSON.parse(result)
	end
end


def link_edit(url,title = nil,note = nil)
	if is_bitlink(url)
		edit = "edit="
		unless title.nil?
			ttl = "&title=#{title}"
			edit << "title,"
		end
		unless note.nil?
			nt = "&note=#{note}"
			edit << "note,"
		end
		edit = edit[0..-2]

		link = "https://api-ssl.bitly.com/v3/user/link_edit?access_token=#{$token}&link=#{fix_prefix(url)}&#{edit}#{ttl}#{nt}"
		result = open(link).read()
		return JSON.parse(result)
	end	
end

def link_lookup(*url)
	urls = ""
	url.each do |u|
		if is_bitlink(u)
			urls << "&link=#{fix_prefix(u)}"
		elsif !is_bitlink(u)
			urls << "&url=#{fix_prefix(u).to_uri}"
		end
	end
	
	link = "https://api-ssl.bitly.com/v3/user/link_lookup?access_token=#{$token}#{urls}"

	result = open(link).read()
	return JSON.parse(result)
end

def link_save(url,title = nil, note = nil, private = true)
	if !is_bitlink(url)

		unless title.nil?
			ttl = "&title=#{title}"
		end
		unless note.nil?
			nt = "&note=#{note}"
		end

		link = "https://api-ssl.bitly.com/v3/user/link_save?access_token=#{$token}&longUrl=#{fix_prefix(url).to_uri}#{ttl}#{nt}&private=#{private}"
		result = open(link).read()
		return JSON.parse(result)
	end

end

def clicks(bitlink,unit,units,timezone = 10,rollup = false,limit = 100)
	if is_bitlink(bitlink)
		link = "https://api-ssl.bitly.com/v3/link/clicks?access_token=#{$token}&link=#{fix_prefix(bitlink)}&unit=#{unit}&units=#{units}&timezone-#{timezone}&rollup=#{rollup}&limit=#{limit}"
		result = open(link).read()
		return JSON.parse(result)
	end
end

def link_countries(bitlink,unit,units,timezone = 10, limit = 100)
	if is_bitlink(bitlink)
		link = "https://api-ssl.bitly.com/v3/link/countries?access_token=#{$token}&link=#{fix_prefix(bitlink)}&unit=#{unit}&units=#{units}&timezone-#{timezone}&limit=#{limit}"
		puts link
		result = open(link).read()
		return JSON.parse(result)
	end
end