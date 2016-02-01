require 'open-uri'
require 'json'

class ConnectionTest
  $services_link =
  [
    {'id': 1,
     'platform': 'Plataforma Suporte',
     'url': 'http://sysrad.com.br/online/',
		},
    {'id': 2,
     'platform': 'Painel Mobile',
     'url': 'http://sysrad.com.br/painelmobile/'
		},
    {'id': 3,
     'platform': 'YMWebDocuments',
     'url': 'http://sysrad.com.br/'
    },
    {'id': 4,
     'platform': 'Avaliação Suporte',
     'url': 'http://sysrad.com.br/'
    },
    {'id': 5,
     'platform': 'Midias teste',
     'url': 'http://192.168.1.40:90'
    }
  ]
				   
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
      p 'Error: ' + e.to_s
	    sleep 2
    ensure
      internet_connection
	  end
  end

  private

  def test_connection url
    begin
      p 'Online: ' + @platform['platform'].to_s if open(url)
      sleep 2
    rescue
      p 'Offline: ' + @platform['platform'].to_s
      sleep 2
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


