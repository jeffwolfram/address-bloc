require_relative '../models/address_book'

class MenuController
attr_reader :address_book

def initialize
  @address_book = AddressBook.new
end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View entry number"
    puts "6 - Exit"
    puts "7 - Nuke it all!!!!!!!"
    print "Enter your selection: "

    selection = gets.to_i

  case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      entry_number
      main_menu
    when 6
      puts "Good-bye"
      exit(0)
    when 7
      puts "delete all entries"
      nuke
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
  end
  end
  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "NewAddressBloc entry"
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  #import csv file
  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"

  end
  def nuke
    puts "Are you sure you want to delete the whole address book?? (yes/no)"
    answer = gets.chomp
    if answer == "yes"
      the_count = address_book.entries.count
    address_book.entries.clear
    system "clear"
    puts "You have deleted #{the_count} entries"
    main_menu
  elsif answer == "no"
    system "clear"
    main_menu
  else
    puts "invalid selection"
    system "clear"
    main_menu
    end

  end
  def entry_number

      puts "Select entry number"
      selection = gets.chomp.to_i
      if selection < @address_book.entries.count
      puts @address_book.entries[selection].to_s
    else
      puts "You have picked an invalid number"
      entry_number
      end

  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated Phone Number: "
    phone_number = gets.chomp
    print "updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry: "
    puts entry

  end

  def search_entries
print "Search by name: "
name = gets.chomp
match = address_book.binary_search(name)
system "clear"
if match
  puts match.to_s
  search_submenu(match)
else
  puts "No match found for #{name}"
end

  end
  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts " m - return to main menu"

    selection = gets.chomp
    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "Clear"
      main_menu
    when "m"
      system "Clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end

  def entry_submenu(entry)
     # #16
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     selection = gets.chomp

     case selection
       when "n"
       when "d"
         delete_entry(entry)
       when "e"
         edit_entry(entry)
         entry_submenu(entry)
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         entry_submenu(entry)
     end
  end

end
