FactoryBot.define do
  factory :user do
    name { 'User' }
    sequence :email do |n|
      "user_#{n}@email.com"
    end
    password { 'p@ssw0rd' }
  end
end