Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <005b01c4165b$5541b0e0$4000fe0a@rtsviec64>
From: "Harald Meier" <meh1@rts.at>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <003201c4161f$d37a2050$4000fe0a@rtsviec64> <1080630888.4094.5.camel@pegasus>
Subject: Re: [Bluez-users] PAND and RFCOMM simultaneously
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0058_01C4166C.15C53020"
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
Date: Tue, 30 Mar 2004 15:31:34 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0058_01C4166C.15C53020
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

the output of hciconfig -a is:

hci0: Type: PCIBD Address: 00:02:78:02:2E:C3 ACL MTU: 192:8 SCO MTU: =
64:8

UP RUNNING PSCAN ISCAN

RX bytes:70 acl:0 sco:0 events:7 errors:0

TX bytes:34 acl:0 sco:0 commands:7 errors:0

Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

Link policy:

Link mode: SLAVE ACCEPT

Name: 'ka0009 (0)'

Class: 0x000000

Service Classes: Unspecified

Device Class: Miscellaneous,

HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:

0x175

Manufacturer: Cambridge Silicon Radio (10)

------=_NextPart_000_0058_01C4166C.15C53020
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY>
<DIV>
<P><FONT face=3DArial size=3D2>Hi Marcel,</FONT></P>
<P><FONT face=3DArial size=3D2>the output of hciconfig -a is:</FONT></P>
<P><FONT face=3DArial size=3D2>hci0: Type: PCI</FONT><FONT face=3DArial =
size=3D2>BD=20
Address: 00:02:78:02:2E:C3 ACL MTU: 192:8 SCO MTU: 64:8</FONT></P>
<P><FONT face=3DArial size=3D2>UP RUNNING PSCAN ISCAN</FONT></P>
<P><FONT face=3DArial size=3D2>RX bytes:70 acl:0 sco:0 events:7 =
errors:0</FONT></P>
<P><FONT face=3DArial size=3D2>TX bytes:34 acl:0 sco:0 commands:7=20
errors:0</FONT></P>
<P><FONT face=3DArial size=3D2>Features: 0xff 0xff 0x0f 0x00 0x00 0x00 =
0x00=20
0x00</FONT></P>
<P><FONT face=3DArial size=3D2>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 =
HV2=20
HV3</FONT></P>
<P><FONT face=3DArial size=3D2>Link policy:</FONT></P>
<P><FONT face=3DArial size=3D2>Link mode: SLAVE ACCEPT</FONT></P>
<P><FONT face=3DArial size=3D2>Name: 'ka0009 (0)'</FONT></P>
<P><FONT face=3DArial size=3D2>Class: 0x000000</FONT></P>
<P><FONT face=3DArial size=3D2>Service Classes: Unspecified</FONT></P>
<P><FONT face=3DArial size=3D2>Device Class: Miscellaneous,</FONT></P>
<P><FONT face=3DArial size=3D2>HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP =
Ver: 1.1 (0x1)=20
LMP Subver:</FONT></P>
<P><FONT face=3DArial size=3D2>0x175</FONT></P>
<P><FONT face=3DArial size=3D2>Manufacturer: Cambridge Silicon Radio=20
(10)</FONT></P></DIV></BODY></HTML>

------=_NextPart_000_0058_01C4166C.15C53020--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
