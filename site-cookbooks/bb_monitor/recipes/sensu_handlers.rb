%w[
  flowdock
  redphone
].each do |package|
  gem_package package do
    action :install
  end
end

%w[
  flowdock.rb
  pagerduty.rb
].each do |handler|
  cookbook_file ::File.join(node.sensu.directory, "handlers", handler) do
    source "sensu_handlers/#{handler}"
    mode 0755
  end
end

sensu_handler "graphite" do
  type "tcp"
  socket({
    :host => node['graphite']['host'],
    :port => 2003
  })
  mutator "graphite"
end


unless node[:bb_monitor][:sensu][:pagerduty_api].empty?
  sensu_snippet "pagerduty" do
    content({
      :api_key =>  node[:bb_monitor][:sensu][:pagerduty_api]
    })
  end

  sensu_handler "pagerduty" do
    type "pipe"
    command "pagerduty.rb"
    severities ["ok", "critical", "warning"]
  end
end
