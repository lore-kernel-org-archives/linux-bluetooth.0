Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Feb 2008 16:15:40 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <542471.17672.qm@web8408.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1740533717=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1740533717==
Content-Type: multipart/alternative; boundary="0-1148723614-1202294740=:17672"

--0-1148723614-1202294740=:17672
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I edited /etc/bluetooth/audio.service to have=0AAutostart=3Dfalse=0Akilled =
hcid, sdpd and started again....=0AAnd I run seperately=0A[root@localhost P=
ramod]# /usr/local/lib/bluetooth/bluetoothd-service-audio=0Aaudio[13767]: B=
luetooth Audio daemon=0Aaudio[13767]: Unix socket created: 5=0Aaudio[13767]=
: audio.conf: /etc/bluetooth/audio.conf: key Enable not found=0Aaudio[13767=
]: audio.conf: /etc/bluetooth/audio.conf: key Disable not found=0Aaudio[137=
67]: add_service_record: got record id 0x10000=0Aaudio[13767]: audio.conf: =
/etc/bluetooth/audio.conf: key Disable not found=0Aaudio[13767]: audio.conf=
: /etc/bluetooth/audio.conf: group A2DP not found=0Aaudio[13767]: audio.con=
f: /etc/bluetooth/audio.conf: group A2DP not found=0Aaudio[13767]: audio.co=
nf: /etc/bluetooth/audio.conf: group A2DP not found=0Aaudio[13767]: audio.c=
onf: /etc/bluetooth/audio.conf: group A2DP not found=0Aaudio[13767]: SEP 0x=
80e3040 registered: type:0 codec:0 seid:1=0Aaudio[13767]: add_service_recor=
d: got record id 0x10001=0Aaudio[13767]: add_service_record: got record id =
0x10002=0Aaudio[13767]: add_service_record: got record id 0x10003=0Aaudio[1=
3767]: Registered manager path:/org/bluez/audio=0A=0A When I try connecting=
 to my headset =0A[root@localhost ~]# /usr/local/bin/rfcomm connect 0 00:0F=
:DE:B1:02:42 1=0ACan't connect RFCOMM socket: Invalid exchange=0A=0A=0AThan=
ks and Best regards =0APramod=0A=0A----- Original Message ----=0AFrom: Marc=
el Holtmann <marcel@holtmann.org>=0ATo: BlueZ development <bluez-devel@list=
s.sourceforge.net>=0ASent: Wednesday, 6 February, 2008 3:36:18 PM=0ASubject=
: Re: [Bluez-devel] system hangs playing audio on headset=0A=0AHi =0APramod=
,=0A=0A> =0AThanks =0Afor =0Athat =0Ahint=0A> =0AWhen =0AI =0Atry =0A> =0A[=
root@localhost=0A> =0APramod]# =0A/usr/local/lib/bluetooth/bluetoothd-servi=
ce-audio=0A> =0Athis =0Ais =0Anot =0Aworking....=0A> =0Aaudio[13117]: =0ABl=
uetooth =0AAudio =0Adaemon=0A> =0Aaudio[13117]: =0AUnix =0Asocket =0Acreate=
d: =0A5=0A> =0Aaudio[13117]: =0Aaudio.conf: =0A/etc/bluetooth/audio.conf: =
=0Akey =0AEnable =0Anot=0A> =0Afound=0A> =0Aaudio[13117]: =0Aaudio.conf: =
=0A/etc/bluetooth/audio.conf: =0Akey =0ADisable =0Anot=0A> =0Afound=0A> =0A=
audio[13117]: =0AAdding =0Aservice =0Arecord =0Afailed: =0AMethod =0A"AddSe=
rviceRecord"=0A> =0Awith =0Asignature =0A"ay" =0Aon =0Ainterface =0A"org.bl=
uez.Database" =0Adoesn't =0Aexist=0A> =0Aaudio[13117]: =0AUnable =0Ato =0Ar=
egister =0AHS =0AAG =0Aservice =0Arecord=0A> =0Aaudio[13117]: =0AUnregister=
ed =0Amanager =0Apath=0A> =0Aaudio[13117]: =0AAudio =0Ainit =0Afailed!=0A> =
=0A> =0AI =0Asaw =0Athose =0AAddServiceRecord =0Ascripts =0Aon =0Abluez_Aud=
io_HowTO..=0A> =0AHow =0Ato =0Awork =0Athem =0Aout?=0A=0Amake =0Asure =0Ayo=
u =0Aare =0Aactually =0Arunning =0Ahcid =0Afrom =0A3.25 =0Aand =0Anot =0Aso=
me =0Adistribution =0Adefault.=0A=0ARegards=0A=0AMarcel=0A=0A=0A=0A--------=
-----------------------------------------------------------------=0AThis =
=0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0A=
challenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt=
.com/MRT/go/vse0120000070mrt/direct/01/=0A_________________________________=
______________=0ABluez-devel =0Amailing =0Alist=0ABluez-devel@lists.sourcef=
orge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-devel=0A=0A=
=0A=0A=0A=0A=0A=0A      Chat on a cool, new interface. No download required=
. Go to http://in.messenger.yahoo.com/webmessengerpromo.php
--0-1148723614-1202294740=:17672
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">I edited /etc/bluetooth/audio.service to have<br>Autostart=
=3Dfalse<br>killed hcid, sdpd and started again....<br>And I run seperately=
<br>[root@localhost Pramod]# /usr/local/lib/bluetooth/bluetoothd-service-au=
dio<br>audio[13767]: Bluetooth Audio daemon<br>audio[13767]: Unix socket cr=
eated: 5<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: key Enable=
 not found<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: key Disa=
