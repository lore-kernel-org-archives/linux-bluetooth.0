Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sergio Manzano <sergiolnx@adhesivo.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508091950.10325.sergiolnx@adhesivo.org>
Subject: [Bluez-users] RE: Using dial up via bluetooth enabled phone
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 9 Aug 2005 19:50:08 +0200

Hi,

If you handset can connect with W.., i'm sure that is able to connect with=
=20
your Linux, i dont know what is the requeriments of your operator, but sure=
=20
that do not difer a lot of from anothers. Excuse me, my english is very=20
bad!!!

You need know the following data:

APN - Access point name
user - password in order to establish a ppp conection with your provider.

Also, you need the following SW, (Included in your Suse...):

pppd
chat=20
irda-utils
bluez-libs
bluez-utils
bluez-sdp
bluez-pan
bluez-kernel
bluez-hciemu
bluez-hcidump
bluez-bluefw

=46irst, check if your handset can supports the service:
# sdptool browse $ADDR=20
( Where $ADDR is the handset's MAC )

The the response should be something like:
[...]
Service Name: Dial-up Networking
[...]
Service RecHandle: 0x10001
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
[...]

After, you need a "pipe" with your handset, as root:
 # mknod /dev/rfcomm0 c 136 6

=2E..for bind devices:
# rfcomm bind 0 aa:aa:aa:aa:aa:aa 1
Where aa:aa:aa:aa:aa:aa is the MAC address of device

Now, you should have a link with your handset, you can check it with the=20
command:
# rfcomm
The response should be something like:
rfcomm0: xx:xx:xx:xx:xx:xx channel X clean
or
rfcomm0: xx:xx:xx:xx:xx:xx channel X open
both are well.

NOTE: for release this links use :
#rfcomm release X
in order to release the link X.

Now, if all is well you need a ppp scripts in order to make a connection.
NOTE: If you are using a 2.4 kernel, include the following line=20
in /etc/modules.conf
options ppp_async flag_time=3D0

But no necessary in the case of kernels 2.6!!!!! (Your case).

Create a file named, for example YourProviderGPRS in /etc/ppp/peers/
That contains:
#---------------------------------------------------------
#	YourProviderGPRS script
#---------------------------------------------------------
hide-password=20
noauth
connect '/usr/sbin/chat -v -f /etc/ppp/chat-YourProviderGPRS'
debug
/dev/rfcomm0 115200=20
defaultroute
noipdefault=20
user <USER>
usepeerdns
# end script

Where <USER> is the user provided for your operator,  rfcommX  where X is t=
he=20
rfcomm number previously created.

Create a file named, for example chat-YourProviderGPRS in /etc/ppp/
#---------------------------------------------------------
#	chat-YourProviderGPRS script
#---------------------------------------------------------
TIMEOUT         5
ECHO            ON
ABORT           '\nBUSY\r'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
''              \rAT
TIMEOUT         12
OK	'AT&F'
OK	'ATV1E0S0=3D0&D2&C1'
OK	AT+CMEE=3D1
OK	'AT+cgdcont=3D<CID>,"IP",<APN>'
OK-AT-OK ATD*99***1#
CONNECT ""
#End script

Take care with this script!!!
This information is for generic m=F3dem, (similar handsets), but you can re=
try=20
this information, cheking the logs when you makes a connection with your W,=
=20
it is the modem initialization, also you can check the *.inf included in th=
e=20
W drivers:

OK	'AT&F'
OK	'ATV1E0S0=3D0&D2&C1'
OK	AT+CMEE=3D1


OK	'AT+cgdcont=3D<CID>,"IP",<APN>'
OK-AT-OK ATD*99***1#
CONNECT ""

The parameter:=20
'AT+cgdcont=3D<CID>,"IP",<APN>'
In spanish is called "Cadena de inicializaci=F3n", in English perhaps somet=
ing=20
like Initialization chain????
<CID> --> You can use every one, ususally 1 to 9.
<APN> --> Access Point Name --> provided for your operator.

OK-AT-OK ATD*99***1#
Dial number should be in the following form, (using the same CID):
*99***<CID>#

=46inally modify the file:  /etc/ppp/pap-secrets, (if your provider uses PA=
P=20
authentication)
and include the following line:
<user>	*	<password>

Provided for your operator.

for launch it , as root (if your user is not a dialup group member):
# pppd call YourProviderGPRS

The response should be something like:

AT
OK
AT&F
OK
ATV1E0S0=3D0&D2&C1
OK

OK

OK

CONNECT
Serial connection established.
using channel 10
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=3D0x1 <asyncmap 0x0> <magic 0xfd7f7abc> <pcomp> <accom=
p>]
rcvd [LCP ConfReq id=3D0x2 <auth pap> <accomp> <pcomp> <asyncmap 0x0> <magi=
c=20
0x58f313d6>]
sent [LCP ConfAck id=3D0x2 <auth pap> <accomp> <pcomp> <asyncmap 0x0> <magi=
c=20
0x58f313d6>]
rcvd [LCP ConfAck id=3D0x1 <asyncmap 0x0> <magic 0xfd7f7abc> <pcomp> <accom=
p>]
sent [LCP EchoReq id=3D0x0 magic=3D0xfd7f7abc]
sent [PAP AuthReq id=3D0x1 user=3D"vodafone" password=3D<hidden>]
rcvd [LCP EchoRep id=3D0x0 magic=3D0x58f313d6]
rcvd [PAP AuthAck id=3D0x1 "Congratulations!"]
Remote message: Congratulations!
PAP authentication succeeded
[...]

the with:
# ifconfig

check if the connection was successfull!!!

I hope that works!!!!!!,=20

If this scripts cannot works give me more information about your operator i=
n=20
order to help you!!

Best Regards

Sergio Manzano
sergiolnx@adhesivo.org


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
