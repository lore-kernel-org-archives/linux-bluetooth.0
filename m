Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <CF8C38B8FA1ED511A92400508BE37F0B0A961D03@exchange_corp.bhcsecurities.com>
From: "Rybalkin, Albert" <Albert.Rybalkin@Fiserv.com>
To: "'bluez-users@lists.sourceforge.net'"
	 <bluez-users@lists.sourceforge.net>,
   "'albertr@iral.com'"
	 <albertr@iral.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C40F52.A099A418"
Subject: [Bluez-users] panu question
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
Date: Sun, 21 Mar 2004 08:41:43 -0600

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C40F52.A099A418
Content-Type: text/plain

The NAP server is win2k box running BlueSoleil 1.4.2. PANU client is linux
2.4.18 with latest BlueZ kernel patches and recent userland. The client was
trying to connect with: 

 

pand --role PANU --service NAP --connect 00:10:60:A2:CB:8E --nodetach 

 

Here's a snipset from syslog: 

 

Mar 20 22:56:26 localhost pand[10355]: PAN daemon ver 1.1 

Mar 20 22:56:26 localhost pand[10355]: Connecting to 00:10:60:A2:CB:8E 

Mar 20 22:56:34 localhost hcid[9931]: pin_code_request
(sba=00:E0:03:7A:CA:52, dba=00:10:60:A2:CB:8E) 

Mar 20 22:56:34 localhost hcid[9931]: link_key_notify
(sba=00:E0:03:7A:CA:52) 

Mar 20 22:56:34 localhost hcid[9931]: Replacing link key 00:E0:03:7A:CA:52
00:10:60:A2:CB:8E 

Mar 20 22:56:34 localhost pand[10355]: Connect to 00:10:60:A2:CB:8E failed.
Connection refused(111) 

Mar 20 22:56:34 localhost modprobe: modprobe: Can't locate module bnep0 

 

Here's a relevant packet dump: 

 

HCIDump - HCI packet analyzer ver 1.5 

device: hci0 snap_len: 1028 filter: 0xffffffff 

1079841480.014826 < HCI Command: Create Connection(0x01|0x0005) plen 13 

1079841480.018618 > HCI Event: Command Status(0x0f) plen 4 

1079841481.141376 > HCI Event: Connect Complete(0x03) plen 11 

1079841481.146042 < ACL data: handle 0x0001 flags 0x02 dlen 12 

  L2CAP(s): Connect req: psm 15 scid 0x0040 

1079841481.146135 < HCI Command: Write Link Policy Settings(0x02|0x000d)
plen 4 

1079841481.154064 > HCI Event: Max Slots Change(0x1b) plen 3 

1079841481.157711 > HCI Event: Number of Completed Packets(0x13) plen 5 

1079841481.159440 > HCI Event: Command Complete(0x0e) plen 6 

1079841481.186978 > HCI Event: Max Slots Change(0x1b) plen 3 

1079841481.190467 > ACL data: handle 0x0001 flags 0x02 dlen 16 

  L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 1 status 1 

1079841481.268379 > HCI Event: Link Key Request(0x17) plen 6 

1079841481.269926 < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22


1079841481.317000 > HCI Event: Command Complete(0x0e) plen 10 

1079841481.374126 > ACL data: handle 0x0001 flags 0x02 dlen 16 

  L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 1 status 2 

1079841481.375454 > ACL data: handle 0x0001 flags 0x02 dlen 16 

  L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 3 status 0 

1079841483.366055 < HCI Command: Disconnect(0x01|0x0006) plen 3 

1079841483.369603 > HCI Event: Command Status(0x0f) plen 4 

1079841483.450023 > HCI Event: Disconn Complete(0x05) plen 4 

 

Any hints what is going wrong here? 

 

Thanks, 

-albertr


------_=_NextPart_001_01C40F52.A099A418
Content-Type: text/html

<html>

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">


<meta name=Generator content="Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US link=blue vlink=purple>

<div class=Section1>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>The NAP server is win2k box running BlueSoleil 1.4.2. PANU
client is linux 2.4.18 with latest BlueZ kernel patches and recent userland.
The client was trying to connect with: </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>pand --role PANU --service NAP --connect 00:10:60:A2:CB:8E
--nodetach </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Here's a snipset from syslog: </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:26</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost pand[10355]:
PAN daemon ver 1.1 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:26</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost pand[10355]:
Connecting to 00:10:60:A2:CB:8E </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:34</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost hcid[9931]:
pin_code_request (sba=00:E0:03:7A:CA:52, dba=00:10:60:A2:CB:8E) </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:34</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost hcid[9931]:
link_key_notify (sba=00:E0:03:7A:CA:52) </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:34</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost hcid[9931]:
Replacing link key 00:E0:03:7A:CA:52 00:10:60:A2:CB:8E </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:34</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost pand[10355]:
Connect to 00:10:60:A2:CB:8E failed. Connection refused(111) </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Mar 20 </span></font><font size=2 face=Arial><span
 style='font-size:10.0pt;font-family:Arial'>22:56:34</span></font><font size=2
face=Arial><span style='font-size:10.0pt;font-family:Arial'> localhost modprobe:
modprobe: Can't locate module bnep0 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Here's a relevant packet dump: </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>HCIDump - HCI packet analyzer ver 1.5 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>device: hci0 snap_len: 1028 filter: 0xffffffff </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841480.014826 &lt; HCI Command: Create Connection(0x01|0x0005)
plen 13 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841480.018618 &gt; HCI Event: Command Status(0x0f) plen
4 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.141376 &gt; HCI Event: Connect Complete(0x03) plen
11 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.146042 &lt; ACL data: handle 0x0001 flags 0x02 dlen
12 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp; L2CAP(s): Connect req: psm 15 scid 0x0040 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.146135 &lt; HCI Command: Write Link Policy Settings(0x02|0x000d)
plen 4 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.154064 &gt; HCI Event: Max Slots Change(0x1b) plen
3 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.157711 &gt; HCI Event: Number of Completed Packets(0x13)
plen 5 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.159440 &gt; HCI Event: Command Complete(0x0e) plen
6 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.186978 &gt; HCI Event: Max Slots Change(0x1b) plen
3 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.190467 &gt; ACL data: handle 0x0001 flags 0x02 dlen
16 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp; L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result
1 status 1 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.268379 &gt; HCI Event: Link Key Request(0x17) plen
6 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.269926 &lt; HCI Command: Link Key Request Reply(0x01|0x000b)
plen 22 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.317000 &gt; HCI Event: Command Complete(0x0e) plen
10 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.374126 &gt; ACL data: handle 0x0001 flags 0x02 dlen
16 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp; L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result
1 status 2 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841481.375454 &gt; ACL data: handle 0x0001 flags 0x02 dlen
16 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp; L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result
3 status 0 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841483.366055 &lt; HCI Command: Disconnect(0x01|0x0006) plen
3 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841483.369603 &gt; HCI Event: Command Status(0x0f) plen
4 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>1079841483.450023 &gt; HCI Event: Disconn Complete(0x05) plen
4 </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Any hints what is going wrong here? </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>Thanks, </span></font></p>

<p class=MsoNormal><font size=2 face=Arial><span style='font-size:10.0pt;
font-family:Arial'>-albertr</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C40F52.A099A418--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
