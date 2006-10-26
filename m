Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 26 Oct 2006 07:14:00 -0700
Message-ID: <77ADC7D0C96B1F44A924DC4E952A5E0E01120785@AZ25EXM01.gddsi.com>
In-Reply-To: <20061026053406.20806.qmail@web52008.mail.yahoo.com>
From: "Turley, Scott-P27856" <Scott.Turley@gdc4s.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez/bluetooth newbie
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0598136129=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0598136129==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F908.FBC0DAF4"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F908.FBC0DAF4
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Sure, I copied the source from the following website:
=20
http://people.csail.mit.edu/albert/bluez-intro/
=20
-Scott



________________________________

	From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of anoop
	Sent: Wednesday, October 25, 2006 10:34 PM
	To: BlueZ users
	Subject: Re: [Bluez-users] Bluez/bluetooth newbie
=09
=09
	Hi Scott,
	=20
	I am also in the search for  such a library.
	Can you point me to this?.
	=20
	Anoop
=09
	"Turley, Scott-P27856" <Scott.Turley@gdc4s.com> wrote:

		Doing a little more investigation, I found a library
that sends/receives
		data over a socket connection using rfcomm.=20
	=09
		However, if I use the client side of this library, doing
a connect to
		another bluetooth device that implements the Serial Port
Profile, it
		works beautifully, I'm able to send data that gets
displayed on the
		windows side hyperterminal.
	=09
		When I try to run the server side library on the Linux
machine, and
		attempt to make a connection over the hyperterminal, I
get an error
		message: "Connection attempt failed because the remote
device does not
		support the Serial Port Profile".
	=09
		How do I get a listener on a Linux host to accept serial
port profile
		connections?
	=09
		-Scott
	=09
		-----Original Message-----
		From: bluez-users-bounces@lists.sourceforge.net
		[mailto:bluez-users-bounces@lists.sourceforge.net] On
Behalf Of Marcel
		Holtmann
		Sent: Thursday, October 19, 2006 9:30 PM
		To: BlueZ users
		Subject: Re: [Bluez-users] Bluez/bluetooth newbie
	=09
		Hi Scott,
	=09
		> I'm trying to do something really simple in the
bluetooth environment.
		> I attached a USB bluetooth module (from A7
engineering) to a Linx PC,=20
		> and I attached a serial module to a windows PC. This
serial module=20
		> has the complete stack, and I just interface to it
with ASCII commands
	=09
		> over a serial port profile. I want to simply send
ASCII text across a
	=09
		> bluetooth serial connection between the two computers.
		>=20
		> I have been able to do this successfully with a
windows host. Here=20
		> are the steps I'm taking:
		>=20
		> * On the Windows side, I connect to the serial
bluetooth module,
		> configure the baud rate to 9600, no HW flow control,
etc.
		> * On the Linux side I start the hcid and sdpd
services.
		> * Then I search for the remote bluetooth device using
"hcitool
		> inq" and I see it.
		> * I establish a connection using "hcitool cc ".
	=09
		this step is not needed at all.
	=09
		> * Finally I use rfcomm to make a serial connection:
"rfcomm
		> connect 0 1".
	=09
		You might wanna use "rfcomm --raw connect 0 1".
	=09
		> The windows side recognizes a connection is made, but
I am unable to=20
		> get data across.
		>=20
		> I have found no way to establish baud rate. Is that
necessary across=20
		> bluetooth?
	=09
		No. The baud rate is for the physical interface of the
module and not
		the RFCOMM connection.
	=09
		Regards
	=09
		Marcel
	=09
	=09
	=09
=09
------------------------------------------------------------------------
		-
		Using Tomcat but need to do more? Need to support web
services,
		security?
		Get stuff done quickly with pre-integrated technology to
make your job
		easier Download IBM WebSphere Application Server v.1.0.1
based on Apache
		Geronimo
=09
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
		_______________________________________________
		Bluez-users mailing list
		Bluez-users@lists.sourceforge.net
		https://lists.sourceforge.net/lists/listinfo/bluez-users
	=09
=09
------------------------------------------------------------------------
-
		Using Tomcat but need to do more? Need to support web
services, security?
		Get stuff done quickly with pre-integrated technology to
make your job easier
		Download IBM WebSphere Application Server v.1.0.1 based
on Apache Geronimo
=09
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
		_______________________________________________
		Bluez-users mailing list
		Bluez-users@lists.sourceforge.net
		https://lists.sourceforge.net/lists/listinfo/bluez-users
	=09


=09
________________________________

	Stay in the know. Pulse on the new Yahoo.com. Check it out.
<http://us.rd.yahoo.com/evt=3D42974/*http://www.yahoo.com/preview> =20


------_=_NextPart_001_01C6F908.FBC0DAF4
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2883" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D561131214-26102006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Sure, I copied the source from the following=20
website:</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D561131214-26102006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D561131214-26102006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2><A=20
href=3D"http://people.csail.mit.edu/albert/bluez-intro/">http://people.cs=
ail.mit.edu/albert/bluez-intro/</A></FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D561131214-26102006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D561131214-26102006><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>-Scott</FONT></SPAN></DIV><FONT face=3DArial =
color=3D#0000ff=20
size=3D2></FONT><BR>
<BLOCKQUOTE style=3D"MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  bluez-users-bounces@lists.sourceforge.net=20
  [mailto:bluez-users-bounces@lists.sourceforge.net] <B>On Behalf Of=20
  </B>anoop<BR><B>Sent:</B> Wednesday, October 25, 2006 10:34 =
