module Enumerable
  def my_each
    self.length.times do|i|
      yield self[i]
    end
  end

  def my_each_with_index
    self.length.times do |i|
      yield self[i],i 
    end
  end

  def my_select 
    result=[]
    self.my_each do |element|
      result << element if yield element 
    end
    result
  end

  def my_all?
    self.length.times do |i|
      return false unless yield self[i]
    end 
    return true
  end

  def my_any?
    self.length.times do |i|
      return true if yield self[i]
    end 
    return false
  end

  def my_none?
    self.length.times do |i|
      return false if yield self[i]
    end 
    return true
  end

  def my_count
    count=0
    self.my_each do |element|
      count +=1 if (not block_given? ) || yield( element)
    end
    count
  end

  def my_map proc=nil
    result=[]
    self.my_each do |element|
      result << (( block_given?)? yield(element) : proc.call(element))
    end
    result
  end


  def my_inject initial=nil
    result=initial
    self.my_each do |element|
      if result.nil?
        result=element
      else
        result = yield(result,element)
      end
    end
    result
  end
end

class Array
  include Enumerable
end

def multiply_els arr
  arr.my_inject{ |sum,x| sum*x}    
end

arr=[1,2,5,9,7,9]

puts "#my_each"
arr.my_each {|element| puts element}
puts "#my_each_with_index"
arr.my_each_with_index{|element,index| puts "#{index} -> #{element}"}
puts "#my_select"
puts arr.my_select{|element| element>5}
puts "#my_all?"
puts arr.my_all? {|element| element<10}
puts "#my_any?"
puts arr.my_any? {|element| element==1}
puts "#my_none?"
puts arr.my_none? {|element| element==10}
puts "#my_count"
puts arr.my_count{ |element| element ==9}
puts arr.my_count
puts "#my_inject"
puts arr.my_inject{|sum,element| sum+element }
puts "#multiply_els([2,4,5])"
puts multiply_els([2,4,5])
puts "#my_map (proc)"
proc= Proc.new {|element| element *10}
puts arr.my_map(proc)
puts "#my_map (block)"
puts arr.my_map{|element| element *10}