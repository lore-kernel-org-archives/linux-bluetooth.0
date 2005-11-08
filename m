Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49B64@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] textfile.c find_key
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E49A.8A2DA1B0"
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
Date: Tue, 8 Nov 2005 11:28:04 -0800

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5E49A.8A2DA1B0
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

Not sure if you are interested in this but in the file textfile.c, function
find_key.  If map is ever NULL the strstr will segment fault.  An instance
of this happening would be when the key file was empty.  This might happen
if a Linux Op was removing keys that were invalidated by a lost pairing.  I
feel that in general checking for a NULL is better than not.

Here's a patch ...

--- ./bluez-utils-2.21/common/textfile.c        2005-09-10
05:27:26.000000000 -0700
+++ ./bluez-utils-2.21-orig/common/textfile.c   2005-11-08
11:18:09.837262992 -0800
@@ -115,11 +115,16 @@
 
 static inline char *find_key(char *map, char *key, size_t len)
 {
-       char *off = strstr(map, key);
+       char *off = NULL;
+
+       if(map)
+       {
+               off = strstr(map, key);
 
                while (off && ((off > map && *(off - 1) != '\r' &&
                               *(off - 1) != '\n') || *(off + len) != ' '))
                off = strstr(off + len, key);
+       }
 
        return off;
 }

Thanks,
Robert

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, November 08, 2005 10:17 AM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] C Program for Getting Link Quality


Hi Arpit,

> I did a yum update bluez*.
> 
> The verion I'm using is:
> 
> [root@174-15 bluetooth]# ls -l
> total 116
> -rw-r--r--  1 root root  3607 Mar  2  2005 bluetooth.h
> 
> On including sys/socket.h..the error is the same:

maybe <sys/ioctl.h> is also missing.

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

------_=_NextPart_001_01C5E49A.8A2DA1B0
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

<P><FONT SIZE=3D2>Not sure if you are interested in this but in the =
file textfile.c, function find_key.&nbsp; If map is ever NULL the =
strstr will segment fault.&nbsp; An instance of this happening would be =
when the key file was empty.&nbsp; This might happen if a Linux Op was =
removing keys that were invalidated by a lost pairing.&nbsp; I feel =
that in general checking for a NULL is better than not.</FONT></P>

<P><FONT SIZE=3D2>Here's a patch ...</FONT>
</P>

<P><FONT SIZE=3D2>--- =
./bluez-utils-2.21/common/textfile.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 2005-09-10 05:27:26.000000000 -0700</FONT>
<BR><FONT SIZE=3D2>+++ =
./bluez-utils-2.21-orig/common/textfile.c&nbsp;&nbsp; 2005-11-08 =
11:18:09.837262992 -0800</FONT>
<BR><FONT SIZE=3D2>@@ -115,11 +115,16 @@</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;static inline char *find_key(char *map, char =
*key, size_t len)</FONT>
<BR><FONT SIZE=3D2>&nbsp;{</FONT>
<BR><FONT SIZE=3D2>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *off =3D =
strstr(map, key);</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *off =3D =
NULL;</FONT>
<BR><FONT SIZE=3D2>+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(map)</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</FONT>
<BR><FONT =
SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; off =3D strstr(map, key);</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; while (off &amp;&amp; ((off &gt; map =
&amp;&amp; *(off - 1) !=3D '\r' &amp;&amp;</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(off - 1) !=3D '\n') || =
*(off + len) !=3D ' '))</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; off =3D strstr(off + len, key);</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
off;</FONT>
<BR><FONT SIZE=3D2>&nbsp;}</FONT>
</P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, November 08, 2005 10:17 AM</FONT>
<BR><FONT SIZE=3D2>To: bluez-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Bluez-devel] C Program for Getting =
Link Quality</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Arpit,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; I did a yum update bluez*.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; The verion I'm using is:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; [root@174-15 bluetooth]# ls -l</FONT>
<BR><FONT SIZE=3D2>&gt; total 116</FONT>
<BR><FONT SIZE=3D2>&gt; -rw-r--r--&nbsp; 1 root root&nbsp; 3607 =
Mar&nbsp; 2&nbsp; 2005 bluetooth.h</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; On including sys/socket.h..the error is the =
same:</FONT>
</P>

<P><FONT SIZE=3D2>maybe &lt;sys/ioctl.h&gt; is also missing.</FONT>
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
------_=_NextPart_001_01C5E49A.8A2DA1B0--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
