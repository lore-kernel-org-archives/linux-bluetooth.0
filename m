Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001301c398bb$b5aa9eb0$0300a8c0@neonmura>
From: "Jonas Tsang" <d99jots@stud.hh.se>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C398CC.78DDD4A0"
Subject: [Bluez-devel] Using two sco-channels
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Oct 2003 18:44:06 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C398CC.78DDD4A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I'm trying to make an easy application to connect a bt-device with two =
different headsets through sco-channels. The application is mainly based =
on hstest. Connection to the first headset works fine, but as soon as I =
try to open another sco-channel to the 2nd headset, it fails.I get an =
error message saying: "address already in use". I found that an error =
occurs when I try to bind a new socket to the same source-address (the =
bt-device). Does anyone know if it's possible to use two sco-channels =
simultaneously? (I'm not using any bluetooth USB dongle and creating two =
different RFCOMM-channels works fine.) Any suggestions?

Thanks in advance.

/Jonas
------=_NextPart_000_0010_01C398CC.78DDD4A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1264" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi, </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm trying to make an easy application =
to connect a=20
bt-device with two different headsets through sco-channels. The =
application is=20
mainly based on hstest. Connection to the first headset works fine, but =
as soon=20
as I try to open another sco-channel to the 2nd headset, it fails.I get =
an error=20
message saying: "address already in use". I found that an error occurs =
when I=20
try to bind a new socket to the same source-address (the =
bt-device).&nbsp;Does=20
anyone know if it's possible to use two sco-channels simultaneously? =
(I'm not=20
using any bluetooth USB dongle and creating two different =
RFCOMM-channels works=20
fine.) Any suggestions?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in advance.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>/Jonas</FONT></DIV></BODY></HTML>

------=_NextPart_000_0010_01C398CC.78DDD4A0--




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
