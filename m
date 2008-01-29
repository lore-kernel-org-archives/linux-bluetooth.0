Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 19:44:37 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <269801.28820.qm@web8401.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1010987824=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1010987824==
Content-Type: multipart/alternative; boundary="0-1335289433-1201616077=:28820"

--0-1335289433-1201616077=:28820
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi miguel sir,=0ANeed i install ALSA plugins for this....=0ABut i read in a=
udio servicxe related doc that they are there in BLuez....=0AThanks=0APramo=
d=0A=0A=0A----- Original Message ----=0AFrom: pramod gurav <pramod_gurav_et=
c@yahoo.co.in>=0ATo: BlueZ users <bluez-users@lists.sourceforge.net>=0ASent=
: Tuesday, 29 January, 2008 7:38:31 PM=0ASubject: Re: [Bluez-users] Can't c=
onnect RFCOMM socket: Permission denied=0A=0Ahi Miguel sir,=0AI am able to =
connect now...=0Abut the connection lasts for only for few seconds..after i=
t gets disconnected,.=0AAlso the pop up is not comming on the system...it c=
ame only once...=0A=0AWhen i try to play audo file using=0A[Pramod@localhos=
t ~]$ mplayer_install/usr/local/bin/mplayer -ao alsa:device=3Dbluetooth 1.m=
p3=0Athis gives me error...=0A=0Abt_audio_service_open: connect() failed: C=
onnection refused (111)=0A[AO_ALSA] Playback open error: Connection refused=
=0ACould not open/initialize audio device -> no sound.=0AAudio: no sound=0A=
Video: no video=0A=0Awhats are the reason for these...dont i have alsa plug=
ins or what...=0Athanks in advance..=0APramod=0A=0A----- Original Message -=
---=0AFrom: Miguel <mc354@tid.es>=0ATo: BlueZ users <bluez-users@lists.sour=
ceforge.net>=0ASent: Tuesday, 29 January, 2008 6:55:55 PM=0ASubject: Re: [B=
luez-users] Can't connect RFCOMM socket: Permission denied=0A=0A=0A=0A=0A  =
=0A  =0A=0Arfcomm creates a devices in /dev/rfcomm0 in your case. Check if =
you have the correct permissions. =0A=0A=0A=0ATry to connect using root use=
r ...=0A=0A=0A=0AOn Tue, 2008-01-29 at 18:37 +0530, pramod gurav wrote:=0A=
=0A    hi all, =0A=0A    I am connection my system to Bt headset...=0A=0A  =
  But when i try to connect it using =0A=0A    $rfcomm connect 0 00:0F:DE:B=
1:02:42 =0A=0A    error comes......... Can't connect RFCOMM socket: Permiss=
ion denied=0A=0A    The /var/log/messages has following..=0A=0A    =0A=0A  =
  Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 registered=0A=0A    Jan 2=
9 18:03:17 localhost hcid[1406]: HCI dev 0 up=0A=0A    Jan 29 18:03:17 loca=
lhost hcid[1406]: Device hci0 has been added=0A=0A    Jan 29 18:03:17 local=
host hcid[1406]: Starting security manager 0=0A=0A    Jan 29 18:03:17 local=
host hcid[1406]: Device hci0 has been activated=0A=0A    Jan 29 18:06:47 lo=
calhost hcid[1406]: link_key_request (sba=3D00:00:00:00:00:00, dba=3D00:0F:=
DE:B1:02:42)=0A=0A    Jan 29 18:06:47 localhost hcid[1406]: pin_code_reques=
t (sba=3D00:00:00:00:00:00, dba=3D00:0F:DE:B1:02:42)=0A=0A    Jan 29 18:11:=
13 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D0=
0:0F:DE:B1:02:42)=0A=0A    Jan 29 18:13:25 localhost last message repeated =
2 times=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: Bluetooth HCI daemo=
n=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: Unknown option 'passkey' =
line 24=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: syntax error line 2=
4=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: syntax error line 34=0A=
=0A    Jan 29 18:14:03 localhost hcid[15000]: Can't get system message bus =
name: Connection ":1.34" is not allowed to own the service "org.bluez" due =
to security policies in the configuration file=0A=0A    Jan 29 18:14:03 loc=
alhost hcid[15000]: Can't open PIN file /etc/bluetooth/pin: Permission deni=
ed (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15001]: Can't init device h=
ci0: Permission denied (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15002]:=
 Can't set scan mode on hci0: Permission denied (13)=0A=0A    Jan 29 18:14:=
