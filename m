Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F6A6D2.9080408@ozob.net>
Date: Tue, 13 Mar 2007 08:27:46 -0500
From: Gene Imes <ebi7@ozob.net>
MIME-Version: 1.0
To: list - bluez-users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] can not send from phone to laptop
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I can not send a picture from my phone to my laptop but I can send from 
laptop to phone. This has worked before libs and utils 3.7. I use 3.9 now.

Here is the output of hicdupm -VX:

root@go:/etc/bluetooth# hcidump -VX
HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:16:B8:37:07:D3 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:16:B8:37:07:D3 role 0x01
     Role: Slave
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 42 bdaddr 00:16:B8:37:07:D3 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 42
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:16:B8:37:07:D3 mode 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 42 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 42 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 42
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
     handle 42 ptype 0xcc18
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 42
     Features: 0xff 0xed 0x8d 0xf8 0x1a 0x08 0x00 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:16:B8:37:07:D3 mode 2 clkoffset 0x0000
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
     status 0x00 handle 42 ptype 0xff1e
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 
3-DH5
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:16:B8:37:07:D3 name 'Gene'
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1500
< ACL data: handle 42 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       Success
       MTU 1500
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 45
     L2CAP(d): cid 0x0040 len 41 [psm 1]
         SDP SSA Req: tid 0x1 len 0x24
           pat uuid-16 0x111b (ImagingResp)
           max 1500
           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 
0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0310 (SuppCapabilities) 
0x0311 (SuppFeatures) 0x0312 (SuppFunctions) 0x0313 (SuppTotalCapacity)
           cont 00
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 36
     L2CAP(d): cid 0x0040 len 32 [psm 1]
         SDP SSA Req: tid 0x1 len 0x1b
           pat uuid-16 0x1105 (OBEXObjPush)
           max 1500
           aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 
0x0009 (BTProfileDescList) 0x0100 (SrvName) 0x0303 (SuppFormatsList)
           cont 00
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:16:B8:37:07:D3 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:16:B8:37:07:D3 role 0x01
     Role: Slave
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 43 bdaddr 00:16:B8:37:07:D3 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 43
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:16:B8:37:07:D3 mode 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 43 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 43 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 43
     Features: 0xff 0xed 0x8d 0xf8 0x1a 0x08 0x00 0x00
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 43
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
     handle 43 ptype 0xcc18
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:16:B8:37:07:D3 mode 2 clkoffset 0x0000
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
     status 0x00 handle 43 ptype 0xff1e
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 
3-DH5
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 43 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       Success
       MTU 672
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:16:B8:37:07:D3 name 'Gene'
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 25
     L2CAP(d): cid 0x0040 len 21 [psm 1]
         SDP SSA Req: tid 0x1 len 0x10
           pat uuid-16 0x1105 (OBEXObjPush)
           max 672
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 43 reason 0x13
     Reason: Remote User Terminated Connection


I appreciate any help.

Thanks,

-- 
Gene Imes ============================= ozob.net

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
