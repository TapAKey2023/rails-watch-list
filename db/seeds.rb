# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

url = 'http://tmdb.lewagon.com/movie/top_rated'
response= URI.open(url).read
data = JSON.parse(response)
movies_array = data["results"]
img_url = "http://image.tmdb.org/t/p/w500"

movies_array.each do |movie|
  new_movie = Movie.new(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: img_url + movie["poster_path"],
    rating: movie["vote_average"]
  )
  new_movie.save
end

puts "movies done! now for the list"
puts "creating 3 lists"
List.create!(name: "Watchlist")
List.create!(name: "Completed")
List.create!(name: "Upcoming")

puts "all done! roll camera"

# user["results"].each do |movie|
#   movie.create(title: movie["title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/original/#{movie["poster_path"]}", rating: movie["vote_average"])
#   p movie
# end
