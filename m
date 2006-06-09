Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44892B25.6000309@personnelware.com>
References: <44891608.2030906@personnelware.com>
	<1149836904.6618.4.camel@localhost>
	<44892B25.6000309@personnelware.com>
Date: Fri, 09 Jun 2006 10:07:22 +0200
Message-Id: <1149840442.6618.16.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PM325 by LG cell phone - pairing failed
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

Hi Carl,

> > For the rest show us the output of "hcidump -X -V" while
> > you are trying to pair. I suspect that you PIN help isn't called
> > properly.
> >   
> HCI sniffer - Bluetooth packet analyzer ver 1.28
> device: hci0 snap_len: 1028 filter: 0xffffffff
>  > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 08:00:37:03:EF:36 class 0x400204 type ACL

So the phone established the connection to you.

> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 08:00:37:03:EF:36 role 0x01
>     Role: Slave
>  > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>  > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 42 bdaddr 08:00:37:03:EF:36 type ACL encrypt 0x00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 42 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
>  > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 08:00:37:03:EF:36 mode 1
>  > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 42
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 42 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
>  > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 42 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 42 slots 5
>  > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 08:00:37:03:EF:36
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>     bdaddr 08:00:37:03:EF:36 len 4 pin '1234'
>  > HCI Event: Command Complete (0x0e) plen 10
>     PIN Code Request Reply (0x01|0x000d) ncmd 1
>     status 0x00 bdaddr 08:00:37:03:EF:36
>  > HCI Event: Link Key Notification (0x18) plen 23
>     bdaddr 08:00:37:03:EF:36 key 7ECC0F84F68E851175F204130B4E561A type 0

the pairing itself works. You get a valid link key.

>  > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 42 reason 0x13
>     Reason: Remote User Terminated Connection

Then it disconnects. That is strange.

>  > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 08:00:37:03:EF:36 class 0x400204 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 08:00:37:03:EF:36 role 0x01
>     Role: Slave
>  > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>  > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 43 bdaddr 08:00:37:03:EF:36 type ACL encrypt 0x00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 43 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
>  > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 08:00:37:03:EF:36 mode 1
>  > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 43
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 43 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
>  > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 43 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 43 slots 5
>  > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0044
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0044 result 0 status 0
>       Connection successful
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 20
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 8
>       MTU 256 FlushTO 65535
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
>  > ACL data: handle 43 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0040 len 18 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xd
>           pat uuid-16 0x1108 (Headset)
>           max 240
>           aid(s) 0x0001 (SrvClassIDList)
>           cont 00
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0044 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x5
>           count 2
>           cont 00

It looks for you being a headset and this will obviously fail.

>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0044
> < ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0044
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0045
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 0 status 0
>       Connection successful
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 20
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 8
>       MTU 256 FlushTO 65535
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 0
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
>  > ACL data: handle 43 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0040 len 18 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xd
>           pat uuid-16 0x111e (Handsfree)
>           max 240
>           aid(s) 0x0001 (SrvClassIDList)
>           cont 00
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(d): cid 0x0045 len 10 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x5
>           count 2
>           cont 00

Second try with handsfree and this will fail, too.

>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
> < ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
>  > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 43 reason 0x13
>     Reason: Remote User Terminated Connection

So since you are not emulating a headset or handsfree unit, this is not
the way to go.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
