Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <005001c4aeef$5d9d8e80$8601b6ac@monika>
Reply-To: "Monika Hubrich" <monikahubrich@aol.com>
From: "Monika Hubrich" <monikahubrich@aol.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004D_01C4AF00.1DB02380"
Subject: [Bluez-users] PICO Bluetooth Card / Modem
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
Date: Sun, 10 Oct 2004 19:34:10 +0200


------=_NextPart_000_004D_01C4AF00.1DB02380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
I tried to install my bluetooth modem (PICO/Sphinx Bluetooth Modem) on SuSE=20=
Linux 8.2.
But I get always the message "Connection refused".
What do I wrong?

linux:~ # hciconfig
hci0:   Type: PCCARD
        BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1407 acl:29 sco:0 events:69 errors:0
        TX bytes:1157 acl:34 sco:0 commands:35 errors:0

linux:~ # hciconfig hci0 up
linux:~ # hciconfig -a
hci0:   Type: PCCARD
        BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1407 acl:29 sco:0 events:69 errors:0
        TX bytes:1157 acl:34 sco:0 commands:35 errors:0
        Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver: 0x300
        Manufacturer: Ericsson Technology Licensing (0)

linux:~ # hcitool scan
Scanning ...
        00:02:C7:09:9B:FA       n/a
linux:~ # sdptool browse 00:02:C7:09:9B:FA
Browsing 00:02:C7:09:9B:FA ...
linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 1
Can't connect RFCOMM socket: Connection refused
linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 2
Can't connect RFCOMM socket: Connection refused

Greetings

Moni Hubrich


------=_NextPart_000_004D_01C4AF00.1DB02380
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2743.600" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I tried to install my bluetooth modem (PICO=
/Sphinx=20
Bluetooth Modem) on SuSE Linux 8.2.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But I get always the message "Connection=20
refused".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>What do I wrong?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>linux:~ # hciconfig<BR>hci0:&nbsp;&nbsp; Ty=
pe:=20
PCCARD<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:=20
00:80:37:14:C3:51 ACL MTU: 672:10&nbsp; SCO MTU:=20
64:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN=20
ISCAN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1407 acl:29 sco=
:0=20
events:69 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:11=
57=20
acl:34 sco:0 commands:35 errors:0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>linux:~ # hciconfig hci0 up<BR>linux:~ # hc=
iconfig=20
-a<BR>hci0:&nbsp;&nbsp; Type:=20
PCCARD<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:=20
00:80:37:14:C3:51 ACL MTU: 672:10&nbsp; SCO MTU:=20
64:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN=20
ISCAN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1407 acl:29 sco=
:0=20
events:69 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:11=
57=20
acl:34 sco:0 commands:35 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00=20
0x00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5=20=
DH1=20
DH3 DH5 HV1 HV3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:=20
RSWITCH HOLD SNIFF PARK<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link m=
ode:=20
SLAVE ACCEPT<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ=20
(0)'<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class:=20
0x000100<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes:=20
Unspecified<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class:=20
Computer, Uncategorized<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ve=
r:=20
1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver:=20
0x300<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Ericsson=20
Technology Licensing (0)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>linux:~ # hcitool scan<BR>Scanning=20
...<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
00:02:C7:09:9B:FA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<BR>linux:~ # sdpto=
ol=20
browse 00:02:C7:09:9B:FA<BR>Browsing 00:02:C7:09:9B:FA ...<BR>linux:~ # rfco=
mm=20
connect 0 00:02:C7:09:9B:FA 1<BR>Can't connect RFCOMM socket: Connection=20
refused<BR>linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 2<BR>Can't connect=20
RFCOMM socket: Connection refused<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Greetings</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Moni Hubrich</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_004D_01C4AF00.1DB02380--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
