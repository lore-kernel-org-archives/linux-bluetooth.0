Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 19 Oct 2006 12:52:41 -0700
Message-ID: <77ADC7D0C96B1F44A924DC4E952A5E0E0112074E@AZ25EXM01.gddsi.com>
From: "Turley, Scott-P27856" <Scott.Turley@gdc4s.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluez/bluetooth newbie
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1623638211=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1623638211==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F3B8.2358C2BD"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F3B8.2358C2BD
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to do something really simple in the bluetooth environment.
I attached a USB bluetooth module (from A7 engineering) to a Linx PC,
and I attached a serial module to a windows PC.  This serial module has
the complete stack, and I just interface to it with ASCII commands over
a serial port profile.  I want to simply send ASCII text across a
bluetooth serial connection between the two computers.

I have been able to do this successfully with a windows host.  Here are
the steps I'm taking:

*	On the Windows side, I connect to the serial bluetooth module,
configure the baud rate to 9600, no HW flow control, etc.
*	On the Linux side I start the hcid and sdpd services.
*	Then I search for the remote bluetooth device using "hcitool
inq" and I see it.
*	I establish a connection using "hcitool cc <bt address>".
*	Finally I use rfcomm to make a serial connection:  "rfcomm
connect 0 <bt address> 1".

The windows side recognizes a connection is made, but I am unable to get
data across.

I have found no way to establish baud rate.  Is that necessary across
bluetooth? =20

I am expecting to just type into a window and see the characters show up
in the external window.  This works when both sides are Windows machines
using hyperterm.

Instead, when I type on the windows hyperterm, I get the ascii
characters repeated (is the Linux side bouncing the characters back?).
On the Linux side, when I type in the window, nothing really happens.

Any help/advice would be helpful.

Thanks in advance.

Scott Turley
Software Engineer
GENERAL DYNAMICS DECISION SYSTEMS
Communications Systems Division
8201 E. McDowell Rd.=20
Scottsdale, AZ 85257
phone:  480-675-2613


------_=_NextPart_001_01C6F3B8.2358C2BD
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>Bluez/bluetooth newbie</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm trying to do something really =
simple in the bluetooth environment.&nbsp; I attached a USB bluetooth =
module (from A7 engineering) to a Linx PC, and I attached a serial =
module to a windows PC.&nbsp; This serial module has the complete stack, =
and I just interface to it with ASCII commands over a serial port =
profile.&nbsp; I want to simply send ASCII text across a bluetooth =
serial connection between the two computers.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have been able to do this =
successfully with a windows host.&nbsp; Here are the steps I'm =
taking:</FONT>
</P>

<UL>
<LI><FONT SIZE=3D2 FACE=3D"Arial">On the Windows side, I connect to the =
serial bluetooth module, configure the baud rate to 9600, no HW flow =
control, etc.</FONT></LI>

<LI><FONT SIZE=3D2 FACE=3D"Arial">On the Linux side I start the hcid and =
sdpd services.</FONT></LI>

<LI><FONT SIZE=3D2 FACE=3D"Arial">Then I search for the remote bluetooth =
device using &quot;hcitool inq&quot; and I see it.</FONT></LI>

<LI><FONT SIZE=3D2 FACE=3D"Arial">I establish a connection using =
&quot;hcitool cc &lt;bt address&gt;&quot;.</FONT></LI>

<LI><FONT SIZE=3D2 FACE=3D"Arial">Finally I use rfcomm to make a serial =
connection:&nbsp; &quot;rfcomm connect 0 &lt;bt address&gt; =
1&quot;.</FONT></LI>
<BR>
</UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">The windows side recognizes a =
connection is made, but I am unable to get data across.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have found no way to establish baud =
rate.&nbsp; Is that necessary across bluetooth?&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am expecting to just type into a =
window and see the characters show up in the external window.&nbsp; This =
works when both sides are Windows machines using hyperterm.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Instead, when I type on the windows =
hyperterm, I get the ascii characters repeated (is the Linux side =
bouncing the characters back?).&nbsp; On the Linux side, when I type in =
the window, nothing really happens.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any help/advice would be =
helpful.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks in advance.</FONT>
</P>

<P><B><FONT SIZE=3D1 FACE=3D"Arial">Scott Turley</FONT></B>

<BR><FONT SIZE=3D1 FACE=3D"Arial">Software Engineer</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">GENERAL DYNAMICS DECISION =
SYSTEMS</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">Communications Systems Division</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">8201 E. McDowell Rd. </FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">Scottsdale, AZ 85257</FONT>

<BR><FONT SIZE=3D1 FACE=3D"Arial">phone:&nbsp; 480-675-2613</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6F3B8.2358C2BD--


--===============1623638211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1623638211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1623638211==--
