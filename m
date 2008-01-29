Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 19:38:31 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <462043.24837.qm@web8401.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1569220895=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1569220895==
Content-Type: multipart/alternative; boundary="0-1269096528-1201615711=:24837"

--0-1269096528-1201615711=:24837
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi Miguel sir,=0AI am able to connect now...=0Abut the connection lasts for=
 only for few seconds..after it gets disconnected,.=0AAlso the pop up is no=
t comming on the system...it came only once...=0A=0AWhen i try to play audo=
 file using=0A[Pramod@localhost ~]$ mplayer_install/usr/local/bin/mplayer -=
ao alsa:device=3Dbluetooth 1.mp3=0Athis gives me error...=0A=0Abt_audio_ser=
vice_open: connect() failed: Connection refused (111)=0A[AO_ALSA] Playback =
open error: Connection refused=0ACould not open/initialize audio device -> =
no sound.=0AAudio: no sound=0AVideo: no video=0A=0Awhats are the reason for=
 these...dont i have alsa plugins or what...=0Athanks in advance..=0APramod=
=0A=0A----- Original Message ----=0AFrom: Miguel <mc354@tid.es>=0ATo: BlueZ=
 users <bluez-users@lists.sourceforge.net>=0ASent: Tuesday, 29 January, 200=
8 6:55:55 PM=0ASubject: Re: [Bluez-users] Can't connect RFCOMM socket: Perm=
ission denied=0A=0A=0A=0A=0A  =0A  =0A=0Arfcomm creates a devices in /dev/r=
fcomm0 in your case. Check if you have the correct permissions. =0A=0A=0A=
=0ATry to connect using root user ...=0A=0A=0A=0AOn Tue, 2008-01-29 at 18:3=
7 +0530, pramod gurav wrote:=0A=0A    hi all, =0A=0A    I am connection my =
system to Bt headset...=0A=0A    But when i try to connect it using =0A=0A =
   $rfcomm connect 0 00:0F:DE:B1:02:42 =0A=0A    error comes......... Can't=
 connect RFCOMM socket: Permission denied=0A=0A    The /var/log/messages ha=
s following..=0A=0A    =0A=0A    Jan 29 18:03:17 localhost hcid[1406]: HCI =
dev 0 registered=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 u=
p=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been added=
=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Starting security manager 0=
=0A=0A    Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activa=
ted=0A=0A    Jan 29 18:06:47 localhost hcid[1406]: link_key_request (sba=3D=
00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0A    Jan 29 18:06:47 localh=
ost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B=
1:02:42)=0A=0A    Jan 29 18:11:13 localhost hcid[1406]: pin_code_request (s=
ba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0A    Jan 29 18:13:25 l=
ocalhost last message repeated 2 times=0A=0A    Jan 29 18:14:03 localhost h=
cid[15000]: Bluetooth HCI daemon=0A=0A    Jan 29 18:14:03 localhost hcid[15=
000]: Unknown option 'passkey' line 24=0A=0A    Jan 29 18:14:03 localhost h=
cid[15000]: syntax error line 24=0A=0A    Jan 29 18:14:03 localhost hcid[15=
000]: syntax error line 34=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: =
Can't get system message bus name: Connection ":1.34" is not allowed to own=
 the service "org.bluez" due to security policies in the configuration file=
=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: Can't open PIN file /etc/b=
luetooth/pin: Permission denied (13)=0A=0A    Jan 29 18:14:03 localhost hci=
d[15001]: Can't init device hci0: Permission denied (13)=0A=0A    Jan 29 18=
:14:03 localhost hcid[15002]: Can't set scan mode on hci0: Permission denie=
d (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15002]: Can't set auth on hc=
i0: Permission denied (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15002]: =
Can't set encrypt on hci0: Permission denied (13)=0A=0A    Jan 29 18:14:03 =
localhost hcid[15000]: Starting security manager 0=0A=0A    Jan 29 18:18:10=
 localhost hcid[15022]: Bluetooth HCI daemon=0A=0A    Jan 29 18:18:10 local=
host hcid[15022]: Unknown option 'passkey' line 24=0A=0A    Jan 29 18:18:10=
 localhost hcid[15022]: syntax error line 24=0A=0A    Jan 29 18:18:10 local=
host hcid[15022]: syntax error line 34=0A=0A    Jan 29 18:18:10 localhost h=
cid[15022]: Can't get system message bus name: Connection ":1.35" is not al=
lowed to own the service "org.bluez" due to security policies in the config=
uration file=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: Can't open PIN=
 file /etc/bluetooth/pin: Permission denied (13)=0A=0A    Jan 29 18:18:10 l=
ocalhost hcid[15023]: Can't init device hci0: Permission denied (13)=0A=0A =
   Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode on hci0: Perm=
ission denied (13)=0A=0A    Jan 29 18:18:10 localhost hcid[15024]: Can't se=
t auth on hci0: Permission denied (13)=0A=0A    Jan 29 18:18:10 localhost h=
cid[15024]: Can't set encrypt on hci0: Permission denied (13)=0A=0A    Jan =
29 18:18:10 localhost hcid[15022]: Starting security manager 0=0A=0A    Jan=
 29 18:18:29 localhost hcid[15000]: Exit.=0A=0A    Jan 29 18:18:31 localhos=
t hcid[15022]: Exit.=0A=0A    Jan 29 18:20:22 localhost smartd[1554]: Devic=
e: /dev/hda, 1 Currently unreadable (pending) sectors=0A=0A    Jan 29 18:20=
:22 localhost smartd[1554]: Device: /dev/hda, 1 Offline uncorrectable secto=
rs=0A=0A    Jan 29 18:26:19 localhost kernel: usb 2-1: USB disconnect, addr=
ess 5=0A=0A    Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 down=0A=0A  =
  Jan 29 18:26:19 localhost hcid[1406]: Stopping security manager 0=0A=0A  =
  Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been disabled=0A=0A=
    Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unregistered=0A=0A    J=
an 29 18:26:19 localhost hcid[1406]: Unregister path: /org/bluez/hci0=0A=0A=
    Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been removed=0A=
=0A    Jan 29 18:32:01 localhost hcid[15118]: Bluetooth HCI daemon=0A=0A   =
 Jan 29 18:32:01 localhost hcid[15118]: Unknown option 'passkey' line 24=0A=
=0A    Jan 29 18:32:01 localhost hcid[15118]: syntax error line 24=0A=0A   =
 Jan 29 18:32:01 localhost hcid[15118]: Can't get system message bus name: =
Connection ":1.36" is not allowed to own the service "org.bluez" due to sec=
urity policies in the configuration file=0A=0A    Jan 29 18:32:01 localhost=
 hcid[15118]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13=
)=0A=0A    =0A=0A    =0A=0A    Can anyone please help me....=0A=0A    =0A=
=0A    Thanks in Advance...=0A=0A    Pramod=0A=0A    =0A=0A=0A=0A    =0A=0A=
    =0A=0A=0A=0A    5, 50, 500, 5000 - Store N number of mails in your inbo=
