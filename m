Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users]  Again dund
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAA+vFVNecj90SxNE/BGWtzYwEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1099913396.6896.88.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 8 Nov 2004 15:37:20 +0100

Hi Marcel,

##>
##>There is no easy way to delete a link key at the moment and=20
##>so I think the best way is to delete the file=20
##>/etc/bluetooth/link_key and restart your running hcid.

now I have a new link_key with the right key :) :)

I'm able to connect via bluetooth

Linux-Notebook:/ # dund --connect 00:0B:CE:00:01:8F

Linux-Notebook:/ # dund --show
rfcomm0: 00:0B:CE:00:01:8F channel 1 pppd pid 6820

marvelous!! But now I need the next step. I want to use the
bluetooth-connection as/like an ethernet-connection as the BT-Modul =
gives me
the function of a switch and router with DHCP

I tried to get infos of the services provided, but no result:

Linux-Notebook:/ # sdptool browse 00:0B:CE:00:01:8F
Browsing 00:0B:CE:00:01:8F ...
Linux-Notebook:/ #=20

Linux-Notebook:~ # hcidump -x
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change(0x12) plen 8
  00 8F 01 00 CE 0B 00 01
> HCI Event: Connect Complete(0x03) plen 11
  00 29 00 8F 01 00 CE 0B 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
  8F 01 00 CE 0B 00 01
> HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 29 00
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> HCI Event: Max Slots Change(0x1b) plen 3
  29 00 05
> HCI Event: Link Key Request(0x17) plen 6
  8F 01 00 CE 0B 00
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  8F 01 00 CE 0B 00 0B 9B 0C 37 93 EC 88 55 72 FF 66 DE A8 50
  06 E5
> HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 8F 01 00 CE 0B 00
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 2016
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x40 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 15
    L2CAP(d): cid 0x40 len 11 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6
          cnt 0x3
          cont 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
  01 29 00 01 00
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect(0x01|0x0006) plen 3
  29 00 13
> HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete(0x05) plen 4
  00 29 00 16

Please, Marcel, what is to do?

Thanks and regards
Peter




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
