Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5A8BF.831368C1"
Message-ID: <9772C290CD0BDF4B91356C9102BA886A01AFEEC1@ftrdmel1.rd.francetelecom.fr>
From: "zze-CONCEPT-PHONE CHABOUD-CROUSAZ B ext RD-TECH-GRE" <bchaboudcrousaz.ext@rd.francetelecom.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RFCOMM connection between a PocketPc and a linux station
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Aug 2005 17:21:32 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A8BF.831368C1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



I try to set up a serial port connection between a Pocket PC running
windows and a linux station running Bluez (with a bluetooth dongle).
>From the linux station I succeeded in connecting to the pocket PC thanks
to:
Rfcomm connect 0 address_of_pocketPc 1

=3D> the PocketPc is "connected" and his serial port profil also.

Then the pocketPC must send data to the linux thanks to COM
port.(createfile, open ,writefile...). Everything seems to work
perfectly on the pocketPC's side.

But on the linux side, nothing is received. Cat /dev/bluetooth/rfcomm/0
doesn't display anything.
Moreoever when I execute my own program that open
/dev/bluetooth/rfcomm/0 and read its contents, nothing changes.

Would it be possible to explain where is the mistake? How to receive
data on the linux side?

Best Regards=20
Baptiste


------_=_NextPart_001_01C5A8BF.831368C1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>RFCOMM connection between a PocketPc and a linux station</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">I try to set up a serial port =
connection between a Pocket PC running windows and a linux station =
running Bluez (with a bluetooth dongle).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">From the linux station I succeeded in =
connecting to the pocket PC thanks to:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Rfcomm connect 0 address_of_pocketPc =
1</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">=3D&gt; the PocketPc is =
&quot;connected&quot; and his serial port profil also.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Then the pocketPC must send data to the =
linux thanks to COM port.(createfile, open ,writefile...). Everything =
seems to work perfectly on the pocketPC's side.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">But on the linux side, nothing is =
received. Cat /dev/bluetooth/rfcomm/0 doesn't display anything.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Moreoever when I execute my own =
program that open /dev/bluetooth/rfcomm/0 and read its contents, nothing =
changes.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Would it be possible to explain where =
is the mistake? How to receive data on the linux side?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best Regards </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Baptiste</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5A8BF.831368C1--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
