Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 18:37:04 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <766221.43681.qm@web8409.mail.in.yahoo.com>
Subject: [Bluez-users] Can't connect RFCOMM socket: Permission denied
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1558028795=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1558028795==
Content-Type: multipart/alternative; boundary="0-699141903-1201612024=:43681"

--0-699141903-1201612024=:43681
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi all, =0AI am connection my system to Bt headset...=0ABut when i try to c=
onnect it using =0A$rfcomm connect 0 00:0F:DE:B1:02:42 =0Aerror comes......=
... Can't connect RFCOMM socket: Permission denied=0AThe /var/log/messages =
has following..=0A=0AJan 29 18:03:17 localhost hcid[1406]: HCI dev 0 regist=
ered=0AJan 29 18:03:17 localhost hcid[1406]: HCI dev 0 up=0AJan 29 18:03:17=
 localhost hcid[1406]: Device hci0 has been added=0AJan 29 18:03:17 localho=
st hcid[1406]: Starting security manager 0=0AJan 29 18:03:17 localhost hcid=
[1406]: Device hci0 has been activated=0AJan 29 18:06:47 localhost hcid[140=
6]: link_key_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0AJ=
an 29 18:06:47 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00=
:00, dba=3D00:0F:DE:B1:02:42)=0AJan 29 18:11:13 localhost hcid[1406]: pin_c=
ode_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0AJan 29 18:=
13:25 localhost last message repeated 2 times=0AJan 29 18:14:03 localhost h=
cid[15000]: Bluetooth HCI daemon=0AJan 29 18:14:03 localhost hcid[15000]: U=
nknown option 'passkey' line 24=0AJan 29 18:14:03 localhost hcid[15000]: sy=
ntax error line 24=0AJan 29 18:14:03 localhost hcid[15000]: syntax error li=
ne 34=0AJan 29 18:14:03 localhost hcid[15000]: Can't get system message bus=
 name: Connection ":1.34" is not allowed to own the service "org.bluez" due=
 to security policies in the configuration file=0AJan 29 18:14:03 localhost=
 hcid[15000]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13=
)=0AJan 29 18:14:03 localhost hcid[15001]: Can't init device hci0: Permissi=
on denied (13)=0AJan 29 18:14:03 localhost hcid[15002]: Can't set scan mode=
 on hci0: Permission denied (13)=0AJan 29 18:14:03 localhost hcid[15002]: C=
an't set auth on hci0: Permission denied (13)=0AJan 29 18:14:03 localhost h=
cid[15002]: Can't set encrypt on hci0: Permission denied (13)=0AJan 29 18:1=
4:03 localhost hcid[15000]: Starting security manager 0=0AJan 29 18:18:10 l=
ocalhost hcid[15022]: Bluetooth HCI daemon=0AJan 29 18:18:10 localhost hcid=
[15022]: Unknown option 'passkey' line 24=0AJan 29 18:18:10 localhost hcid[=
15022]: syntax error line 24=0AJan 29 18:18:10 localhost hcid[15022]: synta=
x error line 34=0AJan 29 18:18:10 localhost hcid[15022]: Can't get system m=
essage bus name: Connection ":1.35" is not allowed to own the service "org.=
bluez" due to security policies in the configuration file=0AJan 29 18:18:10=
 localhost hcid[15022]: Can't open PIN file /etc/bluetooth/pin: Permission =
denied (13)=0AJan 29 18:18:10 localhost hcid[15023]: Can't init device hci0=
: Permission denied (13)=0AJan 29 18:18:10 localhost hcid[15024]: Can't set=
 scan mode on hci0: Permission denied (13)=0AJan 29 18:18:10 localhost hcid=
[15024]: Can't set auth on hci0: Permission denied (13)=0AJan 29 18:18:10 l=
ocalhost hcid[15024]: Can't set encrypt on hci0: Permission denied (13)=0AJ=
an 29 18:18:10 localhost hcid[15022]: Starting security manager 0=0AJan 29 =
18:18:29 localhost hcid[15000]: Exit.=0AJan 29 18:18:31 localhost hcid[1502=
2]: Exit.=0AJan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Cur=
rently unreadable (pending) sectors=0AJan 29 18:20:22 localhost smartd[1554=
]: Device: /dev/hda, 1 Offline uncorrectable sectors=0AJan 29 18:26:19 loca=
lhost kernel: usb 2-1: USB disconnect, address 5=0AJan 29 18:26:19 localhos=
t hcid[1406]: HCI dev 0 down=0AJan 29 18:26:19 localhost hcid[1406]: Stoppi=
ng security manager 0=0AJan 29 18:26:19 localhost hcid[1406]: Device hci0 h=
as been disabled=0AJan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unregist=
ered=0AJan 29 18:26:19 localhost hcid[1406]: Unregister path: /org/bluez/hc=
i0=0AJan 29 18:26:19 localhost hcid[1406]: Device hci0 has been removed=0AJ=
an 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daemon=0AJan 29 18:32:0=
1 localhost hcid[15118]: Unknown option 'passkey' line 24=0AJan 29 18:32:01=
 localhost hcid[15118]: syntax error line 24=0AJan 29 18:32:01 localhost hc=
