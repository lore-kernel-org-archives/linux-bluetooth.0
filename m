Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Scott W Gifford <gifford@umich.edu>
Message-ID: <qszekj3j47n.fsf@timepilot.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] USB/Bluetooth dongle doesn't work in hub
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
Date: Mon, 08 Nov 2004 18:44:44 -0500

Hello,

I'm trying to connect a USB/Bluetooth dongle to my laptop running
Fedora Core 2 with a Linux 2.6.8-1.521 kernel, and these bluez RPMs
installed:

    bluez-bluefw-1.0-2, bluez-libs-2.5-2.1, bluez-libs-devel-2.5-2.1,
    bluez-pin-0.23-1, bluez-utils-2.4-3, bluez-sdp-devel-1.5-2.1,
    bluez-hcidump-1.5-4, bluez-sdp-1.5-2.1, bluez-pan-1.1-4

I've got both a Belkin F8T001 version 2 dongle, and an AmbiCom
BT2000.C-USB dongle.  Both devices work great when I plug them
directly into the laptop, but fail when I connect them via a hub,
logging something like this:

    Nov  8 18:29:24 localhost kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb 1f48cf94 err -28
    Nov  8 18:29:24 localhost hcid[23855]: Can't init device hci0. Input/output error(5)

I get the same effect plugging in to the hub on my base station, my
keyboard, or a Belkin hub I just purchased.

I'd like to get this working for two reasons.  First, the USB ports on
my laptop aren't available when I'm in my docking station.  Second,
for the project I'm working on I'd like to connect several Bluetooth
adapters to my machine over a distance of 20 meters or so, which will
require hubs.

I've appended full logs of what happens on a working direct connection
and a failed connection through a hub, with the Belkin adapter; the
results with the AmbiCom are similar.

Any advice on getting this working?

Thanks!

----ScottG.


Logs when Plugging in Belkin dongle directly to laptop
======================================================
Nov  8 18:27:20 localhost kernel: usb 3-1: new full speed USB device using address 10
Nov  8 18:27:20 localhost default.hotplug[23492]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEBUG=yes SEQNUM=495 _=/bin/env)Nov  8 18:27:20 localhost default.hotplug[23492]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:27:20 localhost default.hotplug[23504]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/003/010 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=496 _=/bin/env)
Nov  8 18:27:20 localhost default.hotplug[23504]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:27:20 localhost default.hotplug[23524]: arguments (bluetooth) env (OLDPWD=/ DEVPATH=/class/bluetooth/hci0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 INTERFACE=hci0 DEBUG=yes SEQNUM=497 _=/bin/env)
Nov  8 18:27:20 localhost default.hotplug[23524]: no runnable /etc/hotplug/bluetooth.agent is installed
Nov  8 18:27:20 localhost default.hotplug[23533]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.1 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/003/010 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=498 _=/bin/env)
Nov  8 18:27:20 localhost default.hotplug[23533]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:27:20 localhost default.hotplug[23553]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.2 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/003/010 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=499 _=/bin/env)
Nov  8 18:27:20 localhost default.hotplug[23553]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:27:20 localhost hcid[3346]: HCI dev 0 registered
Nov  8 18:27:21 localhost hcid[3346]: HCI dev 0 up
Nov  8 18:27:21 localhost hcid[3346]: Starting security manager 0
Nov  8 18:27:22 localhost usb.agent[23504]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:27:22 localhost usb.agent[23504]: Setup 0x00 0x00 for USB product 50d/81/828
Nov  8 18:27:23 localhost usb.agent[23533]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:27:23 localhost usb.agent[23553]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:27:23 localhost usb.agent[23533]: Setup 0x00 0x00 for USB product 50d/81/828
Nov  8 18:27:24 localhost usb.agent[23553]: Setup 0x00 0x00 for USB product 50d/81/828

hciconfig when Plugging in Belkin dongle directly to laptop
===========================================================
hci0:   Type: USB
        BD Address: 00:0A:3A:56:48:B9 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:101 acl:0 sco:0 events:13 errors:0
        TX bytes:296 acl:0 sco:0 commands:12 errors:0

Logs when Plugging in Belkin dongle to USB hub
==============================================

Nov  8 18:29:23 localhost kernel: usb 1-1.4: new full speed USB device using address 28
Nov  8 18:29:23 localhost kernel: ehci_hcd 0000:00:1d.7: qh 20a8b200 (#0) state 1
Nov  8 18:29:23 localhost default.hotplug[23775]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.4 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEBUG=yes SEQNUM=505 _=/bin/env)
Nov  8 18:29:23 localhost default.hotplug[23775]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:29:23 localhost default.hotplug[23787]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.4/1-1.4:1.0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/001/028 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=506 _=/bin/env)
Nov  8 18:29:23 localhost default.hotplug[23787]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:29:23 localhost default.hotplug[23807]: arguments (bluetooth) env (OLDPWD=/ DEVPATH=/class/bluetooth/hci0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 INTERFACE=hci0 DEBUG=yes SEQNUM=507 _=/bin/env)
Nov  8 18:29:23 localhost default.hotplug[23807]: no runnable /etc/hotplug/bluetooth.agent is installed
Nov  8 18:29:23 localhost default.hotplug[23816]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.4/1-1.4:1.1 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/001/028 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=508 _=/bin/env)
Nov  8 18:29:23 localhost default.hotplug[23816]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:29:24 localhost default.hotplug[23836]: arguments (usb) env (OLDPWD=/ DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.4/1-1.4:1.2 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 DEVICE=/proc/bus/usb/001/028 PRODUCT=50d/81/828 TYPE=224/1/1 DEBUG=yes SEQNUM=509 _=/bin/env)
Nov  8 18:29:24 localhost default.hotplug[23836]: invoke /etc/hotplug/usb.agent ()
Nov  8 18:29:24 localhost hcid[3346]: HCI dev 0 registered
Nov  8 18:29:24 localhost kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb 1f48cf94 err -28
Nov  8 18:29:24 localhost hcid[23855]: Can't init device hci0. Input/output error(5)
Nov  8 18:29:25 localhost usb.agent[23787]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:29:25 localhost usb.agent[23816]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:29:26 localhost usb.agent[23836]: Setup hci_usb for USB product 50d/81/828
Nov  8 18:29:26 localhost usb.agent[23787]: Setup 0x00 0x00 for USB product 50d/81/828
Nov  8 18:29:26 localhost usb.agent[23816]: Setup 0x00 0x00 for USB product 50d/81/828
Nov  8 18:29:27 localhost usb.agent[23836]: Setup 0x00 0x00 for USB product 50d/81/828
 
hciconfig when Plugging in Belkin dongle to USB hub
===================================================

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
