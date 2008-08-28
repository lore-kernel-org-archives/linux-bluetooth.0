Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Aug 2008 09:41:48 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <42300.41687.qm@web8406.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Does not work BT headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0377663447=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0377663447==
Content-Type: multipart/alternative; boundary="0-2076315751-1219896708=:41687"

--0-2076315751-1219896708=:41687
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Send the output  of=0A$ hcitool conn=0AIt should show both SCO and ACL conn=
ections.=0A=0Aand have you run =0A$ passkey-agent --default 0000 &=0Atry ru=
nning this. This is way to set the PIN for authentication.=0A And how do yo=
u connect before running mplayer?=0AWhen you run mplayer it will automatica=
lly establish connection. So no need to do it manually if you are doing so.=
=0A=0A=0A Thanks and Best regards=0A=0A=0APramod=0A=0A=0A=0A----- Original =
Message ----=0AFrom: Murat D. Kadirov <banderols@gmail.com>=0ATo: bluez-use=
rs@lists.sourceforge.net=0ASent: Wednesday, 27 August, 2008 6:57:37 PM=0ASu=
bject: [Bluez-users] Does not work BT headset=0A=0ASubj. I want to use my J=
abra BT-125I with VoIP. I have=0Akernel 2.6.25.16=0Abluez-libs-3.26=0Abluez=
-utils-3.26=0A=0Aroot@darkstar:~# hciconfig -a=0Ahci0:    Type: USB=0ABD Ad=
dress: 00:02:5B:0B:62:DC ACL MTU: 310:10 SCO MTU: 64:8=0AUP RUNNING PSCAN I=
SCAN =0ARX bytes:6905 acl:115 sco:0 events:243 errors:0=0ATX bytes:3023 acl=
:102 sco:0 commands:80 errors:0=0AFeatures: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0=
x00 0x80=0APacket type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 =0ALink policy:=
 RSWITCH HOLD SNIFF PARK =0ALink mode: SLAVE ACCEPT =0AName: 'BlueZ (0)'=0A=
Class: 0x000100=0AService Classes: Unspecified=0ADevice Class: Computer, Un=
categorized=0AHCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subv=
er: 0xc5c=0AManufacturer: Cambridge Silicon Radio (10)=0A=0Amurat[~]$ cat .=
asoundrc =0Apcm.bluetooth {=0A   type bluetooth=0A   device 00:16:8F:DA:83:=
75=0A}=0A=0Aroot@darkstar:~# cat /etc/bluetooth/passkeys/default=0A0000=0A=
=0A/etc/rc.d/rc.bluetooth start=0A=0Ain /var/log/message:=0A=0AAug 27 19:08=
:09 darkstar hcid[5728]: Bluetooth HCI daemon=0AAug 27 19:08:09 darkstar sd=
pd[5730]: Bluetooth SDP daemon=0AAug 27 19:08:09 darkstar sdpd[5730]: Start=
ing SDP server=0AAug 27 19:08:09 darkstar hcid[5728]: HCI dev 0 registered=
=0AAug 27 19:08:09 darkstar hcid[5728]: HCI dev 0 already up=0AAug 27 19:08=
:09 darkstar hcid[5728]: Device hci0 has been added=0AAug 27 19:08:09 darks=
tar hcid[5728]: Starting security manager 0=0AAug 27 19:08:10 darkstar hcid=
[5728]: Device hci0 has been activated=0AAug 27 19:08:10 darkstar hcid[5728=
]: Created local server at=0Aunix:abstract=3D/var/run/dbus-PGjXVjD9xD,guid=
=3Ddaeabde0d6b435052d3bea3e48b551ba=0AAug 27 19:08:10 darkstar input[5740]:=
 Bluetooth Input daemon=0AAug 27 19:08:10 darkstar audio[5741]: Bluetooth A=
