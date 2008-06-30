Return-Path: <cyrus@holtmann.org>
From: "Malte J. Wetz" <bluez-users-mlist@malte-wetz.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 30 Jun 2008 15:02:05 +0200
MIME-Version: 1.0
Message-Id: <200806301502.05323.bluez-users-mlist@malte-wetz.de>
Subject: [Bluez-users] Belkin USB-Dongle blocks USB subsystem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello!

I have the following problem: Whenever I plug in my Belkin USB dongle, its =

blue led is constantly on and the USB subsystem appears to be blocked.

It looks like this ("_" indicates cursor position):

root@triton:~# lsusb
_


And it remains this way until I remove the dongle. Then, I get the normal =

listing (without the removed dongle, of course).

A =BBhciconfig hci0 reset=AB only returns: "connection timed out". Reboots =
or =

module reloading don't help either.

The syslog looks like this:

Jun 30 14:50:24 triton kernel: hub 2-4.1:1.0: state 7 ports 7 chg 0000 evt =

0040
Jun 30 14:50:24 triton kernel: hub 2-4.1:1.0: port 6, status 0101, change =

0001, 12 Mb/s
Jun 30 14:50:24 triton kernel: hub 2-4.1:1.0: debounce: port 6: total 125ms =

stable 100ms status 0x100
Jun 30 14:50:26 triton kernel: hub 2-4.1:1.0: state 7 ports 7 chg 0000 evt =

0040
Jun 30 14:50:26 triton kernel: hub 2-4.1:1.0: port 6, status 0101, change =

0001, 12 Mb/s
Jun 30 14:50:26 triton kernel: hub 2-4.1:1.0: debounce: port 6: total 100ms =

stable 100ms status 0x101
Jun 30 14:50:26 triton kernel: hub 2-4.1:1.0: port 6 not reset yet, waiting =

10ms
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: new full speed USB device using =

ehci_hcd and address 15
Jun 30 14:50:27 triton kernel: hub 2-4.1:1.0: port 6 not reset yet, waiting =

10ms
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: skipped 1 descriptor after =

interface
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: default language 0x0409
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: uevent
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: usb_probe_device
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: configuration #1 chosen from 1 =

choice
Jun 30 14:50:27 triton hcid[10257]: HCI dev 0 registered
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: adding 2-4.1.6:1.0 (config #1, =

interface 0)
Jun 30 14:50:27 triton kernel: usb 2-4.1.6:1.0: uevent
Jun 30 14:50:27 triton kernel: hci_usb 2-4.1.6:1.0: usb_probe_interface
Jun 30 14:50:27 triton kernel: hci_usb 2-4.1.6:1.0: usb_probe_interface - =

got id
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: adding 2-4.1.6:1.1 (config #1, =

interface 1)
Jun 30 14:50:27 triton kernel: usb 2-4.1.6:1.1: uevent
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: adding 2-4.1.6:1.2 (config #1, =

interface 2)
Jun 30 14:50:27 triton kernel: usb 2-4.1.6:1.2: uevent
Jun 30 14:50:27 triton kernel: hci_usb 2-4.1.6:1.2: usb_probe_interface
Jun 30 14:50:27 triton kernel: hci_usb 2-4.1.6:1.2: usb_probe_interface - =

got id
Jun 30 14:50:27 triton kernel: pegasus 2-4.1.6:1.2: usb_probe_interface
Jun 30 14:50:27 triton kernel: pegasus 2-4.1.6:1.2: usb_probe_interface - =

got id
Jun 30 14:50:27 triton kernel: usb 2-4.1.6: link qh1-0e01/f774e580 start 0 =

[1/2 us]
Jun 30 14:50:37 triton kernel: usb 2-4.1.6: unlink qh1-0e01/f774e580 start =
0 =

[1/2 us]
Jun 30 14:50:37 triton hcid[13024]: Can't init device hci0: Connection time=
d =

out (110)


System is Ubuntu Hardy (8.04) with self compiled kernel 2.6.25.8 and =

bluez-3.26 . After the first problems I compiled bluez-3.34 from source but =

it did not fix my problems.

I got myself another dongle (MSI BToes 2.0) and tried that one. It connects =

fine and appears to work correctly but when I try to use it with my Jabra =

BT 205 headset, I get get no audio data.

The only BT adaptor that really works without problems is the one that came =

with my Logitech MX900 mouse. Alas, it does not support EDR and is a bit =

bulky compared to "normal" dongles.

Mainboard: Asus M2N32SLI-Deluxe with NForce 590SLI chipset
The belkin dongle is this one: =

http://catalog.belkin.com/IWCatProductPage.process?Product_Id=3D273100

Any ideas what my problem might be?

-- =

Malte J. Wetz  <mail@malte-wetz.de>
Homepage: www.malte-wetz.de (PGP/GPG Keys available on homepage)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
