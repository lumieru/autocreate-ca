cp cnf/website.conf /root/ca/intermediate/website.conf
cd /root/ca;
rm intermediate/index.txt
touch intermediate/index.txt
openssl genrsa -aes256 \
      -out intermediate/private/www.sensedevil.com.key-pass.pem 2048;
chmod 400 intermediate/private/www.sensedevil.com.key-pass.pem;
# remove password
echo "input password to remove password from private key"
openssl rsa -in intermediate/private/www.sensedevil.com.key-pass.pem -out intermediate/private/www.sensedevil.com.key.pem

openssl req -config intermediate/website.conf \
      -key intermediate/private/www.sensedevil.com.key.pem \
      -new -sha256 -out intermediate/csr/www.sensedevil.com.csr.pem;
openssl ca -config intermediate/website.conf \
      -extensions server_cert -days 3650 -notext -md sha256 \
      -in intermediate/csr/www.sensedevil.com.csr.pem \
      -out intermediate/certs/www.sensedevil.com.cert.pem;
chmod 444 intermediate/certs/www.sensedevil.com.cert.pem;
openssl x509 -noout -text \
      -in intermediate/certs/www.sensedevil.com.cert.pem;
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
      intermediate/certs/www.sensedevil.com.cert.pem;