x. Click here.=0A----------------------------------------------------------=
---------------=0AThis SF.net email is sponsored by: Microsoft=0ADefy all c=
hallenges. Microsoft(R) Visual Studio 2008.=0Ahttp://clk.atdmt.com/MRT/go/v=
se0120000070mrt/direct/01/=0A______________________________________________=
_ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.=
sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=0A=0A      =
Now you can chat without downloading messenger. Go to http://in.messenger.y=
ahoo.com/webmessengerpromo.php
--0-1269096528-1201615711=:24837
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hi Miguel sir,<br>I am able to connect now...<br>bu=
t the connection lasts for only for few seconds..after it gets disconnected=
,.<br>Also the pop up is not comming on the system...it came only once...<b=
r><br>When i try to play audo file using<br>[Pramod@localhost ~]$ mplayer_i=
nstall/usr/local/bin/mplayer -ao alsa:device=3Dbluetooth 1.mp3<br>this give=
s me error...<br><br>bt_audio_service_open: connect() failed: Connection re=
fused (111)<br>[AO_ALSA] Playback open error: Connection refused<br>Could n=
ot open/initialize audio device -&gt; no sound.<br>Audio: no sound<br>Video=
: no video<br><br>whats are the reason for these...dont i have alsa plugins=
 or what...<br>thanks in advance..<br>Pramod<br><br><div style=3D"font-fami=
ly:
 times new roman,new york,times,serif; font-size: 12pt;">----- Original Mes=
sage ----<br>From: Miguel &lt;mc354@tid.es&gt;<br>To: BlueZ users &lt;bluez=
-users@lists.sourceforge.net&gt;<br>Sent: Tuesday, 29 January, 2008 6:55:55=
 PM<br>Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission d=
enied<br><br>=0A=0A=0A  =0A  =0A=0Arfcomm creates a devices in /dev/rfcomm0=
 in your case. Check if you have the correct permissions. <br>=0A<br>=0ATry=
 to connect using root user ...<br>=0A<br>=0AOn Tue, 2008-01-29 at 18:37 +0=
530, pramod gurav wrote:=0A<blockquote type=3D"CITE">=0A    <font color=3D"=
#000000">hi all, </font><br>=0A    <font color=3D"#000000">I am connection =
my system to Bt headset...</font><br>=0A    <font color=3D"#000000">But whe=
n i try to connect it using </font><br>=0A    <font color=3D"#000000">$rfco=
mm connect 0 00:0F:DE:B1:02:42 </font><br>=0A    <font color=3D"#000000">er=
ror comes......... Can't connect RFCOMM socket: Permission denied</font><br=
>=0A    <font color=3D"#000000">The /var/log/messages has following..</font=
><br>=0A    <br>=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hc=
id[1406]: HCI dev 0 registered</font><br>=0A    <font color=3D"#000000">Jan=
 29 18:03:17 localhost hcid[1406]: HCI dev 0 up</font><br>=0A    <font colo=
r=3D"#000000">Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been ad=
ded</font><br>=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hcid=
[1406]: Starting security manager 0</font><br>=0A    <font color=3D"#000000=
">Jan 29 18:03:17 localhost hcid[1406]: Device hci0 has been activated</fon=
t><br>=0A    <font color=3D"#000000">Jan 29 18:06:47 localhost hcid[1406]: =
link_key_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)</font><=
br>=0A    <font color=3D"#000000">Jan 29 18:06:47 localhost hcid[1406]: pin=
_code_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)</font><br>=
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
--7--><hr size=3D1></hr> Meet people who discuss and share your passions. <=
a href=3D"http://in.rd.yahoo.com/tagline_groups_7/*http://in.promos.yahoo.c=
om/groups"> Join them now.</a></body></html>
--0-1269096528-1201615711=:24837--



--===============1569220895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1569220895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1569220895==--
