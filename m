Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Mon, 23 Oct 2006 12:32:08 +0530
Message-ID: <019d01c6f671$284585a0$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <d1a198ae0610221203n6e0dd9a4y1cdf40e4bd79f8d5@mail.gmail.com>
Subject: [Bluez-users] hcid problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1564099239=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1564099239==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_019E_01C6F69F.41FDC1A0"

This is a multi-part message in MIME format.

------=_NextPart_000_019E_01C6F69F.41FDC1A0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi=20
I am using bluez-utils-3.7 and red hat linux kernel version 2.4.20-8. I =
have installed dbus-0.61 but I am facing problem in starting hcid. From =
the mailing archives I could make out that dbus message bus is not =
started so hcid is not starting up. I get the error :
=20
[root@del32tpt hcid]# hcid -n
hcid[10086]: Bluetooth HCI daemon
hcid[10086]: Can't open system message bus connection: Failed to connect =
to socket /usr/local/var/run/dbus/system_bus_socket: No such file or =
directory

Can you please tell me how to get this message bus running on my PC.
=20
Thanks in advance,

Sumeet Verma



=20

------=_NextPart_000_019E_01C6F69F.41FDC1A0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Courier New" size=3D2><SPAN=20
class=3D155075806-23102006>Hi </SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Courier New" size=3D2><SPAN=20
class=3D155075806-23102006>I am using bluez-utils-3.7 and red hat linux =
kernel=20
version 2.4.20-8. I have installed dbus-0.61 but I am facing problem in =
starting=20
hcid. From the mailing archives I could make out that dbus message bus =
is not=20
started so hcid is not starting up. I get the error =
:</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Courier New" size=3D2><SPAN=20
class=3D155075806-23102006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Courier New" size=3D2><SPAN=20
class=3D155075806-23102006>[root@del32tpt hcid]# hcid -n<BR>hcid[10086]: =
Bluetooth=20
HCI daemon<BR>hcid[10086]: Can't open system message bus connection: =
Failed to=20
connect to socket /usr/local/var/run/dbus/system_bus_socket: No such =
file or=20
directory<BR></SPAN></FONT></DIV>
<DIV><SPAN class=3D155075806-23102006><FONT face=3D"Courier New" =
size=3D2>Can you=20
please tell me how to get this message bus running on my =
PC.</FONT></SPAN></DIV>
<DIV><SPAN class=3D155075806-23102006><FONT face=3D"Courier New"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D155075806-23102006><FONT face=3D"Courier New" =
size=3D2>Thanks in=20
advance,</FONT></SPAN></DIV><!-- Converted from text/plain format -->
<P><FONT size=3D2>Sumeet Verma<BR><BR></FONT></P>
<DIV><FONT face=3D"Courier New" =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_019E_01C6F69F.41FDC1A0--



--===============1564099239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1564099239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1564099239==--
