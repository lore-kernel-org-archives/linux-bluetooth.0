Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000c01c4847b$d1fe14f0$5000005a@naxus>
From: "Carlos AM" <Carlos@naxus.biz>
To: "lista bluez" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C4848C.94F10D90"
Subject: [Bluez-devel] BCSP not working
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 Aug 2004 19:01:20 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C4848C.94F10D90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

These messages appear on the kernel log when I am using BCSP:

<3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
<3>bcsp_recv: Checksum failed: computed b237 received 0000
<4>Warning: kfree_skb passed an skb still on a list (from 000f77a4).
<2>kernel BUG at skbuff.c:319!
<3>bcsp_recv: Short BCSP packet

Then the computer hangs.

I enabled "Send CRC with every hci packet" in the kernel and in the =
bluetooth device.

What's happening?




Carlos AM
Naxus Conectividad M=F3vil
------=_NextPart_000_0009_01C4848C.94F10D90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>These messages appear on the kernel log =
when I am=20
using BCSP:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&lt;3&gt;bcsp_recv: Out-of-order packet =
arrived,=20
got 1 expected 0<BR>&lt;3&gt;bcsp_recv: Checksum failed: computed b237 =
received=20
0000<BR>&lt;4&gt;Warning: kfree_skb passed an skb still on a list (from=20
000f77a4).<BR>&lt;2&gt;kernel BUG at =
skbuff.c:319!<BR>&lt;3&gt;bcsp_recv: Short=20
BCSP packet</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>Then the computer hangs.</DIV><FONT face=3DArial =
size=3D2></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial size=3D2>I enabled =
"Send CRC with=20
every hci packet" in the kernel and in the bluetooth =
device.</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial size=3D2>What's=20
happening?</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2>&nbsp;</DIV>
<DIV><BR></DIV></FONT>
<DIV><FONT face=3DArial size=3D2>Carlos AM<BR>Naxus Conectividad=20
M=F3vil</FONT></FONT></DIV></BODY></HTML>

------=_NextPart_000_0009_01C4848C.94F10D90--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
