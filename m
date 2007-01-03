Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <459B9565.3060306@glidos.net>
Date: Wed, 03 Jan 2007 11:37:09 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>	<1167725398.30886.32.camel@violet>	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>	<20070102081813.6a264b0e.ml133@netpole.com.br>	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>	<20070102094414.f7b9cef1.ml133@netpole.com.br>	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>	<1167743069.30886.54.camel@violet>	<459A60A1.80906@glidos.net>	<1167745840.30886.77.camel@violet>	<459AC8B4.7090407@glidos.net>
	<1167772692.30886.117.camel@violet> <459B947A.30803@glidos.net>
In-Reply-To: <459B947A.30803@glidos.net>
Subject: Re: [Bluez-users] Problems fooling my S100 into using Bluez as a
 modem
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

Paul Gardiner wrote:
> Also, I have to own up to something silly: when some of your
> statements seemed to imply that most of this should work
> without special configuration, I put the original config
> files in place, but didn't notice that dund was off by
> default.  I'll post some new dumps with that corrected.

This is the dump of my S100 discovering Bluez. This is
without a preceding call to "sdptool add DUN", and
although the device is discovered, the S100 then
refuses to use it as a modem:

HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:09:2D:08:BC:57 class 0x100114 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:09:2D:08:BC:57 role 0x01
     Role: Slave
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 42 bdaddr 00:09:2D:08:BC:57 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 42
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:09:2D:08:BC:57 mode 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 42 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
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
 > HCI Event: Command Status (0x0f) plen 4
     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:09:2D:08:BC:57 mode 2 clkoffset 0x0000
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
     status 0x00 handle 42 ptype 0xff1e
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 
3-DH5
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 42
     Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:09:2D:08:BC:57 name 'Pocket_PC2'
 > HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:09:2D:08:BC:57
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
     bdaddr 00:09:2D:08:BC:57 len 4 pin '6969'
 > HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Reply (0x01|0x000d) ncmd 1
     status 0x00 bdaddr 00:09:2D:08:BC:57
 > HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:09:2D:08:BC:57 key 8293311B9D50705254DBEBA5259F9851 type 0
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:09:2D:08:BC:57 class 0x100114 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:09:2D:08:BC:57 role 0x01
     Role: Slave
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 43 bdaddr 00:09:2D:08:BC:57 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 43
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:09:2D:08:BC:57 mode 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 43 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0055
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0055 result 0 status 0
       Connection successful
 > HCI Event: Command Status (0x0f) plen 4
     Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 43 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 43
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
     handle 43 ptype 0xcc18
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:09:2D:08:BC:57 mode 2 clkoffset 0x0000
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
     status 0x00 handle 43 ptype 0xff1e
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 
3-DH5
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 43
     Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:09:2D:08:BC:57 name 'Pocket_PC2'
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0055 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0055 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 4
     L2CAP(d): cid 0x0040 len 34 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1d
           pat uuid-128 00001108-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0055 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0055
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0055
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0056
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0056 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0056 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0056 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 4
     L2CAP(d): cid 0x0040 len 34 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1d
           pat uuid-128 0000111e-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0056 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0056
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0056
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0057
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0057 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0057 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0057 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 4
     L2CAP(d): cid 0x0040 len 34 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1d
           pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0057 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0057
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0057
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0058
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0058 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0058 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0058 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 4
     L2CAP(d): cid 0x0040 len 34 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1d
           pat uuid-128 00001101-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 234
     L2CAP(d): cid 0x0058 len 230 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0xe1
           count 222
           record #0
               aid 0x0000 (SrvRecHndl)
                  uint 0x10002
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x1101 (SP) >
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x5 > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0100 (SrvName)
                  str "KBtSerialChat"
               aid 0x0101 (SrvDesc)
                  str "KDE Bluetooth Serial Chat Service"
           record #1
               aid 0x0000 (SrvRecHndl)
                  uint 0x10003
               aid 0x0001 (SrvClassIDList)
                  < uuid-16 0x1101 (SP) >
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x1b > >
               aid 0x0005 (BrwGrpList)
                  < uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0100 (SrvName)
                  str "KDE Bemused Server"
               aid 0x0101 (SrvDesc)
                  str "KDE Server for the Bemused remote control protocol"
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0058
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0058
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0059
< ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0059 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0059 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0059 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > ACL data: handle 43 flags 0x02 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 17
 > ACL data: handle 43 flags 0x01 dlen 4
     L2CAP(d): cid 0x0040 len 34 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1d
           pat uuid-128 0350278f-3dca-4e62-831d-a41165ff906c
           max 4088
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 43 flags 0x02 dlen 14
     L2CAP(d): cid 0x0059 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
 > ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0059
< ACL data: handle 43 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0059
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 43 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 43 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 43 reason 0x16
     Reason: Connection Terminated by Local Host

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
