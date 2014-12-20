module Faker
  require 'date'

  class Number < Base
    class << self
      def number(digits)
        (1..digits).collect {digit}.join
      end

      def decimal(l_digits, r_digits = 2)
        l_d = self.number(l_digits)
        r_d = self.number(r_digits)
        "#{l_d}.#{r_d}"
      end

      def digit
        (rand() * 9).round.to_s
      end

      def hexadecimal(digits)
        hex = ""
        digits.times { hex += rand(15).to_s(16) }
        hex
      end

      def between(from = 1.00, to = 5000.00)
        Faker::Base::rand_in_range(from, to)
      end

      def positive(from = 1.00, to = 5000.00)
        random_number = between(from, to)
        greater_than_zero(random_number)
      end

      def negative(from = -5000.00, to = -1.00)
        random_number = between(from, to)
        less_than_zero(random_number)
      end

      # Just in China, the fu*king country.
      def cn_id
        headers = %w(110101 130101 130601 201073 320103 330701 410501 510105 610424)

        random_year = Random.new.rand(1970..1990)
        random_month =Random.new.rand(1..12)
        random_day  = Random.new.rand(1..30)
        random_birthday = Date.new(random_year,random_month,random_day).strftime('%Y%m%d')

        random_suffix = Random.new.rand(1000..9999)

        "#{headers.sample}#{random_birthday}#{random_suffix}"
      end

      private

      def greater_than_zero(number)
        should_be(number, :>)
      end

      def less_than_zero(number)
        should_be(number, :<)
      end

      def should_be(number, method_to_compare)
        if number.send(method_to_compare, 0)
          number
        else
          number * -1
        end
      end
    end
  end
end
