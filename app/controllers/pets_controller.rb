class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      pet = Pet.create(name: params[:pet][:name], owner: owner)
    else
      pet = Pet.create(params[:pet])
    end

    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    #binding.pry
    pet = Pet.find_or_create_by(params[:id])

    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
      pet.update(owner: owner)
    else
      owner = Owner.find(params[:pet][:owner_id])
      owner.pets.delete(pet)
      pet.update(name: params[:pet][:name], owner: owner)
    end

    redirect to "pets/#{pet.id}"
  end
end
