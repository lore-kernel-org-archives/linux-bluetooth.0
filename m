Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000a01c46ff6$f6013a10$5000005a@naxus>
From: "Carlos AM" <Carlos@naxus.biz>
To: "lista bluez" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C47007.B91F1340"
Subject: [Bluez-devel] modify RFCOMM_DISC_TIMEOUT
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Jul 2004 16:19:54 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C47007.B91F1340
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I am developing a GPS unit that communicates via RFCOMM and I noticed =
that the timeout of the RFCOMM disconnection is 20 seconds.
=BFDoes exists a way to change this timeout from a rfcomm server program =
that uses sockets?
It seems that changing this #define in the rfcomm.h is not enough

Regards
Carlos AM
Naxus Conectividad M=F3vil
------=_NextPart_000_0007_01C47007.B91F1340
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
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am developing a GPS unit that =
communicates via=20
RFCOMM and I noticed that the timeout of the RFCOMM disconnection is 20=20
seconds.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>=BFDoes exists a way to change this =
timeout from a=20
rfcomm server program that uses sockets?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>It seems that changing this #define in =
the rfcomm.h=20
is not enough</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Carlos AM<BR>Naxus Conectividad=20
M=F3vil</FONT></DIV></BODY></HTML>

------=_NextPart_000_0007_01C47007.B91F1340--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
