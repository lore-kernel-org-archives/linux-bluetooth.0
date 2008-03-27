Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY118-DAV9D9EC1C84DCF7A987834CC7FE0@phx.gbl>
From: <ichane@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 27 Mar 2008 10:10:10 +0800
MIME-Version: 1.0
Subject: [Bluez-users] sdptool add service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1000278713=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1000278713==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0040_01C88FF2.BDB2AC00"

This is a multi-part message in MIME format.

------=_NextPart_000_0040_01C88FF2.BDB2AC00
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi there:

Do I need to add service manually using sdptool add? I got different
results using pand and rfcomm listen as servers.

1. >pand -s -M --role=3DNAP=20
After run the command above, no need to run "sdptool add NAP". The
service is already registered to sdpd.

2.>rfcomm listen 1 1
Need to run sdptool add SP to register SPP service to sdpd.

Am I correct?

Thanks a lot,

Chane
------=_NextPart_000_0040_01C88FF2.BDB2AC00
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi there:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Do I need to add service manually using =
sdptool=20
add? I got different</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>results using pand and rfcomm listen as =

servers.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1. &gt;pand -s -M --role=3DNAP =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>After run the command above, no need to =
run=20
"sdptool add NAP". The</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>service is already registered to =
sdpd.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2.&gt;rfcomm listen 1 1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Need to run sdptool add SP to register =
SPP service=20
to sdpd.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Am I correct?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Chane</FONT></DIV></BODY></HTML>

------=_NextPart_000_0040_01C88FF2.BDB2AC00--



--===============1000278713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1000278713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1000278713==--
