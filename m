Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C62B4D.4942BA7F"
Message-ID: <06CCEA2EB1B80A4A937ED59005FA85518805BE@svits26.main.ad.rit.edu>
From: "Christopher E Piggott" <cepasp@rit.edu>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] magic constants in sdptool.c
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
Date: Mon, 6 Feb 2006 13:43:57 -0500

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62B4D.4942BA7F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

static int cmd_records(int argc, char **argv)
{
    ...
    uint32_t base[] =3D { 0x10000, 0x1002e, 0x110b };
    ...
}
=20
Where do these magic constants come from?
=20
--Chris
=20
--
Christopher Piggott
Sr. Staff Engineer
Systems Modernization and Sustainment Center
Mailstop 78-1220
Rochester Institute of Technology
133 Lomb Memorial Drive
Rochester, NY 14523
(585) 475-4664
=20
=20

------_=_NextPart_001_01C62B4D.4942BA7F
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>static int cmd_records(int argc, char=20
**argv)<BR>{<BR><SPAN=20
class=3D485323818-06022006>&nbsp;&nbsp;&nbsp;&nbsp;...</SPAN></FONT></DIV=
>
<DIV><FONT><SPAN class=3D485323818-06022006></SPAN><FONT =
face=3DArial><FONT=20
size=3D2><SPAN class=3D485323818-06022006>&nbsp;&nbsp;&nbsp; =
</SPAN>uint32_t base[]=20
=3D { 0x10000, 0x1002e, 0x110b };</FONT></FONT></FONT></DIV>
<DIV><FONT><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D485323818-06022006>&nbsp;&nbsp;&nbsp;=20
...</SPAN></FONT></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT><FONT><SPAN class=3D485323818-06022006></SPAN><FONT=20
face=3DArial><FONT size=3D2><SPAN=20
class=3D485323818-06022006></SPAN>}</FONT></FONT></FONT></FONT></FONT></D=
IV>
<DIV><FONT><FONT><FONT><FONT face=3DArial><FONT=20
size=3D2></FONT></FONT></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT><FONT><FONT><SPAN class=3D485323818-06022006><FONT =
face=3DArial=20
size=3D2>Where do these magic constants come=20
from?</FONT></SPAN></FONT></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT><FONT><FONT><SPAN class=3D485323818-06022006><FONT =
face=3DArial=20
size=3D2></FONT></SPAN></FONT></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT><FONT><FONT><SPAN class=3D485323818-06022006><FONT =
face=3DArial=20
size=3D2>--Chris</FONT></SPAN></FONT></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT><FONT><FONT><SPAN=20
class=3D485323818-06022006></SPAN></FONT></FONT></FONT></FONT>&nbsp;</DIV=
>
<DIV align=3Dleft><FONT face=3DArial size=3D2>--</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Christopher =
Piggott</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Sr. Staff =
Engineer</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Systems Modernization and =
Sustainment=20
Center</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Mailstop =
78-1220</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Rochester Institute of=20
Technology</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>133 Lomb Memorial =
Drive</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Rochester, NY =
14523</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>(585) =
475-4664</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C62B4D.4942BA7F--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
