#!/usr/bin/env ruby-local-exec
# important to have .ruby-version in folder with version which has terminal-notifier installed

require('terminal-notifier')
VERSION_FILE = File.join(File.dirname(__FILE__), "/rails_version")
PATH = File.dirname(__FILE__)
value = %x( gem search ^rails$ )
pre = %x( gem search '^rails$' --pre )
new_pre = (/(?<=\()(.*?)(?=\))/.match(pre)).to_s.split(', ').first
new_version = /\d+\.\d+\.\d+/.match(value).to_s
current = File.read(VERSION_FILE).split("\n")
current_version, current_pre = current.first, current.last
unless current_version == new_version && current_pre == new_pre
  version = (current_version != new_version) ? new_version : new_pre
  TerminalNotifier.notify("Yay! New version #{version} available. 🎉💰", title: 'Rails', appIcon: PATH + '/rails.png', contentImage: PATH + '/ruby.png', sound: 'default', open: 'https://rubygems.org/gems/rails')
  File.write(VERSION_FILE, "#{new_version}\n#{new_pre}")
end

exit 0
