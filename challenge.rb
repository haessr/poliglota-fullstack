#################################
#################################
# INTERSECTION_UNION SOLUTION
#################################
#################################

def deduplicate(array)
  result = []
  array.each do |element|
    result << element unless result.include?(element)
  end

  result
end

def intersection(arr1, arr2)
  result = []
  deduplicated_arr1 = deduplicate(arr1)
  deduplicated_arr2 = deduplicate(arr2)

  deduplicated_arr1.each do |element|
    result << element if deduplicated_arr2.include?(element)
  end

  result.sort { |a, b| a <=> b }
end

def union(arr1, arr2)
  deduplicate([*arr1, *arr2]).sort { |a, b| a <=> b }
end

def intersection_union(arr1, arr2)
  [intersection(arr1, arr2), union(arr1, arr2)]
end

#################################
#################################
# FIND_BOB SOLUTION
#################################
#################################

def find(array, query)
  index = 0
  while index <= array.length - 1
    return index if array[index].downcase == query.downcase

    index += 1
  end

  return -1
end

def find_bob(names)
  find(names, 'Bob')
end

#################################
#################################
# UNIQUE SOLUTION
#################################
#################################

def build_hash_entry(value, count, index)
  {
    value: value,
    count: count,
    index: index
  }
end

def build_hash(array)
  # Crear la estructura { key: options } ==> {'10': {value: 10, count: 1, index:1}}
  hash = {}
  index = 0

  while index <= array.length - 1
    if hash.include?(array[index].to_s)
      hash[array[index].to_s][:count] += 1
    else
      hash[array[index].to_s] = build_hash_entry(array[index], 1, index)
    end

    index += 1
  end

  hash
end

def unique(array)
  hash = build_hash(array)

  # Filtramos aquel/aquellos elemento(s) con valor :count igual a 1
  filtered_hash = hash.select { |_key, options| options[:count] == 1 }
  return [] if filtered_hash.length.zero?

  if filtered_hash.length == 1
    filtered_hash.map { |_key, options| [options[:value], options[:index]] }
                 .first
  else
    filtered_hash.map { |_key, options| [options[:value], options[:index]] }
  end
end

#################################
#################################
# OUTPUTS
#################################
#################################

puts 'intersection_union outputs:'
p intersection_union([4, 4, 6, 7, 8], [4, 5, 9]) # => [[4], [4, 5, 6, 7, 8, 9]]
p intersection_union([7, 8, 9], [1, 2, 3]) # => [[], [1, 2, 3, 7, 8, 9]]
puts ''

puts 'find_bob outputs:'
p find_bob(%w[Jimmy Layla Bob]) # => 2
p find_bob(%w[Bob Layla Kaitlyn Patricia]) # => 0
p find_bob(%w[Jimmy Layla James]) # => -1
puts ''

puts 'unique outputs:'
p unique([3, 3, 1, 3, 3, 3]) # => [1, 2]
p unique([0, 0, 0, 0.93, 0]) # => [0.93, 3]
p unique([1, 1, 1, 1, 1, 0, 1, 1]) # => [0, 5]
# Sin elementos unicos
p unique([3, 4, 5, 4, 3, 3, 5, 4, 4, 3]) # =>[]
# Multiples elementos unicos
# p unique([1, 2, 3, 3, 4]) # => [[1, 0], [2, 1], [4, 4]]
puts ''
