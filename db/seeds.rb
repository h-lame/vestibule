# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

def user(name)
  User.create!(:name => name)
end

def suggestions_for(proposal, suggestions)
  now = Time.now

  suggestions.reverse.each do |(author, body)|
    proposal.suggestions.create :author => author, :body => body, :created_at => now, :updated_at => now
    now -= 30.minutes
  end
end

alice = user("alice")
bob = user("bob")
charlie = user("charlie")
daniel = user("daniel")

a = alice.proposals.create :title => "Fake it till you make it", :description => <<-EOS
I've written a few things recently which work against 3rd party HTTP API's recently. 

In doing so I always run across the issue of how to spec these interactions, how to debug what's being passed back and forth etc... 

In my [rspreedly gem][1] I stub out the HTTP requests on a fairly low level and use fixtures for the XML being passed which I generated by using Martin's [net-http-spy][2]. 

Other options include: 

 * [FakeWeb][3] 
 * Just use the actual service 
 * Build a mock/simulated app to test against 
 * A replaying middleman/proxy like [wiretapper][4] 

Would anyone be interested in a talk where I look into theseissues/options and the pros and cons of the various approaches? 

[1]: http://github.com/rlivsey/rspreedly 
[2]: http://github.com/martinbtt/net-http-spy/ 
[3]: http://fakeweb.rubyforge.org/ 
[4]: http://github.com/joshuabates/wiretapper/
EOS

suggestions_for(a, [
  [daniel, %{+1 from me. I've used FakeWeb extensively, and run into some interesting issues - would like to see the terrain surveyed...}],
  [bob, %{I think this might be most interesting to me with a walk-through example; I know about FakeWeb, or at least that it exists, but I don't tend to reach for it. Maybe if I see how someone builds their tests against in with some concrete examples. 

What do you think?}],
  [alice, %{I've not used FakeWeb myself, so figure it might be a good time to look into it! I was thinking of maybe going through each of the options, showing some real examples of how specs could work for each one and then a bit of compare and contrast to see the benefits of each method?}],
  [charlie, %{+1 

I think there is a lot of good discussion to be had around this and I'd also be interested in hearing thoughts on the different techniques.

My gem is just one tool in the box for this kind of stuff}],
  [daniel, %{I was also struggling with stubbing HTTP requests in one of the projects and I created recently WebMock (http://github.com/bblimke/webmock).
    
I was thinking about giving a lightning talk at Ruby Manor. Here are some features:

* Stubbing requests and verifying expectations of request executions 
* Matching requests based on method, url, headers and body 
* Support for Test::Unit and RSpec (and can be easily extended to other frameworks) 
* Support for Net::Http and other http libraries based on Net::Http 
* Adding other http library adapters is easy}]
])

bob.proposals.create :title => "Breaking stuff with JRuby", :description => <<-EOS
I spend a lot of time prodding odd corners of Ruby, more often than not unsuccessfully. This is immensely good fun and anyone who's endured my Ruby Plumber's Guide will know that the knowledge gained can be useful. 

What I have in mind is a similarly irresponsible exercise involving JRuby, but as time is probably too short to cook up much interesting in the way of slides I'd like to organise a round-table hackathon in which we pool knowledge about ruby-ffi, unix, etc. and see how far we can push JRuby before breaking it. 

Needless to say, this will be purely for recreational purposes :)
EOS

# no suggestions...

c = charlie.proposals.create :title => "The need for and usage of xpath for cucumber steps", :description => <<-EOS
When doing large cucumber suites for website development I find there are often situations where css selectors and/or have_tag matchers just don't cut it. 

The medicine for this are xpaths, but they take a while to wrap your head around and to see how they can be useful. I have a couple of examples from the battlefield that should demonstrate these things. 

Anybody interested in a talk like this?
EOS

suggestions_for(c, [[alice, %{I was actually in the process of debugging some Cucumber steps using XPaths (via HPricot) when your e-mail arrived. So yes, I'd be interested.}]])