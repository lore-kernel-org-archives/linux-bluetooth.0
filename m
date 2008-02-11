Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Feb 2008 15:37:01 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <867146.70553.qm@web8414.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0614918494=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0614918494==
Content-Type: multipart/alternative; boundary="0-1815856859-1202724421=:70553"

--0-1815856859-1202724421=:70553
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi=0Ai tried adding options hci_usb force_scofix=3D1 to file etc/modprobe.d=
/bluez=0Abut this file was not there I created it and added the option.=0AB=
ut no change=0AOne more thing is i have no module called hci_usb found when=
 I do=0A[Pramod@localhost ~]$ lsmod | grep hci=0Auhci_hcd               290=
72  0=0AThis is some info i would like to share =0A[Pramod@localhost ~]$ ca=
t /etc/modules.conf=0A #Bluez=0A#alias net-pf-31      bluez=0A#alias bt-pro=
to-0     l2cap=0Aalias net-pf-31 bluez=0Aalias bt-proto-0 l2cap=0Aalias bt-=
proto-2 sco=0Aalias bt-proto-3 rfcomm=0A=0A[Pramod@localhost ~]$ /usr/local=
/sbin/hciconfig -a=0Ahci0:   Type: USB=0A        BD Address: 00:0B:0D:33:9E=
:FB ACL MTU: 120:20 SCO MTU: 64:0=0A        UP RUNNING PSCAN ISCAN=0A      =
  RX bytes:6912199 acl:71 sco:135480 events:72 errors:0=0A        TX bytes:=
1053 acl:35 sco:0 commands:30 errors:0=0A        Features: 0xff 0xff 0x05 0=
x00 0x00 0x00 0x00 0x00=0A        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 =
HV2 HV3=0A        Link policy: HOLD PARK=0A        Link mode: ACCEPT MASTER=
=0A        Name: 'MistralBD'=0A        Class: 0x000100=0A        Service Cl=
asses: Unspecified=0A        Device Class: Computer, Uncategorized=0A      =
  HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757=0A  =
      Manufacturer: Silicon Wave (11)=0A=0Aplease Suggest me if something i=
s wrong=0A =0AThanks and Best regards =0APramod=0A=0A----- Original Message=
 ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo: BlueZ users <bluez-users@li=
sts.sourceforge.net>=0ASent: Saturday, 9 February, 2008 4:38:02 AM=0ASubjec=
t: Re: [Bluez-users] Headset not playing audio HELP PLEASE=0A=0A=0AOn =0AFr=
i, =0A8 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:=0A=0A-> =0AOn =0Athe =
=0Aconsole =0Awhere =0Ai =0Arun =0Athe =0Aaudio =0Aservice =0AI =0Aget =0At=
hese =0Alog=0A-> =0Aaudio[3032]: =0AAccepted =0Anew =0Aclient =0Aconnection=
 =0Aon =0Aunix =0Asocket =0A(fd=3D9) =0Aaudio[3032]: =0AAudio =0AAPI: =0Are=
ceived =0ABT_GETCAPABILITIES_REQ=0A-> =0Aaudio[3032]: =0AGot =0Apath =0A/or=
g/bluez/hci0 =0Afor =0Aadapter =0Awith =0Aaddress =0A00:0B:0D:33:9E:FB=0A->=
 =0Aaudio[3032]: =0A/org/bluez/hci0 =0AGetRemoteName(): =0ANot =0Aavailable=
=0A-> =0APasskey =0Arequest =0Afor =0Adevice =0A00:0F:DE:B1:02:42=0A=0A=0AD=
id =0Ayou =0Aalso =0Astart =0Aauth-agent? =0AMy =0Aheadset =0Auses =0Aboth:=
=0A=0APasskey =0Arequest =0Afor =0Adevice =0A00:1A:45:01:F9:42 =0AAuthoriza=
tion =0Arequest =0Afor =0Adevice =0A00:1A:45:01:F9:42=0A=0A=0A-> =0Aaudio[3=
032]: =0AAudio =0Aservice =0Adiscovery =0Acompleted =0Awith =0Asuccess=0A->=
 =0Aaudio[3032]: =0AFound =0AHeadset =0Arecord=0A-> =0Aaudio[3032]: =0ADisc=
