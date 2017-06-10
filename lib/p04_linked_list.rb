class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end

  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    prev_link = @tail.prev
    @tail.prev = new_link
    new_link.prev = prev_link
    new_link.next = @tail
    prev_link.next = new_link

  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
      end
    end

  end

  def remove(key)
    each do |link|
      if key == link.key
        prev_link = link.prev
        next_link = link.next
        prev_link.next = next_link
        next_link.prev = prev_link
      end
    end
  end

  def each(&block)
    i = @head
    until i.next == @tail
      i = i.next
      block.call(i)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
