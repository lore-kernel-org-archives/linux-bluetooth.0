Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 16:04:19 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <240808.31000.qm@web8406.mail.in.yahoo.com>
Subject: Re: [Bluez-devel] system hangs playing audio on headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1333826642=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1333826642==
Content-Type: multipart/alternative; boundary="0-2098922758-1202294059=:31000"

--0-2098922758-1202294059=:31000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks again =0Ahere are things I dif this time. i used hcid =0Afrom =0A3.2=
5 this earlier it was default one..=0Ai Killed hcid, sdpd=0A1....[root@loca=
lhost Pramod]# /usr/local/sbin/hcid -f /etc/bluetooth/hcid.conf=0A2....[roo=
t@localhost Pramod]# /usr/local/sbin/sdpd=0AIn /var/log/messages i got thes=
e....=0A=0AFeb  6 16:00:54 localhost hcid[13679]: Bluetooth HCI daemon=0AFe=
b  6 16:00:54 localhost hcid[13679]: HCI dev 0 registered=0AFeb  6 16:00:54=
 localhost hcid[13679]: HCI dev 0 already up=0AFeb  6 16:00:54 localhost hc=
id[13679]: Device hci0 has been added=0AFeb  6 16:00:54 localhost hcid[1367=
9]: Starting security manager 0=0AFeb  6 16:00:54 localhost hcid[13679]: De=
vice hci0 has been activated=0AFeb  6 16:00:54 localhost hcid[13679]: Creat=
ed local server at unix:abstract=3D/var/run/dbus-n166L1zFtk,guid=3D5e8ca947=
0269ae5e1dc9e1530dd0fd00=0AFeb  6 16:00:55 localhost audio[13682]: Bluetoot=
h Audio daemon=0AFeb  6 16:00:55 localhost audio[13682]: Unix socket create=
d: 5=0AFeb  6 16:00:55 localhost input[13683]: Bluetooth Input daemon=0AFeb=
  6 16:00:55 localhost input[13683]: Registered input manager path:/org/blu=
ez/input=0AFeb  6 16:00:55 localhost input[13683]: Failed to listen on cont=
rol channel=0AFeb  6 16:00:55 localhost hcid[13679]: Can't connect to SDP d=
aemon:(Connection refused, 111)=0AFeb  6 16:00:55 localhost hcid[13679]: Fa=
iled to register service record=0AFeb  6 16:00:55 localhost audio[13682]: A=
dding service record failed: Connection refused=0AFeb  6 16:00:55 localhost=
 audio[13682]: Unable to register HS AG service record=0AFeb  6 16:00:55 lo=
calhost audio[13682]: Unregistered manager path=0AFeb  6 16:00:55 localhost=
 audio[13682]: Audio init failed!=0AFeb  6 16:01:39 localhost audio[13690]:=
 Bluetooth Audio daemon=0AFeb  6 16:01:39 localhost audio[13690]: Unix sock=
et created: 5=0AFeb  6 16:01:39 localhost hcid[13679]: Can't connect to SDP=
 daemon:(Connection refused, 111)=0AFeb  6 16:01:39 localhost hcid[13679]: =
Failed to register service record=0AFeb  6 16:01:39 localhost audio[13690]:=
 Adding service record failed: Connection refused=0AFeb  6 16:01:39 localho=
st audio[13690]: Unable to register HS AG service record=0AFeb  6 16:01:39 =
localhost audio[13690]: Unregistered manager path=0AFeb  6 16:01:39 localho=
st audio[13690]: Audio init failed!=0AWhat are these failures?=0ANeed i run=
 /usr/local/lib/bluetooth/bluetoothd-service-audio agian..?? =0AThanks and =
Best regards =0APramod=0A=0A----- Original Message ----=0AFrom: Marcel Holt=
mann <marcel@holtmann.org>=0ATo: BlueZ development <bluez-devel@lists.sourc=
eforge.net>=0ASent: Wednesday, 6 February, 2008 3:36:18 PM=0ASubject: Re: [=
Bluez-devel] system hangs playing audio on headset=0A=0AHi =0APramod,=0A=0A=
> =0AThanks =0Afor =0Athat =0Ahint=0A> =0AWhen =0AI =0Atry =0A> =0A[root@lo=
calhost=0A> =0APramod]# =0A/usr/local/lib/bluetooth/bluetoothd-service-audi=
o=0A> =0Athis =0Ais =0Anot =0Aworking....=0A> =0Aaudio[13117]: =0ABluetooth=
 =0AAudio =0Adaemon=0A> =0Aaudio[13117]: =0AUnix =0Asocket =0Acreated: =0A5=
