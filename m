Return-Path: <cyrus@holtmann.org>
Message-ID: <022301c8aa48$d4d03040$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <seife@suse.de>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Tue, 29 Apr 2008 17:31:51 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Bluez-utils-3.30 (patched) plugins failing at startup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0735331216=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0735331216==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0220_01C8AA1E.E8F80BD0"

This is a multi-part message in MIME format.

------=_NextPart_000_0220_01C8AA1E.E8F80BD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Stefan,

thank you for your response.  Just before receiving your message in the =
digest, I enabled glib, and the plugins do load.

Now, however, when I attempt to ActivateService for "audio" against =
/org/bluez and the org.bluez.Manager interface, it still tries to launch =
the now-obsolete bluetoothd-service-audio.

At least at this point, I now have a direction to "hack" in (zzzzzzzt: =
out comes the C-machete...).

Mit freundlichen Gr=FC=DFen,

David Stockwell
------=_NextPart_000_0220_01C8AA1E.E8F80BD0
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
<DIV><FONT face=3DArial size=3D2>Stefan,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>thank you for your response.&nbsp; Just =
before=20
receiving your message in the digest, I enabled glib, and the plugins do =

load.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Now, however, when I attempt to =
ActivateService for=20
"audio" against /org/bluez and the org.bluez.Manager interface, it still =
tries=20
to launch the now-obsolete bluetoothd-service-audio.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>At least at this point, I now have a =
direction to=20
"hack" in (zzzzzzzt: out comes the C-machete...).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2>Mit freundlichen Gr</FONT><FONT=20
size=3D2>=FC=DF</FONT><FONT size=3D2>en,</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David =
Stockwell</FONT></DIV></BODY></HTML>

------=_NextPart_000_0220_01C8AA1E.E8F80BD0--



--===============0735331216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0735331216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0735331216==--
