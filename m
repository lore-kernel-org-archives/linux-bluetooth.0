Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000e01c4cd7d$f2c02020$2c00a8c0@DISCO17G>
From: "Carlos Azevedo" <carlosarazevedo@netcabo.pt>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C4CD7D.F2B26480"
Subject: [Bluez-devel] Re: Re: Lifetech BlueConnect DOES NOT work with bluez
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
Date: Thu, 18 Nov 2004 14:50:29 -0000

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C4CD7D.F2B26480
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

No, this dongle has a SiliconWave chipset. This chipset implements the =
1.2 spec, but Bluez implements 1.1 only. Specifically, on the 1.2 spec =
the Add SCO Connection is deprecated and indicated as 'not to be used'. =
The Bluez code (net/bluetooth/hci_conn.c) uses that command to start a =
SCO voice connection to a headset. I'm suspecting that the dongle =
doesn't implement the Add SCO command properly and causes my problems. =
But nevertheless a 1.2 spec device is not required (and is even =
discoraged) to implement it.
The hcidump indicates that the connection is established but on shut =
down (when the SCO socket is closed) a first disconnect exchange is =
concluded but SCO data keeps coming in. The Bluez code complains about =
those packets (in hci_scodata_packet) and only after a second disconnect =
exchange does the SCO data stop.
I'm now trying to use the Create Synchronous Connection (as per 1.2 =
spec) instead to see if this works.
By the way hcidump 1.16 reports the Create command as an Accept one =
(0x01|0x0028).

Carlos A. R. Azevedo
------=_NextPart_000_000B_01C4CD7D.F2B26480
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#d9e9f9>
<DIV><FONT face=3DArial size=3D2>Hi Marcel,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>No, this dongle has a SiliconWave =
chipset. This=20
chipset implements the 1.2 spec, but Bluez implements 1.1 only. =
Specifically, on=20
the 1.2 spec the Add SCO Connection is deprecated and indicated as 'not =
to be=20
used'. The Bluez code (net/bluetooth/hci_conn.c) uses that command to =
start a=20
SCO voice connection to a headset. I'm suspecting that the dongle =
doesn't=20
implement the Add SCO command properly and causes my problems. But =
nevertheless=20
a 1.2 spec device is not required (and is even discoraged) to implement=20
it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The hcidump indicates that the =
connection is=20
established but on shut down (when the SCO socket is closed) a first =
disconnect=20
exchange is concluded but SCO data keeps coming in. The Bluez code =
complains=20
about those packets (in hci_scodata_packet) and only after a second =
disconnect=20
exchange does the SCO data stop.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm now trying to&nbsp;use the Create =
Synchronous=20
Connection (as per 1.2 spec) instead to see if this works.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>By the way hcidump 1.16 reports the =
Create command=20
as an Accept one (0x01|0x0028).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Carlos A. R. =
Azevedo</FONT></DIV></BODY></HTML>

------=_NextPart_000_000B_01C4CD7D.F2B26480--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
