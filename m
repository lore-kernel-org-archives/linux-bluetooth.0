Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <002c01c46a77$034a25e0$5000005a@naxus>
From: "Carlos AM" <Carlos@naxus.biz>
To: "lista bluez" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0029_01C46A87.C62F89F0"
Subject: [Bluez-devel] RFCOMM communication gets stalled
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
Date: Thu, 15 Jul 2004 16:21:24 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0029_01C46A87.C62F89F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I'm using bluez-libs-2.7 and bluez-utils-2.7 to develop a GPS system =
that communicates via bluetooth. I use the RFCOMM and the connection and =
disconnection works fine but the transmission gets stalled in about ten =
minutes. Both sides indicate that they are still connected, but in the =
GPS side, the process that writes in the rfcomm device =
(/dev/bluetooth/rfcomm/0) stops on a blocking write call:

    write(fdbluetooth,s,strlen(s));

I open the rfcomm device this way:

    fdbluetooth=3D open("/dev/bluetooth/rfcomm/0",O_RDWR | O_NOCTTY);


That write call works fine for a while until the communication gets =
stalled.

Is a bad implementation of the process that writes in the rfcomm device?
Is that issue solved in the 2.8 version of bluez?



Carlos AM
Naxus Conectividad M=F3vil
------=_NextPart_000_0029_01C46A87.C62F89F0
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
<DIV><FONT face=3DArial size=3D2>I'm using bluez-libs-2.7 and =
bluez-utils-2.7 to=20
develop a GPS system that communicates via bluetooth. I use the RFCOMM =
and the=20
connection and disconnection works fine but the transmission gets =
stalled in=20
about ten minutes. Both sides indicate that they are still connected, =
but in the=20
GPS side, the process that writes in the rfcomm device (</FONT><FONT =
face=3DArial=20
size=3D2>/dev/bluetooth/rfcomm/0) stops on a blocking write =
call:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;=20
write(fdbluetooth,s,strlen(s));</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I open the rfcomm device this =
way:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; fdbluetooth=3D=20
open("/dev/bluetooth/rfcomm/0",O_RDWR | O_NOCTTY);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>That&nbsp;write call works fine =
for&nbsp;a while=20
until the communication gets stalled.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is a bad implementation of the process =
that writes=20
in the rfcomm device?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Is that issue solved in the 2.8 version =
of=20
bluez?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Carlos AM<BR>Naxus Conectividad=20
M=F3vil</FONT></DIV></BODY></HTML>

------=_NextPart_000_0029_01C46A87.C62F89F0--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
