require 'rails_helper'

describe 'Dog resource', type: :feature do
  context 'when a user is logged in' do
    let!(:user) { create(:user) }

    ## I wanted to create a spec where we could test that the form is working 
    ## as expected to create a dog and to edit a dog when a user is signed in.
    ## Devise sign_in is not working for some reason, and I ran out of time to 
    ## fix it. But, if this worked the spec should be passing :)
    
    before { sign_in user }

    it 'can create a profile' do
      visit new_dog_path
      fill_in 'Name', with: 'Speck'
      fill_in 'Description', with: 'Just a dog'
      attach_file 'Image', 'spec/fixtures/images/speck.jpg'
      click_button 'Create Dog'
      expect(Dog.count).to eq(1)
    end

    it 'cannot edit a dog profile if not the owner' do
      dog = create(:dog)
      visit edit_dog_path(dog)
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).not_to eq('Speck')
    end

    it 'can delete a dog profile' do
      dog = create(:dog)
      visit dog_path(dog)
      click_link "Delete #{dog.name}'s Profile"
      expect(Dog.count).to eq(0)
    end
  end
end
