Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C616D0.D7A56CE6"
Message-ID: <9772C290CD0BDF4B91356C9102BA886A02D10A08@ftrdmel1.rd.francetelecom.fr>
From: "zze-eperspace HUE E ext RD-SIRP-CAE" <ehue.ext@rd.francetelecom.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] SAP service connection problem
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
Date: Wed, 11 Jan 2006 18:02:44 +0100

This is a multi-part message in MIME format.

------_=_NextPart_001_01C616D0.D7A56CE6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to connect to the SIM access profile of several mobile
phones, and can't get any connection. When I try to open an RFCOMM
channel, I get a "Can't connect RFCOMM socket: Connection refused" error
*after* the PIN code exchange.

My setup is Red Hat 4 EL with kernel 2.6.9-11.EL. I upgraded bluez-libs
and bluez-utils to version 2.24. I have a D-Link DBT-120 USB dongle,
using the hci_usb driver. lsusb says it's a "Cambridge Silicon Radio,
Ltd Bluetooth Dongle (HCI mode)".
Loaded kernel modules are : rfcomm, l2cap, hci_usb, bluetooth.
Here's the way I try to connect the SAP service :
# hcitool scan
To get the mobile phone address
# sdptool browse <bt addr>
To get the SAP channel number. I'm looking for the service named "SIM
ACCESS".
# rfcomm connect 0 <bt addr> <chan number>
Here it says it can't connect. Of course, I have no other open rfcomm
connection at the time.

I tried with two Nokia (6230 and 6820) and a Siemens phones, none of
them worked, but I can connect to any other RFCOMM service.
Authentication and encryption are enabled in hcid.conf, as well as all
link policies, inquiry and page scans.

Does somebody have any clue on how to connect to this SAP service ?

Thanks,


Edouard Hue

------_=_NextPart_001_01C616D0.D7A56CE6
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
<TITLE>SAP service connection problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm trying to connect to the SIM access =
profile of several mobile phones, and can't get any connection. When I =
try to open an RFCOMM channel, I get a &quot;Can't connect RFCOMM =
socket: Connection refused&quot; error *after* the PIN code =
exchange.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">My setup is Red Hat 4 EL with kernel =
2.6.9-11.EL. I upgraded bluez-libs and bluez-utils to version 2.24. I =
have a D-Link DBT-120 USB dongle, using the hci_usb driver. lsusb says =
it's a &quot;Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI =
mode)&quot;.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Loaded kernel modules are : rfcomm, =
l2cap, hci_usb, bluetooth.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Here's the way I try to connect the =
SAP service :</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># hcitool scan</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">To get the mobile phone address</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># sdptool browse &lt;bt =
addr&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">To get the SAP channel number. I'm =
looking for the service named &quot;SIM ACCESS&quot;.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># rfcomm connect 0 &lt;bt addr&gt; =
&lt;chan number&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Here it says it can't connect. Of =
course, I have no other open rfcomm connection at the time.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I tried with two Nokia (6230 and 6820) =
and a Siemens phones, none of them worked, but I can connect to any =
other RFCOMM service.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Authentication and encryption are =
enabled in hcid.conf, as well as all link policies, inquiry and page =
scans.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Does somebody have any clue on how to =
connect to this SAP service ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Edouard Hue</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C616D0.D7A56CE6--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
