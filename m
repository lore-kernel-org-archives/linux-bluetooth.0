Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C50F8C.EC992F8F"
Message-ID: <6EF58BF68042DF4AA46A54994117D64F0253E787@mercury.mtctech.com>
From: "Williams, Richard" <Richard.Williams@mtctechnologies.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Maintain Bluetooth Connections
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
Date: Thu, 10 Feb 2005 11:23:58 -0500

This is a multi-part message in MIME format.

------_=_NextPart_001_01C50F8C.EC992F8F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Greetings Marcel,

I have a small, wearable computer, battery powered, of course. The
X-scale processor is connected to the BT radio through a serial port and
is the master in a small network of BT devices. All this works very
well. This is running Linux 2.6 with the latest patches.

During idle periods, to save power, I want to suspend the main
microprocessor. The BT radio is powered from a separate circuit. For
now, before I suspend the micro, I close all the connections, and
perform a "bluetooth stop". When the micro wakes up, the micro does a
"bluetooth start" and then reestablishes the connections to the
peripheral devices. This does work, but it takes some time. I would like
to have the BT network recover as quickly as possible.

Is it possible to instruct the BT radio to autonomously maintain the
established connections, even though the microprocessor has been
suspended ?  So that when the main processor wakes up, the BT network is
still there. I don't know how much of the connection "keep alive"
function is performed by the Bluez stack.

Thank you, as usual for all your help.

Best Regards,

Rich

----------------------------
Richard B. Williams
Vitronics, Inc.
An MTC Technologies Company
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@mtctechnologies.com



------_=_NextPart_001_01C50F8C.EC992F8F
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6944.0">
<TITLE>Maintain Bluetooth Connections</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Greetings Marcel,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have a small, wearable computer, =
battery powered, of course. The X-scale processor is connected to the BT =
radio through a serial port and is the master in a small network of BT =
devices. All this works very well. This is running Linux 2.6 with the =
latest patches.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">During idle periods, to save power, I =
want to suspend the main microprocessor. The BT radio is powered from a =
separate circuit. For now, before I suspend the micro, I close all the =
connections, and perform a &quot;bluetooth stop&quot;. When the micro =
wakes up, the micro does a &quot;bluetooth start&quot; and then =
reestablishes the connections to the peripheral devices. This does work, =
but it takes some time. I would like to have the BT network recover as =
quickly as possible.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is it possible to instruct the BT radio =
to autonomously maintain the established connections, even though the =
microprocessor has been suspended ?&nbsp; So that when the main =
processor wakes up, the BT network is still there. I don't know how much =
of the connection &quot;keep alive&quot; function is performed by the =
Bluez stack.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thank you, as usual for all your =
help.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best Regards,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Rich</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">----------------------------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Richard B. Williams</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Vitronics, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">An MTC Technologies Company</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">3 Corbett Way</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Eatontown, NJ 07724-2262</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">732-389-0244 x29</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">Richard.Williams@mtctechnologies.com</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C50F8C.EC992F8F--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
