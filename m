Return-Path: <cyrus@holtmann.org>
Message-ID: <051f01c88e7f$2e73f040$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 25 Mar 2008 08:50:25 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Minimum Version of GStreamer for bluez-utils-3.29?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0931860946=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0931860946==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_051C_01C88E55.44717630"

This is a multi-part message in MIME format.

------=_NextPart_000_051C_01C88E55.44717630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

bluez-utils-3.29 does not compile: failing in compilation of =
gstrtpsbcpay.c,
@201: implicit declaration of gst_adapter_copy, and
@208: 'GstBaseRtpPayloadClass' has no member named 'handle_event'

It appears GStreamer is only up to 0.10.9 or thereabouts.  What is the =
minimum/expected version of GStreamer 0.10 for bluez-utils-3.29? =
According to the GStreamer site, the current version is 0.10.18, as of =
just a few days ago.

Another question: I do not intend to use streaming audio in this =
application, and I have to ask why all of this is bundled into the audio =
module at this fairly deep layer?  Seems to be a bit too bundled, =
leading to too many dependencies, unless everybody is intent on =
developing headset applications.

DS
------=_NextPart_000_051C_01C88E55.44717630
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
<DIV><FONT face=3DArial size=3D2>bluez-utils-3.29 does not compile: =
failing in=20
compilation of gstrtpsbcpay.c,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>@201: implicit declaration of =
gst_adapter_copy,=20
and</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>@208: 'GstBaseRtpPayloadClass' has no =
member named=20
'handle_event'</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It appears GStreamer is only up to =
0.10.9 or=20
thereabouts.&nbsp; What is the minimum/expected version of GStreamer =
0.10 for=20
bluez-utils-3.29? According to the GStreamer site, the current version =
is=20
0.10.18, as of just a few days ago.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Another question:&nbsp;I do not intend =
to use=20
streaming audio in this application, and I have to ask why all of this =
is=20
bundled into the audio module at this fairly deep layer?&nbsp; Seems to =
be a bit=20
too bundled, leading to too many dependencies, unless everybody is =
intent on=20
developing headset applications.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV></BODY></HTML>

------=_NextPart_000_051C_01C88E55.44717630--



--===============0931860946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0931860946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0931860946==--
