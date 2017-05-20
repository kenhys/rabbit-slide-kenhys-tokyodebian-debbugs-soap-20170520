require "savon"

wsdl_url = "http://git.savannah.gnu.org/gitweb/?p=emacs/elpa.git;a=blob_plain;f=packages/debbugs/Debbugs.wsdl;hb=HEAD"

client = Savon.client(wsdl: wsdl_url,
                      endpoint: "http://bugs.debian.org/cgi-bin/soap.cgi",
                      namespace: "Debbugs/SOAP")
response = client.call(:get_bugs) do
  message(query: ['package', 'pbuilder', 'severity', 'wishlist'])
end

bug_numbers = response.body[:get_bugs_response][:array][:item]
bug_numbers.each do |bugnumber|
  p bugnumber
end


