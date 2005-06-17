Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Joe Halliwell <joeh@dai.ed.ac.uk>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1119015912.9917.29.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Modprobe FATAL errors
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
Date: Fri, 17 Jun 2005 14:45:12 +0100

Hi,

I've been successfully using blueZ for a month, but (following a kernel
upgrade and reboot -- not wise 3 days before a tech demo...) it's
suddenly stopped working. 

I'm trying to diagnose the problem and have noticed that the kernel is
complaining about the hci_usb module:

Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb

However, (on my very limited understanding) the HCI layer is functional:

$ sudo hcitool scan
Scanning ...
        00:13:70:D8:40:68       Joe
$ sudo l2ping 00:13:70:D8:40:68
Ping: 00:13:70:D8:40:68 from 00:0E:A1:31:B1:48 (data size 20) ...
0 bytes from 00:13:70:D8:40:68 id 0 time 55.37ms
0 bytes from 00:13:70:D8:40:68 id 1 time 8.67ms
0 bytes from 00:13:70:D8:40:68 id 2 time 8.64ms
$ sudo hcitool info 00:13:70:D8:40:68
Requesting information ...
        BD Address:  00:13:70:D8:40:68
        Device Name: Joe
        LMP Version: 1.1 (0x1) LMP Subversion: 0x382
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO>

Nevertheless gammu no longer works:

$ sudo gammu textall --identify
[Gammu            - 1.01.11 built 14:36:45 May 17 2005 in gcc 3.3]
[Connection       - "bluephonet"]
[Model type       - "6230"]
[Device           - "00:13:70:D8:40:68"]
[Run on           - Linux, kernel 2.6.10-5-k7]
[Module           - "1100|1100a|1100b|3100|3100b|3105|3108|3200|3200a|
3220|3300|3510|3510i|3530|3589i|3590|3595|5100|5140|6100|6200|6220|6230|
6310|6310i|6385|6510|6610|6610i|6800|6810|6820|7200|7210|7250|7250i|
7600|8310|8390|8910|8910i"]
00:13:70:D8:40:68
Channel 9 - "OBEX Object Push"
Channel 10 - "OBEX File Transfer"
Channel 1 - "Dial-up networking"
Channel 15 - "Nokia PC Suite"
Channel 3 - "COM 1"
Channel 13 - "Voice Gateway"
Channel 12 - "Audio Gateway"
Channel 11 - "SyncML Client"
Channel 4 - "SIM ACCESS"
Connecting to RF channel 15
[ERROR 2: Error opening device. Unknown/busy or no permissions.]
Error opening device. Unknown/busy or no permissions.

Do the modprobe errors explain this problem? Or is something else at
issue?

I'd greatly appreciate *any* help or advice.

Joe



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
