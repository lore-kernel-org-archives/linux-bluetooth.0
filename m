Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 19:25:42 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <80662.65756.qm@web8404.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1770900555=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1770900555==
Content-Type: multipart/alternative; boundary="0-1757093411-1201614942=:65756"

--0-1757093411-1201614942=:65756
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

thank you sir for ur reply=0Ai tried being root..=0ANow its working..but wh=
en i enter the PIN for HS BT device on my system it shows an error=0A[Pramo=
d@localhost ~]$ sudo rfcomm connect 0 00:0F:DE:B1:02:42=0ACan't create RFCO=
MM TTY: Address already in use=0Awhats the reason....=0AThanks in advance=
=0APramod=0A=0A----- Original Message ----=0AFrom: Miguel <mc354@tid.es>=0A=
To: BlueZ users <bluez-users@lists.sourceforge.net>=0ASent: Tuesday, 29 Jan=
uary, 2008 6:55:55 PM=0ASubject: Re: [Bluez-users] Can't connect RFCOMM soc=
ket: Permission denied=0A=0A=0A=0A=0A  =0A  =0A=0Arfcomm creates a devices =
in /dev/rfcomm0 in your case. Check if you have the correct permissions. =
=0A=0A=0A=0ATry to connect using root user ...=0A=0A=0A=0AOn Tue, 2008-01-2=
9 at 18:37 +0530, pramod gurav wrote:=0A=0A    hi all, =0A=0A    I am conne=
ction my system to Bt headset...=0A=0A    But when i try to connect it usin=
g =0A=0A    $rfcomm connect 0 00:0F:DE:B1:02:42 =0A=0A    error comes......=
.... Can't connect RFCOMM socket: Permission denied=0A=0A    The /var/log/me=
ssages has following..=0A=0A    =0A=0A    Jan 29 18:03:17 localhost hcid[14=
06]: HCI dev 0 registered=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: HC=
I dev 0 up=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has b=
een added=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Starting security =
manager 0=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has be=
en activated=0A=0A    Jan 29 18:06:47 localhost hcid[1406]: link_key_reques=
t (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0A    Jan 29 18:06:=
47 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D0=
0:0F:DE:B1:02:42)=0A=0A    Jan 29 18:11:13 localhost hcid[1406]: pin_code_r=
equest (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0A    Jan 29 1=
8:13:25 localhost last message repeated 2 times=0A=0A    Jan 29 18:14:03 lo=
calhost hcid[15000]: Bluetooth HCI daemon=0A=0A    Jan 29 18:14:03 localhos=
t hcid[15000]: Unknown option 'passkey' line 24=0A=0A    Jan 29 18:14:03 lo=
calhost hcid[15000]: syntax error line 24=0A=0A    Jan 29 18:14:03 localhos=
t hcid[15000]: syntax error line 34=0A=0A    Jan 29 18:14:03 localhost hcid=
[15000]: Can't get system message bus name: Connection ":1.34" is not allow=
ed to own the service "org.bluez" due to security policies in the configura=
tion file=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN fi=
le /etc/bluetooth/pin: Permission denied (13)=0A=0A    Jan 29 18:14:03 loca=
lhost hcid[15001]: Can't init device hci0: Permission denied (13)=0A=0A    =
Jan 29 18:14:03 localhost hcid[15002]: Can't set scan mode on hci0: Permiss=
ion denied (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15002]: Can't set a=
uth on hci0: Permission denied (13)=0A=0A    Jan 29 18:14:03 localhost hcid=
[15002]: Can't set encrypt on hci0: Permission denied (13)=0A=0A    Jan 29 =
18:14:03 localhost hcid[15000]: Starting security manager 0=0A=0A    Jan 29=
 18:18:10 localhost hcid[15022]: Bluetooth HCI daemon=0A=0A    Jan 29 18:18=
:10 localhost hcid[15022]: Unknown option 'passkey' line 24=0A=0A    Jan 29=
 18:18:10 localhost hcid[15022]: syntax error line 24=0A=0A    Jan 29 18:18=
:10 localhost hcid[15022]: syntax error line 34=0A=0A    Jan 29 18:18:10 lo=
calhost hcid[15022]: Can't get system message bus name: Connection ":1.35" =
is not allowed to own the service "org.bluez" due to security policies in t=
he configuration file=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: Can't=
 open PIN file /etc/bluetooth/pin: Permission denied (13)=0A=0A    Jan 29 1=
8:18:10 localhost hcid[15023]: Can't init device hci0: Permission denied (1=
3)=0A=0A    Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode on h=
ci0: Permission denied (13)=0A=0A    Jan 29 18:18:10 localhost hcid[15024]:=
 Can't set auth on hci0: Permission denied (13)=0A=0A    Jan 29 18:18:10 lo=
