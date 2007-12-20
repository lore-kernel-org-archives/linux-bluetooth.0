Return-Path: <cyrus@holtmann.org>
Message-ID: <009b01c8432a$f2b9a800$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 20 Dec 2007 18:08:31 +0100
MIME-Version: 1.0
Subject: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1434524141=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1434524141==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0098_01C84333.542F53C0"

This is a multi-part message in MIME format.

------=_NextPart_000_0098_01C84333.542F53C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

When I try to open 3 RFCOMM connections from the same device to 3 remote =
ones, the first connection is OK but the 2 following give a "Error: =
Command Disallowed". I suspect an incorrect bluetooth parameter in my =
hcid.conf (lp ? lm ?)

Any hint is welcome !

PC is running a 2.6.23.12 Kernel with BlueZ 3.23

hcidump & hciconfig are below if it can help !

Thanks a lot,
Oli

------------------------------------------------------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2007-12-20 17:58:21.442414 < HCI Command: Create Connection =
(0x01|0x0005) plen 13
    bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-20 17:58:21.468697 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1

2007-12-20 17:58:21.468711 < HCI Command: Create Connection =
(0x01|0x0005) plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-20 17:58:21.472695 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed

2007-12-20 17:58:21.472705 < HCI Command: Create Connection =
(0x01|0x0005) plen 13
    bdaddr 00:16:4E:83:2D:19 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-20 17:58:21.476695 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed

------------------------------------------------------------------------

hci0:   Type: USB
        BD Address: 00:10:60:E8:B6:A1 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING
        RX bytes:9938 acl:157 sco:0 events:350 errors:0
        TX bytes:3965 acl:148 sco:0 commands:118 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: SNIFF
        Link mode: MASTER
        Name: 'BlueZ'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: =
0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

------=_NextPart_000_0098_01C84333.542F53C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When I try to open 3 RFCOMM connections =
from the=20
same device to 3 remote ones, the first connection is OK but the=20
2&nbsp;following give a "Error: Command Disallowed". I suspect an=20
incorrect&nbsp;bluetooth parameter in my hcid.conf (lp ? lm =
?)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any hint is welcome !</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>PC is running a 2.6.23.12 Kernel with =
BlueZ=20
3.23</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hcidump &amp; hciconfig are below if it =
can help=20
!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Oli</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>----------------------------------------------------------------=
--------</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>HCI sniffer - Bluetooth packet analyzer =
ver=20
1.40<BR>device: hci0 snap_len: 1028 filter: 0xffffffff<BR>2007-12-20=20
17:58:21.442414 &lt; HCI Command: Create Connection (0x01|0x0005) plen=20
13<BR>&nbsp;&nbsp;&nbsp; bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch =
0x00=20
clkoffset 0x0000<BR>&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3=20
DH5<BR>2007-12-20 17:58:21.468697 &gt; HCI Event: Command Status (0x0f) =
plen=20
4<BR>&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd =

1<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>2007-12-20 17:58:21.468711 &lt; HCI =
Command: Create=20
Connection (0x01|0x0005) plen 13<BR>&nbsp;&nbsp;&nbsp; bdaddr =
00:19:2D:15:FF:0E=20
ptype 0xcc18 rswitch 0x00 clkoffset 0x0000<BR>&nbsp;&nbsp;&nbsp; Packet =
type:=20
DM1 DM3 DM5 DH1 DH3 DH5<BR>2007-12-20 17:58:21.472695 &gt; HCI Event: =
Command=20
Status (0x0f) plen 4<BR>&nbsp;&nbsp;&nbsp; Create Connection =
(0x01|0x0005)=20
status 0x0c ncmd 1<BR>&nbsp;&nbsp;&nbsp; Error: Command=20
Disallowed<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>2007-12-20 17:58:21.472705 &lt; HCI =
Command: Create=20
Connection (0x01|0x0005) plen 13<BR>&nbsp;&nbsp;&nbsp; bdaddr =
00:16:4E:83:2D:19=20
ptype 0xcc18 rswitch 0x00 clkoffset 0x0000<BR>&nbsp;&nbsp;&nbsp; Packet =
type:=20
DM1 DM3 DM5 DH1 DH3 DH5<BR>2007-12-20 17:58:21.476695 &gt; HCI Event: =
Command=20
Status (0x0f) plen 4<BR>&nbsp;&nbsp;&nbsp; Create Connection =
(0x01|0x0005)=20
status 0x0c ncmd 1<BR>&nbsp;&nbsp;&nbsp; Error: Command=20
Disallowed<BR></FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>----------------------------------------------------------------=
--------</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hci0:&nbsp;&nbsp; Type:=20
USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: =
00:10:60:E8:B6:A1=20
ACL MTU: 384:8 SCO MTU: =
64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
RUNNING<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:9938 =
acl:157=20
sco:0 events:350 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
TX=20
bytes:3965 acl:148 sco:0 commands:118=20
errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff =
0xff 0x8f=20
0xfe 0x9b 0xf9 0x00 0x80<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Packet=20
type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2=20
HV3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:=20
SNIFF<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode:=20
MASTER<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name:=20
'BlueZ'<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class:=20
0x000100<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes:=20
Unspecified<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class:=20
Computer, Uncategorized<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
HCI Ver:=20
2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:=20
0x7a6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: =
Cambridge=20
Silicon Radio (10)<BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0098_01C84333.542F53C0--



--===============1434524141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1434524141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1434524141==--
