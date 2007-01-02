Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <459AC8B4.7090407@glidos.net>
Date: Tue, 02 Jan 2007 21:03:48 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>	<1167725398.30886.32.camel@violet>	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>	<20070102081813.6a264b0e.ml133@netpole.com.br>	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>	<20070102094414.f7b9cef1.ml133@netpole.com.br>	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>	<1167743069.30886.54.camel@violet>
	<459A60A1.80906@glidos.net> <1167745840.30886.77.camel@violet>
In-Reply-To: <1167745840.30886.77.camel@violet>
Subject: Re: [Bluez-users] problem in
 making	multiple	connections	using	single bluetooth adapter using bluez
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

Marcel Holtmann wrote:
> Hi Paul,
> 
>>> And once again "hcidump -X -V" is your friend in showing what
>>> actually happens on the Bluetooth chip level.
>> Are there people on this list that might be willing to look over
>> a posted dump then?  My problem with DUN produced a trace, but
>> I gave up on it because there was no way I could understand
>> it. Is it worth my posting a dump?
> 
> depends on what level the problem actually is. If it is hidden somewhere
> in the PPP part it is unlikely that you get a fast answer. If it is
> something obvious you might get your problem solved very quickly. So it
> is always worth posting the hcidump.

Great. Thanks for at least having a look.  I think the problem is
early on because I get nothing in my logs from dund.

Here it is:

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
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 42 slots 5
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0200
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0200 result 0 status 0
       Connection successful
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
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0200 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0200 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:09:2D:08:BC:57 name 'Pocket_PC2'
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 2
     L2CAP(d): cid 0x0040 len 32 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1b
           pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 42 flags 0x02 dlen 52
     L2CAP(d): cid 0x0200 len 48 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x2b
           count 40
           record #0
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x2 > >
           record #1
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x2 > >
           cont 00
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0201
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0201 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0200
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0200
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0201 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0201 flags 0x00 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0201 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 1
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 4 frame_type 0 credit_flow 15 pri 32 ack_timer 0
       frame_size 1024 max_retrans 0 credits 7
< ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0201 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0201
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0201
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0202
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0202 result 0 status 0
       Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 4096
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0202 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0202 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 2
     L2CAP(d): cid 0x0040 len 32 [psm 1]
         SDP SSA Req: tid 0x0 len 0x1b
           pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
           max 4088
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 42 flags 0x02 dlen 52
     L2CAP(d): cid 0x0202 len 48 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x2b
           count 40
           record #0
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x2 > >
           record #1
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x2 > >
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0203
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0203 result 0 status 0
       Connection successful
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0202
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0202
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0203 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0203 flags 0x00 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0203 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 17
 > ACL data: handle 42 flags 0x01 dlen 1
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 4 frame_type 0 credit_flow 15 pri 32 ack_timer 0
       frame_size 1024 max_retrans 0 credits 7
< ACL data: handle 42 flags 0x02 dlen 8
     L2CAP(d): cid 0x0203 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0203
< ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0203
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 42 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 42 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 42 reason 0x16
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