03 localhost hcid[15002]: Can't set auth on hci0: Permission denied (13)=0A=
=0A    Jan 29 18:14:03 localhost hcid[15002]: Can't set encrypt on hci0: Pe=
rmission denied (13)=0A=0A    Jan 29 18:14:03 localhost hcid[15000]: Starti=
ng security manager 0=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: Bluet=
ooth HCI daemon=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: Unknown opt=
ion 'passkey' line 24=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: synta=
x error line 24=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: syntax erro=
r line 34=0A=0A    Jan 29 18:18:10 localhost hcid[15022]: Can't get system =
message bus name: Connection ":1.35" is not allowed to own the service "org=
..bluez" due to security policies in the configuration file=0A=0A    Jan 29 =
18:18:10 localhost hcid[15022]: Can't open PIN file /etc/bluetooth/pin: Per=
mission denied (13)=0A=0A    Jan 29 18:18:10 localhost hcid[15023]: Can't i=
nit device hci0: Permission denied (13)=0A=0A    Jan 29 18:18:10 localhost =
hcid[15024]: Can't set scan mode on hci0: Permission denied (13)=0A=0A    J=
an 29 18:18:10 localhost hcid[15024]: Can't set auth on hci0: Permission de=
nied (13)=0A=0A    Jan 29 18:18:10 localhost hcid[15024]: Can't set encrypt=
 on hci0: Permission denied (13)=0A=0A    Jan 29 18:18:10 localhost hcid[15=
022]: Starting security manager 0=0A=0A    Jan 29 18:18:29 localhost hcid[1=
5000]: Exit.=0A=0A    Jan 29 18:18:31 localhost hcid[15022]: Exit.=0A=0A   =
 Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Currently unre=
adable (pending) sectors=0A=0A    Jan 29 18:20:22 localhost smartd[1554]: D=
evice: /dev/hda, 1 Offline uncorrectable sectors=0A=0A    Jan 29 18:26:19 l=
ocalhost kernel: usb 2-1: USB disconnect, address 5=0A=0A    Jan 29 18:26:1=
9 localhost hcid[1406]: HCI dev 0 down=0A=0A    Jan 29 18:26:19 localhost h=
cid[1406]: Stopping security manager 0=0A=0A    Jan 29 18:26:19 localhost h=
cid[1406]: Device hci0 has been disabled=0A=0A    Jan 29 18:26:19 localhost=
 hcid[1406]: HCI dev 0 unregistered=0A=0A    Jan 29 18:26:19 localhost hcid=
[1406]: Unregister path: /org/bluez/hci0=0A=0A    Jan 29 18:26:19 localhost=
 hcid[1406]: Device hci0 has been removed=0A=0A    Jan 29 18:32:01 localhos=
t hcid[15118]: Bluetooth HCI daemon=0A=0A    Jan 29 18:32:01 localhost hcid=
[15118]: Unknown option 'passkey' line 24=0A=0A    Jan 29 18:32:01 localhos=
t hcid[15118]: syntax error line 24=0A=0A    Jan 29 18:32:01 localhost hcid=
[15118]: Can't get system message bus name: Connection ":1.36" is not allow=
ed to own the service "org.bluez" due to security policies in the configura=
tion file=0A=0A    Jan 29 18:32:01 localhost hcid[15118]: Can't open PIN fi=
le /etc/bluetooth/pin: Permission denied (13)=0A=0A    =0A=0A    =0A=0A    =
Can anyone please help me....=0A=0A    =0A=0A    Thanks in Advance...=0A=0A=
    Pramod=0A=0A    =0A=0A=0A=0A    =0A=0A    =0A=0A=0A=0A    5, 50, 500, 5=
