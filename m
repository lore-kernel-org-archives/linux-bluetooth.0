Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000c01c41a0c$b0441c80$7b6b7b8c@yaya>
From: "guang" <m9187@cn.ee.ccu.edu.tw>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C41A4F.BB4FBC40"
Subject: [Bluez-users] pin code problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 4 Apr 2004 14:18:41 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C41A4F.BB4FBC40
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi all:
I implement an Audio Gateway (PC) to communication a Headset (sony =
ericsson HBH-65), but  AG can't commucation HS. As fllow:

I type " l2ping 00:0D:E3:00:00:33"=20
and it appear :
  [root@bluez root]# l2ping 00:0A:D9:A1:F4:49
  Can't connect.: Permission denied

and i used hcidump to dump file:

HCIDump - HCI packet analyzer ver 1.6
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11

I guess the problem be caused by PIN Code.
How can I enter PIN Code to response HS.
How to paring between AG and HS ?


------=_NextPart_000_0009_01C41A4F.BB4FBC40
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi all:</FONT></DIV>
<DIV><FONT size=3D2>I implement an Audio Gateway (PC) to communication a =
Headset=20
(sony ericsson HBH-65), but&nbsp; AG can't commucation HS. As=20
fllow:</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I type " l2ping 00:0D:E3:00:00:33" </FONT></DIV>
<DIV><FONT size=3D2>and it appear :</FONT></DIV>
<DIV><FONT size=3D2>&nbsp; [root@bluez root]# l2ping =
00:0A:D9:A1:F4:49<BR>&nbsp;=20
Can't connect.: Permission denied</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>and i used hcidump to dump file:</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>HCIDump - HCI packet analyzer ver 1.6<BR>&lt; HCI =
Command:=20
Create Connection(0x01|0x0005) plen 13<BR>&gt; HCI Event: Command =
Status(0x0f)=20
plen 4<BR>&gt; HCI Event: Link Key Request(0x17) plen 6<BR>&lt; HCI =
Command:=20
Link Key Request Negative Reply(0x01|0x000c) plen 6<BR>&gt; HCI Event: =
Command=20
Complete(0x0e) plen 10<BR>&lt; HCI Command: Link Key Request Negative=20
Reply(0x01|0x000c) plen 6<BR>&gt; HCI Event: Command Complete(0x0e) plen =

10<BR>&lt; HCI Command: Link Key Request Negative Reply(0x01|0x000c) =
plen=20
6<BR>&gt; HCI Event: Command Complete(0x0e) plen 10<BR>&gt; HCI Event: =
Connect=20
Complete(0x03) plen 11<BR></FONT></DIV>
<DIV><FONT size=3D2>I guess the problem be caused by PIN =
Code.</FONT></DIV>
<DIV><FONT size=3D2>How can I enter PIN Code to response =
HS.</FONT></DIV>
<DIV><FONT size=3D2>How to paring between AG and HS ?</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_0009_01C41A4F.BB4FBC40--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