overed =0AHeadset =0Aservice =0Aon =0ARFCOMM =0Achannel =0A1=0A-> =0Aaudio[=
3032]: =0ASelecting =0Adefault =0Adevice=0A-> =0Aaudio[3032]: =0AAudio =0AA=
PI: =0Asending =0ABT_GETCAPABILITIES_RSP=0A-> =0Aaudio[3032]: =0AAudio =0AA=
PI: =0Areceived =0ABT_SETCONFIGURATION_REQ=0A-> =0Aaudio[3032]: =0Aconfig =
=0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D =0A0 =0Aallocat=
ion =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0Abitpool =
=0A=3D =0A0=0A-> =0Aaudio[3032]: =0AState =0Achanged =0A/org/bluez/audio/de=
vice0: =0AHEADSET_STATE_DISCONNECTED =0A-> =0AHEADSET_STATE_CONNECT_IN_PROG=
RESS=0A-> =0Aaudio[3032]: =0A/org/bluez/audio/device0: =0AConnecting =0Ato =
=0A00:0F:DE:B1:02:42 =0Achannel =0A1=0A-> =0Aaudio[3032]: =0AState =0Achang=
ed =0A/org/bluez/audio/device0: =0AHEADSET_STATE_CONNECT_IN_PROGRESS =0A-> =
=0AHEADSET_STATE_CONNECTED=0A-> =0Aaudio[3032]: =0A/org/bluez/audio/device0=
: =0AConnected =0Ato =0A00:0F:DE:B1:02:42=0A-> =0Aaudio[3032]: =0AState =0A=
changed =0A/org/bluez/audio/device0: =0AHEADSET_STATE_CONNECTED =0A-> =0AHE=
ADSET_STATE_PLAY_IN_PROGRESS=0A-> =0Aaudio[3032]: =0AReceived =0AAT*ECBP=3D=
?=0A-> =0Aaudio[3032]: =0ABadly =0Aformated =0Aor =0Aunrecognized =0Acomman=
d: =0AAT*ECBP=3D?=0A=0AI =0Ahad =0Aerrors =0Alike =0Athese =0Athe =0Aday =
=0Abefore. =0AIf =0AI =0Aremeber =0Aright, =0Asetting =0Aforce_scofix=3D1 =
=0Aon =0Athe =0Adevice's =0Amodule =0A(hci_usb) =0Aseemed =0Ato =0Aclear =
=0Athem =0Aup. =0ABut =0AI =0Aforgot =0Aif =0Ayour =0ABluetooth =0Aadapter =
=0Ais =0Ausb =0Aor =0Anot.=0A=0ADid =0Ayou =0Apair =0Athe =0Adevices =0Afir=
st? =0AMy =0Aheadset =0Ahad =0Aa =0Abutton =0Ato =0Apress =0Awhich =0Amakes=
 =0Ait =0Apair. =0AI've =0Aheard =0Athe =0Anoise =0Atoo, =0Alike =0Athe =0A=
one =0Ayou're =0Agetting. =0AI =0Aupgraded =0Ato=0A3.25, =0Aset =0Athe =0Af=
orce_scofix =0Ato =0A1 =0Aand =0Atried =0Aa =0Afew =0Adifferent =0Avalues =
=0Ain=0Aaudio.conf. =0AAfter =0Athat =0Ait =0Ajust =0Aworked.=0A=0A=0A=0A--=
-----------------------------------------------------------------------=0AT=
his =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall=
 =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.a=
tdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A_____________________________=
__________________=0ABluez-users =0Amailing =0Alist=0ABluez-users@lists.sou=
rceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=
=0A=0A=0A=0A=0A=0A=0A      Share files, take polls, and discuss your passio=
ns - all under one roof. Go to http://in.promos.yahoo.com/groups
--0-1815856859-1202724421=:70553
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi<br>i tried adding options hci_usb force_scofix=3D1 to fi=
le etc/modprobe.d/bluez<br>but this file was not there I created it and add=
ed the option.<br>But no change<br>One more thing is i have no module calle=
d hci_usb found when I do<br>[Pramod@localhost ~]$ lsmod | grep hci<br>uhci=
_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 29072&nbsp; 0<br>This is some info i would like to share <br>=
[Pramod@localhost ~]$ cat /etc/modules.conf<br>&nbsp;#Bluez<br>#alias net-p=
f-31&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bluez<br>#alias bt-proto-0&nbsp;&nbsp;&n=
bsp;&nbsp; l2cap<br>alias net-pf-31 bluez<br>alias bt-proto-0 l2cap<br>alia=
s bt-proto-2 sco<br>alias bt-proto-3 rfcomm<br><br>[Pramod@localhost ~]$ /u=
sr/local/sbin/hciconfig -a<br>hci0:&nbsp;&nbsp; Type:
 USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0B:0D:33:=
9E:FB ACL MTU: 120:20 SCO MTU: 64:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX bytes:6912199 acl:71 sco:135480 events:72 errors:0<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1053 acl:35 sco:0 commands:30 errors:0<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x05 0x00 =
0x00 0x00 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet ty=
pe: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Link policy: HOLD PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Link mode: ACCEPT MASTER<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Name: 'MistralBD'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x0=
00100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspec=
ified<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class:
 Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI =
Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Silicon Wave (11)<br><br>=
please Suggest me if something is wrong<br><div>&nbsp;</div>Thanks and Best=
 regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: times new ro=
man,new york,times,serif; font-size: 12pt;"><br><br><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;">----- Original =
Message ----<br>From: jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users =
&lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Saturday, 9 February, 20=
08 4:38:02 AM<br>Subject: Re: [Bluez-users] Headset not playing audio HELP =
PLEASE<br><br><br>On =0AFri, =0A8 =0AFeb =0A2008, =0Apramod =0Agurav =0Awro=
te:<br><br>-&gt; =0AOn =0Athe =0Aconsole =0Awhere =0Ai =0Arun =0Athe =0Aaud=
io =0Aservice =0AI =0Aget =0Athese =0Alog<br>-&gt; =0Aaudio[3032]: =0AAccep=
ted =0Anew =0Aclient =0Aconnection =0Aon =0Aunix =0Asocket =0A(fd=3D9) =0Aa=
udio[3032]: =0AAudio =0AAPI: =0Areceived =0ABT_GETCAPABILITIES_REQ<br>-&gt;=
 =0Aaudio[3032]: =0AGot =0Apath =0A/org/bluez/hci0 =0Afor =0Aadapter =0Awit=
h =0Aaddress =0A00:0B:0D:33:9E:FB<br>-&gt; =0Aaudio[3032]: =0A/org/bluez/hc=
i0 =0AGetRemoteName(): =0ANot =0Aavailable<br>-&gt; =0APasskey =0Arequest =
=0Afor =0Adevice =0A00:0F:DE:B1:02:42<br><br><br>Did =0Ayou =0Aalso =0Astar=
t =0Aauth-agent? =0AMy =0Aheadset =0Auses =0Aboth:<br><br>Passkey =0Areques=
t =0Afor =0Adevice =0A00:1A:45:01:F9:42 <br>Authorization =0Arequest =0Afor=
 =0Adevice =0A00:1A:45:01:F9:42<br><br><br>-&gt; =0Aaudio[3032]: =0AAudio =
=0Aservice =0Adiscovery =0Acompleted =0Awith =0Asuccess<br>-&gt; =0Aaudio[3=
032]: =0AFound =0AHeadset =0Arecord<br>-&gt; =0Aaudio[3032]: =0ADiscovered =
=0AHeadset =0Aservice =0Aon =0ARFCOMM =0Achannel =0A1<br>-&gt; =0Aaudio[303=
2]: =0ASelecting =0Adefault =0Adevice<br>-&gt; =0Aaudio[3032]: =0AAudio =0A=
API: =0Asending =0ABT_GETCAPABILITIES_RSP<br>-&gt; =0Aaudio[3032]: =0AAudio=
 =0AAPI: =0Areceived =0ABT_SETCONFIGURATION_REQ<br>-&gt; =0Aaudio[3032]: =
