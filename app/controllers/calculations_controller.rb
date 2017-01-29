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
    #character_count_without_spaces

    #remove whitespace:
    text_without_spaces=@text.gsub(" ", "")
    text_without_newlines= text_without_spaces.gsub("\n", "")
    text_without_carriage_returns=text_without_newlines.gsub("\r", "")
    text_without_tabs= text_without_carriage_returns.gsub("\t","")

    @character_count_without_spaces = @text.delete(' ').delete("\n").length

    array_of_words =@text.split
    @word_count = @array_of_words.count
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

    @rate_percentage=@apr/100 /12
    nper=@years*12
    rate=@apr/100/12
    @monthly_payment = @principal*@rate_percentage/ ((1-1/(1+@rate_percentage))**(@years*12))

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

    if @count.odd?
      @median = @sorted_numbers[@count/2]
    else
      left_of_middle = @sorted_numbers[(@count/2)-1]
      right_of_middle = @sorted_numbers[(@count/2)]
      @median= (left_of_middle+right_of_middle)/2

    #@median = (@sorted_numbers[(@sorted_numbers.length - 1) / 2] + @sorted_numbers[@sorted_numbers.length / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count

    squared_differences = []
    @numbers.each do |num|
      difference= num = @mean
      squared_differences = difference**2
      squared_differences.push(squared_differences)
    end

    #def sample_variance
    #m = @numbers.mean
    #sum = @numbers.inject(0){|accum, i| accum + (i - m) ** 2 }
    #return @variance= @sum / (@numbers.length - 1).to_f
    #end

    #numbers= [8,12,4]
    #squared_numbers=[]
    #numbers.each do |num|
    #  squared_numbers.push(num**2)
    #end


    @variance = squared_differences.sum/@count

    def standard_deviation
       return Math.sqrt(@numbers.sample_variance)
     end


    @standard_deviation = Math.sqrt(@variance)

    leader=nil
    leader_count= 0

    @numbers.each do |num|
      occurrences = @numbers.count(num)
      if occurrences > leader_count
        leader = num
        leader_count = occurences
      end
    end
    @mode = leader


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
