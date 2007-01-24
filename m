Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Homayoun Ahmed" <asgc54@dsl.pipex.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 24 Jan 2007 17:03:39 -0000
MIME-Version: 1.0
Message-Id: <20070124170338.AEC30E000669@astro.systems.pipex.net>
Subject: [Bluez-users] hcid deamon error: HCI dev 0 down when trying to pair
	phone to laptop
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1261663919=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1261663919==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01C73FD9.98D3A9D0"

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C73FD9.98D3A9D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello 

 

I am having trouble will pairing my phone with my laptop. I am using a usb
Bluetooth dongle. When I run hciconfig - a I get the following 

 

hci0:   Type: USB

        BD Address: 00:02:5B:01:0B:E0 ACL MTU: 384:8 SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN

        RX bytes:88 acl:0 sco:0 events:10 errors:0

        TX bytes:44 acl:0 sco:0 commands:10 errors:0

        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

        Link policy:

        Link mode: SLAVE ACCEPT

        Name: 'H_LAPTOP'

        Class: 0x020104

        Service Classes: Networking

        Device Class: Computer, Desktop workstation

        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:
0x7a6

        Manufacturer: Cambridge Silicon Radio (10)

 

I then killed the hcid deamon and ran the deamon in foreground mode using
hcid -n and got the following message

 

hcid[3028]: Bluetooth HCI daemon

hcid[3028]: Starting security manager 0

hcid[3028]: Sending getting name command failed: Connection timed out (110)

hcid[3028]: Getting name failed with status 0x76 

 

I'm not too sure what this error represents and a google search and a search
in the archives section did not find anything. 

When I then try using my phone to pair it to my laptop I get asked for the
pin and I enter the pin the phone says that it cannot pair the phone and the
laptop. The following lines are then outputted to the screen 

 

hcid[3028]: pin_code_request (sba=00:02:5B:01:0B:E0, dba=00:13:FD:FA:74:96)

hcid[3028]: link_key_notify (sba=00:02:5B:01:0B:E0, dba=00:13:FD:FA:74:96)

hcid[3028]: HCI dev 0 down

hcid[3028]: Stoping security manager 0

hcid[3028]: HCI dev 0 unregistered

hcid[3028]: HCI dev 0 registered

hcid[3028]: HCI dev 0 up

hcid[3028]: Starting security manager 0

hcid[3028]: Sending getting name command failed: Connection timed out (110)

hcid[3028]: Getting name failed with status 0x11

 

for some reason the dongle device seems to go down and it can not be paired
but then is turned back on again. Can anyone help?

 

Thanks in advance


------=_NextPart_000_0008_01C73FD9.98D3A9D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Hello <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I am having trouble will pairing my phone with =
my
laptop. I am using a usb Bluetooth dongle. When I run hciconfig &#8211; =
a I get
the following <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hci0:&nbsp;&nbsp; Type: =
USB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD
Address: 00:02:5B:01:0B:E0 ACL MTU: 384:8 SCO MTU: =
64:8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP =
RUNNING
PSCAN ISCAN<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX
bytes:88 acl:0 sco:0 events:10 errors:0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX
bytes:44 acl:0 sco:0 commands:10 errors:0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Features:
0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Packet
type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Link
policy:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Link mode:
SLAVE ACCEPT<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Name:
'H_LAPTOP'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Class:
0x020104<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Service
Classes: Networking<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Device
Class: Computer, Desktop workstation<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI =
Ver:
2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: =
0x7a6<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Manufacturer: <st1:place w:st=3D"on"><st1:City =
w:st=3D"on">Cambridge</st1:City></st1:place>
Silicon Radio (10)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I then killed the hcid deamon and ran the =
deamon in
foreground mode using hcid &#8211;n and got the following =
message<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Bluetooth HCI =
daemon<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Starting security manager =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Sending getting name command =
failed:
Connection timed out (110)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Getting name failed with status =
0x76 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;m not too sure what this error =
represents and
a google search and a search in the archives section did not find =
anything. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>When I then try using my phone to pair it to =
my
laptop I get asked for the pin and I enter the pin the phone says that =
it
cannot pair the phone and the laptop. The following lines are then =
outputted to
the screen <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: pin_code_request =
(sba=3D00:02:5B:01:0B:E0,
dba=3D00:13:FD:FA:74:96)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: link_key_notify =
(sba=3D00:02:5B:01:0B:E0,
dba=3D00:13:FD:FA:74:96)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: HCI dev 0 =
down<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Stoping security manager =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: HCI dev 0 =
unregistered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: HCI dev 0 =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: HCI dev 0 =
up<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Starting security manager =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Sending getting name command =
failed:
Connection timed out (110)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>hcid[3028]: Getting name failed with status =
0x11<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>for some reason the dongle device seems to go =
down and
it can not be paired but then is turned back on again. Can anyone =
help?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks in advance<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0008_01C73FD9.98D3A9D0--



--===============1261663919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1261663919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1261663919==--
