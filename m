Return-Path: <robertw@healthhero.com>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A6B@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
   Robert Wlaschin
	 <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'"
	 <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
Date: Tue, 4 Oct 2005 15:46:14 -0700 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C935.6CEEDBD0"
List-ID: <bluez-devel.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C935.6CEEDBD0
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

That was a good suggestion.  I've seen usage of those programs on various
help/websites.

Due to a hardware limitations, I only have microcom available which seems
flaky at best.  I seem to be getting the 'Exitcode 2 - cannot open device
/dev/rfcomm0' error message.  But I have tried opening a standard serial
connection with microcom and it does function.

The code in attest should work given the method I am using, is this correct?
If so I can just rewrite it to something ... a little more towards my
purpose.

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, October 04, 2005 12:59 PM
To: Robert Wlaschin
Cc: 'bluez-devel@lists.sourceforge.net'
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm


Hi Robert,

> In regards to the type of communication, I'm trying to create a BT
> serial connection.  The device I'm attempting to connect to is
> actually a weight scale (medical device).  It doesn't support any
> other services.  I probably need to add that I changed rfcomm.conf to
> listen, bind, and connect for rfcomm0.  Note: The last time I used
> linux was in college and it was only to compile my assignments, so I'm
> not savvy.

you need to do a "rfcomm bind 0 <bdaddr> <channel>" and you will get a
new /dev/rfcomm0 TTY device. Now use a terminal program like minicom or
cu for the communication.

Regards

Marcel


------_=_NextPart_001_01C5C935.6CEEDBD0
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

<P><FONT SIZE=3D2>Marcel,</FONT>
</P>

<P><FONT SIZE=3D2>That was a good suggestion.&nbsp; I've seen usage of =
those programs on various help/websites.</FONT>
</P>

<P><FONT SIZE=3D2>Due to a hardware limitations, I only have microcom =
available which seems flaky at best.&nbsp; I seem to be getting the =
'Exitcode 2 - cannot open device /dev/rfcomm0' error message.&nbsp; But =
I have tried opening a standard serial connection with microcom and it =
does function.</FONT></P>

<P><FONT SIZE=3D2>The code in attest should work given the method I am =
using, is this correct?&nbsp; If so I can just rewrite it to something =
... a little more towards my purpose.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, October 04, 2005 12:59 PM</FONT>
<BR><FONT SIZE=3D2>To: Robert Wlaschin</FONT>
<BR><FONT SIZE=3D2>Cc: 'bluez-devel@lists.sourceforge.net'</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] Cannot send through =
serial device rfcomm</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; In regards to the type of communication, I'm =
trying to create a BT</FONT>
<BR><FONT SIZE=3D2>&gt; serial connection.&nbsp; The device I'm =
attempting to connect to is</FONT>
<BR><FONT SIZE=3D2>&gt; actually a weight scale (medical device).&nbsp; =
It doesn't support any</FONT>
<BR><FONT SIZE=3D2>&gt; other services.&nbsp; I probably need to add =
that I changed rfcomm.conf to</FONT>
<BR><FONT SIZE=3D2>&gt; listen, bind, and connect for rfcomm0.&nbsp; =
Note: The last time I used</FONT>
<BR><FONT SIZE=3D2>&gt; linux was in college and it was only to compile =
my assignments, so I'm</FONT>
<BR><FONT SIZE=3D2>&gt; not savvy.</FONT>
</P>

<P><FONT SIZE=3D2>you need to do a &quot;rfcomm bind 0 &lt;bdaddr&gt; =
&lt;channel&gt;&quot; and you will get a</FONT>
<BR><FONT SIZE=3D2>new /dev/rfcomm0 TTY device. Now use a terminal =
program like minicom or</FONT>
<BR><FONT SIZE=3D2>cu for the communication.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C935.6CEEDBD0--