id[15118]: Can't get system message bus name: Connection ":1.36" is not all=
owed to own the service "org.bluez" due to security policies in the configu=
ration file=0AJan 29 18:32:01 localhost hcid[15118]: Can't open PIN file /e=
tc/bluetooth/pin: Permission denied (13)=0A=0A=0ACan anyone please help me.=
...=0A=0AThanks in Advance...=0APramod=0A=0A=0A=0A=0A      Download prohibi=
ted? No problem. CHAT from any browser, without download. Go to http://in.m=
essenger.yahoo.com/webmessengerpromo.php/
--0-699141903-1201612024=:43681
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>hi all, <br>I am connection my system to Bt headset...=
<br>But when i try to connect it using <br>$rfcomm connect 0 00:0F:DE:B1:02=
:42 <br>error comes......... Can't connect RFCOMM socket: Permission denied=
<br>The /var/log/messages has following..<br><br>Jan 29 18:03:17 localhost =
hcid[1406]: HCI dev 0 registered<br>Jan 29 18:03:17 localhost hcid[1406]: H=
CI dev 0 up<br>Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been a=
dded<br>Jan 29 18:03:17 localhost hcid[1406]: Starting security manager 0<b=
r>Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activated<br>J=
an 29 18:06:47 localhost hcid[1406]: link_key_request (sba=3D00:00:00:00:00=
:00, dba=3D00:0F:DE:B1:02:42)<br>Jan 29 18:06:47 localhost hcid[1406]: pin_=
code_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)<br>Jan 29
 18:11:13 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, =
dba=3D00:0F:DE:B1:02:42)<br>Jan 29 18:13:25 localhost last message repeated=
 2 times<br>Jan 29 18:14:03 localhost hcid[15000]: Bluetooth HCI daemon<br>=
Jan 29 18:14:03 localhost hcid[15000]: Unknown option 'passkey' line 24<br>=
Jan 29 18:14:03 localhost hcid[15000]: syntax error line 24<br>Jan 29 18:14=
:03 localhost hcid[15000]: syntax error line 34<br>Jan 29 18:14:03 localhos=
t hcid[15000]: Can't get system message bus name: Connection ":1.34" is not=
 allowed to own the service "org.bluez" due to security policies in the con=
figuration file<br>Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN fi=
le /etc/bluetooth/pin: Permission denied (13)<br>Jan 29 18:14:03 localhost =
hcid[15001]: Can't init device hci0: Permission denied (13)<br>Jan 29 18:14=
:03 localhost hcid[15002]: Can't set scan mode on hci0: Permission denied (=
13)<br>Jan 29 18:14:03 localhost hcid[15002]: Can't set auth on hci0:
 Permission denied (13)<br>Jan 29 18:14:03 localhost hcid[15002]: Can't set=
 encrypt on hci0: Permission denied (13)<br>Jan 29 18:14:03 localhost hcid[=
15000]: Starting security manager 0<br>Jan 29 18:18:10 localhost hcid[15022=
]: Bluetooth HCI daemon<br>Jan 29 18:18:10 localhost hcid[15022]: Unknown o=
ption 'passkey' line 24<br>Jan 29 18:18:10 localhost hcid[15022]: syntax er=
ror line 24<br>Jan 29 18:18:10 localhost hcid[15022]: syntax error line 34<=
br>Jan 29 18:18:10 localhost hcid[15022]: Can't get system message bus name=
: Connection ":1.35" is not allowed to own the service "org.bluez" due to s=
ecurity policies in the configuration file<br>Jan 29 18:18:10 localhost hci=
d[15022]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)<br=
>Jan 29 18:18:10 localhost hcid[15023]: Can't init device hci0: Permission =
denied (13)<br>Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode o=
n hci0: Permission denied (13)<br>Jan 29 18:18:10 localhost
 hcid[15024]: Can't set auth on hci0: Permission denied (13)<br>Jan 29 18:1=
8:10 localhost hcid[15024]: Can't set encrypt on hci0: Permission denied (1=
3)<br>Jan 29 18:18:10 localhost hcid[15022]: Starting security manager 0<br=
>Jan 29 18:18:29 localhost hcid[15000]: Exit.<br>Jan 29 18:18:31 localhost =
hcid[15022]: Exit.<br>Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/=
hda, 1 Currently unreadable (pending) sectors<br>Jan 29 18:20:22 localhost =
smartd[1554]: Device: /dev/hda, 1 Offline uncorrectable sectors<br>Jan 29 1=
8:26:19 localhost kernel: usb 2-1: USB disconnect, address 5<br>Jan 29 18:2=
6:19 localhost hcid[1406]: HCI dev 0 down<br>Jan 29 18:26:19 localhost hcid=
[1406]: Stopping security manager 0<br>Jan 29 18:26:19 localhost hcid[1406]=
: Device hci0 has been disabled<br>Jan 29 18:26:19 localhost hcid[1406]: HC=
I dev 0 unregistered<br>Jan 29 18:26:19 localhost hcid[1406]: Unregister pa=
th: /org/bluez/hci0<br>Jan 29 18:26:19 localhost hcid[1406]: Device
 hci0 has been removed<br>Jan 29 18:32:01 localhost hcid[15118]: Bluetooth =
HCI daemon<br>Jan 29 18:32:01 localhost hcid[15118]: Unknown option 'passke=
y' line 24<br>Jan 29 18:32:01 localhost hcid[15118]: syntax error line 24<b=
r>Jan 29 18:32:01 localhost hcid[15118]: Can't get system message bus name:=
 Connection ":1.36" is not allowed to own the service "org.bluez" due to se=
curity policies in the configuration file<br>Jan 29 18:32:01 localhost hcid=
[15118]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)<br>=
<br><br>Can anyone please help me....<br><br>Thanks in Advance...<br>Pramod=
<br></div></div><br>=0A=0A=0A      <!--4--><hr size=3D1></hr> 5, 50, 500, 5=
000 - Store N number of mails in your inbox. <a href=3D"http://in.rd.yahoo.=
com/tagline_mail_4/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/t=
ools-08.html/">Click here.</a></body></html>
--0-699141903-1201612024=:43681--


--===============1558028795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1558028795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1558028795==--