udio daemon=0AAug 27 19:08:10 darkstar input[5740]: Registered input manage=
r=0Apath:/org/bluez/input=0AAug 27 19:08:10 darkstar audio[5741]: Unix sock=
et created: 5=0AAug 27 19:08:10 darkstar hcid[5728]: Default passkey agent =
(:1.43,=0A/org/bluez/passkey_agent_5737) registered=0AAug 27 19:08:10 darks=
tar audio[5741]: Registered manager=0Apath:/org/bluez/audio=0AAug 27 19:08:=
10 darkstar audio[5741]: Loading device 00:16:8F:DA:83:75=0A(headset )=0AAu=
g 27 19:08:10 darkstar audio[5741]: Setting 00:16:8F:DA:83:75 as=0Adefault =
device=0A=0Ain /var/log/debug:=0A=0AAug 27 19:08:10 darkstar audio[5741]: a=
udio.conf:=0A/etc/bluetooth/audio.conf: key Enable not found=0AAug 27 19:08=
:10 darkstar audio[5741]: audio.conf:=0A/etc/bluetooth/audio.conf: key Disa=
ble not found=0AAug 27 19:08:10 darkstar audio[5741]: add_service_record: g=
ot record id=0A0x10000=0AAug 27 19:08:10 darkstar audio[5741]: audio.conf:=
=0A/etc/bluetooth/audio.conf: key Disable not found=0AAug 27 19:08:10 darks=
tar audio[5741]: audio.conf:=0A/etc/bluetooth/audio.conf: group A2DP not fo=
und=0AAug 27 19:08:10 darkstar last message repeated 3 times=0AAug 27 19:08=
:10 darkstar audio[5741]: SEP 0x8069130 registered: type:0=0Acodec:0 seid:1=
=0AAug 27 19:08:10 darkstar audio[5741]: add_service_record: got record id=
=0A0x10001=0AAug 27 19:08:10 darkstar audio[5741]: add_service_record: got =
record id=0A0x10002=0AAug 27 19:08:10 darkstar audio[5741]: add_service_rec=
ord: got record id=0A0x10003=0AAug 27 19:08:10 darkstar audio[5741]: Got pa=
th /org/bluez/hci0 for=0Aadapter with address 00:02:5B:0B:62:DC=0AAug 27 19=
:08:10 darkstar audio[5741]: Selecting default device=0A=0AWhen I connect h=
eadset and run mplayer -ao alsa:device=3Dbluetooth track_01.mp3=0AVery sile=
nt whistle is audible.=0A=0Ain /var/log/messages:=0A=0AAug 27 19:12:12 dark=
star hcid[5728]: link_key_request=0A(sba=3D00:02:5B:0B:62:DC, dba=3D00:16:8=
F:DA:83:75)=0AAug 27 19:12:13 darkstar hcid[5728]: link_key_notify=0A(sba=
=3D00:02:5B:0B:62:DC, dba=3D00:16:8F:DA:83:75)=0AAug 27 19:14:09 darkstar a=
udio[5741]: Audio API: received=0ABT_GETCAPABILITIES_REQ=0AAug 27 19:14:09 =
darkstar audio[5741]: Audio API: sending=0ABT_GETCAPABILITIES_RSP=0AAug 27 =
19:14:09 darkstar audio[5741]: Audio API: received=0ABT_SETCONFIGURATION_RE=
Q=0AAug 27 19:14:09 darkstar audio[5741]: config sco - device =3D=0A00:16:8=
F:DA:83:75 access_mode =3D 2=0AAug 27 19:14:10 darkstar hcid[5728]: link_ke=
y_request=0A(sba=3D00:02:5B:0B:62:DC, dba=3D00:16:8F:DA:83:75)=0AAug 27 19:=
14:51 darkstar audio[5741]: Audio API: sending=0ABT_SETCONFIGURATION_RSP=0A=
=0Ain /var/log/syslog=0A=0AAug 27 19:12:13 darkstar audio[5741]: Access den=
ied: Authorization agent=0Adoes not exist=0AAug 27 19:14:51 darkstar audio[=
5741]: connect(): Connection timed out=0A(110)=0AAug 27 19:14:51 darkstar a=
udio[5741]: config failed=0A=0Ain /var/log/debug=0A=0AAug 27 19:12:13 darks=
tar audio[5741]: Requesting authorization for=0Adevice 00:16:8F:DA:83:75, U=
UID 00001112-0000-1000-8000-00805F9B34FB=0AAug 27 19:12:13 darkstar audio[5=
741]: State changed=0A/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED =
->=0AHEADSET_STATE_CONNECT_IN_PROGRESS=0AAug 27 19:12:13 darkstar audio[574=
1]: State changed=0A/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROG=
RESS ->=0AHEADSET_STATE_DISCONNECTED=0AAug 27 19:14:09 darkstar audio[5741]=
: Accepted new client connection on=0Aunix socket (fd=3D9)=0AAug 27 19:14:0=
9 darkstar audio[5741]: State changed=0A/org/bluez/audio/device0: HEADSET_S=
TATE_DISCONNECTED ->=0AHEADSET_STATE_CONNECT_IN_PROGRESS=0AAug 27 19:14:10 =
darkstar audio[5741]: /org/bluez/audio/device0:=0AConnecting to 00:16:8F:DA=
:83:75 channel 2=0A=0AWhat have I made not correctly? I have goggled very m=
uch, but did not=0Afind anything helpful. Anyone have tips that can help?=
=0AThanks.=0A=0A-- =0AMurat D. Kadirov=0A=0A-------------------------------=
------------------------------------------=0AThis SF.Net email is sponsored=
 by the Moblin Your Move Developer's challenge=0ABuild the coolest Linux ba=
