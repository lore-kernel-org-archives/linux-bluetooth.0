Return-Path: <cyrus@holtmann.org>
Message-ID: <046701c8d25f$0dcf13a0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 19 Jun 2008 17:51:44 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Fw: Next Release, and Device.DiscoverServices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1188819611=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1188819611==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0464_01C8D235.23342A20"

This is a multi-part message in MIME format.

------=_NextPart_000_0464_01C8D235.23342A20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I think I answered my question when I saw the tag for release 3.33 show =
up on cvs.bluez.sourceforge.net.

For now, I have pulled only REL-3_33 and not subsequent patches -- to =
see if this new release answers my questions WRT UUIDs in GetProperties, =
etc., connecting with SSP, and the like.

I also hope you are successful in getting the bluez.org site back up; it =
must have been a serious problem to take it down for so long...

Best regards,
David Stockwell

----- Original Message -----=20
From: David Stockwell=20
To: BlueZ development=20
Sent: Wednesday, June 18, 2008 9:47 AM
Subject: Next Release, and Device.DiscoverServices


I have been working with Adapter.CreateDevice, and have been frustrated =
by finding that the list of UUIDs returned by Device.GetProperties is =
always empty.  (Getting the connectivity right is a necessary precursor =
to implementation of AVRCP with Metadata.)

Looking at the CVS, I see all have been quite busy, including adding a =
new DiscoverServices method, which I presume will do the querying of the =
remote SDP and filling in the list of UUIDs.  Am I correct?

I also see a lot of work around BT2.1 and SSP.

Given all of that, I am about to pull everything down from CVS, but am =
wondering if you are about to do another release (don't want to waste =
any effort if things are stabilizing enough to release again in a few =
days).

All the best,
DS
------=_NextPart_000_0464_01C8D235.23342A20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I think I answered my question when I =
saw the tag=20
for release 3.33 show up on cvs.bluez.sourceforge.net.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>For now, I have pulled only REL-3_33 =
and not=20
subsequent patches --&nbsp;to see if this new release answers my =
questions WRT=20
UUIDs in GetProperties, etc., connecting with SSP, and the =
like.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I also hope you are successful in =
getting the=20
bluez.org site back up; it must have been a serious problem to take it =
down for=20
so long...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>David Stockwell</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV style=3D"FONT: 10pt arial">----- Original Message -----=20
<DIV style=3D"BACKGROUND: #e4e4e4; font-color: black"><B>From:</B> <A=20
title=3Ddstockwell@frequency-one.com=20
href=3D"mailto:dstockwell@frequency-one.com">David Stockwell</A> </DIV>
<DIV><B>To:</B> <A title=3Dbluez-devel@lists.sourceforge.net=20
href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ development</A> =
</DIV>
<DIV><B>Sent:</B> Wednesday, June 18, 2008 9:47 AM</DIV>
<DIV><B>Subject:</B> Next Release, and =
Device.DiscoverServices</DIV></DIV>
<DIV><BR></DIV>
<DIV><FONT face=3DArial size=3D2>I have been working with =
Adapter.CreateDevice, and=20
have been frustrated by finding that the list of UUIDs returned by=20
Device.GetProperties is always empty.&nbsp; (Getting the connectivity =
right is a=20
necessary precursor to implementation of AVRCP with =
Metadata.)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Looking at the CVS, I see all have been =
quite busy,=20
including adding a new DiscoverServices method, which I presume will do =
the=20
querying of the remote SDP and filling in the list of UUIDs.&nbsp; Am I=20
correct?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I also see&nbsp;a lot of work around =
BT2.1 and=20
SSP.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Given all of that, I am about to pull =
everything=20
down from CVS, but am wondering if you are about to do another release =
(don't=20
want to waste any effort if things are stabilizing enough to release =
again in a=20
few days).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>All the best,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV></BODY></HTML>

------=_NextPart_000_0464_01C8D235.23342A20--



--===============1188819611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1188819611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1188819611==--