000 - Store N number of mails in your inbox. Click here.=0A----------------=
---------------------------------------------------------=0AThis SF.net ema=
il is sponsored by: Microsoft=0ADefy all challenges. Microsoft(R) Visual St=
udio 2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A____=
___________________________________________ Bluez-users mailing list Bluez-=
users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bl=
uez-users=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A       Meet people who discuss an=
d share your passions.  Join them now.=0A=0A=0A=0A=0A=0A      Save all your=
 chat conversations. Find them online at http://in.messenger.yahoo.com/webm=
essengerpromo.php
--0-1335289433-1201616077=:28820
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hi miguel sir,<br>Need i install ALSA plugins for t=
his....<br>But i read in audio servicxe related doc that they are there in =
BLuez....<br>Thanks<br>Pramod<br><br><br><div style=3D"font-family: times n=
ew roman,new york,times,serif; font-size: 12pt;">----- Original Message ---=
-<br>From: pramod gurav &lt;pramod_gurav_etc@yahoo.co.in&gt;<br>To: BlueZ u=
sers &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Tuesday, 29 January=
, 2008 7:38:31 PM<br>Subject: Re: [Bluez-users] Can't connect RFCOMM socket=
: Permission denied<br><br><div style=3D"font-family: times new roman,new y=
ork,times,serif; font-size: 12pt;"><div style=3D"font-family: times new rom=
an,new york,times,serif; font-size: 12pt;">hi Miguel sir,<br>I am able to
 connect now...<br>but the connection lasts for only for few seconds..after=
 it gets disconnected,.<br>Also the pop up is not comming on the system...i=
t came only once...<br><br>When i try to play audo file using<br>[Pramod@lo=
calhost ~]$ mplayer_install/usr/local/bin/mplayer -ao alsa:device=3Dbluetoo=
th 1.mp3<br>this gives me error...<br><br>bt_audio_service_open: connect() =
failed: Connection refused (111)<br>[AO_ALSA] Playback open error: Connecti=
on refused<br>Could not open/initialize audio device -&gt; no sound.<br>Aud=
io: no sound<br>Video: no video<br><br>whats are the reason for these...don=
t i have alsa plugins or what...<br>thanks in advance..<br>Pramod<br><br><d=
iv style=3D"font-family: times new roman,new york,times,serif; font-size: 1=
2pt;">----- Original Message ----<br>From: Miguel &lt;mc354@tid.es&gt;<br>T=
o: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Tuesday, =
29 January, 2008 6:55:55 PM<br>Subject: Re: [Bluez-users] Can't connect
 RFCOMM socket: Permission denied<br><br>=0A=0A=0A  =0A  =0A=0Arfcomm creat=
es a devices in /dev/rfcomm0 in your case. Check if you have the correct pe=
rmissions. <br>=0A<br>=0ATry to connect using root user ...<br>=0A<br>=0AOn=
 Tue, 2008-01-29 at 18:37 +0530, pramod gurav wrote:=0A<blockquote type=3D"=
CITE">=0A    <font color=3D"#000000">hi all, </font><br>=0A    <font color=
=3D"#000000">I am connection my system to Bt headset...</font><br>=0A    <f=
ont color=3D"#000000">But when i try to connect it using </font><br>=0A    =
<font color=3D"#000000">$rfcomm connect 0 00:0F:DE:B1:02:42 </font><br>=0A =
   <font color=3D"#000000">error comes......... Can't connect RFCOMM socket=
: Permission denied</font><br>=0A    <font color=3D"#000000">The /var/log/m=
essages has following..</font><br>=0A    <br>=0A    <font color=3D"#000000"=
>Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 registered</font><br>=0A  =
  <font color=3D"#000000">Jan 29 18:03:17 localhost hcid[1406]: HCI dev 0 u=
p</font><br>=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hcid[1=
406]: Device hci0 has been added</font><br>=0A    <font color=3D"#000000">J=
an 29 18:03:17 localhost hcid[1406]: Starting security manager 0</font><br>=
=0A    <font color=3D"#000000">Jan 29 18:03:17 localhost hcid[1406]: Device=
 hci0 has been activated</font><br>=0A    <font color=3D"#000000">Jan 29 18=
