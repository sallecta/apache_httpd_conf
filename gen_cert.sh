dir0="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
dir_cert=$dir0"/conf/ssl"
name_key="server.key"
name_crt="server.crt"
fn_stoponerror ()
{
	#usage:
	# fn_stoponerror "$?" $LINENO
	# or (opens xed at error line)
	# fn_stoponerror "$?" $LINENO xed
	er=$1
	lNo=$2
	#fn_interrupt $lNo
	if [ $er -ne 0 ]; then
		printf "\n$me: line $lNo: error [$er]\n"
		exit $er
	else
		clear
		printf "\n$me: line $lNo: success.\n\n "
	fi
}

if [ -d "$dir_cert" ]; then
	rm --force --recursive "$dir_cert"
	fn_stoponerror "$?" $LINENO
fi

mkdir -p "$dir_cert"
fn_stoponerror "$?" $LINENO

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$dir_cert/$name_key" -out "$dir_cert/$name_crt"
fn_stoponerror "$?" $LINENO

sudo chown -R $USER:users $dir_cert
fn_stoponerror "$?" $LINENO
