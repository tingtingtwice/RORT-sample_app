require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "example user", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "			"
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "			"
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end 

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@gmail.com user.lastname@columbia.edu talk123@columbia.org]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "This email address #{@user.email.inspect}, #{@user.email} should be valid." 
  	end
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user_at_gmail.com user@gmail.com@gmail.com user@gmail+yahoo.com user@gmail,com]
  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address
  		assert_not @user.valid?,  "This email address #{@user.email} should be invalid."
  	end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?, "This email address #{duplicate_user.email} should be rejected"
	end

  test "password should be present (non-blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end 

  test "password should have a minimum length of six" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end






