require 'dotenv/load'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'vonage'
require 'pony'

require 'byebug'

# CallerId App for getting details about a phone number.
class CallerId < Sinatra::Base
  register Sinatra::Reloader

  configure do
    $vonage = Vonage::Client.new
  end

  get '/' do
    erb :phone_form
  end

  post '/lookup' do
    @insight = $vonage.number_insight.advanced_async(
      number: params['phone'],
      callback: "#{request.base_url}/nexmo_insights?response=#{params['response']}"
    )
    erb :phone_lookup
  end

  post '/nexmo_insights' do
    phone_info = JSON.parse(request.body.read)

    # Print it out so we can view the response in the console
    puts params
    puts phone_info

    response = $vonage.sms.send(
      from: ENV['VONAGE_SMS_FROM'],
      to: params['response'],
      text: "#{phone_info['status_message']}! #{phone_info['country_code']} #{phone_info['international_format_number']} (#{phone_info['valid_number']})"
    )
    puts response.http_response

    status 200
  rescue Vonage::Error => e
    puts e
  end
  run! if app_file == $PROGRAM_NAME
end
