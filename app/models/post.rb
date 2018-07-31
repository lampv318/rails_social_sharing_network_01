class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
  has_many :tags
  has_many :comments, dependent: :destroy
  has_many :votes, as: :target, class_name: Action.name
end
