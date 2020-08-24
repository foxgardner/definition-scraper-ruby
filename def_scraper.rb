require 'nokogiri' # Gem for Parsing
require 'open-uri' # Wrapper for HTTP

words_file = 'words.txt' # Defines the wordfile. It is called in a handful of places.
word_count = `wc -l "#{words_file}"`.split(' ')[0].to_i # Counts lines (words) in file

puts "Words in Progress:"

word_count.times do |i| # Loops for each word
    
    word = IO.readlines("#{words_file}")[i] # Picks word from file given the line number
    puts word # Prints that word into terminal.

    page = URI.open("https://www.merriam-webster.com/dictionary/#{word.strip}") # Inserts that word into website URL
    parse_page = Nokogiri::HTML(page) # Parses page

    definition = parse_page.css(".dtText").text # Collects the definition on website

    File.write("log.txt", "#{word.strip}: #{definition} \n", mode: "a") # Writes word and definition in log.txt
end

puts "Finished, check log.txt file for words and definitions."