require "savon"
require "pp"

wsdl_url = "http://git.savannah.gnu.org/gitweb/?p=emacs/elpa.git;a=blob_plain;f=packages/debbugs/Debbugs.wsdl;hb=HEAD"

client = Savon.client(wsdl: wsdl_url,
                      endpoint: "http://bugs.debian.org/cgi-bin/soap.cgi",
                      namespace: "Debbugs/SOAP")
# fetch status of pbuilder specific bugs
response = client.call(:get_status) do
  message(bugs: ["807406", "837812"])
end

bugs = response.body[:get_status_response][:s_gensym3][:item]
bugs.each do |bug|
  item = bug[:value]
  puts "#{bug[:key]}:#{item[:pending]}:#{item[:subject]}"
end


