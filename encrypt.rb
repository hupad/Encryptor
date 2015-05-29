class Encrypt

	def cipher(rotation)
		charecters = (' '..'z').to_a
		rotated_charecters = charecters.rotate(rotation)
		Hash[charecters.zip(rotated_charecters)]
	end

	def encrypt_letter(letter, rotation)
		chipher_for_rotation = self.cipher(rotation)
		chipher_for_rotation[letter]
	end

	def encrypt(string, rotation)
		lowercase_letters = string.downcase.split("")
		encrypted_letters = lowercase_letters.collect do |letter|
								self.encrypt_letter(letter, rotation)
							end.join
	end

	def decrypt_letter(letter, rotation)
		chipher_for_rotation = self.cipher(-rotation)
		chipher_for_rotation[letter]
	end

	def decrypt(string,rotation)
		lowercase_letters = string.downcase.split("")
		decrypted_letters = lowercase_letters.collect do |letter|
								self.decrypt_letter(letter, rotation)
							end.join
	end

	def encrypt_file(file, rotation)
		
		input = File.open(file,'r')
		out = File.open('secret.txt.encrypted', 'w')
		
		encrypted_value = self.encrypt(input.read, rotation)

		out.write(encrypted_value)
		input.close
		out.close
	end

	def crack(encrypted_message)
		(' '..'z').to_a.count.times.collect do |attempt|
			decrypt(encrypted_message, attempt)
		end
	end
end