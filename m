Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <005e01c4f320$e16dd0b0$6f04a8c0@ZBOX>
From: "Suriyan" <suriyan@netgadgets.co.th>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005B_01C4F35B.8D9719C0"
Subject: [Bluez-devel] Re: Re: multi rfcomm/sco connection
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
Date: Wed, 5 Jan 2005 19:20:01 +0700

This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C4F35B.8D9719C0
Content-Type: text/plain;
	charset="windows-874"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I just found lastest patch in hci_usb.c that pass alternate setting =
(isoc) as kernel module parameter but it's still static solution to =
support more than one SCO connection over single bluetooth adapter. Are =
you working on dynamically support? I have try to do this a few week ago =
but I stuck on usb_set_interface() function since I cannot meet it's =
pre-conditions.

Thanks.

Best Regards,
Suriyan.

------=_NextPart_000_005B_01C4F35B.8D9719C0
Content-Type: text/html;
	charset="windows-874"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-874">
<META content=3D"MSHTML 6.00.2800.1458" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><FONT size=3D3>Hi Marcel,<BR><BR>I just =
found lastest=20
patch in hci_usb.c that pass alternate setting (isoc) as kernel module=20
parameter&nbsp;but it's still static solution to support more than =
one&nbsp;SCO=20
connection over&nbsp;single bluetooth&nbsp;adapter.&nbsp;Are =
you&nbsp;working on=20
dynamically support? I have try to do this a few week ago but I stuck on =

usb_set_interface() function since I cannot meet it's=20
pre-conditions.</FONT></FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>Thanks.</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>Best Regards,</FONT></DIV>
<DIV><FONT face=3DArial>Suriyan.</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_005B_01C4F35B.8D9719C0--




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