sed applications with Moblin SDK & win great prizes=0AGrand prize is a trip=
 for two to an Open Source event anywhere in the world=0Ahttp://moblin-cont=
est.org/redirect.php?banner_id=3D100&url=3D/=0A____________________________=
___________________=0ABluez-users mailing list=0ABluez-users@lists.sourcefo=
rge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=
=0A      Unlimited freedom, unlimited storage. Get it now, on http://help.y=
ahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
--0-2076315751-1219896708=:41687
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Send the output&nbsp; of<br>$ hcitool conn<br>It should sho=
w both SCO and ACL connections.<br><br>and have you run <br>$ passkey-agent=
 --default 0000 &amp;<br>try running this. This is way to set the PIN for a=
uthentication.<br>&nbsp;And how do you connect before running mplayer?<br>W=
hen you run mplayer it will automatically establish connection. So no need =
to do it manually if you are doing so.<br><br><div>&nbsp;</div>Thanks and B=
est regards<br><br><div>Pramod<div><br></div><div style=3D"font-family: tim=
es new roman,new york,times,serif; font-size: 12pt;"><br><div style=3D"font=
-family: arial,helvetica,sans-serif; font-size: 10pt;">----- Original Messa=
ge ----<br>From: Murat D. Kadirov &lt;banderols@gmail.com&gt;<br>To: bluez-=
users@lists.sourceforge.net<br>Sent: Wednesday, 27 August, 2008 6:57:37
 PM<br>Subject: [Bluez-users] Does not work BT headset<br><br>Subj. I want =