PM<BR><B>To:</B>=20
  BlueZ users<BR><B>Subject:</B> Re: [Bluez-users] Bluez/bluetooth=20
  newbie<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>Hi Scott,</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>I am also in the&nbsp;search for&nbsp; such a library.</DIV>
  <DIV>Can you point me to this?.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Anoop<BR><BR><B><I>"Turley, Scott-P27856"=20
  &lt;Scott.Turley@gdc4s.com&gt;</I></B> wrote:</DIV>
  <BLOCKQUOTE class=3Dreplbq=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px =
solid">Doing=20
    a little more investigation, I found a library that =
sends/receives<BR>data=20
    over a socket connection using rfcomm. <BR><BR>However, if I use the =
client=20
    side of this library, doing a connect to<BR>another bluetooth device =
that=20
    implements the Serial Port Profile, it<BR>works beautifully, I'm =
able to=20
    send data that gets displayed on the<BR>windows side=20
    hyperterminal.<BR><BR>When I try to run the server side library on =
the Linux=20
    machine, and<BR>attempt to make a connection over the hyperterminal, =
I get=20
    an error<BR>message: "Connection attempt failed because the remote =
device=20
    does not<BR>support the Serial Port Profile".<BR><BR>How do I get a =
listener=20
    on a Linux host to accept serial port=20
    profile<BR>connections?<BR><BR>-Scott<BR><BR>-----Original=20
    Message-----<BR>From:=20
    =
bluez-users-bounces@lists.sourceforge.net<BR>[mailto:bluez-users-bounces@=
lists.sourceforge.net]=20
    On Behalf Of Marcel<BR>Holtmann<BR>Sent: Thursday, October 19, 2006 =
9:30=20
    PM<BR>To: BlueZ users<BR>Subject: Re: [Bluez-users] Bluez/bluetooth=20
    newbie<BR><BR>Hi Scott,<BR><BR>&gt; I'm trying to do something =
really simple=20
    in the bluetooth environment.<BR>&gt; I attached a USB bluetooth =
module=20
    (from A7 engineering) to a Linx PC, <BR>&gt; and I attached a serial =
module=20
    to a windows PC. This serial module <BR>&gt; has the complete stack, =
and I=20
    just interface to it with ASCII commands<BR><BR>&gt; over a serial =
port=20
    profile. I want to simply send ASCII text across a<BR><BR>&gt; =
bluetooth=20
    serial connection between the two computers.<BR>&gt; <BR>&gt; I have =
been=20
    able to do this successfully with a windows host. Here <BR>&gt; are =
the=20
    steps I'm taking:<BR>&gt; <BR>&gt; * On the Windows side, I connect =
to the=20
    serial bluetooth module,<BR>&gt; configure the baud rate to 9600, no =
HW flow=20
    control, etc.<BR>&gt; * On the Linux side I start the hcid and sdpd=20
    services.<BR>&gt; * Then I search for the remote bluetooth device =
using=20
    "hcitool<BR>&gt; inq" and I see it.<BR>&gt; * I establish a =
connection using=20
    "hcitool cc <BT address>".<BR><BR>this step is not needed at=20
    all.<BR><BR>&gt; * Finally I use rfcomm to make a serial connection: =

    "rfcomm<BR>&gt; connect 0 <BT address>1".<BR><BR>You might wanna use =
"rfcomm=20
    --raw connect 0 <BDADDR>1".<BR><BR>&gt; The windows side recognizes =
a=20
    connection is made, but I am unable to <BR>&gt; get data =
across.<BR>&gt;=20
    <BR>&gt; I have found no way to establish baud rate. Is that =
necessary=20
    across <BR>&gt; bluetooth?<BR><BR>No. The baud rate is for the =
physical=20
    interface of the module and not<BR>the RFCOMM=20
    =
connection.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR>-----------------=
-------------------------------------------------------<BR>-<BR>Using=20
    Tomcat but need to do more? Need to support web=20
    services,<BR>security?<BR>Get stuff done quickly with pre-integrated =

    technology to make your job<BR>easier Download IBM WebSphere =
Application=20
    Server v.1.0.1 based on=20
    =
Apache<BR>Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D=
120709&amp;bid=3D263057&amp;dat=3D121642<BR>_____________________________=
__________________<BR>Bluez-users=20
    mailing=20
    =
list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.ne=
t/lists/listinfo/bluez-users<BR><BR>-------------------------------------=
------------------------------------<BR>Using=20
    Tomcat but need to do more? Need to support web services, =
security?<BR>Get=20
    stuff done quickly with pre-integrated technology to make your job=20
    easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on =
Apache=20
    =
Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&am=
p;bid=3D263057&amp;dat=3D121642<BR>______________________________________=
_________<BR>Bluez-users=20
    mailing=20
    =
list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.ne=
t/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR>
  <P>
  <HR SIZE=3D1>
  Stay in the know. Pulse on the new Yahoo.com. <A=20
  =
href=3D"http://us.rd.yahoo.com/evt=3D42974/*http://www.yahoo.com/preview"=
>Check it=20
  out.</A> </BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6F908.FBC0DAF4--


--===============0598136129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0598136129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0598136129==--
