Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 28 Jun 2007 10:06:59 -0400
Message-ID: <2EB6297382462046A9427D7324788A4801F55372@MCLNEXVS06.resource.ds.bah.com>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] hcidump with multiple dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0991346570=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0991346570==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7B98D.97DEEA8A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7B98D.97DEEA8A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry, I forgot to mention that I'm running 2.6.20-1.2952 Fedora Core 6
with the latest Bluez libs and utils.
thanks,
=20
Rich
=20
-----------------------------------------------------------------
Hello,
=20
I've been working on a project that requires multiple Bluetooth dongles
on a single PC. I have a USB 2.0 hub with two dongles. I can create my
problem in the following manner:
=20
- window 1     l2ping xx:xx:xx:xx:xx:xx  - so this command is running
constantly.
- window 2     hcidump -i hci0               - this command is dumping
the output correctly.
- window 3     hcitool scan -i hci1
- window 4     hcidump -i hci1
=20
After a little while ( sometimes immediately ) the hcitool scan in
window 3 will fail:
=20
# hcitool scan -i hci1
Scanning...
=20
Inquiry failed. Connection timed out.
#
#
=20
The test works fine if I do NOT use hcidump. That is, I can run window 1
and 3 all day with no problem. When I add hcidump, the "hcitool scan -i
hci1" will then begin to fail to connect to the hci device.
=20
Have you seen this ? Any fixes?
=20
thank you.
=20
Rich Williams
=20
=20

------_=_NextPart_001_01C7B98D.97DEEA8A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007>Sorry, I forgot to mention that I'm running=20
2.6.20-1.2952 Fedora Core 6 with the latest Bluez libs and=20
utils.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007>thanks,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007>Rich</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007><SPAN=20
class=3D620340514-28062007>----------------------------------------------=
-------------------</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>I've =
been working on=20
a project that requires multiple Bluetooth dongles on a single PC. I =
have a USB=20
2.0 hub with two dongles. I can create my problem in the following=20
manner:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>- =
window=20
1&nbsp;&nbsp;&nbsp; &nbsp;<STRONG>l2ping =
xx:xx:xx:xx:xx:xx</STRONG>&nbsp; - so=20
this command is running constantly.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>- =
window=20
2&nbsp;&nbsp;&nbsp;&nbsp; <STRONG>hcidump -i=20
hci0</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
- this command is dumping the output correctly.</SPAN></FONT></DIV>
<DIV><SPAN class=3D737285213-28062007><FONT face=3DArial><FONT =
size=3D2>- window=20
3&nbsp;&nbsp;&nbsp;&nbsp; <STRONG>hcitool scan -i=20
hci1</STRONG></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D737285213-28062007><FONT face=3DArial><FONT =
size=3D2>- window=20
4&nbsp;&nbsp;&nbsp;&nbsp; <STRONG>hcidump -i=20
hci1</STRONG></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>After =
a little while=20
( sometimes immediately ) the hcitool scan in window 3 will=20
fail:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007># =
hcitool scan -i=20
hci1</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007>Scanning...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D737285213-28062007>Inquiry failed.=20
Connection timed out.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007>#</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007>#</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>The =
test works fine=20
if I do NOT use hcidump. That is, I can run window 1 and 3 all day with =
no=20
problem. When I add hcidump, the "hcitool scan -i hci1" will then begin =
to fail=20
to connect to the hci device.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>Have =
you seen this ?=20
Any fixes?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>thank=20
you.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D737285213-28062007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D737285213-28062007>Rich=20
Williams</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7B98D.97DEEA8A--


--===============0991346570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0991346570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0991346570==--
