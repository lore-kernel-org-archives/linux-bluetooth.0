Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: bc90021 <bc90021@bc90021.net>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1120113308.22582.9.camel@viskulan.tigerhost.net>
Mime-Version: 1.0
Subject: [Bluez-users] Unabe To Pair With My Linux Machine
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
Date: Thu, 30 Jun 2005 02:35:07 -0400

All,

I apologise, as it is late, and I am tired.  I would like to pair my
Treo 650 with my Gentoo desktop, in the hopes of eventually using
MultiSync over Bluetooth.  I have the two connecting to each other, and
they can see each other.  However, when setting up the Desktop as a
trusted device, I can't get them to pair.

Here are the two scenarios:

1)  Scenario 1:  hcid.conf has "auth" and "encrypt" enabled
(uncommented).  The connection is initiated from the phone, and I get
the following with hcidump -x:

HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 3
> HCI Event: Command Complete (0x0e) plen 4
  01 1A 0C 00
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
    bdaddr 00:00:00:00:00:00 all 1
> HCI Event: Command Complete (0x0e) plen 8
  01 0D 0C 00 10 00 00 00
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
    enable 1
> HCI Event: Command Complete (0x0e) plen 4
  01 20 0C 00
< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1
    mode 1
> HCI Event: Command Complete (0x0e) plen 4
  01 22 0C 00
< HCI Command: Write Local Name (0x03|0x0013) plen 248
    name 'BlueZ (Viskulan)'
> HCI Event: Command Complete (0x0e) plen 4
  01 13 0C 00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
    class 0x3e0100
> HCI Event: Command Complete (0x0e) plen 4
  01 24 0C 00
> HCI Event: Connect Request (0x04) plen 10
  5D 63 60 E0 07 00 0C 02 50 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:07:E0:60:63:5D role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Link Key Request (0x17) plen 6
  5D 63 60 E0 07 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:07:E0:60:63:5D
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 5D 63 60 E0 07 00
> HCI Event: PIN Code Request (0x16) plen 6
  5D 63 60 E0 07 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:E0:60:63:5D
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 5D 63 60 E0 07 00
> HCI Event: Connect Complete (0x03) plen 11
  06 29 00 5D 63 60 E0 07 00 01 00

As you can see, with the auth and encrypt enabled, the desktop doesn't
seem to be sending anything.  Also, I never get the popup on my phone to
put in the pin.

Scenario 2: hcid.conf has "auth" and "encrypt" disabled (commented).
The connection is initiated from the phone, and I get the following with
hcidump -x:

HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  5D 63 60 E0 07 00 0C 02 50 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:07:E0:60:63:5D role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 5D 63 60 E0 07 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  5D 63 60 E0 07 00 01
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0x0018
    Packet type: DM1 DH1
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 00
> HCI Event: PIN Code Request (0x16) plen 6
  5D 63 60 E0 07 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:07:E0:60:63:5D
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 5D 63 60 E0 07 00
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13

This time, I get the popup on the phone, and can put in the pin, but I
still never get anything sent by the desktop.

I'm using /usr/bin/bluepin, which is a python script that looks like
it's supposed to popup a dialog box for a pin.  That never works.  I
tried using the pin-helper bash  script in /etc/bluetooth (which just
uses cat to output the pin), but that made no difference.

As you can see, I'm stuck.  I'm pretty sure that I'll be able to get
everything else working once I can get the devices paired.

I'm sorry for the long message, and very grateful for any assistance
anyone can offer.

Thanks.

bc90021



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
