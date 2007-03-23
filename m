Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <003501c76d0e$ddcb33c0$c301a8c0@Bahubali>
From: "vikram" <vikram.bidkar@adamya.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 23 Mar 2007 11:18:19 +0530
MIME-Version: 1.0
Subject: [Bluez-users] add spp service, problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1129125743=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1129125743==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C76D3C.F5B76250"

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C76D3C.F5B76250
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=20

I am trying to add spp service, but I am getting "Filed to connect to =
local SDP server".

"session" value i.e. return value of sdp_connect is zero.
I am getting error for following line of code.

session =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);

Please suggest what could be the problem.

Regards,
Vikram
------=_NextPart_000_0032_01C76D3C.F5B76250
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1586" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to add spp service, but I =
am getting=20
"Filed to connect to local SDP server".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>"session" value i.e. return value of =
sdp_connect is=20
zero.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am getting error for&nbsp;following =
line of=20
code.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>session =3D sdp_connect(BDADDR_ANY, =
BDADDR_LOCAL,=20
SDP_RETRY_IF_BUSY);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please suggest what could be the=20
problem.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>Vikram</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0032_01C76D3C.F5B76250--



--===============1129125743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1129125743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1129125743==--
