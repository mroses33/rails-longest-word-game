require 'JSON'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @result = ""
    @letters = params[:letters].delete('\\"').split("")
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    text = JSON.parse(open(url).read)

    if params[:word]
      if (params[:word].upcase.split("") - @letters.to_a).empty?
        if text['found'] == true
          @result = "Congratulations! #{params[:word].upcase} is a valid English word.  Your score is #{params[:word].length}."
        else
          @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word"
        end
      else
        @result = "Sorry, but #{params[:word]} can't be built out of #{@letters.join}"
      end
    end
  end
end
