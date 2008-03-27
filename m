Return-Path: <cyrus@holtmann.org>
Message-ID: <003901c8900a$a282e860$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 27 Mar 2008 08:01:11 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] TODO: --enable/--disable options in bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0922283857=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0922283857==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0036_01C88FE0.B8BE88C0"

This is a multi-part message in MIME format.

------=_NextPart_000_0036_01C88FE0.B8BE88C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Subsequent to yesterday's post, I found all of the configure options to =
enable/disable various options.

In my application, I have no real need (at this point, at least) for =
audio streaming, and I might like to diable -gstreamer, -alsa, and =
similar options.  Probably would also disable -serial and certain other =
profiles.

And there are other things, like --enable-usb, which if I disable it =
might turn off my USB-connected Bluetooth dongle.

However, at this point I am using --enable-all, since there is no real =
documentation of the dependencies.  Any chance these might be =
documented: with 27 options, that's about 268 million permutations, =
which would take a while to figure out...

Something for the TODO list?

David Stockwell


------=_NextPart_000_0036_01C88FE0.B8BE88C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DArial size=3D2>Subsequent to yesterday's post, =
</FONT><FONT=20
face=3DArial size=3D2>I found all of the configure options to =
enable/disable various=20
options.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>In my application, I have no real need =
(at this=20
point, at least) for audio streaming, and I might like to diable =
-gstreamer,=20
-alsa, and similar options.&nbsp; Probably would also disable -serial =
and=20
certain other profiles.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>And there are other things, like =
--enable-usb,=20
which if I disable it might turn off my USB-connected Bluetooth=20
dongle.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>However, at this point I am using =
--enable-all,=20
since there is no real documentation of the dependencies.&nbsp; Any =
chance these=20
might be documented: with 27 options, that's about 268 million =
permutations,=20
which would take a while to figure out...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Something for the TODO =
list?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David Stockwell</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------=_NextPart_000_0036_01C88FE0.B8BE88C0--



--===============0922283857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0922283857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0922283857==--
