require 'rubygems'
require 'Selenium-Webdriver'
# require "rspec"
# require 'respec/expectations'
# instantiate driver and browse to facebook
driver = Selenium::WebDriver.for :chrome
driver.navigate.to 'https://www.facebook.com/'

# Validate facebook loaded
if driver.title == 'Facebook - Log In or Sign Up'
  puts 'Test 1: Pass: Facebook page loaded'
else
  puts 'Test 1: Failed: Facebook page did not load'
end
# End Validate Facebook loaded

# Setup variables
FirstnameField = driver.find_element(:name, 'firstname')
LastnameField = driver.find_element(:name, 'lastname')
EmailField = driver.find_element(:name, 'reg_email__')
EmailConfirmField = driver.find_element(:name, 'reg_email_confirmation__')
PasswordField = driver.find_element(:name, 'reg_passwd__')
BirthdayMonthField = driver.find_element(:name, 'birthday_month')
BirthdayDayField = driver.find_element(:name, 'birthday_day')
BirthdayYearField = driver.find_element(:name, 'birthday_year')
FemaleRadioButton = driver.find_element(:id, 'u_0_a')
MaleRadioButton = driver.find_element(:id, 'u_0_9')
SubmitButton = driver.find_element(:name => 'websubmit')




# Validate filling out form leaving first name field blank
FirstnameField.send_keys ''
FirstnameField.submit

LastnameField.send_keys 'Hudson'
LastnameField.submit

EmailField.send_keys 'drRubik@yahoo.com'
EmailField.submit

EmailConfirmField.send_keys 'drRubik@yahoo.com'
EmailConfirmField.submit

PasswordField.send_keys 'Abcd1234'
PasswordField.submit

BirthdayMonthField.send_keys 'July'
BirthdayMonthField.submit

BirthdayDayField.send_keys '4'
BirthdayDayField.submit

BirthdayYearField.send_keys '1976'
BirthdayYearField.submit


SubmitButton.click
# Click the Red box then click the first name field to prove it works.
RedBox1 = driver.find_element(:xpath, "//div[@class='_5633 _5634 _53ij']/../..")
sleep 1
RedBox1.click
sleep 1
FirstnameField.click

if RedBox1.displayed?
  puts 'Test 2: Pass: First Name Field Blank'
else
  puts 'Test 2 ; Failed: First Name Field'
end
sleep 1
# End 'First name field blank'


# Validate Filling out form leaving last name field blank
FirstnameField.send_keys 'Frank'
FirstnameField.submit

LastnameField.clear
LastnameField.send_keys ''
LastnameField.submit

SubmitButton.click
RedBox2 = driver.find_element(:xpath, './/*[contains(., "your name")]')


if RedBox2.displayed?
  puts 'Test 3: Pass: Last Name Field Blank'
else
  puts 'Test 3 ; Failed: Last Name Field'
end

# End 'Last name field blank'


# Validate email field blank
EmailConfirmField.clear
EmailField.clear
LastnameField.send_keys 'Hudson'
LastnameField.submit

SubmitButton.click


if driver.find_element(:xpath, './/*[contains(., "use this when you log in")]').displayed?
  puts 'Test 4: Pass: Email Field Blank'
else
  puts 'Test 4: Failed: Email Field'
end
sleep 1

# End 'Email field blank'


# Validate 'Confirm email field' blank
EmailField.send_keys('drRubik@yahoo.com')
EmailField.submit
EmailConfirmField.send_keys '1'
EmailConfirmField.submit
SubmitButton.click
if driver.find_element(:xpath, './/*[contains(., "your name?")]').displayed?
  puts 'Test 5: Pass: Confirm Email Field Blank'
else
  puts 'Test 5: Failed: Confirm Email Field'
end
# End 'Confirm email field blank'



# Validate 'Confirm email fields Match'
EmailConfirmField.clear
EmailConfirmField.send_keys 'drubik@yahoo.com'
EmailConfirmField.submit
PasswordField.clear
SubmitButton.click

if driver.find_element(:xpath, './/*[contains(., "Your emails do not match. Please try again")]').displayed?
  puts 'Test 6: Pass: Confirm email Fields match'
else
  puts 'Test 6: Failed: Confirm email Fields'
end
# End 'Confirm email fields match'



# Validate 'Confirm password field is blank'
EmailConfirmField.clear
EmailConfirmField.send_keys 'drRubik@yahoo.com'
EmailConfirmField.submit
PasswordField.clear
SubmitButton.click
if driver.find_element(:xpath, './/*[contains(., "Enter a combination of at least six numbers")]').displayed?
  puts 'Test 7: Pass: Confirm Password Field Blank'
else
  puts 'Test 7: Failed: Confirm Password Field Blank'
end
# End 'Confirm password field is match'



# Validate 'Confirm invalid password'
PasswordField.send_keys 'abc'

SubmitButton.click
if driver.find_element(:id, 'reg_error_inner')
  puts 'Test 8: Pass: Confirm Invalid Password'
else
  puts 'Test 8: Failed: Confirm Invalid Password'
end
# End 'Confirm invalid password'



# Validate 'Toggle Gender Radio Buttons'
FemaleRadioButton.click
if FemaleRadioButton.selected?
  puts 'Test 9 Passed: Female Radio Button Checked'
else
  puts 'Test 9 Failed: Female Radio Button is Not Checked'
end

MaleRadioButton.click

if FemaleRadioButton.selected?
  puts 'Test 10 Failed: Female Radio Button is Checked'
else
  puts 'Test 10 Passed: Male Radio Button is Checked'
end
# End Validate 'Toggle Gender Radio Buttons'

# Validate Date Manipulation
BirthdayMonthField.send_keys 'December'
BirthdayMonthField.submit

BirthdayDayField.send_keys '31'
BirthdayDayField.submit

BirthdayYearField.send_keys '2019'
BirthdayYearField.submit

NameErrorMessage2 = driver.find_element(:xpath, './/*[contains(., "your name")]')
if NameErrorMessage2.enabled?
  puts ' Test 11 Passed: Wrong Birthday Test'
else
  puts 'Test 11 Failed: Wrong Birthday Test'
end
# End Validate Date Manipulation


# Validate Jibberish Names
FirstnameField.clear
FirstnameField.send_keys 'blah'
FirstnameField.submit
LastnameField.clear
LastnameField.send_keys 'Blah'
LastnameField.submit
SubmitButton.click

NameErrorMessage = driver.find_element(:id, 'reg_error_inner')
if NameErrorMessage.enabled?
  puts ' Test 12 Passed: Required Name Message is displayed'
else
  puts 'TEst 12 Failed: Required Name Message is not displayed'
end
sleep 3

# End Validate Jibberish Names
driver.quit