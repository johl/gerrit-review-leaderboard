#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'thor'

class GerritReviewLeaderboard < Thor
  map "-L" => :list
  desc "list", "Prints leaderboard"
  method_options :project => :string, :project => :required
  method_options :host => :string, :host => :required
  method_options :reverse => false
  def list
    project = options[:project]
    host = options[:host]
    reverse = options[:reverse]
    api_cmd = "ssh -p 29418 #{host} gerrit query --format=JSON project:#{project} --all-approvals --patch-sets"
    objects = `#{api_cmd}`
    reviewers = Hash.new
    objects.split("\n").each do |object|
      o = JSON.parse(object)
      if o.keys.include? 'patchSets' then
        patches = o['patchSets']
        patches.each do |p|
          if p.include? 'approvals' then
            p['approvals'].each do |a|
              if a.keys.include? 'description' then
                k = a['by']['name']
                begin
                  reviewers["#{k}"] = reviewers["#{k}"] + 1
                rescue
                  reviewers["#{k}"] = 1
                end
              end
            end
          end
        end
      end
    end
    if (reverse) then
      reviewers.sort {|a1,a2| a2[1]<=>a1[1]}.reverse.each do |e|
        puts "#{e[1]}: #{e[0]}"
      end
    else
      reviewers.sort {|a1,a2| a2[1]<=>a1[1]}.each do |e|
        puts "#{e[1]}: #{e[0]}"
      end
    end
  end
end

GerritReviewLeaderboard.start