:06:47 localhost hcid[1406]: link_key_request (sba=3D00:00:00:00:00:00, dba=
=3D00:0F:DE:B1:02:42)</font><br>=0A    <font color=3D"#000000">Jan 29 18:06=
:47 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D=
00:0F:DE:B1:02:42)</font><br>=0A    <font color=3D"#000000">Jan 29 18:11:13=
 localhost hcid[1406]: pin_code_request (sba=3D00:00:00:00:00:00, dba=3D00:=
0F:DE:B1:02:42)</font><br>=0A    <font color=3D"#000000">Jan 29 18:13:25 lo=
calhost last message repeated 2 times</font><br>=0A    <font color=3D"#0000=
00">Jan 29 18:14:03 localhost hcid[15000]: Bluetooth HCI daemon</font><br>=
=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost hcid[15000]: Unkno=
wn option 'passkey' line 24</font><br>=0A    <font color=3D"#000000">Jan 29=
 18:14:03 localhost hcid[15000]: syntax error line 24</font><br>=0A    <fon=
t color=3D"#000000">Jan 29 18:14:03 localhost hcid[15000]: syntax error lin=
e 34</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost hci=
d[15000]: Can't get system message bus name: Connection ":1.34" is not allo=
wed to own the service "org.bluez" due to security policies in the configur=
ation file</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localho=
st hcid[15000]: Can't open PIN file /etc/bluetooth/pin: Permission denied (=
13)</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost hcid=
[15001]: Can't init device hci0: Permission denied (13)</font><br>=0A    <f=
ont color=3D"#000000">Jan 29 18:14:03 localhost hcid[15002]: Can't set scan=
 mode on hci0: Permission denied (13)</font><br>=0A    <font color=3D"#0000=
00">Jan 29 18:14:03 localhost hcid[15002]: Can't set auth on hci0: Permissi=
on denied (13)</font><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 loc=
alhost hcid[15002]: Can't set encrypt on hci0: Permission denied (13)</font=
><br>=0A    <font color=3D"#000000">Jan 29 18:14:03 localhost hcid[15000]: =
Starting security manager 0</font><br>=0A    <font color=3D"#000000">Jan 29=
 18:18:10 localhost hcid[15022]: Bluetooth HCI daemon</font><br>=0A    <fon=
t color=3D"#000000">Jan 29 18:18:10 localhost hcid[15022]: Unknown option '=
passkey' line 24</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 l=
ocalhost hcid[15022]: syntax error line 24</font><br>=0A    <font color=3D"=
#000000">Jan 29 18:18:10 localhost hcid[15022]: syntax error line 34</font>=
<br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[15022]: C=
an't get system message bus name: Connection ":1.35" is not allowed to own =
the service "org.bluez" due to security policies in the configuration file<=
/font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[150=
22]: Can't open PIN file /etc/bluetooth/pin: Permission denied (13)</font><=
br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[15023]: Ca=
n't init device hci0: Permission denied (13)</font><br>=0A    <font color=
=3D"#000000">Jan 29 18:18:10 localhost hcid[15024]: Can't set scan mode on =
hci0: Permission denied (13)</font><br>=0A    <font color=3D"#000000">Jan 2=
9 18:18:10 localhost hcid[15024]: Can't set auth on hci0: Permission denied=
 (13)</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:10 localhost hc=
id[15024]: Can't set encrypt on hci0: Permission denied (13)</font><br>=0A =
   <font color=3D"#000000">Jan 29 18:18:10 localhost hcid[15022]: Starting =
security manager 0</font><br>=0A    <font color=3D"#000000">Jan 29 18:18:29=
 localhost hcid[15000]: Exit.</font><br>=0A    <font color=3D"#000000">Jan =
29 18:18:31 localhost hcid[15022]: Exit.</font><br>=0A    <font color=3D"#0=
00000">Jan 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Currentl=
y unreadable (pending) sectors</font><br>=0A    <font color=3D"#000000">Jan=
 29 18:20:22 localhost smartd[1554]: Device: /dev/hda, 1 Offline uncorrecta=
