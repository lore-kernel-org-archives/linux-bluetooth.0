Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412091557.33825.wim.delvaux@adaptiveplanet.com>
Subject: [Bluez-users] can no longer connect with pand
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
Date: Thu, 9 Dec 2004 15:57:33 +0100


I had to reboot and now my pand tries but seems unable to connect to the 
server.

Here is the hcidump -a output  To me it looks like the link_key (which should 
exist since devices are paired) is still OK.  However connection fails

What might be wrong ?

device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  96 85 0D C7 02 00 12 01 12 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  96 85 0D C7 02 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Link Key Request (0x17) plen 6
  96 85 0D C7 02 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  96 85 0D C7 02 00 83 82 FF 06 0B 83 05 4F 15 E0 05 C5 A0 1C
  2A 30
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 96 85 0D C7 02 00
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 96 85 0D C7 02 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 CC
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13
> HCI Event: Connect Request (0x04) plen 10
  96 85 0D C7 02 00 12 01 12 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  96 85 0D C7 02 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Link Key Request (0x17) plen 6
  96 85 0D C7 02 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  96 85 0D C7 02 00 83 82 FF 06 0B 83 05 4F 15 E0 05 C5 A0 1C
  2A 30
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 96 85 0D C7 02 00
> HCI Event: Connect Complete (0x03) plen 11
  00 2A 00 96 85 0D C7 02 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  2A 00 18 CC
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 2A 00 18 CC
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