calhost hcid[15024]: Can't set encrypt on hci0: Permission denied (13)=0A=
=0A    Jan 29 18:18:10 localhost hcid[15022]: Starting security manager 0=
=0A=0A    Jan 29 18:18:29 localhost hcid[15000]: Exit.=0A=0A    Jan 29 18:1=
8:31 localhost hcid[15022]: Exit.=0A=0A    Jan 29 18:20:22 localhost smartd=
[1554]: Device: /dev/hda, 1 Currently unreadable (pending) sectors=0A=0A   =
 Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Offline uncorr=
ectable sectors=0A=0A    Jan 29 18:26:19 localhost kernel: usb 2-1: USB dis=
connect, address 5=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0=
 down=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: Stopping security mana=
ger 0=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been d=
isabled=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unregister=
ed=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: Unregister path: /org/blu=
ez/hci0=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been=
 removed=0A=0A    Jan 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daem=
on=0A=0A    Jan 29 18:32:01 localhost hcid[15118]: Unknown option 'passkey'=
 line 24=0A=0A    Jan 29 18:32:01 localhost hcid[15118]: syntax error line =
24=0A=0A    Jan 29 18:32:01 localhost hcid[15118]: Can't get system message=
 bus name: Connection ":1.36" is not allowed to own the service "org.bluez"=
 due to security policies in the configuration file=0A=0A    Jan 29 18:32:0=
1 localhost hcid[15118]: Can't open PIN file /etc/bluetooth/pin: Permission=
 denied (13)=0A=0A    =0A=0A    =0A=0A    Can anyone please help me....=0A=
=0A    =0A=0A    Thanks in Advance...=0A=0A    Pramod=0A=0A    =0A=0A=0A=0A=
    =0A=0A    =0A=0A=0A=0A    5, 50, 500, 5000 - Store N number of mails in=
 your inbox. Click here.=0A------------------------------------------------=
-------------------------=0AThis SF.net email is sponsored by: Microsoft=0A=
Defy all challenges. Microsoft(R) Visual Studio 2008.=0Ahttp://clk.atdmt.co=
m/MRT/go/vse0120000070mrt/direct/01/=0A____________________________________=
___________ Bluez-users mailing list Bluez-users@lists.sourceforge.net http=
s://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=
=0A=0A      Get the freedom to save as many mails as you wish. To know how,=
 go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
--0-1757093411-1201614942=:65756
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">thank you sir for ur reply<br>i tried being root..<=
br>Now its working..but when i enter the PIN for HS BT device on my system =
it shows an error<br>[Pramod@localhost ~]$ sudo rfcomm connect 0 00:0F:DE:B=
1:02:42<br>Can't create RFCOMM TTY: Address already in use<br>whats the rea=
son....<br>Thanks in advance<br>Pramod<br><br><div style=3D"font-family: ti=
mes new roman,new york,times,serif; font-size: 12pt;">----- Original Messag=
e ----<br>From: Miguel &lt;mc354@tid.es&gt;<br>To: BlueZ users &lt;bluez-us=
ers@lists.sourceforge.net&gt;<br>Sent: Tuesday, 29 January, 2008 6:55:55 PM=
<br>Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission deni=
ed<br><br>=0A=0A=0A  =0A  =0A=0Arfcomm creates a devices in /dev/rfcomm0 in=
 your case. Check if you have the correct permissions. <br>=0A<br>=0ATry to=
 connect using root user ...<br>=0A<br>=0AOn Tue, 2008-01-29 at 18:37 +0530=
, pramod gurav wrote:=0A<blockquote type=3D"CITE">=0A    <font color=3D"#00=
0000">hi all, </font><br>=0A    <font color=3D"#000000">I am connection my =
system to Bt headset...</font><br>=0A    <font color=3D"#000000">But when i=
 try to connect it using </font><br>=0A    <font color=3D"#000000">$rfcomm =
