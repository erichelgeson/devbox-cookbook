#
# Cookbook Name:: devbox
# Recipe:: default
#
# Copyright 2013, Eric Helgeson
#
include_recipe "apt"
include_recipe "ssh_known_hosts"

# Unix Utils
%w{build-essential git curl unzip bash-completion vim-nox}.each do |pkg|
	package pkg
end

# git config, all the time since i dont care and dont want to manage a template.
execute "git-config" do
	user "vagrant"
	# http://tickets.opscode.com/browse/CHEF-2288
	environment(
      'HOME' => '/home/vagrant'
	)
	command 'git config --global user.email "erichelgeson@gmail.com"; git config --global user.name "Eric Helgeson"; git config --global color.ui true; git config --global core.editor vi'
end

execute "copy-local-ssh-to-vagrant" do
  user "vagrant"
  environment(
      'HOME' => '/home/vagrant'
  )
  command 'cp -r /vagrant/dotssh /home/vagrant/.ssh && chmod 600 /home/vagrant/.ssh/*'
  not_if { File.exists?("/home/vagrant/.ssh") }
end

ssh_known_hosts_entry 'github.com'

# Ruby 1.9
template "/home/vagrant/.gemrc" do
  source "dotgemrc.erb"
  owner  "vagrant"
  group  "vagrant"
end

# Ubuntu 12.04 acutally install 1.9.3 with 1.9.1, weird!
%w{ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 libopenssl-ruby1.9.1 libssl-dev zlib1g-dev libxslt-dev libxml2-dev}.each do |pkg|
	package pkg
end
# Ruby gems
%w{jekyll berkshelf maruku rdiscount rake sass bourbon}.each do |gem|
	gem_package gem
end

# Python
%w{python-dev python-virtualenv python-pip}.each do |pkg|
	package pkg
end

