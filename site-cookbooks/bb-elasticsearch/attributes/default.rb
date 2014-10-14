default[:elasticsearch][:http_auth] = false
default[:elasticsearch][:http_auth_plugin] = 'https://github.com/Asquera/elasticsearch-http-basic/releases/download/1.3.2/elasticsearch-http-basic-1.3.2.jar'

if node[:elasticsearch][:http_auth]
  default[:elasticsearch][:custom_config][:basic_auth] = true
  default[:elasticsearch][:custom_config][:user] = node[:elasticsearch][:basic_auth][:user]
  default[:elasticsearch][:custom_config][:password] = node[:elasticsearch][:basic_auth][:password]
end

normal[:java][:install_flavor] = 'openjdk'
normal[:java][:jdk_version] = '7'