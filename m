Return-Path: <cyrus@holtmann.org>
Message-ID: <025301c8bd58$5066df70$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Quick Check: calling ListDevices method of Adapter in DBus-GLib-C++
Date: Fri, 23 May 2008 23:40:33 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0250_01C8BD2E.64EE1910"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0250_01C8BD2E.64EE1910
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It appears to me that the proper GType that matches up with an Array of =
Object Paths is:

dbus_g_type_get_collection("GSList", DBUS_TYPE_G_OBJECT_PATH)

This returns a pointer to a singly-linked list (GSList), which one may =
iterate through using g_slist_foreach, which calls an iterator function =
for each Object Path in the list.

A gpointer passed to the iterator function contains the Device path: =
(e.g., /hci0/dev_00_00_00_00_00_00), and may be cast to a (const char *) =
for processing as a C/C++ string.

Do I have this right, or is there a better way to attack this?

DS
------=_NextPart_000_0250_01C8BD2E.64EE1910
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>It appears to me that the proper GType =
that matches=20
up with an Array of Object Paths is:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>dbus_g_type_get_collection("GSList",=20
DBUS_TYPE_G_OBJECT_PATH)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This returns a pointer to a =
singly-linked list=20
(GSList), which one may iterate through using g_slist_foreach, which =
calls an=20
iterator function for each Object Path in the list.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>A gpointer passed to the iterator =
function contains=20
the Device path: (e.g., /hci0/dev_00_00_00_00_00_00), and may be cast to =
a=20
(const char *) for processing as a C/C++ string.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Do I have this right, or is there a =
better way to=20
attack this?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV></BODY></HTML>

------=_NextPart_000_0250_01C8BD2E.64EE1910--
