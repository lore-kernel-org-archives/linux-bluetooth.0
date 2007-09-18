Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 18 Sep 2007 09:45:43 +0530
Message-ID: <6E672510D37D58428215BDFDF097DB46014692C9@EXGNT01.sasken.com>
From: "Pintu Agarwal" <pintu.agarwal@sasken.com>
To: <bluez-devel@lists.sourceforge.net>
Cc: maxk@qualcomm.com
Subject: [Bluez-devel] FW: Need some help - linux bluetooth driver
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1871034518=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1871034518==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F9AA.5D6E74E8"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7F9AA.5D6E74E8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi,
=20
I need a help in compiling the linux 2.4.22 code (bluetooth part).
Can you help me here.
=20
=20
Here is my problem description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
I have a linux system which is running on Linux 2.4.22-ncgl-10.12.1.0
kernel. It is a modified kernel.=20
Here the BLUETOOTH part is removed from the kernel.=20
(I didnt find - hci_core , hci_conn.o , and other required drivers and
some of the export symbols are missing)
(It report un resolved symbols - "hci_register_dev")
=20
I have the 2.4.22-ncgl-10.12.1.0 kernel source with me (on another
system).
Now, I dont want to build the whole kernel again. (This is not possible
as it is in another system under separate path)
=20
I wanted to compile only the Bluetooth related path (net/bluetooth/*)
from this kernel source and put all related stuffs on my system.
Is it possible??????? Please let me know the procedure. Please help me
out.
=20
That is I wanted to compile all the bluetooth protocol stack related
drivers separately.
Such as - hci_conn.c , hci_core.c, rfcomm.c , l2cap.c , etc, etc
=20
Also under net/bluetooth folder I saw there is one file - syms.c that
contains many EXPORT_SYMBOLS.
Please let me know how to use this file to export these symbols on my
box.
(My un resolved symbols are actually present here)
=20
Note:
I could able to create hci_core.o etc but I am not able to link syms.c
to export the required symbols.
=20
=20
Please help me out.
=20
=20
=20
Thanks a lot,
Pintu=20
=20
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

------_=_NextPart_001_01C7F9AA.5D6E74E8
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1589" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>I need a =
help in=20
compiling the linux 2.4.22 code (bluetooth part).</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Can you h=
elp me=20
here.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Here is m=
y problem=20
description</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>I have a =
linux=20
system which is running on Linux <FONT=20
color=3D#0000ff>2.4.22-ncgl-10.12.1.0</FONT> kernel. It is a modified kerne=
l=2E=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Here the =
BLUETOOTH=20
part is removed from the kernel. </FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>(I didnt =
find -=20
hci_core , hci_conn.o , and other required drivers and some of the export=20
symbols are missing)</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>(It repor=
t un=20
resolved symbols - "hci_register_dev")</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>I have th=
e <FONT=20
color=3D#0000ff>2.4.22-ncgl-10.12.1.0</FONT> kernel source with me (on anot=
her=20
system).</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Now, I do=
nt want to=20
build the whole kernel again. (This is not possible as it is in another sys=
tem=20
under separate path)</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>I wanted =
to compile=20
only the Bluetooth related path (net/bluetooth/*) from&nbsp;this kernel=20
source&nbsp;and put all related stuffs on my system.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Is it=20
possible??????? Please let me know the procedure. Please help me=20
out.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>That is I=
 wanted to=20
compile all the bluetooth protocol stack related drivers=20
separately.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Such as -=
 hci_conn.c=20
, hci_core.c, rfcomm.c , l2cap.c , etc, etc</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Also unde=
r=20
net/bluetooth folder I saw there is one file - syms.c that contains many=20
EXPORT_SYMBOLS.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Please le=
t me know=20
how to use this file to export these symbols on my box.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>(My un re=
solved=20
symbols are actually present here)</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2>Note:</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>I could a=
ble to=20
create hci_core.o etc but I am not able to link syms.c to export the requir=
ed=20
symbols.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Please he=
lp me=20
out.</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Thanks a=20
lot,</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial size=3D2>Pintu=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D596210115-17092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV><pre>SASKEN BUSINESS DISCLAIMER
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

------_=_NextPart_001_01C7F9AA.5D6E74E8--


--===============1871034518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1871034518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1871034518==--
