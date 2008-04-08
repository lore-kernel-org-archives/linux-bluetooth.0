Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2008 14:19:19 +0200
Message-ID: <EADBA796DAC6CB4089D6C9FC6A87773501DFEDB4@ERLM862A.ww001.siemens.net>
From: "Krause, Bernd" <bernd.bk.krause@siemens.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] need implementation for dfutool via uart;
	what does usb_control_msg?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1787561428=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1787561428==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C89972.CABC4BEA"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89972.CABC4BEA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
I need an implementation for the dfu-functionality via uart. For this
purpose, I need to know
what the function usb_control_msg writes exactly to the usb-Device to
duplicate for example
the header for uart.
I was unable to find an exact implementation of this function with e.g.
the given parameters
(USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE, DFU_UPLOAD). I only
found the
functions usb_start_wait_urb
<http://www.srcdoc.com/linux_2.2.26/usb_8c.html#a41>  and usb_submit_urb
<http://www.srcdoc.com/linux_2.2.26/usb_8c.html#a38> , but I can't find
out what is really send via usb.
Can anybody tell me what this function sends to the device? And if
anyone knows, it is possible
to rewrite this functionality for uart?
=20
Thanks for help,
Best Regards, Bernd Krause

Siemens AG
Medical Solutions
MED MR PLM ST SCC
Allee am Roethelheimpark 2
91052 Erlangen, Germany
Tel.:=20
Fax:=20
mailto:bernd.bk.krause@siemens.com
=20

------_=_NextPart_001_01C89972.CABC4BEA
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3268" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT size=3D2><SPAN class=3D106451612-08042008>
<DIV><SPAN class=3D162253311-08042008><FONT =
face=3DArial>Hello,</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>I need an =
implementation=20
for the dfu-functionality via uart. For this purpose, I need to=20
know</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>what the =
function=20
usb_control_msg writes exactly to the usb-Device to duplicate for=20
example</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>the header for=20
uart.</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>I was unable to =
find an=20
exact implementation of this function with e.g. the given=20
parameters</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>(USB_TYPE_CLASS =
|=20
USB_DIR_IN | USB_RECIP_INTERFACE,&nbsp;DFU_UPLOAD).<SPAN=20
class=3D106451612-08042008> I only found the</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial><SPAN=20
class=3D106451612-08042008>functions <A class=3Dcode=20
href=3D"http://www.srcdoc.com/linux_2.2.26/usb_8c.html#a41">usb_start_wai=
t_urb</A>&nbsp;and=20
<A class=3Dcode=20
href=3D"http://www.srcdoc.com/linux_2.2.26/usb_8c.html#a38">usb_submit_ur=
b</A>,=20
but I can't find out what is really send via =
usb.</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>Can anybody =
tell me what=20
this function sends to the device? And if anyone knows, it is=20
possible</FONT></SPAN></DIV>
<DIV><SPAN class=3D162253311-08042008><FONT face=3DArial>to rewrite this =

functionality for uart?</FONT></SPAN></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV align=3Dleft><SPAN class=3D162253311-08042008></SPAN><FONT =
face=3DArial>T<SPAN=20
class=3D162253311-08042008>hanks for help,</SPAN></FONT></DIV>
<DIV align=3Dleft><FONT size=3D+0><SPAN =
class=3D162253311-08042008></SPAN><SPAN=20
class=3D162253311-08042008></SPAN><FONT face=3DArial size=3D2>B<SPAN=20
class=3D162253311-08042008>est Regards, </SPAN>Bernd=20
Krause</FONT></FONT></DIV></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><BR>Siemens AG<BR>Medical =
Solutions<BR>MED MR PLM=20
ST SCC<BR>Allee am Roethelheimpark 2<BR>91052 Erlangen, Germany<BR>Tel.: =

<BR>Fax: <BR>mailto:<A=20
href=3D"mailto:bernd.bk.krause@siemens.com">bernd.bk.krause@siemens.com</=
A></FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C89972.CABC4BEA--


--===============1787561428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1787561428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1787561428==--