=0A> =0Aaudio[13117]: =0Aaudio.conf: =0A/etc/bluetooth/audio.conf: =0Akey =
=0AEnable =0Anot=0A> =0Afound=0A> =0Aaudio[13117]: =0Aaudio.conf: =0A/etc/b=
luetooth/audio.conf: =0Akey =0ADisable =0Anot=0A> =0Afound=0A> =0Aaudio[131=
17]: =0AAdding =0Aservice =0Arecord =0Afailed: =0AMethod =0A"AddServiceReco=
rd"=0A> =0Awith =0Asignature =0A"ay" =0Aon =0Ainterface =0A"org.bluez.Datab=
ase" =0Adoesn't =0Aexist=0A> =0Aaudio[13117]: =0AUnable =0Ato =0Aregister =
=0AHS =0AAG =0Aservice =0Arecord=0A> =0Aaudio[13117]: =0AUnregistered =0Ama=
nager =0Apath=0A> =0Aaudio[13117]: =0AAudio =0Ainit =0Afailed!=0A> =0A> =0A=
I =0Asaw =0Athose =0AAddServiceRecord =0Ascripts =0Aon =0Abluez_Audio_HowTO=
..=0A> =0AHow =0Ato =0Awork =0Athem =0Aout?=0A=0Amake =0Asure =0Ayou =0Aare=
 =0Aactually =0Arunning =0Ahcid =0Afrom =0A3.25 =0Aand =0Anot =0Asome =0Adi=
stribution =0Adefault.=0A=0ARegards=0A=0AMarcel=0A=0A=0A=0A----------------=
---------------------------------------------------------=0AThis =0ASF.net =
=0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges=
. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/g=
o/vse0120000070mrt/direct/01/=0A___________________________________________=
____=0ABluez-devel =0Amailing =0Alist=0ABluez-devel@lists.sourceforge.net=
=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-devel=0A=0A=0A=0A=0A=
=0A=0A=0A      Chat on a cool, new interface. No download required. Go to h=
ttp://in.messenger.yahoo.com/webmessengerpromo.php
--0-2098922758-1202294059=:31000
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Thanks again <br>here are things I dif this time. i used hc=
id =0Afrom =0A3.25 this earlier it was default one..<br>i Killed hcid, sdpd=
<br>1....[root@localhost Pramod]# /usr/local/sbin/hcid -f /etc/bluetooth/hc=
id.conf<br>2....[root@localhost Pramod]# /usr/local/sbin/sdpd<br>In /var/lo=
g/messages i got these....<br><br>Feb&nbsp; 6 16:00:54 localhost hcid[13679=
]: Bluetooth HCI daemon<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: HCI =
dev 0 registered<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: HCI dev 0 a=
lready up<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: Device hci0 has be=
en added<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: Starting security m=
anager 0<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: Device hci0 has bee=
n activated<br>Feb&nbsp; 6 16:00:54 localhost hcid[13679]: Created local se=
rver at unix:abstract=3D/var/run/dbus-n166L1zFtk,guid=3D5e8ca9470269ae5e1dc=
9e1530dd0fd00<br>Feb&nbsp; 6 16:00:55 localhost audio[13682]: Bluetooth Aud=
io daemon<br>Feb&nbsp; 6 16:00:55 localhost audio[13682]: Unix socket creat=
ed:
 5<br>Feb&nbsp; 6 16:00:55 localhost input[13683]: Bluetooth Input daemon<b=
r>Feb&nbsp; 6 16:00:55 localhost input[13683]: Registered input manager pat=
h:/org/bluez/input<br>Feb&nbsp; 6 16:00:55 localhost input[13683]: Failed t=
o listen on control channel<br>Feb&nbsp; 6 16:00:55 localhost hcid[13679]: =
Can't connect to SDP daemon:(Connection refused, 111)<br>Feb&nbsp; 6 16:00:=
55 localhost hcid[13679]: Failed to register service record<br>Feb&nbsp; 6 =
16:00:55 localhost audio[13682]: Adding service record failed: Connection r=
efused<br>Feb&nbsp; 6 16:00:55 localhost audio[13682]: Unable to register H=
S AG service record<br>Feb&nbsp; 6 16:00:55 localhost audio[13682]: Unregis=
tered manager path<br>Feb&nbsp; 6 16:00:55 localhost audio[13682]: Audio in=
it failed!<br>Feb&nbsp; 6 16:01:39 localhost audio[13690]: Bluetooth Audio =
daemon<br>Feb&nbsp; 6 16:01:39 localhost audio[13690]: Unix socket created:=
 5<br>Feb&nbsp; 6 16:01:39 localhost hcid[13679]: Can't connect to
 SDP daemon:(Connection refused, 111)<br>Feb&nbsp; 6 16:01:39 localhost hci=
