Return-Path: <robertw@healthhero.com>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A6E@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'bluez-devel@lists.sourceforge.net'"
	 <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
Date: Wed, 5 Oct 2005 11:38:07 -0700 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C9DB.EDB79760"
List-ID: <bluez-devel.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C9DB.EDB79760
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

Thanks, that seems to get rid of the Authentication error.  I seem to be
able to issue commands through microcom now.

I appreciate the help.  Is there a recommended way to verify the linkkey
isn't incorrect?

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Wednesday, October 05, 2005 10:54 AM
To: Robert Wlaschin
Cc: 'bluez-devel@lists.sourceforge.net'
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm


Hi Robert,

> much for the help thus far.  Yes the rfcomm0 device is created: 
> This is the output from rfcomm; rfcomm0: 00:A0:96:0D:3B:80 channel 1
> closed, I have also seen it report [tty-attached] when I am attempting
> to read/write/connect, but it says 'config' not 'open'
> 
> So, I saw this error message:
> 
> > HCI Event: Connect Complete (0x03) plen 11 
>     status 0x05 handle 41 bdaddr 00:A0:96:0D:3B:80 type ACL encrypt
> 0x00 
>     Error: Authentication Failure

this means that you provide the wrong link key. Delete all your link
keys or set the device into pairing mode.

> So I did this: hciconfig hci0 auth, but I still got the same error, so
> I followed with this: hciconfig hci0 encrypt, but I still seem to be
> getting the error message.

This is a misconception. What activated security mode 3 and this is not
helpful at all.

Regards

Marcel


------_=_NextPart_001_01C5C9DB.EDB79760
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

<P><FONT SIZE=3D2>Thanks, that seems to get rid of the Authentication =
error.&nbsp; I seem to be able to issue commands through microcom =
now.</FONT>
</P>

<P><FONT SIZE=3D2>I appreciate the help.&nbsp; Is there a recommended =
way to verify the linkkey isn't incorrect?</FONT>
</P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Wednesday, October 05, 2005 10:54 AM</FONT>
<BR><FONT SIZE=3D2>To: Robert Wlaschin</FONT>
<BR><FONT SIZE=3D2>Cc: 'bluez-devel@lists.sourceforge.net'</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] Cannot send through =
serial device rfcomm</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; much for the help thus far.&nbsp; Yes the =
rfcomm0 device is created: </FONT>
<BR><FONT SIZE=3D2>&gt; This is the output from rfcomm; rfcomm0: =
00:A0:96:0D:3B:80 channel 1</FONT>
<BR><FONT SIZE=3D2>&gt; closed, I have also seen it report =
[tty-attached] when I am attempting</FONT>
<BR><FONT SIZE=3D2>&gt; to read/write/connect, but it says 'config' not =
'open'</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; So, I saw this error message:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; HCI Event: Connect Complete (0x03) plen 11 =
</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp; status 0x05 handle 41 =
bdaddr 00:A0:96:0D:3B:80 type ACL encrypt</FONT>
<BR><FONT SIZE=3D2>&gt; 0x00 </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Error: Authentication =
Failure</FONT>
</P>

<P><FONT SIZE=3D2>this means that you provide the wrong link key. =
Delete all your link</FONT>
<BR><FONT SIZE=3D2>keys or set the device into pairing mode.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; So I did this: hciconfig hci0 auth, but I still =
got the same error, so</FONT>
<BR><FONT SIZE=3D2>&gt; I followed with this: hciconfig hci0 encrypt, =
but I still seem to be</FONT>
<BR><FONT SIZE=3D2>&gt; getting the error message.</FONT>
</P>

<P><FONT SIZE=3D2>This is a misconception. What activated security mode =
3 and this is not</FONT>
<BR><FONT SIZE=3D2>helpful at all.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C9DB.EDB79760--
