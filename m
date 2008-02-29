Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 29 Feb 2008 14:31:50 +0800
Message-ID: <47F5C02EBFFEA44790CECC3E79BBE1640A737DB4@ZMY16EXM64.ds.mot.com>
From: "Song Haojie-a23023" <a23023@motorola.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Can not run "hciconfig hci0 up"
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1507893917=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1507893917==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87A9C.C4CB554D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87A9C.C4CB554D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I am not the root user of a Redhat PC, and I am try the hciconfig
command,
>hciconfig -a
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT

=20
h>hciconfig hci0 up
Can't init device hci0. Permission denied(13)

=20
Why I cannot start up hci0 successfully? Do it need I log in with the
root username?
=20
BRs
Johnson
=20

------_=_NextPart_001_01C87A9C.C4CB554D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3268" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D111372806-29022008>I am =
not the root=20
user of a Redhat PC, and I am try the hciconfig =
command,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D111372806-29022008>&gt;hciconfig=20
-a<BR>hci0:&nbsp;&nbsp; Type: =
USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU:=20
0:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
DOWN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 =
sco:0=20
events:0 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
bytes:0 acl:0=20
sco:0 commands:0 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00=20
0x00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DH1=20
HV1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
policy:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE=20
ACCEPT<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D111372806-29022008>h&gt;hciconfig hci0=20
up<BR>Can't init device hci0. Permission =
denied(13)<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D111372806-29022008>Why I =
cannot start=20
up hci0 successfully? Do it need I log in with the root=20
username?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008>BRs</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D111372806-29022008>Johnson</SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D111372806-29022008></DIV></SPAN></FONT>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C87A9C.C4CB554D--


--===============1507893917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1507893917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1507893917==--
