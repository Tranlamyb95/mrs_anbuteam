Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  root "pages#show", page: "home"
  get "pages/:page", to: "pages#show", as: "page"

  resources :users, only: :show
  resources :videos
  resources :images
  resources :reviews
  resources :genres
  resources :categories

  resources :movies do
  resources :favorite_movies, only: [ :create, :destroy ]
  resources :reviews
    member do
      :reviews
    end
  end

  resources :actors do
    resources :favorite_actors, only: [:create, :destroy]
  end
  resources :not_found, only: :index

  resources :follow_users, only: :index
  resources :users, only: [:show, :update] do
    resources :relationships, only: [:create, :destroy]
  end
end
