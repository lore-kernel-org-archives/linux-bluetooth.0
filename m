Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A2089D.5030100@phaldor.co.uk>
From: Dave Givens <dave.givens@phaldor.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="------------000102040408030202000504"
Subject: [Bluez-users] Bluetooth Printing (Belkin Print Server)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 22 Nov 2004 15:41:17 +0000

This is a multi-part message in MIME format.
--------------000102040408030202000504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel et al,
    I have taken Marcels advice and moved to SUSE 9.2 after trying 
Debian on the way. I could not get Debian to work with SATA and so it 
was a non starter for this system. SUSE works a treat with SATA, 
wireless LAN card and everything but my bluetooth print server. I cannot 
find any services for this device, my phone shows up fine as does a 
windows bluetooth enabled machine. I have included results from some 
commands, please let me know if  there are any others I should run. Any 
help would be greatly appreciated as I have very little hair left.

admin@Gimli:~> hcitool inq
Inquiring ...
            00:0F:DE:1C:2A:59      clock offset: 0x2893      class: 0x520204
            00:09:DD:10:39:03      clock offset: 0x7eae      class: 0x020104
            00:02:72:40:80:A3      clock offset: 0x2151      class: 0x040680
admin@Gimli:~> hcitool inq
Scanning ...
            00:0F:DE:1C:2A:59      dave
            00:09:DD:10:39:03      DRAGON
            00:02:72:40:80:A3      BELKIN_PRT_4080A3
admin@Gimli:~> hcitool info 00:02:72:40:80:A3
Requesting information ...
    BD Address:  00:02:72:40:80:A3
    Device Name: BELKIN_PRT_4080A3
    LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
    Manufacturer: Cambridge Silicon Radio (10)
    Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        <3-slot packets> <5-slot packets> <encryption> <slot offset>
        <timing accuracy> <role switch> <hold mode> <sniff mode>
        <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
        <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
        <power control> <transparent SCO>
admin@Gimli:~> hcidump -x
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  A3 80 40 72 02 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 A3 80 40 72 02 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  A3 80 40 72 02 00 01
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x0000 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 672
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0051 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x0051 len 22 [psm 1]
        SDP SSA Req: tid 0x0 len 0x11
          pat uuid-32 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6
          cnt 0x3
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0052 flags 0x0000 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 672
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0052 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x0052 len 22 [psm 1]
        SDP SSA Req: tid 0x0 len 0x11
          pat uuid-32 0x0100 (L2CAP)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x8
          cnt 0x3
          cont 02 00 00
..... (etc etc etc) ....


Dave Givens

--------------000102040408030202000504
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Marcel et al,<br>
&nbsp;&nbsp;&nbsp; I have taken Marcels advice and moved to SUSE 9.2 after trying
Debian on the way. I could not get Debian to work with SATA and so it
was a non starter for this system. SUSE works a treat with SATA,
wireless LAN card and everything but my bluetooth print server. I
cannot find any services for this device, my phone shows up fine as
does a windows bluetooth enabled machine. I have included results from
some commands, please let me know if&nbsp; there are any others I should
run. Any help would be greatly appreciated as I have very little hair
left.<br>
<br>
<tt>admin@Gimli:~&gt; hcitool inq<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:0F:DE:1C:2A:59&nbsp;&nbsp; &nbsp;&nbsp; clock offset: 0x2893&nbsp;&nbsp; &nbsp;&nbsp; class:
0x520204<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:09:DD:10:39:03&nbsp;&nbsp; &nbsp;&nbsp; clock offset: 0x7eae &nbsp; &nbsp;&nbsp; class:
0x020104<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:02:72:40:80:A3&nbsp;&nbsp; &nbsp;&nbsp; clock offset: 0x2151&nbsp;&nbsp; &nbsp;&nbsp; class:
0x040680<br>
</tt><tt>admin@Gimli:~&gt; hcitool inq<br>
Scanning ...<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:0F:DE:1C:2A:59&nbsp;&nbsp; &nbsp;&nbsp; dave<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:09:DD:10:39:03&nbsp;&nbsp; &nbsp;&nbsp; DRAGON<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; 00:02:72:40:80:A3&nbsp;&nbsp; &nbsp;&nbsp; BELKIN_PRT_4080A3</tt><br>
<tt>admin@Gimli:~&gt; hcitool info </tt><tt>00:02:72:40:80:A3</tt><br>
<tt>Requesting information ...<br>
&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:02:72:40:80:A3<br>
&nbsp;&nbsp;&nbsp; Device Name: BELKIN_PRT_4080A3<br>
&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x20d<br>
&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt;
&lt;encryption&gt; &lt;slot offset&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt;
&lt;sniff mode&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO
link&gt; &lt;HV2 packets&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt;
&lt;CVSD&gt; &lt;paging scheme&gt; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt; <br>
</tt><tt>admin@Gimli:~&gt; hcidump -x<br>
HCIDump - HCI packet analyzer ver 1.11<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp; A3 80 40 72 02 00 18 CC 02 00 00 00 01 <br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 05 04 <br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 00 29 00 A3 80 40 72 02 00 01 00 <br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 29 00 0F 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp; 01 0D 08 00 29 00 <br>
&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>
&nbsp; A3 80 40 72 02 00 01 <br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 29 00 05 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0051 flags 0x0000 clen 0<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 672 <br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0051 flags 0x0000 result 0 clen 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 26<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0051 len 22 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0x11<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x1002 (PubBrwsGrp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 15<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt 0x3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00 <br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0041<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0052 flags 0x0000 clen 0<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0<br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 672 <br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0052 flags 0x0000 result 0 clen 0<br>
&lt; ACL data: handle 0x0029 flags 0x02 dlen 26<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0052 len 22 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0x11<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-32 0x0100 (L2CAP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 01 29 00 01 00 <br>
&gt; ACL data: handle 0x0029 flags 0x02 dlen 17<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 13 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt 0x3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 02 00 00 <br>
<font color="#000099">..... (etc etc etc) ....</font><br>
</tt><br>
<br>
Dave Givens<br>
</body>
</html>

--------------000102040408030202000504--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
