Return-Path: <cyrus@holtmann.org>
Message-ID: <01e501c8bc60$e20638c0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 22 May 2008 18:09:24 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] bluez hcid v3.31 main.conf
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1361134212=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1361134212==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01E2_01C8BC36.F71EDCF0"

This is a multi-part message in MIME format.

------=_NextPart_000_01E2_01C8BC36.F71EDCF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On startup, hcid attempts to load_config(CONFIGDIR "main.conf").  =
However, main.conf is missing.  This may have been a recent change in =
that in hcid.h, HCID_CONFIG_FILE refers to CONFIGDIR "hcid.conf".

When I attempt to substitute HCID_CONFIG_FILE to load_config, =
load_config chokes on what is in that file.

So, what is/should be contained in main.conf?  Is the correct, or what =
should it be?  (In general, using a "magic filename" like "main.conf" is =
not a great practice, and perhaps makes the code base harder to =
maintain, especially when a #define with a similar purpose already =
exists in the headers...)

Thanks in advance,

David Stockwell

BTW, to those who are going to be there, enjoy Helsinki...one of the few =
places I have not yet been!
------=_NextPart_000_01E2_01C8BC36.F71EDCF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>On startup, hcid attempts to =
load_config(CONFIGDIR=20
"main.conf").&nbsp; However, main.conf is missing.&nbsp; This may have =
been a=20
recent change in that in hcid.h, HCID_CONFIG_FILE refers to CONFIGDIR=20
"hcid.conf".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When I attempt to substitute =
HCID_CONFIG_FILE to=20
load_config, load_config chokes on what is in that file.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So, what is/should be contained in =
main.conf?&nbsp;=20
Is the correct, or what should it be?&nbsp; (In general, using a "magic=20
filename" like "main.conf" is not a great practice, and perhaps makes =
the code=20
base harder to maintain, especially when a #define with a similar =
purpose=20
already exists in the headers...)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in advance,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David Stockwell</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>BTW, to those who are going to be =
there, enjoy=20
Helsinki...one of the few places I have not yet =
been!</FONT></DIV></BODY></HTML>

------=_NextPart_000_01E2_01C8BC36.F71EDCF0--



--===============1361134212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1361134212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1361134212==--