ble sectors</font><br>=0A    <font color=3D"#000000">Jan 29 18:26:19 localh=
ost kernel: usb 2-1: USB disconnect, address 5</font><br>=0A    <font color=
=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 down</font><br=
>=0A    <font color=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: Stopp=
ing security manager 0</font><br>=0A    <font color=3D"#000000">Jan 29 18:2=
6:19 localhost hcid[1406]: Device hci0 has been disabled</font><br>=0A    <=
font color=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: HCI dev 0 unre=
gistered</font><br>=0A    <font color=3D"#000000">Jan 29 18:26:19 localhost=
 hcid[1406]: Unregister path: /org/bluez/hci0</font><br>=0A    <font color=
=3D"#000000">Jan 29 18:26:19 localhost hcid[1406]: Device hci0 has been rem=
oved</font><br>=0A    <font color=3D"#000000">Jan 29 18:32:01 localhost hci=
d[15118]: Bluetooth HCI daemon</font><br>=0A    <font color=3D"#000000">Jan=
 29 18:32:01 localhost hcid[15118]: Unknown option 'passkey' line 24</font>=
<br>=0A    <font color=3D"#000000">Jan 29 18:32:01 localhost hcid[15118]: s=
yntax error line 24</font><br>=0A    <font color=3D"#000000">Jan 29 18:32:0=
1 localhost hcid[15118]: Can't get system message bus name: Connection ":1.=
36" is not allowed to own the service "org.bluez" due to security policies =
in the configuration file</font><br>=0A    <font color=3D"#000000">Jan 29 1=
8:32:01 localhost hcid[15118]: Can't open PIN file /etc/bluetooth/pin: Perm=
ission denied (13)</font><br>=0A    <br>=0A    <br>=0A    <font color=3D"#0=
00000">Can anyone please help me....</font><br>=0A    <br>=0A    <font colo=
r=3D"#000000">Thanks in Advance...</font><br>=0A    <font color=3D"#000000"=
>Pramod</font><br>=0A    <br>=0A</blockquote>=0A<blockquote type=3D"CITE">=
=0A    <br>=0A    =0A<hr size=3D"1">=0A<br>=0A    <font color=3D"#000000">5=
, 50, 500, 5000 - Store N number of mails in your inbox. <a rel=3D"nofollow=
" target=3D"_blank" href=3D"http://in.rd.yahoo.com/tagline_mail_4/*http://h=
elp.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here.</=
a></font>=0A<pre><font color=3D"#000000">----------------------------------=
---------------------------------------</font>=0A<font color=3D"#000000">Th=
is SF.net email is sponsored by: Microsoft</font>=0A<font color=3D"#000000"=
>Defy all challenges. Microsoft(R) Visual Studio 2008.</font>=0A<font color=
=3D"#000000"><a rel=3D"nofollow" target=3D"_blank" href=3D"http://clk.atdmt=
..com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse012=
0000070mrt/direct/01/</a></font>=0A<font color=3D"#000000">________________=
_______________________________ Bluez-users mailing list <a rel=3D"nofollow=
" ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"_blank" hr=
ef=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourcefor=
ge.net</a> <a rel=3D"nofollow" target=3D"_blank" href=3D"https://lists.sour=
ceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists=
/listinfo/bluez-users</a></font>=0A</pre>=0A</blockquote>=0A</div><br></div=
></div><br>=0A=0A=0A      <hr size=3D"1"> Meet people who discuss and share=
 your passions. <a rel=3D"nofollow" target=3D"_blank" href=3D"http://in.rd.=
yahoo.com/tagline_groups_7/*http://in.promos.yahoo.com/groups"> Join them n=
ow.</a></div><br></div></div><br>=0A=0A=0A      <!--2--><hr size=3D1></hr> =
Unlimited freedom, unlimited storage. <a href=3D"http://in.rd.yahoo.com/tag=
line_mail_2/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08=
..html/">Get it now</a></body></html>
--0-1335289433-1201616077=:28820--



--===============1010987824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1010987824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1010987824==--
