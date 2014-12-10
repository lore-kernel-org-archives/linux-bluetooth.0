Return-Path: <cyrus@holtmann.org>
Message-ID: <54884879.8010903@googlemail.com>
Date: Wed, 10 Dec 2014 13:19:53 +0000
From: Chris Clayton <chris2553@googlemail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Firmware load fails in 3.18.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In trying to diagnose a problem with bluetooth-audio on my laptop, I've spotted that the firmware is failing to load.
The bluetooth related output from dmesg is:

[    0.426890] Bluetooth: Core ver 2.19
[    0.426986] Bluetooth: HCI device and connection manager initialized
[    0.427038] Bluetooth: HCI socket layer initialized
[    0.427087] Bluetooth: L2CAP socket layer initialized
[    0.427137] Bluetooth: SCO socket layer initialized
[    1.017575] Bluetooth: hci0: read Intel version: 3707100180012d0d00
[    1.017602] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq failed with error -2
[    1.017604] Bluetooth: hci0 failed to open Intel firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq(-2)
[    1.017608] bluetooth hci0: Direct firmware load for intel/ibt-hw-37.7.bseq failed with error -2
[    1.017609] Bluetooth: hci0 failed to open default Intel fw file: intel/ibt-hw-37.7.bseq
[    8.286733] Bluetooth: RFCOMM TTY layer initialized
[    8.288739] Bluetooth: RFCOMM socket layer initialized
[    8.290693] Bluetooth: RFCOMM ver 1.11
[   63.965245] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   63.965257] Bluetooth: HIDP socket layer initialized
[   63.966748] input: Bluetooth Laser Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:256/0005:04B4:0033.0001/input/input10
[   63.966891] hid-generic 0005:04B4:0033.0001: input: BLUETOOTH HID v6.11 Mouse [Bluetooth Laser Mouse] on
80:19:34:5a:67:51

The firmware two files mentioned are installed in /lib/firmware/intel and are successfully loaded by a 3.17.6 kernel:

[chris:~]$ dmesg | grep -i blue
[    7.103619] Bluetooth: Core ver 2.19
[    7.107523] Bluetooth: HCI device and connection manager initialized
[    7.109453] Bluetooth: HCI socket layer initialized
[    7.111373] Bluetooth: L2CAP socket layer initialized
[    7.113301] Bluetooth: SCO socket layer initialized
[    7.154252] Bluetooth: hci0: read Intel version: 3707100180012d0d00
[    7.298260] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
[    7.346464] Bluetooth: hci0: Intel Bluetooth firmware patch completed and activated
[    8.475026] Bluetooth: RFCOMM TTY layer initialized
[    8.476920] Bluetooth: RFCOMM socket layer initialized
[    8.478797] Bluetooth: RFCOMM ver 1.11
[   67.041180] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   67.041193] Bluetooth: HIDP socket layer initialized
[   67.042339] input: Bluetooth Laser Mouse as
/devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.0/bluetooth/hci0/hci0:256/0005:04B4:0033.0001/input/input10
[   67.042478] hid-generic 0005:04B4:0033.0001: input: BLUETOOTH HID v6.11 Mouse [Bluetooth Laser Mouse] on
80:19:34:5a:67:51

