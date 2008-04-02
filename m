Return-Path: <cyrus@holtmann.org>
Message-ID: <014c01c894ca$6cfbe010$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Wed, 2 Apr 2008 09:04:08 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Bug in audio/AVRCP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1087340524=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1087340524==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0149_01C894A0.82C02D90"

This is a multi-part message in MIME format.

------=_NextPart_000_0149_01C894A0.82C02D90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There appears to be a bug in 3.29/audio/control.c, lines 1050-1051.  In =
avrcp_exit, the code removes the ct_record_id twice, and does nothing to =
remove the tg_record_id.

DS
------=_NextPart_000_0149_01C894A0.82C02D90
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
<DIV><FONT face=3DArial size=3D2>There appears to be a bug in =
3.29/audio/control.c,=20
lines 1050-1051.&nbsp; In avrcp_exit, the code removes the ct_record_id =
twice,=20
and does nothing to remove the tg_record_id.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV></BODY></HTML>

------=_NextPart_000_0149_01C894A0.82C02D90--



--===============1087340524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1087340524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1087340524==--
