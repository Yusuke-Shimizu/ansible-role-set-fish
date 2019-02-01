# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check package
describe package('fish') do
	it { should be_installed }
end

# check plugins
fisher_plugins = [
	"0rax/fish-bd", 
	"jethrokuan/z", 
	"jorgebucaran/fishtape", 
	"oh-my-fish/plugin-peco", 
	"oh-my-fish/plugin-aws",
	"oh-my-fish/plugin-osx",
	"yoshiori/fish-peco_select_ghq_repository"
]
describe command("fish -lc 'fisher ls'") do
	include_context 'check_command'
	fisher_plugins.each{|fisher_plugin_name|
		its('stdout') { should include "#{fisher_plugin_name}" }
	}
end
