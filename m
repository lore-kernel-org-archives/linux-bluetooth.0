Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Wed, 2 Aug 2006 09:10:07 +0530
Message-ID: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <3837d8b10608010954l1cba6660g296de8379b2b8022@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1023356758=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1023356758==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002B_01C6B613.782348D0"

This is a multi-part message in MIME format.

------=_NextPart_000_002B_01C6B613.782348D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Keith,

 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0051 < ACL data: handle 44 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0 
      Connection refused - PSM not supported   
There is a connection request from the headset on PSM 23 (0x17) which is
AVCTP.
So probably, the headset is trying to connect on AVRCP, which we reject.
.................................
 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0053 < ACL data: handle 44 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0053 result 2 status 0 
      Connection refused - PSM not supported  
Another request from the headset on PSM 23.
 > ACL data: handle 44 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4   
 > ACL data: handle 44 flags 0x02 dlen 7 
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Close cmd: transaction 1
        ACP SEID 1 
Now, probably, its too much for the headset and it sends close command. 
 
Regards,
Mayank


------=_NextPart_000_002B_01C6B613.782348D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
size=3D2>Hi Keith,</FONT></SPAN></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen =
12<BR>&nbsp;&nbsp;&nbsp;=20
  L2CAP(s): Connect req: psm 23 scid 0x0051 &lt; ACL data: handle 44 =
flags 0x02=20
  dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid =
0x0051=20
  result 2 status 0 <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection =
refused - PSM=20
  not supported&nbsp;&nbsp;<SPAN class=3D382563403-02082006><FONT=20
  face=3D"Courier New" color=3D#0000ff =
size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>There is a connection request from the headset on PSM 23 =
(0x17) which=20
  is AVCTP.</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>So probably, the headset is trying to connect on AVRCP, which =
we=20
  reject.</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>.................................</FONT></SPAN></DIV>
  <DIV>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen =
12<BR>&nbsp;&nbsp;&nbsp;=20
  L2CAP(s): Connect req: psm 23 scid 0x0053 &lt; ACL data: handle 44 =
flags 0x02=20
  dlen 16<BR>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid =
0x0053=20
  result 2 status 0 <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection =
refused - PSM=20
  not supported&nbsp;<SPAN class=3D382563403-02082006><FONT =
face=3D"Courier New"=20
  color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>Another request from the headset on PSM =
23.</FONT></SPAN></DIV>
  <DIV>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen =
6<BR>&nbsp;&nbsp;&nbsp;=20
  L2CAP(d): cid 0x0040 len 2 [psm 25]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  AVDTP(s): Start rsp: transaction 4&nbsp;&nbsp;<SPAN=20
  class=3D382563403-02082006><FONT face=3D"Courier New" color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN>&gt; ACL data: handle 44 flags 0x02 dlen =
7=20
  <BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 3 [psm=20
  25]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Close cmd: transaction =

  1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<SPAN=20
  class=3D382563403-02082006><FONT face=3D"Courier New" color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>Now, probably, its too much for the headset and it sends =
close=20
  command.</FONT>&nbsp;</SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2></FONT></SPAN>&nbsp;</DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>Regards,</FONT></SPAN></DIV>
  <DIV><SPAN class=3D382563403-02082006><FONT face=3D"Courier New" =
color=3D#0000ff=20
  size=3D2>Mayank</FONT></SPAN></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_002B_01C6B613.782348D0--



--===============1023356758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1023356758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1023356758==--
