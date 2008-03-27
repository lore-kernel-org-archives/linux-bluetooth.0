Return-Path: <cyrus@holtmann.org>
Message-ID: <003201c89009$65f46500$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <thiagossantos@gmail.com>
References: <051f01c88e7f$2e73f040$6701a8c0@freqonedev>
	<de4879e80803260952t9967c01pbfe54c5d186419b6@mail.gmail.com>
Date: Thu, 27 Mar 2008 07:52:19 -0500
MIME-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Minimum Version of GStreamer for bluez-utils-3.29?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0705320378=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0705320378==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002F_01C88FDF.7BDA1D30"

This is a multi-part message in MIME format.

------=_NextPart_000_002F_01C88FDF.7BDA1D30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Thaigos.

I guess this is what I get for trying to develop on a machine built from =
a six-month-old distro.  I updated to 0.10.18, which required updates to =
liboil, etc., etc.

All is working now (another post coming...)

DS
  ----- Original Message -----=20
  From: thiagoss=20
  To: BlueZ development=20
  Sent: Wednesday, March 26, 2008 11:52 AM
  Subject: Re: [Bluez-devel] Minimum Version of GStreamer for =
bluez-utils-3.29?


  It was developed using version 0.10.17, but I guess that from 0.10.14 =
everything would work.

  Thiago


  On Tue, Mar 25, 2008 at 10:50 AM, David Stockwell =
<dstockwell@frequency-one.com> wrote:

    bluez-utils-3.29 does not compile: failing in compilation of =
gstrtpsbcpay.c,
    @201: implicit declaration of gst_adapter_copy, and
    @208: 'GstBaseRtpPayloadClass' has no member named 'handle_event'

    It appears GStreamer is only up to 0.10.9 or thereabouts.  What is =
the minimum/expected version of GStreamer 0.10 for bluez-utils-3.29? =
According to the GStreamer site, the current version is 0.10.18, as of =
just a few days ago.

    Another question: I do not intend to use streaming audio in this =
application, and I have to ask why all of this is bundled into the audio =
module at this fairly deep layer?  Seems to be a bit too bundled, =
leading to too many dependencies, unless everybody is intent on =
developing headset applications.

    DS

    =
-------------------------------------------------------------------------=

    This SF.net email is sponsored by: Microsoft
    Defy all challenges. Microsoft(R) Visual Studio 2008.
    http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
    _______________________________________________
    Bluez-devel mailing list
    Bluez-devel@lists.sourceforge.net
    https://lists.sourceforge.net/lists/listinfo/bluez-devel




------=_NextPart_000_002F_01C88FDF.7BDA1D30
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
<DIV><FONT face=3DArial size=3D2>Thanks, Thaigos.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I guess this is what I get for trying =
to develop on=20
a machine built from a six-month-old distro.&nbsp; I updated to 0.10.18, =
which=20
required updates to liboil, etc., etc.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>All is working now (another post=20
coming...)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dthiagossantos@gmail.com=20
  href=3D"mailto:thiagossantos@gmail.com">thiagoss</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ =
development</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, March 26, 2008 =
11:52=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Bluez-devel] =
Minimum=20
  Version of GStreamer for bluez-utils-3.29?</DIV>
  <DIV><BR></DIV>It was developed using version 0.10.17, but I guess =
that from=20
  0.10.14 everything would work.<BR><BR>Thiago<BR><BR>
  <DIV class=3Dgmail_quote>On Tue, Mar 25, 2008 at 10:50 AM, David =
Stockwell=20
  &lt;<A href=3D"mailto:dstockwell@frequency-one.com"=20
  target=3D_blank>dstockwell@frequency-one.com</A>&gt; wrote:<BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV bgcolor=3D"#ffffff">
    <DIV><FONT face=3DArial size=3D2>bluez-utils-3.29 does not compile: =
failing in=20
    compilation of gstrtpsbcpay.c,</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>@201: implicit declaration of =
gst_adapter_copy,=20
    and</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>@208: 'GstBaseRtpPayloadClass' has =
no member=20
    named 'handle_event'</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>It appears GStreamer is only up to =
0.10.9 or=20
    thereabouts.&nbsp; What is the minimum/expected version of GStreamer =
0.10=20
    for bluez-utils-3.29? According to the GStreamer site, the current =
version=20
    is 0.10.18, as of just a few days ago.</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2>Another question:&nbsp;I do not =
intend to use=20
    streaming audio in this application, and I have to ask why all of =
this is=20
    bundled into the audio module at this fairly deep layer?&nbsp; Seems =
to be a=20
    bit too bundled, leading to too many dependencies, unless everybody =
is=20
    intent on developing headset applications.</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV><FONT =
color=3D#888888>
    <DIV><FONT face=3DArial=20
    =
size=3D2>DS</FONT></DIV></FONT></DIV><BR>--------------------------------=
-----------------------------------------<BR>This=20
    SF.net email is sponsored by: Microsoft<BR>Defy all challenges. =
Microsoft(R)=20
    Visual Studio 2008.<BR><A=20
    href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/"=20
    =
target=3D_blank>http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</=
A><BR>_______________________________________________<BR>Bluez-devel=20
    mailing list<BR><A href=3D"mailto:Bluez-devel@lists.sourceforge.net" =

    target=3D_blank>Bluez-devel@lists.sourceforge.net</A><BR><A=20
    href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel"=20
    =
target=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-devel<=
/A><BR><BR></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_002F_01C88FDF.7BDA1D30--



--===============0705320378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0705320378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0705320378==--
