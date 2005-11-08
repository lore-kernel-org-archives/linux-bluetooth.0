Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49B68@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] textfile.c find_key
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E4BF.7E366E30"
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
Date: Tue, 8 Nov 2005 15:52:35 -0800

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5E4BF.7E366E30
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

It might possibly be.  I'm using an Arm processor with the kernel version
2.6.10 for use with Busybox.  It's probably a safe bet that not many people
are using an Arm  processor so it could be something about that.  I'll look
around.

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, November 08, 2005 2:14 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] textfile.c find_key


Hi Robert,

> Normally I would agree with you but I tried it and there came a NULL
> -- to my great surprise.  I could have a bug in the kernel I'm using
> or something else.  If you aren't sure you can always try it out
> yourself and if I'm wrong there you go.  If you could let me know the
> results you get I would appreciate it.
> 
> I ran textfile_get on a file that is size 0.  This should replicate
> the bug for you.  I used test_textfile to test both the problem and
> the 'fix' -- sadly, being that the mmap documentation says that 0
> cannot be returned, I would say that the fix is a farce and mmap
> should be fixed instead.

I can't reproduce this problem. On a file with size 0 the textfile_get()
returns NULL as it should be. No segmentation fault or any other problem
so far. Maybe the kernel or your glibc is broken. What do you use?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C5E4BF.7E366E30
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
<TITLE>RE: [Bluez-devel] textfile.c find_key</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Marcel,</FONT>
</P>

<P><FONT SIZE=3D2>It might possibly be.&nbsp; I'm using an Arm =
processor with the kernel version 2.6.10 for use with Busybox.&nbsp; =
It's probably a safe bet that not many people are using an Arm&nbsp; =
processor so it could be something about that.&nbsp; I'll look =
around.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, November 08, 2005 2:14 PM</FONT>
<BR><FONT SIZE=3D2>To: bluez-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] textfile.c =
find_key</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Normally I would agree with you but I tried it =
and there came a NULL</FONT>
<BR><FONT SIZE=3D2>&gt; -- to my great surprise.&nbsp; I could have a =
bug in the kernel I'm using</FONT>
<BR><FONT SIZE=3D2>&gt; or something else.&nbsp; If you aren't sure you =
can always try it out</FONT>
<BR><FONT SIZE=3D2>&gt; yourself and if I'm wrong there you go.&nbsp; =
If you could let me know the</FONT>
<BR><FONT SIZE=3D2>&gt; results you get I would appreciate it.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I ran textfile_get on a file that is size =
0.&nbsp; This should replicate</FONT>
<BR><FONT SIZE=3D2>&gt; the bug for you.&nbsp; I used test_textfile to =
test both the problem and</FONT>
<BR><FONT SIZE=3D2>&gt; the 'fix' -- sadly, being that the mmap =
documentation says that 0</FONT>
<BR><FONT SIZE=3D2>&gt; cannot be returned, I would say that the fix is =
a farce and mmap</FONT>
<BR><FONT SIZE=3D2>&gt; should be fixed instead.</FONT>
</P>

<P><FONT SIZE=3D2>I can't reproduce this problem. On a file with size 0 =
the textfile_get()</FONT>
<BR><FONT SIZE=3D2>returns NULL as it should be. No segmentation fault =
or any other problem</FONT>
<BR><FONT SIZE=3D2>so far. Maybe the kernel or your glibc is broken. =
What do you use?</FONT>
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
<BR><FONT SIZE=3D2>SF.Net email is sponsored by:</FONT>
<BR><FONT SIZE=3D2>Tame your development challenges with Apache's =
Geronimo App Server. Download</FONT>
<BR><FONT SIZE=3D2>it for free - -and be entered to win a 42&quot; =
plasma tv or your very own</FONT>
<BR><FONT SIZE=3D2>Sony(tm)PSP.&nbsp; Click here to play: <A =
HREF=3D"http://sourceforge.net/geronimo.php" =
TARGET=3D"_blank">http://sourceforge.net/geronimo.php</A></FONT>
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
------_=_NextPart_001_01C5E4BF.7E366E30--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
