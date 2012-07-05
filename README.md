# gerrit-review-leaderboard
gerrit-review-leaderboard is a simple program to display the current leaderboard of reviewers for a Gerrit Code Review project.
It's meant to be run as a standalone command line application.

# Prerequisites

You need to have *Bundler* installed. If you haven't done this
already, please run
    
    gem install bundler

# Installation and running the application

Install the required gems
     
    bundle install

You may now run the application

    chmod a+x ./gerrit-review-leaderboard.rb
    ./gerrit-review-leaderboard.rb list --host=review --project=path/to/my/project
    
Note that --host and --project are required arguments. For reverse
sorting try this:

   ./gerrit-review-leaderboard.rb list --host=review --project=path/to/my/project --reverse
    
