Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <HSJB2Z$B9BA7BECBCE0A10656B7DE841903709B@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "baruffa\@libero\.it" <baruffa@libero.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Why does not pppd directly work?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed,  4 Feb 2004 01:37:47 +0100

Hello,

thanks to the valuable information provided in this list by Cam=
eron B. Prince,
I've been able to  set up a GPRS connection via bluetoot=
h to a T39m mobile phone.
What I'm wondering is why the usual way of usi=
ng pppd directly from the command
line does not work. I know this is not=
 the right place to ask, but if you have
time and will, please satisfy m=
y curiosity. This is the log of a classic pppd call:

[root@ringo me]#p=
ppd call gprs-eric
+++ATmodem init: press <ctrl>-C to disconnect
OK
AT=
E1
OK
AT&FE0V1&D2
OK

OK

OK

OK
 + requesting data connection=0D
=

CONNECT
Serial connection established.
using channel 10
Using interf=
ace ppp0
Connect: ppp0 <--> /dev/rfcomm0
Looking for secret in /etc/ppp=
/pap-secrets for client test server (null)
Got client test
Got server *=

Got secret *
Got auth_addr *
Got client *
Looking for secret in /etc=
/ppp/chap-secrets for client test server (null)
Got client test
Got ser=
ver *
Got secret *
Got auth_addr *
Got client *
sent [LCP ConfReq id=3D=
0x1 <asyncmap 0x0> <magic 0xe78c9680> <pcomp> <accomp>]
rcvd [LCP ConfRe=
q id=3D0x1 <asyncmap 0x0> <pcomp> <accomp> <auth pap>]
sent [LCP ConfAck=
 id=3D0x1 <asyncmap 0x0> <pcomp> <accomp> <auth pap>]
rcvd [LCP ConfRej =
id=3D0x1 <magic 0xe78c9680>]
sent [LCP ConfReq id=3D0x2 <asyncmap 0x0> <=
pcomp> <accomp>]
rcvd [LCP ConfAck id=3D0x2 <asyncmap 0x0> <pcomp> <acco=
mp>]
Looking for secret in /etc/ppp/pap-secrets for client test server (=
null)
Got client test
Got server *
Got secret *
Got auth_addr *
Got =
client *
sent [PAP AuthReq id=3D0x1 user=3D"test" password=3D"test"]
se=
nt [PAP AuthReq id=3D0x2 user=3D"test" password=3D"test"]
rcvd [PAP Auth=
Ack id=3D0x2 ""]
sent [IPCP ConfReq id=3D0x1 <addr 0.0.0.0> <ms-dns1 0.0=
.0.0> <ms-dns3 0.0.0.0>]
sent [CCP ConfReq id=3D0x1 <deflate 15> <deflat=
e(old#) 15> <bsd v1 15>]
rcvd [LCP ProtRej id=3D0x3 80 fd 01 01 00 0f 1a=
 04 78 00 18 04 78 00 15 03 2f]
sent [IPCP ConfReq id=3D0x1 <addr 0.0.0.=
0> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
rcvd [IPCP ConfReq id=3D0x1]
se=
nt [IPCP ConfNak id=3D0x1 <addr 0.0.0.0>]
rcvd [IPCP ConfNak id=3D0x1 <a=
ddr 10.216.254.254> <ms-dns1 194.185.97.134>
<ms-dns3 194.185.97.134>]=0D
=
sent [IPCP ConfReq id=3D0x2 <addr 10.216.254.254> <ms-dns1 194.185.97.134=
>
<ms-dns3 194.185.97.134>]
rcvd [IPCP ConfAck id=3D0x2 <addr 10.216.25=
4.254> <ms-dns1 194.185.97.134>
<ms-dns3 194.185.97.134>]
sent [IPCP Co=
nfReq id=3D0x2 <addr 10.216.254.254> <ms-dns1 194.185.97.134>
<ms-dns3 1=
94.185.97.134>]
rcvd [IPCP ConfAck id=3D0x2 <addr 10.216.254.254> <ms-dn=
s1 194.185.97.134>
<ms-dns3 194.185.97.134>]
sent [IPCP ConfReq id=3D0x=
2 <addr 10.216.254.254> <ms-dns1 194.185.97.134>
<ms-dns3 194.185.97.134=
>]
rcvd [IPCP ConfAck id=3D0x2 <addr 10.216.254.254> <ms-dns1 194.185.97=
.134>
<ms-dns3 194.185.97.134>]
sent [IPCP ConfReq id=3D0x2 <addr 10.21=
6.254.254> <ms-dns1 194.185.97.134>
<ms-dns3 194.185.97.134>]
rcvd [IPC=
P ConfAck id=3D0x2 <addr 10.216.254.254> <ms-dns1 194.185.97.134>
<ms-dn=
s3 194.185.97.134>]
.................
This continues and never ends.=0D
=
Why doesn't pppd see that DNS and IP are passed to me and does not call t=
he
proper script to ip-up the connection?
Sorry for the partial off top=
ic. Hope you do not blame me ;-)
Thanks a lot.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
