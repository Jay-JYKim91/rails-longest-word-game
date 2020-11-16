require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    charset = Array('A'..'Z')
    @picked_chars = Array.new(10) { charset.sample }
  end

  def score
    @original_grid = params[:picked_chars].split(' ').join(',')
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read.to_s)
    @json_result = json["found"]
    if params[:word].split('').all? { |letter| @original_grid.include? letter }
      if @json_result == true
        @result = "Congratulatioins! #{params[:word]} is a valid English word!"
      else
        @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but TEST can not be built our of #{@original_grid}"
    end
  end

end
