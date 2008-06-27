Return-Path: <cyrus@holtmann.org>
Message-ID: <028701c8d897$74b68880$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Connecting to audio_service.Control (or other interfaces)
Date: Fri, 27 Jun 2008 15:50:34 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0284_01C8D86D.897BB580"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0284_01C8D86D.897BB580
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The interface descriptions for audio-api.txt appear to be somewhat =
stagnant (for one area, you are probably waiting for me).

That said: is it still your intent (or that of the development group) =
that the Object Path for audio-connected devices will be =
/org/bluez/audio/device<n> (where "n" is 0-based)?

I assume that one would have to do any/all pairing against the =
org.bluez.Adapter object (e.g., object path /hci0), creating a Device =
object (e.g., /hci0/dev_00_02_5B_01_A4_74) before connecting to the =
audio Service and creating the audio Device (using the BT Address of the =
remote device, e.g., 00:02:5B:01:A4:74).  Do I have this right?

How much of what is in audio-api.txt is or will be obsolete under 4.x?

David Stockwell
------=_NextPart_000_0284_01C8D86D.897BB580
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>The interface descriptions for =
audio-api.txt appear=20
to be somewhat stagnant (for one area, you are probably waiting for=20
me).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>That said: is it still your intent (or =
that of the=20
development group) that the Object Path for audio-connected devices will =

</FONT><FONT face=3DArial size=3D2>be /org/bluez/audio/device&lt;n&gt; =
(where "n" is=20
0-based)?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I assume that one would have to do =
any/all pairing=20
against the org.bluez.Adapter object (e.g., object path /hci0), creating =
a=20
Device object (e.g., /hci0/dev_00_02_5B_01_A4_74) before connecting to =
the audio=20
Service and creating the audio Device (using the BT Address of the =
remote=20
device, e.g., 00:02:5B:01:A4:74).&nbsp; Do I have this =
right?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>How much of what is in audio-api.txt =
is&nbsp;or=20
will be obsolete under 4.x?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David =
Stockwell</FONT></DIV></BODY></HTML>

------=_NextPart_000_0284_01C8D86D.897BB580--