connect 0 00:0F:DE:B1:02:42 </font><br>=0A    <font color=3D"#000000">error=
 comes......... Can't connect RFCOMM socket: Permission denied</font><br>=
=0A    <font color=3D"#000000">The /var/log/messages has following..</font>=
<br>=0A    <br>=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hci=
d[1406]: HCI dev 0 registered</font><br>=0A    <font color=3D"#000000">Jan =
29 18:03:17 localhost hcid[1406]: HCI dev 0 up</font><br>=0A    <font color=
=3D"#000000">Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been add=
ed</font><br>=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hcid[=
1406]: Starting security manager 0</font><br>=0A    <font color=3D"#000000"=
>Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activated</font=
><br>=0A    <font color=3D"#000000">Jan 29 18:06:47 localhost hcid[1406]: l=
ink_key_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)</font><b=
r>=0A    <font color=3D"#000000">Jan 29 18:06:47 localhost hcid[1406]: pin_=
code_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)</font><br>=
=0A    <font color=3D"#000000">Jan 29 18:11:13 localhost hcid[1406]: pin_co=
de_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)</font><br>=0A=
    <font color=3D"#000000">Jan 29 18:13:25 localhost last message repeated=
 2 times</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost=
 hcid[15000]: Bluetooth HCI daemon</font><br>=0A    <font color=3D"#000000"=
>Jan 29 18:14:03 localhost hcid[15000]: Unknown option 'passkey' line 24</f=
ont><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost hcid[15000=
]: syntax error line 24</font><br>=0A    <font color=3D"#000000">Jan 29 18:=
14:03 localhost hcid[15000]: syntax error line 34</font><br>=0A    <font co=
lor=3D"#000000">Jan 29 18:14:03 localhost hcid[15000]: Can't get system mes=
sage bus name: Connection ":1.34" is not allowed to own the service "org.bl=
uez" due to security policies in the configuration file</font><br>=0A    <f=
ont color=3D"#000000">Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN=
 file /etc/bluetooth/pin: Permission denied (13)</font><br>=0A    <font col=
or=3D"#000000">Jan 29 18:14:03 localhost hcid[15001]: Can't init device hci=
0: Permission denied (13)</font><br>=0A    <font color=3D"#000000">Jan 29 1=
8:14:03 localhost hcid[15002]: Can't set scan mode on hci0: Permission deni=
ed (13)</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost =
hcid[15002]: Can't set auth on hci0: Permission denied (13)</font><br>=0A  =
  <font color=3D"#000000">Jan 29 18:14:03 localhost hcid[15002]: Can't set =
encrypt on hci0: Permission denied (13)</font><br>=0A    <font color=3D"#00=
0000">Jan 29 18:14:03 localhost hcid[15000]: Starting security manager 0</f=
ont><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[15022=
]: Bluetooth HCI daemon</font><br>=0A    <font color=3D"#000000">Jan 29 18:=
18:10 localhost hcid[15022]: Unknown option 'passkey' line 24</font><br>=0A=
    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[15022]: syntax e=
rror line 24</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 local=
host hcid[15022]: syntax error line 34</font><br>=0A    <font color=3D"#000=
000">Jan 29 18:18:10 localhost hcid[15022]: Can't get system message bus na=
me: Connection ":1.35" is not allowed to own the service "org.bluez" due to=
 security policies in the configuration file</font><br>=0A    <font color=
=3D"#000000">Jan 29 18:18:10 localhost hcid[15022]: Can't open PIN file /et=
c/bluetooth/pin: Permission denied (13)</font><br>=0A    <font color=3D"#00=
0000">Jan 29 18:18:10 localhost hcid[15023]: Can't init device hci0: Permis=
sion denied (13)</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 l=
ocalhost hcid[15024]: Can't set scan mode on hci0: Permission denied (13)</=
font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[1502=
4]: Can't set auth on hci0: Permission denied (13)</font><br>=0A    <font c=
olor=3D"#000000">Jan 29 18:18:10 localhost hcid[15024]: Can't set encrypt o=
n hci0: Permission denied (13)</font><br>=0A    <font color=3D"#000000">Jan=
 29 18:18:10 localhost hcid[15022]: Starting security manager 0</font><br>=
