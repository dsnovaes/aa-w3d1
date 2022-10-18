require "byebug"

class Array
    def my_each(&blk)
        i = 0
        while i < self.length
            blk.call(self[i]) # can use yield, as in yield(self[i]), without specifying to receive a proc as an argument
            i += 1
        end
        self
    end

    def my_select(&blk)
        arr = []
        self.my_each do |ele|
            arr << ele if blk.call(ele)
        end
        arr
    end

    def my_reject(&blk)
        arr = []
        self.my_each do |ele|
            arr << ele if !blk.call(ele)
        end
        arr
    end

    def my_any?(&blk)
        self.my_each do |ele|
            return true if blk.call(ele)
        end
        false
    end

    def my_all?(&blk)
        self.my_each do |ele|
            return false if !blk.call(ele)
        end
        true
    end

    def my_flatten
        # recursive step
        result = []
        self.my_each do |el| 

            # base case
            if el.instance_of?(Array)
                result += el.my_flatten
            else
                result << el
            end
        end
        result
    end

    def my_zip(*args)    
        zipped = [] # creates array which will be populated and returned
        self.length.times do |i| # iterate self.times increasing the value of i
        #   debugger
          subzip = [self[i]] # creates an array with the i_th value of self
          arrays.my_each do |array| # iterates every array taken in as arguments
            subzip << array[i] # append the i_th array into the subzip array 
          end
          zipped << subzip # append the subzip array into the array being returned in the end
        end
        zipped
    end

    def my_rotate(times=1)
        idx = times % self.length
        # debugger
        self.drop(idx) + self.take(idx)
    end



    def my_join(separator="")
        result = ""
        self.length.times do |i| 
            result += self[i]
            result += separator if i != (self.length-1)
        end
        result
    end

    def my_reverse
        result = []
        self.my_each { |ele| result.unshift(ele) }
        result
    end


end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]


# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

