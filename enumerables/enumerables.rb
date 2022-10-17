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
        result = Array.new(self.length) { Array.new(args.length + 1) }
        (0...self.length).each do |i|
            result[i][0] = self[i]
        end
        (0...args.length).each do |i|
            result[i][i+1] = args[i][i]
        end        

        result
    end

    def my_rotate(times=1)
        
    end


end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]


a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]



# arr1 = [1,2,3,4,5,6]
# arr2 = [2,4,6,8]
# arr1.my_each { |el| p el*3 }
# p arr1.my_select { |ele| ele.even? }
# p arr1.my_reject { |ele| ele.even? }
# p arr1.my_any? { |ele| ele == 7 } # false
# p arr1.my_any? { |ele| ele.even? } # true
# p arr1.my_all? { |ele| ele.even? } # false
# p arr2.my_all? { |ele| ele.even? } # true