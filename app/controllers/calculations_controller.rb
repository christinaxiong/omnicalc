class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split
    text_withoutspaces = @text.gsub(/ /,"")
    occurrences_count = @text.scan(@special_word.gsub(/ /,""))

    @word_count = text_split_into_array.count

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = text_withoutspaces.size
    # can we use something like scan? @character_count_with_spaces-@word_count+1

    @occurrences = occurrences_count.size

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = (params[:annual_percentage_rate].to_f)
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    months= @years*12
    numerator=@principal*(@apr/100/12)
    denominator=1-(1+(@apr/100/12))**(-months)
    @monthly_payment = numerator / denominator

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
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

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

    @range = @maximum - @minimum

    def median                        #Define your method accepting an array as an argument.
      if @sorted_numbers.length.odd?                   #is the length of the array odd?
        return @sorted_numbers[(@sorted_numbers.length - 1) / 2] #find value at this index
      else @sorted_numbers.length.even?               #is the length of the array even?
        return ( @sorted_numbers[@sorted_numbers.length/2] + @sorted_numbers[@sorted_numbers.length/2 - 1] )/2.to_f
        #average the values found at these two indexes and convert to float
      end
    end

    @median = median

    @sum = @numbers.sum

    @mean = @numbers.sum / @count

    @variance = @sum{|i| (i-@mean)**2} / @count

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
