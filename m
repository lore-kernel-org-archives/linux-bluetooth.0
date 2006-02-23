Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <004a01c63829$20f79970$1f1410ac@AL31>
From: "Al Chane" <al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0047_01C6386C.2EA9C820"
Subject: [Bluez-devel] ISSC USB dongle with PAN
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 11:27:51 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0047_01C6386C.2EA9C820
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

      I am trying NAP using an ISSC USB dongle. On the PANU side I use
CRS chip with IVT software on Windows XP.

     The bnep0 connection can be established. Ping with size 900 works. =
But
Ping with size 1000 doesn't work. CSR dongle works fine with same bluez =
software.

I have searched for the list and found othershave similiar problems.In =
addition to set
MTU to 1000(ifconfig bnep0 mtu 1000), a ny other solutions to this =
problems?=20
Does MTU solution must be done on both sides (NAP and PANU)?

thanks for the helps,

Al

------=_NextPart_000_0047_01C6386C.2EA9C820
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am =
trying NAP=20
using an ISSC USB dongle. On the PANU side I use<BR>CRS chip with IVT =
software=20
on Windows XP.<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp; The bnep0 connection can =
be=20
established. Ping with size 900 works. But<BR>Ping with size 1000 =
doesn't work.=20
CSR dongle works fine with same bluez software.<BR><BR>I have searched =
for the=20
list and found othershave similiar problems.In addition to set<BR>MTU to =

1000(ifconfig bnep0 mtu 1000), a ny other solutions to this=20
problems?&nbsp;<BR>Does MTU solution must be done on both sides (NAP and =

PANU)?<BR><BR>thanks for the =
helps,<BR><BR>Al<BR></FONT></DIV></BODY></HTML>

------=_NextPart_000_0047_01C6386C.2EA9C820--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
