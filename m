Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: M Josenhans <m_josenhans@web.de>
Date: Mon, 18 Sep 2006 23:28:54 +0200
Message-ID: <een2ub$f0l$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Browsing Anycom GP-600 GPS Receiver fails
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello bluez,

I own an Anycom GP-600 GPS Receiver. This receiver might have a broken 
SDP stack. I use SuSE Linux 9.3.

When browsing the device using the sdptool browse command, it fails. 
However when using Konqueror to browse the SDP-record on the same 
distribution it works fine.

The difference between kde and sdptool browse seems to be, that kde uses 
a 32 bit UUID, while the sdptool uses a 16 bit UUID.

Is there any chance that bluez could handle such trouble more gracefully 
and issue a waring? I remember prior Bluez versions had been working 
slightly better.

Below you find the dumps for browsing with KDE and sdptool.

Br,
Michael


Browsing with KDE seems to use 32Bit UUID:
------------------------------------------
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 6 num 0
 > HCI Event: Command Status (0x0f) plen 4
     Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
     bdaddr 00:12:EE:9C:D4:CD clkoffset 0x4af5 class 0x520204
 > HCI Event: Inquiry Result (0x02) plen 15
     bdaddr 00:0E:07:8D:EC:65 clkoffset 0x024d class 0x520204
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:78:02:BF:8C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Inquiry Complete (0x01) plen 1
     status 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:78:02:BF:8C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:78:02:BF:8C
     Link key: 8495e337c0ed515f4925967cead95d83
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:78:02:BF:8C
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 43 bdaddr 00:02:78:02:BF:8C type ACL encrypt 0x01
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 43 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 43
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
 > HCI Event: Max Slots Change (0x1b) plen 3
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 48
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 26
     L2CAP(d): cid 0x0051 len 22 [psm 1]
         SDP SSA Req: tid 0x0 len 0x11
           pat uuid-32 0x1002 (PubBrwsGrp)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 48
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 26
     L2CAP(d): cid 0x0052 len 22 [psm 1]
         SDP SSA Req: tid 0x0 len 0x11
           pat uuid-32 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 1
     L2CAP(d): cid 0x0041 len 48 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x2b
           count 38
           cont 02 00 0F
< ACL data: handle 43 flags 0x02 dlen 28
     L2CAP(d): cid 0x0052 len 24 [psm 1]
         SDP SSA Req: tid 0x1 len 0x13
           pat uuid-32 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 02 00 0F
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 10
     L2CAP(d): cid 0x0041 len 23 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x12
           count 15
           record #0
               aid 0x0000 (SrvRecHndl)
                  uint 0x10000
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x1101 (SP) >
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
               aid 0x0100 (SrvName)
                  str "SPP slave"
           cont 00
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0052 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0052 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 43 reason 0x13
     Reason: Remote User Teminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 43 reason 0x16
     Reason: Connection Terminated by Local Host



Browsing with sdptool command seems to use 16 Bit UUIDs:
--------------------------------------------------------

sdptool browse <bdaddr>;

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:78:02:BF:8C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:78:02:BF:8C
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:78:02:BF:8C
     Link key: 8495e337c0ed515f4925967cead95d83
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:78:02:BF:8C
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 42 bdaddr 00:02:78:02:BF:8C type ACL encrypt 0x01
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 42 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 42
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
 > HCI Event: Max Slots Change (0x1b) plen 3
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 48
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 42 flags 0x02 dlen 24
     L2CAP(d): cid 0x0050 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1002 (PubBrwsGrp)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0050 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0050 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 42 reason 0x13
     Reason: Remote User Teminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x16
     Reason: Connection Terminated by Local Host


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
