class GamesController < ApplicationController
    def new
        @letters = []
        (0..10).each do |n|
            n = (65 + rand(26)).chr
            @letters << n
        end
    end

    def score
        raise
    end
end