=0Aconfig =0Asbc =0A- =0Afrequency =0A=3D =0A0 =0Achannel_mode =0A=3D =0A0 =
=0Aallocation =0A=3D =0A0 =0Asubbands =0A=3D =0A0 =0Ablocks =0A=3D =0A0 =0A=
bitpool =0A=3D =0A0<br>-&gt; =0Aaudio[3032]: =0AState =0Achanged =0A/org/bl=
uez/audio/device0: =0AHEADSET_STATE_DISCONNECTED =0A-&gt; =0AHEADSET_STATE_=
CONNECT_IN_PROGRESS<br>-&gt; =0Aaudio[3032]: =0A/org/bluez/audio/device0: =
=0AConnecting =0Ato =0A00:0F:DE:B1:02:42 =0Achannel =0A1<br>-&gt; =0Aaudio[=
3032]: =0AState =0Achanged =0A/org/bluez/audio/device0: =0AHEADSET_STATE_CO=
NNECT_IN_PROGRESS =0A-&gt; =0AHEADSET_STATE_CONNECTED<br>-&gt; =0Aaudio[303=
2]: =0A/org/bluez/audio/device0: =0AConnected =0Ato =0A00:0F:DE:B1:02:42<br=
>-&gt; =0Aaudio[3032]: =0AState =0Achanged =0A/org/bluez/audio/device0: =0A=
HEADSET_STATE_CONNECTED =0A-&gt; =0AHEADSET_STATE_PLAY_IN_PROGRESS<br>-&gt;=
 =0Aaudio[3032]: =0AReceived =0AAT*ECBP=3D?<br>-&gt; =0Aaudio[3032]: =0ABad=
ly =0Aformated =0Aor =0Aunrecognized =0Acommand: =0AAT*ECBP=3D?<br><br>I =
=0Ahad =0Aerrors =0Alike =0Athese =0Athe =0Aday =0Abefore. =0AIf =0AI =0Are=
meber =0Aright, =0Asetting <br>force_scofix=3D1 =0Aon =0Athe =0Adevice's =
=0Amodule =0A(hci_usb) =0Aseemed =0Ato =0Aclear =0Athem =0Aup. =0ABut =0AI =
<br>forgot =0Aif =0Ayour =0ABluetooth =0Aadapter =0Ais =0Ausb =0Aor =0Anot.=
<br><br>Did =0Ayou =0Apair =0Athe =0Adevices =0Afirst? =0AMy =0Aheadset =0A=
had =0Aa =0Abutton =0Ato =0Apress =0Awhich =0Amakes <br>it =0Apair. =0AI've=
 =0Aheard =0Athe =0Anoise =0Atoo, =0Alike =0Athe =0Aone =0Ayou're =0Agettin=
g. =0AI =0Aupgraded =0Ato<br>3.25, =0Aset =0Athe =0Aforce_scofix =0Ato =0A1=
 =0Aand =0Atried =0Aa =0Afew =0Adifferent =0Avalues =0Ain<br>audio.conf. =
=0AAfter =0Athat =0Ait =0Ajust =0Aworked.<br><br><br><br>------------------=
-------------------------------------------------------<br>This =0ASF.net =
=0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenge=
s. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a href=3D"http://clk.at=
dmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D"_blank">http://clk.at=
dmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_________________________=
______________________<br>Bluez-users =0Amailing =0Alist<br><a ymailto=3D"m=
ailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:Bluez-users@lists.s=
ourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank">https:=
//lists.sourceforge.net/lists/listinfo/bluez-users</a><br></div><br></div><=
/div></div><br>=0A=0A=0A      <!--5--><hr size=3D1></hr> Now you can chat w=
ithout downloading messenger. <a href=3D"http://in.rd.yahoo.com/tagline_web=
messenger_5/*http://in.messenger.yahoo.com/webmessengerpromo.php">Click her=
e</a> to know how.</body></html>
--0-1815856859-1202724421=:70553--



--===============0614918494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0614918494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0614918494==--
