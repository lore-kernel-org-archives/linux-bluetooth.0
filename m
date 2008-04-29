Return-Path: <cyrus@holtmann.org>
Message-ID: <022c01c8aa49$55cf90a0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <seife@suse.de>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 29 Apr 2008 17:35:30 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Bluez-utils-3.30 (patched) plugins failing at
	startup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1764531336=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1764531336==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0229_01C8AA1F.6B668C90"

This is a multi-part message in MIME format.

------=_NextPart_000_0229_01C8AA1F.6B668C90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

And......now I see what I did: I did the ActivateService against the OLD =
interface and not the new, current interface...

Hmmmm....

DS
  ----- Original Message -----=20
  From: David Stockwell=20
  To: seife@suse.de ; BlueZ development=20
  Sent: Tuesday, April 29, 2008 5:31 PM
  Subject: Bluez-utils-3.30 (patched) plugins failing at startup


  Stefan,

  thank you for your response.  Just before receiving your message in =
the digest, I enabled glib, and the plugins do load.

  Now, however, when I attempt to ActivateService for "audio" against =
/org/bluez and the org.bluez.Manager interface, it still tries to launch =
the now-obsolete bluetoothd-service-audio.

  At least at this point, I now have a direction to "hack" in (zzzzzzzt: =
out comes the C-machete...).

  Mit freundlichen Gr=FC=DFen,

  David Stockwell
------=_NextPart_000_0229_01C8AA1F.6B668C90
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
<DIV><FONT face=3DArial size=3D2>And......now I see what I did: I did =
the=20
ActivateService against the OLD interface and not the new, current=20
interface...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Hmmmm....</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Ddstockwell@frequency-one.com=20
  href=3D"mailto:dstockwell@frequency-one.com">David Stockwell</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A title=3Dseife@suse.de=20
  href=3D"mailto:seife@suse.de">seife@suse.de</A> ; <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ =
development</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Tuesday, April 29, 2008 =
5:31=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Bluez-utils-3.30 =
(patched)=20
  plugins failing at startup</DIV>
  <DIV><BR></DIV>
  <DIV><FONT face=3DArial size=3D2>Stefan,</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>thank you for your response.&nbsp; =
Just before=20
  receiving your message in the digest, I enabled glib, and the plugins =
do=20
  load.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Now, however, when I attempt to =
ActivateService=20
  for "audio" against /org/bluez and the org.bluez.Manager interface, it =
still=20
  tries to launch the now-obsolete =
bluetoothd-service-audio.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>At least at this point, I now have a =
direction to=20
  "hack" in (zzzzzzzt: out comes the C-machete...).</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial><FONT size=3D2>Mit freundlichen Gr</FONT><FONT =

  size=3D2>=FC=DF</FONT><FONT size=3D2>en,</FONT></FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>David=20
Stockwell</FONT></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0229_01C8AA1F.6B668C90--



--===============1764531336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1764531336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1764531336==--
