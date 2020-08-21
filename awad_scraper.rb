require 'nokogiri' # Gem for Parsing
require 'open-uri' # Wrapper for HTTP


words_file = 'words.txt' # Opens words file
word_count = `wc -l "#{words_file}"`.split(' ')[0].to_i # Counts lines (words) in file

puts "Words in Progress:"

# Loops for each word
word_count.times do |i|
    
    word = IO.readlines("#{words_file}")[i] # Picks word from file given the line number
    puts word # Prints word into terminal.

    page = URI.open("https://www.dictionary.com/browse/#{word.strip}") # Inserts word into website URL
    parse_page = Nokogiri::HTML(page) # Parses page

    definition = parse_page.css(".e1q3nk1v4").text # Collects the definition on website

    File.write("log.txt", "#{word.strip}: #{definition} \n", mode: "a") # Writes word and definition in log.txt
end

puts "Finished, check log.txt file for words and definitions."