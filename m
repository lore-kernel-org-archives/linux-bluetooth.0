Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 23 Aug 2007 09:12:56 -0400
Message-ID: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Multiple Bluetooth Dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0899547327=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0899547327==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E587.4F2D8263"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7E587.4F2D8263
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
I have a system that uses multiple Bluetooth dongles and works just
fine. I've had my system running with several USB hubs and up to the 16
maximum devices that Bluez supports. Now I have a changing requirement
from my customer to handle more than 16 Bluetooth devices. They want
support for up to 30 Bluetooth devices.
=20
I changed the HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to 30,
recompiled and installed bluez_libs and bluez_utils. No problem.
=20
My program works fine with up to 16 Bluetooth devices, but the 17th
device is not recognized and sometimes the entire USB will no longer
work.
=20
Suggestions??
=20
Thank you. Best Regards.
=20
Rich=20

------_=_NextPart_001_01C7E587.4F2D8263
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D023260513-23082007>I have =
a system that=20
uses multiple Bluetooth dongles and works just fine. I've had my system =
running=20
with several USB hubs and up to the 16 maximum devices that Bluez =
supports. Now=20
I have a changing requirement from my customer to handle more than 16 =
Bluetooth=20
devices. They want support for up to 30 Bluetooth =
devices.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D023260513-23082007>I =
changed the=20
HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to 30,&nbsp;recompiled =
and=20
installed&nbsp;bluez_libs and bluez_utils. No =
problem.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D023260513-23082007>My =
program works=20
fine with up to 16 Bluetooth devices, but the 17th device is not =
recognized and=20
sometimes&nbsp;the entire USB&nbsp;will no&nbsp;longer =
work.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007>Suggestions??</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D023260513-23082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D023260513-23082007>Thank =
you. Best=20
Regards.</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2><STRONG>Rich =
</STRONG></FONT><FONT=20
face=3DArial size=3D2></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C7E587.4F2D8263--


--===============0899547327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0899547327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0899547327==--
