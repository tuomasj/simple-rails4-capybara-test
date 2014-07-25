require 'rails_helper'

RSpec.describe "User login feature", feature: true do

  def login_form
    find('form')
  end

  def email_field
    'input[type="email"]'
  end

  def valid_login_form
    within login_form do
      expect(page).to have_selector( email_field, count: 1)
      expect(page).to have_selector('input[type="password"]', count: 1)
      expect(page).to have_selector('input[type="submit"]', count: 1)
    end
  end
  describe "Login form" do
    before(:each) do
      visit login_path
    end
    it "has one email field" do
      within login_form do
        expect(page).to have_selector('input[type="email"]', count: 1)
      end
    end
    it "has one password field" do
      within login_form do
        expect(page).to have_selector('input[type="password"]', count: 1)
      end
    end
    it "has one submit button" do
      within login_form do
        expect(page).to have_selector('input[type="submit"]', count: 1)
      end
    end
    it "has valid login form" do
      expect(valid_login_form).to eql(true)
    end
  end

  describe "User logs in" do
    def login_user_with(email, password)
      visit login_path
      within login_form do
        fill_in "Email", with: email
        fill_in "Password", with: password
        click_button "Login"
      end
    end
    context "with valid email and password" do
      before do
        login_user_with("test@test.com", "sekret")
      end

      it "notifies success to user" do
        expect(page).to have_content("Logged in successfully.")
      end

      it "redirects user to root page" do
        expect(page.current_path).to eql(root_path)
      end
    end
    context "with invalid email" do
      before do
        login_user_with("wrong@email.com", "not sekret")
      end
      it "renders the login form again" do
        expect(valid_login_form).to eql(true)
      end
      it "shows error message to user" do
        expect(page).to have_content("Invalid email or password.")
      end
    end
  end
end
