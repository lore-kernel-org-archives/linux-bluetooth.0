Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How can I create a rfcomm connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050716092527.60722.qmail@web15704.mail.cnb.yahoo.com>
References: <20050716092527.60722.qmail@web15704.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1121607963.22662.24.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 17 Jul 2005 15:46:03 +0200

Hi,

> I have a SCR module on a arm platform,and have another
> module on another arm. I can't create a rfcomm
> connection!
> arm platform A:
> [\u@\h \W]\$ hcitool scan
> Scanning ...
>         4A:49:4E:00:15:2F       B
> [\u@\h \W]\$ rfcomm connect 0 4A:49:4E:00:15:2F
> Can't connect RFCOMM socket: Connection refused
> 
> [\u@\h \W]\$ rfcomm connect 0 4A:49:4E:00:15:2F 9
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 4A:49:4E:00:15:2F ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 2F 15 00 4E 49 4A 01 00
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
> result 0 status 0
>       Connection successful
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
> 4
>       MTU 1024
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> > ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
> 4
>       MTU 1024
> < ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0x1c
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
> 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7
> ack_timer 0
>       frame_size 1019 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> Can't connect RFCOMM socket: Connection refused
> [\u@\h \W]\$ > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0xfd
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 41 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 29 00 16
> 
> arm platfrom B:
> > HCI Event: Connect Request (0x04) plen 10
>   2F 15 00 4E 49 4A 00 00 00 01
> < HCI Command: Accept Connection Request (0x01|0x0009)
> plen 7
>     bdaddr 4A:49:4E:00:15:2F role 0x01
>     Role: Slave
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 2F 15 00 4E 49 4A 01 00
> < HCI Command: Change Connection Packet Type
> (0x01|0x000f) plen 4
>     handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Page Scan Repetition Mode Change (0x20)
> plen 7
>   2F 15 00 4E 49 4A 01
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
> result 0 status 0
>       Connection successful
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 0F 04
> > HCI Event: Connection Packet Type Changed (0x1d)
> plen 5
>   00 29 00 18 CC
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
> 4
>       MTU 1024
> < ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
> 4
>       MTU 1024
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0x1c
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
> 0x70 mcc_len 8
>       dlci 18 frame_type 0 credit_flow 15 pri 7
> ack_timer 0
>       frame_size 1019 max_retrans 0 credits 7
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x18
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0xfd
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 29 00 13
> 
> and if I enter command "rfcomm listen 0 9" on one
> platform,the result on another is 
> "Waiting for connection on channel 9
> Connection from 4A:49:4E:00:15:2F to
> /dev/bluetooth/rfcomm/0
> Press CTRL-C for hangup".
> 
> And it didn't prompte to enter pin.
> rfcomm0 {
>         # Automatically bind the device at startup
>         bind yes;
>                                                       
>                                                       
>  
>         # Bluetooth address of the device
>         device 4A:49:4E:00:15:2F
>                                                       
>                                                       
>  
>         # RFCOMM channel for the connection
>         channel 1;
>                                                       
>                                                       
>  
>         # Description of the connection
>         comment "Example Bluetooth device";
> }
> 
> 
> I really have no idea what is wrong!  And I can't read
> these hcidump result,I am sorry!

why don't you test these things with rctest. It implements the client
and the server side. The authentication (pairing) is only triggered when
you ask for it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
