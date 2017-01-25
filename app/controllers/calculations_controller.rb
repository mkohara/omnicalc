class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]



    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(' ').delete("\n").length

    @word_count = @text.scan(/[\w-]+/).size
    #this runs into an issue with words with '

    @occurrences = @special_word.size


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @rate_percentage=@apr/100
    @monthly_payment = @principal*@rate_percentage/ ((1-1/(1+@rate_percentage))*(@years*12))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = ((@ending-@starting)/60)
    @hours = ((@ending - @starting) / 3600)
    @days = ((@ending-@starting) / 1.day).round
    @weeks = ((@ending-@starting) / 1.week)
    @years = ((@ending-@starting) / 1.year)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    @median = (@sorted_numbers[(@sorted_numbers.length - 1) / 2] + @sorted_numbers[@sorted_numbers.length / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count

    def sample_variance
    m = @numbers.mean
    sum = @numbers.inject(0){|accum, i| accum + (i - m) ** 2 }
    return @variance= @sum / (@numbers.length - 1).to_f
    end

    numbers= [8,12,4]
    squared_numbers=[]
    numbers.each do |num|
      squared_numbers.push(num**2)
    end


    @variance = squared_numbers.sum/@sum

    def standard_deviation
       return Math.sqrt(@numbers.sample_variance)
     end


    @standard_deviation = Math.sqrt(@variance)

    def hash_for_mode(numbers)
      hash = Hash.new(0)
      numbers.each do |i|
        hash[i]+=1
      end
      hash
    end

    hash_for_mode(numbers)
    @mode = hash_for_mode(numbers)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