=0A    <font color=3D"#000000">Jan 29 18:18:29 localhost hcid[15000]: Exit.=
</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:31 localhost hcid[15=
022]: Exit.</font><br>=0A    <font color=3D"#000000">Jan 29 18:20:22 localh=
ost smartd[1554]: Device: /dev/hda, 1 Currently unreadable (pending) sector=
s</font><br>=0A    <font color=3D"#000000">Jan 29 18:20:22 localhost smartd=
[1554]: Device: /dev/hda, 1 Offline uncorrectable sectors</font><br>=0A    =
<font color=3D"#000000">Jan 29 18:26:19 localhost kernel: usb 2-1: USB disc=
onnect, address 5</font><br>=0A    <font color=3D"#000000">Jan 29 18:26:19 =
localhost hcid[1406]: HCI dev 0 down</font><br>=0A    <font color=3D"#00000=
0">Jan 29 18:26:19 localhost hcid[1406]: Stopping security manager 0</font>=
<br>=0A    <font color=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: De=
vice hci0 has been disabled</font><br>=0A    <font color=3D"#000000">Jan 29=
 18:26:19 localhost hcid[1406]: HCI dev 0 unregistered</font><br>=0A    <fo=
nt color=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: Unregister path:=
 /org/bluez/hci0</font><br>=0A    <font color=3D"#000000">Jan 29 18:26:19 l=
ocalhost hcid[1406]: Device hci0 has been removed</font><br>=0A    <font co=
lor=3D"#000000">Jan 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daemon=
</font><br>=0A    <font color=3D"#000000">Jan 29 18:32:01 localhost hcid[15=
118]: Unknown option 'passkey' line 24</font><br>=0A    <font color=3D"#000=
000">Jan 29 18:32:01 localhost hcid[15118]: syntax error line 24</font><br>=
=0A    <font color=3D"#000000">Jan 29 18:32:01 localhost hcid[15118]: Can't=
 get system message bus name: Connection ":1.36" is not allowed to own the =
service "org.bluez" due to security policies in the configuration file</fon=
t><br>=0A    <font color=3D"#000000">Jan 29 18:32:01 localhost hcid[15118]:=
 Can't open PIN file /etc/bluetooth/pin: Permission denied (13)</font><br>=
=0A    <br>=0A    <br>=0A    <font color=3D"#000000">Can anyone please help=
 me....</font><br>=0A    <br>=0A    <font color=3D"#000000">Thanks in Advan=
ce...</font><br>=0A    <font color=3D"#000000">Pramod</font><br>=0A    <br>=
=0A</blockquote>=0A<blockquote type=3D"CITE">=0A    <br>=0A    =0A<hr size=
=3D"1">=0A<br>=0A    <font color=3D"#000000">5, 50, 500, 5000 - Store N num=
ber of mails in your inbox. <a rel=3D"nofollow" target=3D"_blank" href=3D"h=
ttp://in.rd.yahoo.com/tagline_mail_4/*http://help.yahoo.com/l/in/yahoo/mail=
/yahoomail/tools/tools-08.html/">Click here.</a></font>=0A<pre><font color=
=3D"#000000">--------------------------------------------------------------=
-----------</font>=0A<font color=3D"#000000">This SF.net email is sponsored=
 by: Microsoft</font>=0A<font color=3D"#000000">Defy all challenges. Micros=
oft(R) Visual Studio 2008.</font>=0A<font color=3D"#000000"><a rel=3D"nofol=
low" target=3D"_blank" href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt=
/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a></f=
ont>=0A<font color=3D"#000000">____________________________________________=
___ Bluez-users mailing list <a rel=3D"nofollow" ymailto=3D"mailto:Bluez-us=
ers@lists.sourceforge.net" target=3D"_blank" href=3D"mailto:Bluez-users@lis=
ts.sourceforge.net">Bluez-users@lists.sourceforge.net</a> <a rel=3D"nofollo=
w" target=3D"_blank" href=3D"https://lists.sourceforge.net/lists/listinfo/b=
luez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a></f=
ont>=0A</pre>=0A</blockquote>=0A</div><br></div></div><br>=0A=0A=0A      <!=
--5--><hr size=3D1></hr> Get the freedom to save as many mails as you wish.=
 <a href=3D"http://in.rd.yahoo.com/tagline_mail_5/*http://help.yahoo.com/l/=
in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here to know how.</a></=
body></html>
--0-1757093411-1201614942=:65756--



--===============1770900555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1770900555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1770900555==--
