require_relative 'irc_colors'
require 'rest-client'

module Lita
  module Handlers
    class OnewheelPollen < Handler
      route /pollen\s*(.*)/i, :handle_pollen , command: true

      def handle_pollen(response)
        response.reply "pollen"
        resp = RestClient.get "https://www.pollen.com/forecast/extended/pollen/97206"
        puts resp.cookies.inspect
        cookie_str = ''
        resp.cookies.keys.each do |k|
          cookie_str += "#{k}=#{resp.cookies[k]}; "
        end
        cookie_str.sub! /; $/, ''

        headers = {
            #'Accept': 'application/json, text/plain, */*',
                   # 'Accept-Encoding': 'gzip, deflate, br',
                   # 'Accept-Language': 'en-US,en;q=0.9,it;q=0.8',
                   # 'Connection': 'keep-alive',
                   # 'Cookie': cookie_str,
                   # 'Host': 'www.pollen.com',
                   # 'Origin': 'https://www.pollen.com',
                   'Referer': 'https://www.pollen.com/forecast/extended/pollen/97206',
                   # 'Sec-Fetch-Dest': 'empty',
                   # 'Sec-Fetch-Mode': 'cors',
                   # 'Sec-Fetch-Site': 'same-origin',
                   'User-Agent': 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0'
            #'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36'
        }
        puts headers
        resp2 = RestClient::Request.execute(
                  method: :get,
                  url: "https://www.pollen.com/api/forecast/extended/pollen/97206",
                  headers: headers)
        puts resp2
      end

      Lita.register_handler(self)
    end
  end
end
