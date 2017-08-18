[ -d /root/ca ] || mkdir -p /root/ca;
cp cnf/root-ca /root/ca/openssl.cnf
cd /root/ca;
mkdir certs crl newcerts private;
chmod 700 private;
touch index.txt;
echo 1000 > serial;
openssl genrsa -aes256 -out private/ca.key-pass.pem 4096;
chmod 400 private/ca.key-pass.pem;
# remove password
echo "input password to remove password from private key"
openssl rsa -in private/ca.key-pass.pem -out private/ca.key.pem

openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem;
chmod 444 certs/ca.cert.pem;
openssl x509 -noout -text -in certs/ca.cert.pem;
