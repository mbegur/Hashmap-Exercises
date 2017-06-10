require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets
    i = bucket(key)
    if @store[i].include?(key)
      @store[i].update(key, val)
    else
      @store[i].append(key, val)
      @count += 1
    end

  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&block)
    @store.each do |link_list|
      link_list.each do |link|
        block.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    # prev_store = self
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    prev_store.each do |linked_list|
      linked_list.each do |link|
        set(link.key, link.val)
      end
    end
    # prev_store.each do |k, v|
    #   set(k, v)
    # end
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
