Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 6 Sep 2007 18:26:58 +0530
Message-ID: <6E672510D37D58428215BDFDF097DB46012D653E@EXGNT01.sasken.com>
From: "Pintu Agarwal" <pintu.agarwal@sasken.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] FW: Regarding USB Bluetooth Driver for
	Linux.....(2.4.22 kernel)!
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0757685885=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0757685885==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F085.31FEA6BC"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7F085.31FEA6BC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I have a USB Bluetooth device which can be used to transfer/receive
files from my Mobile.=20
=20
I am working on a PBX system which is running on Linux.
I am planning to write a USB Bluetooth Driver for this in Linux. My  PBX
Linux kernel version is - 2.4.22-ncgl-10.12.1.0
(Note: This kernel is a modified kernel of "2.4.22" without bluetooth
support)
I dont have any means of re-compiling the whole kernel again and putting
it on the box.
Also its not possible for me to upgrade the kernel version to 2.6.
Also this system doesnt have the kernel source as well.
I have to compile my code in some other system and put my binaries on
this box to test.
=20
=20
I have written the starting part of it and my driver seems to detect the
device. That is I could able to read the interface and the endpoints
from it.
=20
But I am stuck on the part where we need to do "register", "open",
"send" on the HCI device.
=20
When I use HCI calls and install my driver I get "un-resolved" symbols.
(hci_register_dev, hci_unregister_dev)
I think this symbols are not exported in my kernel.=20
Is there any way to EXPORT this symbols without re-building the Kernel
again?
=20
Or is there any other way by which I can go ahead. That is without using
HCI.
Can I use RFCOMM here??=20
=20
According to me it looks like "hci_core", "l2cap" and "rfcomm"
interfaces are missing from my kernel.
Is there a way to re-compile only this part from the whole kernel source
and install it on my system to get those symbols.=20
=20
=20
Can you guide me writing my own simple USB bluetooth driver for kernel
2=2E4.22 where I can able to transfer files from my mobile to my linux pc.
Please help me  out.
=20
=20
=20
Thanks, Regards
Pintu
SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged in=
formation. In=20
case you are not the original intended Recipient of the message, you must n=
ot, directly or=20
indirectly, use, Disclose, distribute, print, or copy any part of this mess=
age and you are=20
requested to delete it and inform the sender. Any views expressed in this m=
essage are=20
those of the individual sender unless otherwise stated. Nothing contained i=
n this message=20
shall be construed as an offer or acceptance of any offer by Sasken Communi=
cation=20
Technologies Limited ("Sasken") unless sent with that express intent and wi=
th due=20
authority of Sasken. Sasken has taken enough precautions to prevent the spr=
ead of=20
viruses. However the company accepts no liability for any damage caused by =
any virus=20
transmitted by this email

------_=_NextPart_001_01C7F085.31FEA6BC
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1589" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><FONT face=3DArial =
color=3D#0000ff=20
size=3D2><SPAN class=3D811015813-03092007>Hi,</SPAN></FONT></DIV>
<DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D811015813-03092007><FONT face=3DArial><FONT color=3D#000=
0ff><FONT=20
size=3D2>I have a USB Bluetooth device which can be used to transfer/receiv=
e files=20
from my Mobile.<SPAN=20
class=3D277105713-05092007>&nbsp;</SPAN></FONT></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007><SPAN=20
class=3D277105713-05092007>I am working on a PBX system which is running on=20
Linux.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007>I am planning to write a USB Bluetooth Driver fo=
r this=20
in Linux. </SPAN><SPAN class=3D811015813-03092007>My&nbsp;<SPAN=20
class=3D277105713-05092007>&nbsp;PBX </SPAN>Linux kernel version is -=20
2=2E4.22-ncgl-10.12.1.0<SPAN=20
class=3D277105713-05092007></SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007><SPAN class=3D277105713-05092007>(Note:&nbsp;Thi=
s kernel=20
is a modified&nbsp;kernel of "2.4.22" without bluetooth=20
support)</SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007><SPAN class=3D277105713-05092007>I dont have any=
 means of=20
re-compiling the whole kernel again and putting it on the=20
box.</SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007><SPAN class=3D277105713-05092007>Also its not po=
ssible=20
for me to upgrade the kernel version to=20
2=2E6.</SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007><SPAN class=3D277105713-05092007>Also this syste=
m doesnt=20
have the kernel source as well.</SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D811015813-03092007><SPAN class=3D277105713-05092007>I have to compi=
le my=20
code in some other system and put my binaries&nbsp;on this box&nbsp;to=20
test.</SPAN></SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007><STRONG></STRONG></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>I have=20
written the starting part of it and my driver seems to detect the device.=20
</SPAN></FONT><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007>That is I could able to read the interface and t=
he=20
endpoints from it.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>But I=20
am stuck on the part where we need to do "register", "open", "send" on the =
HCI=20
device.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>When I=20
use HCI calls and install my driver I get "un-resolved" symbols.=20
(hci_register_dev, hci_unregister_dev)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>I=20
think this symbols are not exported in my kernel. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>Is=20
there any way to EXPORT this symbols without re-building the Kernel=20
again?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>Or is=20
there any other way by which I can go ahead. That is without using=20
HCI.</SPAN></FONT></DIV>
<DIV><SPAN class=3D811015813-03092007><FONT face=3DArial><FONT color=3D#000=
0ff><FONT=20
size=3D2>Can I use RFCOMM here??<SPAN=20
class=3D277105713-05092007>&nbsp;</SPAN></FONT></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D811015813-03092007><FONT face=3DArial><FONT color=3D#000=
0ff><FONT=20
size=3D2><SPAN=20
class=3D277105713-05092007></SPAN></FONT></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D811015813-03092007><FONT face=3DArial><FONT color=3D#000=
0ff><FONT=20
size=3D2><SPAN class=3D277105713-05092007>According to me it looks like "hc=
i_core",=20
"l2cap" and "rfcomm" interfaces are missing from my=20
kernel.</SPAN></FONT></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D811015813-03092007><FONT face=3DArial><FONT color=3D#000=
0ff><FONT=20
size=3D2><SPAN class=3D277105713-05092007>Is there a way to re-compile only=
 this=20
part from the whole kernel source and&nbsp;install it on my system to get t=
hose=20
symbols.&nbsp;</SPAN></FONT></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>Can=20
you guide me writing my own simple USB bluetooth driver for kernel 2.4.22 w=
here=20
I can able to transfer files from my mobile to my linux pc.</SPAN></FONT></=
DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D811015813-03=
092007>Please=20
help me&nbsp;<SPAN=20
class=3D277105713-05092007>&nbsp;out</SPAN>.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007>Thanks, Regards</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D811015813-03092007>Pintu</SPAN></FONT></DIV></FONT></DIV><pre>SASKE=
N BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged in=
formation. In=20
case you are not the original intended Recipient of the message, you must n=
ot, directly or=20
indirectly, use, Disclose, distribute, print, or copy any part of this mess=
age and you are=20
requested to delete it and inform the sender. Any views expressed in this m=
essage are=20
those of the individual sender unless otherwise stated. Nothing contained i=
n this message=20
shall be construed as an offer or acceptance of any offer by Sasken Communi=
cation=20
Technologies Limited ("Sasken") unless sent with that express intent and wi=
th due=20
authority of Sasken. Sasken has taken enough precautions to prevent the spr=
ead of=20
viruses. However the company accepts no liability for any damage caused by =
any virus=20
transmitted by this email
</pre></BODY></HTML>

------_=_NextPart_001_01C7F085.31FEA6BC--


--===============0757685885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0757685885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0757685885==--
