Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: AW: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAD6dWEVx0R0S6l7snahV4wgEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAD6dWEVx0R0S6l7snahV4wgEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103131731.8717.23.camel@pegasus>
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
Date: Wed, 15 Dec 2004 18:28:51 +0100

Hi Peter,

> here are the results. I was successful, when I removed link_key again.

I don't what is with the link key. Still weird that they request
authentication on the SDP search, but not using security mode 3.

> Linux-Notebook:/etc/bluetooth # rm link_key
> Linux-Notebook:/etc/bluetooth # cd ~
> Linux-Notebook:~ # sdptool search --bdaddr 00:0B:CE:00:01:8F dun
> Searching for dun on 00:0B:CE:00:01:8F ...
> Linux-Notebook:~ # cd /etc/bluetooth/
> 
> hcidump -x gave:
> 
> Linux-Notebook:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Role Change (0x12) plen 8
>   00 8F 01 00 CE 0B 00 01
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 8F 01 00 CE 0B 00 01 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   29 00 0F 00
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   8F 01 00 CE 0B 00 01
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 29 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > HCI Event: Link Key Request (0x17) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   8F 01 00 CE 0B 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 8F 01 00 CE 0B 00
> > HCI Event: PIN Code Request (0x16) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   8F 01 00 CE 0B 00 07 36 31 33 31 32 39 31 00 00 00 00 00 00
>   00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 8F 01 00 CE 0B 00
> > HCI Event: Link Key Notification (0x18) plen 23
>   8F 01 00 CE 0B 00 80 16 BD DF 9C 8A 0D EA F1 A9 87 6D D8 FD
>   62 8C 00
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 2016
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xf
>           pat uuid-16 0x1103 (DUN)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 15
>     L2CAP(d): cid 0x0040 len 11 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x6
>           cnt 0x3
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   29 00 13
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 29 00 16
> 
> and 
> Linux-Notebook:/etc/bluetooth # rm link_key
> Linux-Notebook:/etc/bluetooth # cd ~
> Linux-Notebook:~ # sdptool search --bdaddr 00:0B:CE:00:01:8F lan
> Searching for lan on 00:0B:CE:00:01:8F ...
> Service Name: Netzwerkzugang
> Service RecHandle: 0x10000
> Service Class ID List:
>   "LAN Access Using PPP" (0x1102)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> 
> hcidump -x
> Linux-Notebook:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Role Change (0x12) plen 8
>   00 8F 01 00 CE 0B 00 01
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 8F 01 00 CE 0B 00 01 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   29 00 0F 00
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   8F 01 00 CE 0B 00 01
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 29 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Link Key Request (0x17) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   8F 01 00 CE 0B 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 8F 01 00 CE 0B 00
> > HCI Event: PIN Code Request (0x16) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   8F 01 00 CE 0B 00 07 36 31 33 31 32 39 31 00 00 00 00 00 00
>   00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 8F 01 00 CE 0B 00
> > HCI Event: Link Key Notification (0x18) plen 23
>   8F 01 00 CE 0B 00 26 2F 2C 00 E6 29 ED BC 43 04 77 C4 AC 6A
>   FE F2 00
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 2016
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 24
>     L2CAP(d): cid 0x0040 len 20 [psm 1]
>         SDP SSA Req: tid 0x0 len 0xf
>           pat uuid-16 0x1102 (LAN)
>           max 0xffff
>           aid(s) 0x0000 - 0xffff
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 93
>     L2CAP(d): cid 0x0040 len 89 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x54
>           cnt 0x51
>           srv rec #0
>             aid 0x0000 (SrvRecHndl)
>                uint 0x10000
>             aid 0x0001 (SrvClassIDList)
>                < uuid-16 0x1102 (LAN) >
>             aid 0x0002 (SrvRecState)
>                uint 0xcebb2243
>             aid 0x0004 (ProtocolDescList)
>                < < uuid-16 0x0100 (L2CAP) > <
>                uuid-16 0x0003 (RFCOMM) uint 0x1 > >
>             aid 0x0006 (LangBaseAttrIDList)
>                < uint 0x656e uint 0x6a uint 0x100 >
>             aid 0x0100 (SrvName)
>                str "Netzwerkzugang"
> 
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   29 00 13
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 29 00 16
> 
> so, I think lan-service is supported but what have I to do?

So they are using LAN access using PPP and not the Dialup Networking
profile. Even if the name is somekind misleading you must use dund for
the connection. Maybe this one does this right job:

	dund -n -D -P 1 -X 00:0B:CE:00:01:8F

If not then your must send in the hcidump and hope that someone decodes
the PPP problems. Using PAN would be a lot easier.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
