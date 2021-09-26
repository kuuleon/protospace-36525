class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      t.timestamps

      t.string      :title,       null: false 
      t.text        :catch_copy,  null: false 
      t.text        :concept,     null: false 
      t.references   :user,        foreign_key: true 
      #t.references :userと記載すれば、user_idというカラムが生成
      #ここに保存する「ユーザー」は必ず存在している事が前提なので、
      #「usersテーブル」の情報を参照する
      #参照する役割を果たすのが「foreign_key: true」 
    end
  end
end
