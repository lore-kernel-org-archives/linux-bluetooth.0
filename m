Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49B66@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] textfile.c find_key
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E4A2.2DF1E6B0"
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
Date: Tue, 8 Nov 2005 12:22:45 -0800

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5E4A2.2DF1E6B0
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

Normally I would agree with you but I tried it and there came a NULL -- to
my great surprise.  I could have a bug in the kernel I'm using or something
else.  If you aren't sure you can always try it out yourself and if I'm
wrong there you go.  If you could let me know the results you get I would
appreciate it.

I ran textfile_get on a file that is size 0.  This should replicate the bug
for you.  I used test_textfile to test both the problem and the 'fix' --
sadly, being that the mmap documentation says that 0 cannot be returned, I
would say that the fix is a farce and mmap should be fixed instead.

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, November 08, 2005 11:55 AM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] textfile.c find_key


Hi Robert,

> Not sure if you are interested in this but in the file textfile.c,
> function find_key.  If map is ever NULL the strstr will segment fault.
> An instance of this happening would be when the key file was empty.
> This might happen if a Linux Op was removing keys that were
> invalidated by a lost pairing.  I feel that in general checking for a
> NULL is better than not.

how can map be NULL? Check "man mmap" about the return value of mmap().

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

------_=_NextPart_001_01C5E4A2.2DF1E6B0
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

<P><FONT SIZE=3D2>Normally I would agree with you but I tried it and =
there came a NULL -- to my great surprise.&nbsp; I could have a bug in =
the kernel I'm using or something else.&nbsp; If you aren't sure you =
can always try it out yourself and if I'm wrong there you go.&nbsp; If =
you could let me know the results you get I would appreciate =
it.</FONT></P>

<P><FONT SIZE=3D2>I ran textfile_get on a file that is size 0.&nbsp; =
This should replicate the bug for you.&nbsp; I used test_textfile to =
test both the problem and the 'fix' -- sadly, being that the mmap =
documentation says that 0 cannot be returned, I would say that the fix =
is a farce and mmap should be fixed instead.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, November 08, 2005 11:55 AM</FONT>
<BR><FONT SIZE=3D2>To: bluez-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] textfile.c =
find_key</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Not sure if you are interested in this but in =
the file textfile.c,</FONT>
<BR><FONT SIZE=3D2>&gt; function find_key.&nbsp; If map is ever NULL =
the strstr will segment fault.</FONT>
<BR><FONT SIZE=3D2>&gt; An instance of this happening would be when the =
key file was empty.</FONT>
<BR><FONT SIZE=3D2>&gt; This might happen if a Linux Op was removing =
keys that were</FONT>
<BR><FONT SIZE=3D2>&gt; invalidated by a lost pairing.&nbsp; I feel =
that in general checking for a</FONT>
<BR><FONT SIZE=3D2>&gt; NULL is better than not.</FONT>
</P>

<P><FONT SIZE=3D2>how can map be NULL? Check &quot;man mmap&quot; about =
the return value of mmap().</FONT>
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
------_=_NextPart_001_01C5E4A2.2DF1E6B0--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
