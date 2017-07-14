require_relative 'contact.rb'

class CRM

  def initialize(name)
    @name = name
    puts "This CRM has the name: " + name
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
       when 1 then add_new_contact
       when 2 then modify_existing_contact
       when 3 then delete_contact
       when 4 then display_all_contacts
       when 5 then search_by_attribute
       when 6 then abort("Goodbye")
     end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )

  end

  def modify_existing_contact
    print "Last name of contact to modify:"
    contact_to_search = gets.chomp
    print "Enter the new last name: "
    updated_value = gets.chomp
    searched_contact = Contact.find_by(
    last_name: contact_to_search
    )
    searched_contact.update(last_name: updated_value)
  end

  def delete_contact
    print "Enter the last name of the contact to delete: "
    contact_to_delete = gets.chomp
    Contact.find_by(last_name: contact_to_delete).delete
  end

  def display_all_contacts
    puts Contact.all.inspect
  end

  def search_by_attribute
    puts "Which attribute would you like to search by? "
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email'
    user_input = gets.to_i
    case user_input
      when 1
        attribute = :first_name
        puts "Enter first name:"
        value = gets.chomp
      when 2
        attribute = :last_name
        puts "Enter last name:"
        value = gets.chomp

      when 3
        attribute = :email
        puts "Enter email address:"
        value = gets.chomp
    end

    returned_contact = Contact.find_by(attribute => value)
    puts returned_contact.inspect

  end


end

at_exit do
  ActiveRecord::Base.connection.close
end
