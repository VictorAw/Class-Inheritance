class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss) #sets the instance variables
    @employees = employees
  end

  def bonus(multiplier)
    result = @employees.inject(0) do |total, employee|
      total += employee.salary
    end
    result * multiplier
  end

  def add_employees(new_employees)
    new_employees.each do |new_employee|
      if new_employee.is_a?(Manager)
        @employees << new_employee
        add_employees(new_employee.employees)
      else
        @employees << new_employee
      end
    end
  end
end

ned = Manager.new("Ned", "Founder", 1_000_000, nil)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)

darren.add_employees([shawna, david])
ned.add_employees([darren])


p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3)

darren.employees