to use my Jabra BT-125I with VoIP. I have<br>kernel 2.6.25.16<br>bluez-libs=
-3.26<br>bluez-utils-3.26<br><br>root@darkstar:~# hciconfig -a<br>hci0:&nbs=
p;&nbsp;&nbsp; Type: USB<br>BD Address: 00:02:5B:0B:62:DC ACL MTU: 310:10 S=
CO MTU: 64:8<br>UP RUNNING PSCAN ISCAN <br>RX bytes:6905 acl:115 sco:0 even=
ts:243 errors:0<br>TX bytes:3023 acl:102 sco:0 commands:80 errors:0<br>Feat=
ures: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80<br>Packet type: DM1 DM3 DM5 D=
H1 DH3 DH5 HV1 HV2 HV3 <br>Link policy: RSWITCH HOLD SNIFF PARK <br>Link mo=
de: SLAVE ACCEPT <br>Name: 'BlueZ (0)'<br>Class: 0x000100<br>Service Classe=
s: Unspecified<br>Device Class: Computer, Uncategorized<br>HCI Ver: 2.0 (0x=
3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c<br>Manufacturer: Cam=
bridge Silicon Radio (10)<br><br>murat[~]$ cat .asoundrc <br>pcm.bluetooth =
{<br>&nbsp;  type bluetooth<br>&nbsp;  device
 00:16:8F:DA:83:75<br>}<br><br>root@darkstar:~# cat /etc/bluetooth/passkeys=
/default<br>0000<br><br>/etc/rc.d/rc.bluetooth start<br><br>in /var/log/mes=
sage:<br><br>Aug 27 19:08:09 darkstar hcid[5728]: Bluetooth HCI daemon<br>A=
ug 27 19:08:09 darkstar sdpd[5730]: Bluetooth SDP daemon<br>Aug 27 19:08:09=
 darkstar sdpd[5730]: Starting SDP server<br>Aug 27 19:08:09 darkstar hcid[=
5728]: HCI dev 0 registered<br>Aug 27 19:08:09 darkstar hcid[5728]: HCI dev=
 0 already up<br>Aug 27 19:08:09 darkstar hcid[5728]: Device hci0 has been =
added<br>Aug 27 19:08:09 darkstar hcid[5728]: Starting security manager 0<b=
r>Aug 27 19:08:10 darkstar hcid[5728]: Device hci0 has been activated<br>Au=
g 27 19:08:10 darkstar hcid[5728]: Created local server at<br>unix:abstract=
=3D/var/run/dbus-PGjXVjD9xD,guid=3Ddaeabde0d6b435052d3bea3e48b551ba<br>Aug =
27 19:08:10 darkstar input[5740]: Bluetooth Input daemon<br>Aug 27 19:08:10=
 darkstar audio[5741]: Bluetooth Audio daemon<br>Aug 27 19:08:10
 darkstar input[5740]: Registered input manager<br>path:/org/bluez/input<br=
>Aug 27 19:08:10 darkstar audio[5741]: Unix socket created: 5<br>Aug 27 19:=
08:10 darkstar hcid[5728]: Default passkey agent (:1.43,<br>/org/bluez/pass=
key_agent_5737) registered<br>Aug 27 19:08:10 darkstar audio[5741]: Registe=
red manager<br>path:/org/bluez/audio<br>Aug 27 19:08:10 darkstar audio[5741=
]: Loading device 00:16:8F:DA:83:75<br>(headset )<br>Aug 27 19:08:10 darkst=
ar audio[5741]: Setting 00:16:8F:DA:83:75 as<br>default device<br><br>in /v=
ar/log/debug:<br><br>Aug 27 19:08:10 darkstar audio[5741]: audio.conf:<br>/=
etc/bluetooth/audio.conf: key Enable not found<br>Aug 27 19:08:10 darkstar =
audio[5741]: audio.conf:<br>/etc/bluetooth/audio.conf: key Disable not foun=
d<br>Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got record i=
d<br>0x10000<br>Aug 27 19:08:10 darkstar audio[5741]: audio.conf:<br>/etc/b=
luetooth/audio.conf: key Disable not found<br>Aug 27 19:08:10
 darkstar audio[5741]: audio.conf:<br>/etc/bluetooth/audio.conf: group A2DP=
 not found<br>Aug 27 19:08:10 darkstar last message repeated 3 times<br>Aug=
 27 19:08:10 darkstar audio[5741]: SEP 0x8069130 registered: type:0<br>code=
c:0 seid:1<br>Aug 27 19:08:10 darkstar audio[5741]: add_service_record: got=
 record id<br>0x10001<br>Aug 27 19:08:10 darkstar audio[5741]: add_service_=
record: got record id<br>0x10002<br>Aug 27 19:08:10 darkstar audio[5741]: a=
dd_service_record: got record id<br>0x10003<br>Aug 27 19:08:10 darkstar aud=
io[5741]: Got path /org/bluez/hci0 for<br>adapter with address 00:02:5B:0B:=
62:DC<br>Aug 27 19:08:10 darkstar audio[5741]: Selecting default device<br>=
<br>When I connect headset and run mplayer -ao alsa:device=3Dbluetooth trac=
k_01.mp3<br>Very silent whistle is audible.<br><br>in /var/log/messages:<br=
><br>Aug 27 19:12:12 darkstar hcid[5728]: link_key_request<br>(sba=3D00:02:=
5B:0B:62:DC, dba=3D00:16:8F:DA:83:75)<br>Aug 27 19:12:13 darkstar
 hcid[5728]: link_key_notify<br>(sba=3D00:02:5B:0B:62:DC, dba=3D00:16:8F:DA=
:83:75)<br>Aug 27 19:14:09 darkstar audio[5741]: Audio API: received<br>BT_=
GETCAPABILITIES_REQ<br>Aug 27 19:14:09 darkstar audio[5741]: Audio API: sen=
ding<br>BT_GETCAPABILITIES_RSP<br>Aug 27 19:14:09 darkstar audio[5741]: Aud=
io API: received<br>BT_SETCONFIGURATION_REQ<br>Aug 27 19:14:09 darkstar aud=
io[5741]: config sco - device =3D<br>00:16:8F:DA:83:75 access_mode =3D 2<br=
>Aug 27 19:14:10 darkstar hcid[5728]: link_key_request<br>(sba=3D00:02:5B:0=
B:62:DC, dba=3D00:16:8F:DA:83:75)<br>Aug 27 19:14:51 darkstar audio[5741]: =
Audio API: sending<br>BT_SETCONFIGURATION_RSP<br><br>in /var/log/syslog<br>=
<br>Aug 27 19:12:13 darkstar audio[5741]: Access denied: Authorization agen=
t<br>does not exist<br>Aug 27 19:14:51 darkstar audio[5741]: connect(): Con=
nection timed out<br>(110)<br>Aug 27 19:14:51 darkstar audio[5741]: config =
failed<br><br>in /var/log/debug<br><br>Aug 27 19:12:13 darkstar audio[5741]=
:
 Requesting authorization for<br>device 00:16:8F:DA:83:75, UUID 00001112-00=
00-1000-8000-00805F9B34FB<br>Aug 27 19:12:13 darkstar audio[5741]: State ch=
anged<br>/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -&gt;<br>HEAD=
SET_STATE_CONNECT_IN_PROGRESS<br>Aug 27 19:12:13 darkstar audio[5741]: Stat=
e changed<br>/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -&=
gt;<br>HEADSET_STATE_DISCONNECTED<br>Aug 27 19:14:09 darkstar audio[5741]: =
Accepted new client connection on<br>unix socket (fd=3D9)<br>Aug 27 19:14:0=
9 darkstar audio[5741]: State changed<br>/org/bluez/audio/device0: HEADSET_=
STATE_DISCONNECTED -&gt;<br>HEADSET_STATE_CONNECT_IN_PROGRESS<br>Aug 27 19:=
14:10 darkstar audio[5741]: /org/bluez/audio/device0:<br>Connecting to 00:1=
6:8F:DA:83:75 channel 2<br><br>What have I made not correctly? I have goggl=
ed very much, but did not<br>find anything helpful. Anyone have tips that c=
an help?<br>Thanks.<br><br>-- <br>Murat D.
 Kadirov<br><br>-----------------------------------------------------------=
--------------<br>This SF.Net email is sponsored by the Moblin Your Move De=
veloper's challenge<br>Build the coolest Linux based applications with Mobl=
in SDK &amp; win great prizes<br>Grand prize is a trip for two to an Open S=
ource event anywhere in the world<br><a href=3D"http://moblin-contest.org/r=
edirect.php?banner_id=3D100&amp;url=3D/" target=3D"_blank">http://moblin-co=
ntest.org/redirect.php?banner_id=3D100&amp;url=3D/</a><br>_________________=
______________________________<br>Bluez-users mailing list<br><a ymailto=3D=
"mailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:Bluez-users@lists=
.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https=
://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank">http=
s://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></div></div></d=
iv></div><br>=0A=0A=0A      <!--2--><hr size=3D1></hr> Did you know? You ca=
n CHAT without downloading messenger. <a href=3D"http://in.rd.yahoo.com/tag=
line_webmessenger_2/*http://in.webmessenger.yahoo.com/"> Click here</a></bo=
dy></html>
--0-2076315751-1219896708=:41687--


--===============0377663447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0377663447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0377663447==--
