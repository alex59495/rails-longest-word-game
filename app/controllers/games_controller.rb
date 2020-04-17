# require 'open-uri'
# require 'json'

class GamesController < ApplicationController
    def new
        @letters = []
        (0..10).each do |n|
            n = (65 + rand(26)).chr
            @letters << n
        end
    end

    def score
        # binding.pry
        url = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
        @hash_word = JSON.parse(url)
        valid_letter = true
        @letters = params[:letters].gsub(/[^a-zA-Z,]/, "").split(',')
        @hash_word["word"].split("").each do |letter|
            if @letters.include? letter.upcase
                @valid_letter = true
            elsif
                @valid_letter = false
            break if @valid_letter == false
            end
        end
        if @valid_letter == false
            @answer = "Sorry but <strong>#{params[:word].upcase}</strong> can't be build with #{@letters}." 
        elsif @hash_word["found"] == false
            @answer = "Sorry but <strong>#{params[:word].upcase}</strong> doesn't seem to be a valid English word..."
        else
           @answer = "<strong>Congratulation !</strong> #{params[:word].upcase} is a valid english word."
           if session[:score] 
            session[:score] += params[:word].length
           else
            session[:score] = params[:word].length
           end
        end
        
    end
end
