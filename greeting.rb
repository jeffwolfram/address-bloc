def greeting
  first = ARGV.shift
  puts ARGV.map { |arg| "#{first} #{arg}" }
end
greeting
