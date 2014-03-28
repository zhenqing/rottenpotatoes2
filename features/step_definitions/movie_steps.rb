# Add a declarative step here for populating the DB with movies.

Given /the following movies exist:/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    #assert Movie.exists?(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = Regexp.new(e1+'(.|\n)*'+e2)
  if page.respond_to? :should
    page.body.should have_xpath('//*', :text => regexp)
  else
    assert page.body.has_xpath?('//*', :text => regexp)
  end
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /^(?:|I )check the following ratings:([^"]*)$/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings=rating_list.split(',')
  ratings.each do |rating|
    When I check %Q[#{rating}]
  end
end
When /^(?:|I )uncheck the following ratings:"([^"]*)"$/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings=rating_list.split(',')
  ratings.each do |rating|
    When I uncheck %Q[#{rating}]
  end
end
Then /^I should see all movies$/ do
  # Make sure that all the movies in the app are visible in the table
  rows = 10
  assert rows = Movie.count
end