d[13679]: Failed to register service record<br>Feb&nbsp; 6 16:01:39 localho=
st audio[13690]: Adding service record failed: Connection refused<br>Feb&nb=
sp; 6 16:01:39 localhost audio[13690]: Unable to register HS AG service rec=
ord<br>Feb&nbsp; 6 16:01:39 localhost audio[13690]: Unregistered manager pa=
th<br>Feb&nbsp; 6 16:01:39 localhost audio[13690]: Audio init failed!<br>Wh=
at are these failures?<br><div>Need i run /usr/local/lib/bluetooth/bluetoot=
hd-service-audio agian..??&nbsp;</div>Thanks and Best regards<div>&nbsp;</d=
iv><div>Pramod<div style=3D"font-family: times new roman,new york,times,ser=
if; font-size: 12pt;"><br><br><div style=3D"font-family: times new roman,ne=
w york,times,serif; font-size: 12pt;">----- Original Message ----<br>From: =
Marcel Holtmann &lt;marcel@holtmann.org&gt;<br>To: BlueZ development &lt;bl=
uez-devel@lists.sourceforge.net&gt;<br>Sent: Wednesday, 6 February, 2008
 3:36:18 PM<br>Subject: Re: [Bluez-devel] system hangs playing audio on hea=
dset<br><br>Hi =0APramod,<br><br>&gt; =0AThanks =0Afor =0Athat =0Ahint<br>&=
gt; =0AWhen =0AI =0Atry <br>&gt; =0A[root@localhost<br>&gt; =0APramod]# =0A=
/usr/local/lib/bluetooth/bluetoothd-service-audio<br>&gt; =0Athis =0Ais =0A=
not =0Aworking....<br>&gt; =0Aaudio[13117]: =0ABluetooth =0AAudio =0Adaemon=
<br>&gt; =0Aaudio[13117]: =0AUnix =0Asocket =0Acreated: =0A5<br>&gt; =0Aaud=
io[13117]: =0Aaudio.conf: =0A/etc/bluetooth/audio.conf: =0Akey =0AEnable =
=0Anot<br>&gt; =0Afound<br>&gt; =0Aaudio[13117]: =0Aaudio.conf: =0A/etc/blu=
etooth/audio.conf: =0Akey =0ADisable =0Anot<br>&gt; =0Afound<br>&gt; =0Aaud=
io[13117]: =0AAdding =0Aservice =0Arecord =0Afailed: =0AMethod =0A"AddServi=
ceRecord"<br>&gt; =0Awith =0Asignature =0A"ay" =0Aon =0Ainterface =0A"org.b=
luez.Database" =0Adoesn't =0Aexist<br>&gt; =0Aaudio[13117]: =0AUnable =0Ato=
 =0Aregister =0AHS =0AAG =0Aservice =0Arecord<br>&gt; =0Aaudio[13117]: =0AU=
nregistered =0Amanager =0Apath<br>&gt; =0Aaudio[13117]: =0AAudio =0Ainit =
=0Afailed!<br>&gt; <br>&gt; =0AI =0Asaw =0Athose =0AAddServiceRecord =0Ascr=
ipts =0Aon =0Abluez_Audio_HowTO..<br>&gt; =0AHow =0Ato =0Awork =0Athem =0Ao=
ut?<br><br>make =0Asure =0Ayou =0Aare =0Aactually =0Arunning =0Ahcid =0Afro=
m =0A3.25 =0Aand =0Anot =0Asome =0Adistribution =0Adefault.<br><br>Regards<=
br><br>Marcel<br><br><br><br>----------------------------------------------=
---------------------------<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =
=0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual=
 =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070=
mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070=
mrt/direct/01/</a><br>_______________________________________________<br>Bl=
uez-devel =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-devel@lists.sour=
ceforge.net" href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@=
lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists=
/listinfo/bluez-devel" target=3D"_blank">https://lists.sourceforge.net/list=
s/listinfo/bluez-devel</a><br></div><br></div></div></div><br>=0A=0A=0A    =
  <!--3--><hr size=3D1></hr> Save all your chat conversations. <a href=3D"h=
ttp://in.rd.yahoo.com/tagline_webmessenger_3/*http://in.messenger.yahoo.com=
/webmessengerpromo.php">Find them online.</a></body></html>
--0-2098922758-1202294059=:31000--


--===============1333826642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1333826642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1333826642==--
