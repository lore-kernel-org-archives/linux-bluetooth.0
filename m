Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	"Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: autosuspend issues with the Intel Bluetooth device [8087:07dc]
Date: Wed, 03 Jul 2013 14:08:00 +0200
Message-ID: <87obajn8wv.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I recently got a Intel Dual Band Wireless-AC 7260 card, which works very
well as a 802.11 wlan module.  So I am now trying to break the Bluetooth
part of it instead :)

And I do find some issues with that... The most important one is that I
cannot get it to work properly with autosuspend enabled.

I currently have two btusb devices in my laptop, the Intel device and an
older Lenovo Broadcom-based device.  Autosuspend is enabled for all
USB devices.

nemi:/tmp# hciconfig 
hci1:   Type: BR/EDR  Bus: USB
        BD Address: 0C:8B:FD:08:09:75  ACL MTU: 1021:5  SCO MTU: 96:5
        UP RUNNING PSCAN 
        RX bytes:965 acl:0 sco:0 events:48 errors:0
        TX bytes:963 acl:0 sco:0 commands:48 errors:0

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:23:4D:F0:D9:1A  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN 
        RX bytes:885 acl:0 sco:0 events:38 errors:0
        TX bytes:894 acl:0 sco:0 commands:38 errors:0

The Lenovo device works as expected, with autosuspend. Reading the
version info as a simple HCI test:

nemi:/tmp# hciconfig hci0 version
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:23:4D:F0:D9:1A  ACL MTU: 1021:8  SCO MTU: 64:1
        HCI Version: 2.1 (0x4)  Revision: 0x518f
        LMP Version: 2.1 (0x4)  Subversion: 0x424c
        Manufacturer: Broadcom Corporation (15)

But the Intel device fails if suspended (and will fail for any HCI
command):

nemi:/tmp# hciconfig hci1 version
Can't read version info hci1: Connection timed out (110)

The driver is of course the same, and the configuration of these devices
are similar:

nemi:/tmp# ls -l /sys/class/bluetooth/
total 0
lrwxrwxrwx 1 root root 0 Jul  3 13:44 hci0 -> ../../devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0
lrwxrwxrwx 1 root root 0 Jul  3 13:44 hci1 -> ../../devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/bluetooth/hci1

nemi:/tmp# grep . /sys/class/bluetooth/hci*/device/supports_autosuspend 
/sys/class/bluetooth/hci0/device/supports_autosuspend:1
/sys/class/bluetooth/hci1/device/supports_autosuspend:1

nemi:/tmp# grep . /sys/class/bluetooth/hci*/device/../power/control
/sys/class/bluetooth/hci0/device/../power/control:auto
/sys/class/bluetooth/hci1/device/../power/control:auto

nemi:/tmp# grep . /sys/class/bluetooth/hci*/device/../power/runtime_*
/sys/class/bluetooth/hci0/device/../power/runtime_active_kids:0
/sys/class/bluetooth/hci0/device/../power/runtime_active_time:48448
/sys/class/bluetooth/hci0/device/../power/runtime_enabled:enabled
/sys/class/bluetooth/hci0/device/../power/runtime_status:suspended
/sys/class/bluetooth/hci0/device/../power/runtime_suspended_time:1502332
/sys/class/bluetooth/hci0/device/../power/runtime_usage:0
/sys/class/bluetooth/hci1/device/../power/runtime_active_kids:0
/sys/class/bluetooth/hci1/device/../power/runtime_active_time:79528
/sys/class/bluetooth/hci1/device/../power/runtime_enabled:enabled
/sys/class/bluetooth/hci1/device/../power/runtime_status:suspended
/sys/class/bluetooth/hci1/device/../power/runtime_suspended_time:1470828
/sys/class/bluetooth/hci1/device/../power/runtime_usage:0


Turning off autosuspend for the Intel device makes it work:

nemi:/tmp# echo on > /sys/class/bluetooth/hci1/device/../power/control
nemi:/tmp# hciconfig hci1 version
hci1:   Type: BR/EDR  Bus: USB
        BD Address: 0C:8B:FD:08:09:75  ACL MTU: 1021:5  SCO MTU: 96:5
        HCI Version: 4.0 (0x6)  Revision: 0x500
        LMP Version: 4.0 (0x6)  Subversion: 0x500
        Manufacturer: Intel Corp. (2)


But this just does not seem right? Any modern USB device is supposed to
support autosuspend, right? I am using the firmware patch included in
the latest public firmware repo:

[    4.652631] Bluetooth: hci1: read Intel version: 370710018002030d00
[    4.656988] Bluetooth: hci1: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[    4.963497] Bluetooth: hci1: Intel Bluetooth firmware patch completed and activated


While looking at this, I also noticed a minor issue with the USB
descriptors.  It cannot be classified as a bug, but it does look like
somebody just forgot to set the iManufacturer, iProduct and iSerial
string indexes in the device descriptor:

Bus 007 Device 002: ID 8087:07dc Intel Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x07dc 
  bcdDevice            0.01
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
[..]

because trying to pull some string descriptors from the device revealed
that indexes 1, 2 and 3 exist without being referenced anywhere:

 1: Intel(R) Corporation
 2: Intel(R) Wilkins Peak 2x2
 3: 001122334455 WP_A0 

The serial number doesn't look right, but the two others should fit
nicely as iManufacturer and iProduct.



Bjørn
