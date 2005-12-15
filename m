Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A blue chamaleon to be
References: <op.s1tgc9j9xabado@portatilegio> <1134636788.5198.42.camel@localhost>
Message-ID: <op.s1tiptlkxabado@portatilegio>
From: "zio tom" <zio.tom@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <1134636788.5198.42.camel@localhost>
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
Date: Thu, 15 Dec 2005 10:16:31 +0100

In data Thu, 15 Dec 2005 09:53:08 +0100, Marcel Holtmann  
<marcel@holtmann.org> ha scritto:

> Hi Giovanni,
> send in the output of "hcidump -X -V" while you are doing this.

Hi Marcel, thank you very much for you asnwering.
Here it is my output

Password:
linux:/home/giovanni # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.24
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0A:28:0C:D4:EF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 5 bdaddr 00:0A:28:0C:D4:EF type ACL encrypt 0x00
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 5 policy 0x0e
     Link policy: HOLD SNIFF PARK
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 5
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1024
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1506
< ACL data: handle 5 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 2
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       Success
       MTU 1024
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 0
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:0A:28:0C:D4:EF
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
     bdaddr 00:0A:28:0C:D4:EF
> HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 00:0A:28:0C:D4:EF
> HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:0A:28:0C:D4:EF
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
     bdaddr 00:0A:28:0C:D4:EF
> HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
     status 0x00 bdaddr 00:0A:28:0C:D4:EF
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 3
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 5 reason 0x13
     Reason: Remote User Terminated Connection
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0A:28:0C:D4:EF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 5 bdaddr 00:0A:28:0C:D4:EF type ACL encrypt 0x00
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 5 policy 0x0e
     Link policy: HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 5
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Max Slots Change (0x1b) plen 3
     handle 5 slots 5
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1024
> ACL data: handle 5 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1506
< ACL data: handle 5 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 2
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       Success
       MTU 1024
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> ACL data: handle 5 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 0
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 1
> HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:0A:28:0C:D4:EF
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
     bdaddr 00:0A:28:0C:D4:EF
> HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 00:0A:28:0C:D4:EF
> HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:0A:28:0C:D4:EF
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
     bdaddr 00:0A:28:0C:D4:EF
> HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
     status 0x00 bdaddr 00:0A:28:0C:D4:EF
> ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18
< ACL data: handle 5 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 5 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 5 packets 3
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 5 reason 0x13
     Reason: Remote User Terminated Connection


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
