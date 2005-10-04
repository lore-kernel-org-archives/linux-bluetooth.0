Return-Path: <robertw@healthhero.com>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A66@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'"
	 <bluez-devel@lists.sourceforge.net>,
   "'Marcel Holtmann'"
	 <marcel@holtmann.org>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
Date: Tue, 4 Oct 2005 09:32:23 -0700 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C901.329E90D0"
List-ID: <bluez-devel.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C901.329E90D0
Content-Type: text/plain;
	charset="iso-8859-1"


I appreciate the heads up.

In regards to the type of communication, I'm trying to create a BT serial
connection.  The device I'm attempting to connect to is actually a weight
scale (medical device).  It doesn't support any other services.  I probably
need to add that I changed rfcomm.conf to listen, bind, and connect for
rfcomm0.  Note: The last time I used linux was in college and it was only to
compile my assignments, so I'm not savvy.

If you are at all familiar with Windows XP, I can use Hyperterminal to
communicate with the meter simply by typing commands in the terminal area
but for this to work I have to assign a port to the BT adapter.

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann
To: bluez-devel@lists.sourceforge.net
Sent: 10/4/05 04:16
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm

Hi Robert,

please stop using HTML emails and especially don't use colors. The good
old plain ASCII is enough.

> I'm cross-compiling for an Arm processor using a Debian 2.6.10 kernel
> with bluez-utils/lib 2.21, and bluez-hcidump 2.25 w/ a brainbox usb
> adapter for rs-232 replacement (CSR chipset)
>  
> I'm having a problem communicating through the /dev/rfcomm0 device.  I
> thought that once the device was connected it would be have like a
> serial device and I could do this ...
>  
> cat /dev/rfcomm0 > myfile.dat
> echo AT > /dev/rfcomm0
>  
> Am I assuming correctly?  If not what am I missing?  Do I need to use
> the pppd or the dund to communicate?  Am I in the wrong mode (master
> vs slave).  
>  
> If this should work please look at my log files, I'm executing
> these commands ... 
>  
> hcid
> sdpd
> sdptool add SP
> rfcomm bind 0 XX:XX ...

I think you made a big mistake in understanding how Bluetooth and Linux
are working. Describe what kind of communication you try to achieve and
then we might be able to help you.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads,
discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C5C901.329E90D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: [Bluez-devel] Cannot send through serial device =
rfcomm</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=3D2>I appreciate the heads up.</FONT>
</P>

<P><FONT SIZE=3D2>In regards to the type of communication, I'm trying =
to create a BT serial connection.&nbsp; The device I'm attempting to =
connect to is actually a weight scale (medical device).&nbsp; It =
doesn't support any other services.&nbsp; I probably need to add that I =
changed rfcomm.conf to listen, bind, and connect for rfcomm0.&nbsp; =
Note: The last time I used linux was in college and it was only to =
compile my assignments, so I'm not savvy.</FONT></P>

<P><FONT SIZE=3D2>If you are at all familiar with Windows XP, I can use =
Hyperterminal to communicate with the meter simply by typing commands =
in the terminal area but for this to work I have to assign a port to =
the BT adapter.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann</FONT>
<BR><FONT SIZE=3D2>To: bluez-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Sent: 10/4/05 04:16</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] Cannot send through =
serial device rfcomm</FONT>
</P>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>please stop using HTML emails and especially don't =
use colors. The good</FONT>
<BR><FONT SIZE=3D2>old plain ASCII is enough.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; I'm cross-compiling for an Arm processor using a =
Debian 2.6.10 kernel</FONT>
<BR><FONT SIZE=3D2>&gt; with bluez-utils/lib 2.21, and bluez-hcidump =
2.25 w/ a brainbox usb</FONT>
<BR><FONT SIZE=3D2>&gt; adapter for rs-232 replacement (CSR =
chipset)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; I'm having a problem communicating through the =
/dev/rfcomm0 device.&nbsp; I</FONT>
<BR><FONT SIZE=3D2>&gt; thought that once the device was connected it =
would be have like a</FONT>
<BR><FONT SIZE=3D2>&gt; serial device and I could do this ...</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; cat /dev/rfcomm0 &gt; myfile.dat</FONT>
<BR><FONT SIZE=3D2>&gt; echo AT &gt; /dev/rfcomm0</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; Am I assuming correctly?&nbsp; If not what am I =
missing?&nbsp; Do I need to use</FONT>
<BR><FONT SIZE=3D2>&gt; the pppd or the dund to communicate?&nbsp; Am I =
in the wrong mode (master</FONT>
<BR><FONT SIZE=3D2>&gt; vs slave).&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; If this should work please look at my log =
files, I'm executing</FONT>
<BR><FONT SIZE=3D2>&gt; these commands ... </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; hcid</FONT>
<BR><FONT SIZE=3D2>&gt; sdpd</FONT>
<BR><FONT SIZE=3D2>&gt; sdptool add SP</FONT>
<BR><FONT SIZE=3D2>&gt; rfcomm bind 0 XX:XX ...</FONT>
</P>

<P><FONT SIZE=3D2>I think you made a big mistake in understanding how =
Bluetooth and Linux</FONT>
<BR><FONT SIZE=3D2>are working. Describe what kind of communication you =
try to achieve and</FONT>
<BR><FONT SIZE=3D2>then we might be able to help you.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>
<BR>
<BR>
<BR>

<P><FONT =
SIZE=3D2>-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>This SF.Net email is sponsored by:</FONT>
<BR><FONT SIZE=3D2>Power Architecture Resource Center: Free content, =
downloads,</FONT>
<BR><FONT SIZE=3D2>discussions,</FONT>
<BR><FONT SIZE=3D2>and more. <A =
HREF=3D"http://solutions.newsforge.com/ibmarch.tmpl" =
TARGET=3D"_blank">http://solutions.newsforge.com/ibmarch.tmpl</A></FONT>=

<BR><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Bluez-devel mailing list</FONT>
<BR><FONT SIZE=3D2>Bluez-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-dev=
el</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C901.329E90D0--
