Return-Path: <cyrus@holtmann.org>
Message-ID: <5564663C.10007@battlepenguin.com>
Date: Tue, 26 May 2015 20:25:32 +0800
From: Sumit's Mailing Lists <lists@battlepenguin.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros Communications,
 Inc. AR3012 Bluetooth 4.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm currently using an MSI WS60 laptop which contains the following
Bluetooth controller (from lsusb):

Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
Bluetooth 4.0

and the more detailed version:

Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
Bluetooth 4.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0cf3 Atheros Communications, Inc.
  idProduct          0x3004 AR3012 Bluetooth 4.0
  bcdDevice            0.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:


In my kernel logs I see the following:

$dmesg | grep -i bluetooth

[    0.334727] Bluetooth: Core ver 2.20
[    0.334734] Bluetooth: HCI device and connection manager initialized
[    0.334736] Bluetooth: HCI socket layer initialized
[    0.334738] Bluetooth: L2CAP socket layer initialized
[    0.334740] Bluetooth: SCO socket layer initialized
[    0.604281] Bluetooth: HCI UART driver ver 2.2
[    0.604283] Bluetooth: HCI H4 protocol initialized
[    0.604285] Bluetooth: HCI BCSP protocol initialized
[    0.604286] Bluetooth: HCILL protocol initialized
[    0.604288] Bluetooth: HCIATH3K protocol initialized
[    0.615125] Bluetooth: RFCOMM TTY layer initialized
[    0.615129] Bluetooth: RFCOMM socket layer initialized
[    0.615132] Bluetooth: RFCOMM ver 1.11
[    0.615136] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    0.615138] Bluetooth: BNEP filters: protocol multicast
[    0.615141] Bluetooth: BNEP socket layer initialized
[    0.615144] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.615146] Bluetooth: HIDP socket layer initialized
[    1.358547] Bluetooth: Patch file not found ar3k/AthrBT_0x00000200.dfu
[    1.358548] Bluetooth: Loading patch file failed

I did a search for this issue and only found other bugs indicating that
this should be reported upstream:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1451689

A mailing list message:

  http://www.spinics.net/lists/linux-wireless/msg135868.html

And a possible duplicate:

  http://www.spinics.net/lists/linux-wireless/msg135869.html

My /proc/version:

  Linux version 4.0.0-wl-ath+ (root@catelyn) (gcc version 4.8.4 (Gentoo
4.8.4 p1.5, pie-0.6.1) ) #14 SMP Thu May 7 18:26:16 AEST 2015

I am running the ath+ branch because my Wi-Fi will not work on the
current kernel (attempted linux-4.0.4-gentoo and Wi-Fi failed to load
firmware, bluetooth had exact same message in kernel logs as reported
above). I'm running commit 4b9abafd of the kvalo/ath fork with the
atk10k firmware files from my own sumdog/ath10k-firmware fork.

Is there an official bug in for this issue yet that I can watch? Are
there any dfu files I can try out there for my specific device? I can
build any kernels you need if you want more specific debugging information.

Sumit
