require 'open-uri'
require 'json'
require 'timeout'


class ConnectionTest
  $services_link = ("[{'id':'1','platform':'Plataforma Suporte','url':'http://sysrad.com.br/online/'},{'id':'2','platform':'Painel Mobile','url':'http://sysrad.com.br/painelmobile/'},{'id':'3','platform':'YMWebDocuments','url':'http://sysrad.com.br/'},{'id':'4','platform':'Avaliação Suporte','url':'http://sysrad.com.br/'},{'id':'5','platform':'Midias teste','url':'http://192.168.1.40:90'},{'id':'6','platform':'Heroku','url':'http://servicesrun.herokuapp.com/'}]").as_json
				   
  def initialize args
    begin
      @services = JSON.parse args
    rescue => e
      p 'Error: ' + e.to_s
    end
  end  
  
  def self.monitore
    new($services_link.to_json).internet_connection
  end
  
  def internet_connection
    begin
      @services.each do |service|
	    @platform = service
        test_connection service['url']
      end
    rescue => e
      p 'Error: ' + e.to_s + ' Time: ' + Time.now.to_s + ' platform: ' + @platform['platform']
    ensure
      sleep 10
      internet_connection
	  end
  end

  private

  def test_connection url
    begin
      timeout(5) do
        p 'Online: ' + @platform['platform'].to_s if open(url)
      end
    rescue => e
      p ' Offline: ' + @platform['platform'].to_s + ' Time: ' + Time.now.to_s + ' error: ' + e.to_s
    end
  end

  def return_platform_for_send_error
    if @platform['id'] == 1
      p @platform['platform'] + ' com problemas.'
    elsif @platform['id'] == 2
      p @platform['platform'] + ' com problemas.'
    elsif @platform['id'] == 3
      p @platform['platform'] + ' com problemas.'
    elsif @platform['id'] == 4
      p @platform['platform'] + ' com problemas.'
    elsif @platform['id'] == 5
      p @platform['platform'] + ' com problemas.'
    end
  end
end

ConnectionTest.monitore


