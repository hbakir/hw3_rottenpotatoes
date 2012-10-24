require 'rspec/expectations'

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  if uncheck
    #Movie.all_ratings.each { |rating| check("ratings_#{rating}") }
    rating_list.split(/[\s,]+/).each { |rating| uncheck("ratings_#{rating}") }
  else
    STDOUT.puts "uncheck is FALSE"
    #Movie.all_ratings.each { |rating| uncheck("ratings_#{rating}") }
    rating_list.split(/[\s,]+/).each { |rating| check("ratings_#{rating}") }
  end
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /^(?:|I )should see the following movies: (.*)/ do |movie_list|
  movie_list.split(/[\s,]+/).each { |movie| Then I should see movie }
end

Then /^(?:|I )should not see the following movies: (.*)/ do |movie_list|
  movie_list.split(/[\s,]+/).each { |movie| Then I should see movie }
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end
