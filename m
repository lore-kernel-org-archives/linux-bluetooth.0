Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAlDHre6TS5Uy1TgCuirvwRgEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1103020326.2143.148.camel@pegasus>
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
Date: Tue, 14 Dec 2004 11:59:18 +0100

Hi Marcel,

##>> What means this, espacially refused(111)?
##>
##>in most cases this is PIN or link key problem. Check with 
##>"hcidump -x" to be sure.

I give you the responses of hcidump -x and hcidump -a

Linux-Notebook:~ # hcidump -x
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change (0x12) plen 8
  00 8F 01 00 CE 0B 00 01
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 8F 01 00 CE 0B 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  8F 01 00 CE 0B 00 01
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0f00 scid 0x0040 result 2 status 0
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16

Linux-Notebook:~ # hcidump -a
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  . . . . . . . . . . . . .
> HCI Event: Command Status (0x0f) plen 4
  . . . .
> HCI Event: Role Change (0x12) plen 8
  . . . . . . . .
> HCI Event: Connect Complete (0x03) plen 11
  . ) . . . . . . . . .
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  ) . . .
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  . . . . . . .
> HCI Event: Command Complete (0x0e) plen 6
  . . . . ) .
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . .
> HCI Event: Max Slots Change (0x1b) plen 3
  ) . .
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0f00 scid 0x0040 result 2 status 0
< HCI Command: Disconnect (0x01|0x0006) plen 3
  ) . .
> HCI Event: Command Status (0x0f) plen 4
  . . . .
> HCI Event: Disconn Complete (0x05) plen 4
  . ) . .

Linux-Notebook:~ #

Regards
Peter                      




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
