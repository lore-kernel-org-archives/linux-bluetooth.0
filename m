Return-Path: <bluez-users-admin@lists.sourceforge.net>
Date: Wed, 9 Feb 2005 10:54:26 -0500 (EST)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0502091045480.2336@gaia3.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Re: Trouble pairing with new phone...
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


When attempting to pair blueZ with the T610 Phone:
hcidump -x gives:
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  B2 E6 1D D9 0A 00 04 02 52 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  B2 E6 1D D9 0A 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  1A 29 00 B2 E6 1D D9 0A 00 01 00

Any hints at what the hex means?


Here is what it looks like when I (successfuly) pair my Palm T with BlueZ
(using the same pin):
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  6A B0 07 E0 07 00 14 01 10 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  6A B0 07 E0 07 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Link Key Request (0x17) plen 6
  6A B0 07 E0 07 00
> HCI Event: Role Change (0x12) plen 8
  00 6A B0 07 E0 07 00 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  6A B0 07 E0 07 00 74 1D E1 2F D1 E1 1E E7 53 C8 C1 F3 B1 7A
  E5 8E
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 6A B0 07 E0 07 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  6A B0 07 E0 07 00 74 1D E1 2F D1 E1 1E E7 53 C8 C1 F3 B1 7A
  E5 8E
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 6A B0 07 E0 07 00
> HCI Event: PIN Code Request (0x16) plen 6
  6A B0 07 E0 07 00
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  6A B0 07 E0 07 00 04 32 36 30 33 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 6A B0 07 E0 07 00
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  6A B0 07 E0 07 00 04 32 36 30 33 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 6A B0 07 E0 07 00
> HCI Event: Link Key Notification (0x18) plen 23
  6A B0 07 E0 07 00 59 4D 27 53 6E D2 22 6D E9 08 45 AC 80 9C
  21 CB 00
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 6A B0 07 E0 07 00 01 01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  6A B0 07 E0 07 00 00
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 CC
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13

obviously, I see where they start to diverge, but I don't know
why...

As I said, I can pair a palm T to the computer, so my PIN appears to be
working correctly... and I can pair the phone with the Palm T, so the
phone appears to be at least paritally working...


Jay





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
