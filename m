Return-Path: <cyrus@holtmann.org>
Subject: hci0 urb xxxxxxxxx failed to resubmit (1)
From: Dick <dick@mrns.nl>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 27 Mar 2010 15:19:19 +0100
Message-ID: <1269699559.3363.4.camel@latitude>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Since I've updated my kernel to 2.6.32.10 I get the following errors in
dmesg:

...
btusb_bulk_complete: hci0 urb e48c1b00 failed to resubmit (1)
btusb_intr_complete: hci0 urb f201c280 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f201c100 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f201c180 failed to resubmit (1)
btusb_intr_complete: hci0 urb f2007580 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f2007f00 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f2007a00 failed to resubmit (1)
btusb_intr_complete: hci0 urb f20eb200 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f20ebf00 failed to resubmit (1)
btusb_bulk_complete: hci0 urb f20eb300 failed to resubmit (1)

I've had urb / isoc errors before and I've fixed that issue with isoc=0
on the 
kernel module, this parameter doesn't seem available anymore.

# modinfo btusb
filename:       /lib/modules/2.6.32.10-1-
fl.smp.gcc4.1.x86.i686/kernel/drivers/bluetooth/btusb.ko
license:        GPL
version:        0.6
description:    Generic Bluetooth USB driver ver 0.6
author:         Marcel Holtmann <marcel@holtmann.org>
srcversion:     F297975F8C54B1A9EB522AC
alias:          usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
depends:        bluetooth
vermagic:       2.6.32.10-1-fl.smp.gcc4.1.x86.i686 SMP mod_unload 686 
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size
(bool)
parm:           force_scofix:Force fixup of wrong SCO buffers size
(bool)
parm:           reset:Send HCI reset command on initialization (bool)

bluez=4.62-1-0.0.1

# hciconfig hci0 -a
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:16:41:92:xx:xx  ACL MTU: 384:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:441742 acl:23420 sco:0 events:2251 errors:0
        TX bytes:1678 acl:28 sco:0 commands:90 errors:1
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'latitude'
        Class: 0x4a010c
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Laptop
        HCI Version: 2.0 (0x3)  Revision: 0x976
        LMP Version: 2.0 (0x3)  Subversion: 0x976
        Manufacturer: Cambridge Silicon Radio (10)

# lsusb
Bus 001 Device 014: ID 413c:8103 Dell Computer Corp. Wireless 350
Bluetooth

My HID devices are laggy and sometimes freeze for a minute.

Please help :)