ble not found<br>audio[13767]: add_service_record: got record id 0x10000<br=
>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: key Disable not found=
<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not fou=
nd<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not f=
ound<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: group A2DP not
 found<br>audio[13767]: audio.conf: /etc/bluetooth/audio.conf: group A2DP n=
ot found<br>audio[13767]: SEP 0x80e3040 registered: type:0 codec:0 seid:1<b=
r>audio[13767]: add_service_record: got record id 0x10001<br>audio[13767]: =
add_service_record: got record id 0x10002<br>audio[13767]: add_service_reco=
rd: got record id 0x10003<br>audio[13767]: Registered manager path:/org/blu=
ez/audio<br><br><div>&nbsp;When I try connecting to my headset <br>[root@lo=
calhost ~]# /usr/local/bin/rfcomm connect 0 00:0F:DE:B1:02:42 1<br>Can't co=
nnect RFCOMM socket: Invalid exchange<br><br></div>Thanks and Best regards<=
div>&nbsp;</div><div>Pramod<div style=3D"font-family: times new roman,new y=
ork,times,serif; font-size: 12pt;"><br><br><div style=3D"font-family: times=
 new roman,new york,times,serif; font-size: 12pt;">----- Original Message -=
---<br>From: Marcel Holtmann &lt;marcel@holtmann.org&gt;<br>To: BlueZ devel=
opment &lt;bluez-devel@lists.sourceforge.net&gt;<br>Sent: Wednesday, 6
 February, 2008 3:36:18 PM<br>Subject: Re: [Bluez-devel] system hangs playi=
ng audio on headset<br><br>Hi =0APramod,<br><br>&gt; =0AThanks =0Afor =0Ath=
at =0Ahint<br>&gt; =0AWhen =0AI =0Atry <br>&gt; =0A[root@localhost<br>&gt; =
=0APramod]# =0A/usr/local/lib/bluetooth/bluetoothd-service-audio<br>&gt; =
=0Athis =0Ais =0Anot =0Aworking....<br>&gt; =0Aaudio[13117]: =0ABluetooth =
=0AAudio =0Adaemon<br>&gt; =0Aaudio[13117]: =0AUnix =0Asocket =0Acreated: =
=0A5<br>&gt; =0Aaudio[13117]: =0Aaudio.conf: =0A/etc/bluetooth/audio.conf: =
=0Akey =0AEnable =0Anot<br>&gt; =0Afound<br>&gt; =0Aaudio[13117]: =0Aaudio.=
conf: =0A/etc/bluetooth/audio.conf: =0Akey =0ADisable =0Anot<br>&gt; =0Afou=
nd<br>&gt; =0Aaudio[13117]: =0AAdding =0Aservice =0Arecord =0Afailed: =0AMe=
thod =0A"AddServiceRecord"<br>&gt; =0Awith =0Asignature =0A"ay" =0Aon =0Ain=
terface =0A"org.bluez.Database" =0Adoesn't =0Aexist<br>&gt; =0Aaudio[13117]=
: =0AUnable =0Ato =0Aregister =0AHS =0AAG =0Aservice =0Arecord<br>&gt; =0Aa=
udio[13117]: =0AUnregistered =0Amanager =0Apath<br>&gt; =0Aaudio[13117]: =
=0AAudio =0Ainit =0Afailed!<br>&gt; <br>&gt; =0AI =0Asaw =0Athose =0AAddSer=
viceRecord =0Ascripts =0Aon =0Abluez_Audio_HowTO..<br>&gt; =0AHow =0Ato =0A=
work =0Athem =0Aout?<br><br>make =0Asure =0Ayou =0Aare =0Aactually =0Arunni=
ng =0Ahcid =0Afrom =0A3.25 =0Aand =0Anot =0Asome =0Adistribution =0Adefault=
.<br><br>Regards<br><br>Marcel<br><br><br><br>-----------------------------=
--------------------------------------------<br>This =0ASF.net =0Aemail =0A=
is =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicros=
oft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/=
go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/=
go/vse0120000070mrt/direct/01/</a><br>_____________________________________=
__________<br>Bluez-devel =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-=
devel@lists.sourceforge.net" href=3D"mailto:Bluez-devel@lists.sourceforge.n=
et">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourc=
eforge.net/lists/listinfo/bluez-devel" target=3D"_blank">https://lists.sour=
ceforge.net/lists/listinfo/bluez-devel</a><br></div><br></div></div></div><=
br>=0A=0A=0A      <!--2--><hr size=3D1></hr> Unlimited freedom, unlimited s=
torage. <a href=3D"http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo=
.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Get it now</a></body><=
/html>
--0-1148723614-1202294740=:17672--


--===============1740533717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1740533717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1740533717==--
