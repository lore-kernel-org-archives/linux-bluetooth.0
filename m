Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Sep 2008 14:00:18 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Reply-To: rankincj@yahoo.com
Subject: Re: Bluetooth 2.1 USB adapter!
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1222381386.6442.8.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <267849.8211.qm@web52908.mail.re2.yahoo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--- On Thu, 25/9/08, Marcel Holtmann <marcel@holtmann.org> wrote:
> load btusb or hci_usb with reset=3D1 and if that helps, I can
> add a quirk for this dongle.

Yes, that certainly did the trick :-) !! There's a bit of noise in the dmes=
g log from usbhid:

usb 4-1: new full speed USB device using uhci_hcd and address 28
usb 4-1: configuration #1 chosen from 1 choice
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 3 ports detected
usb 4-1.1: new full speed USB device using uhci_hcd and address 29
usb 4-1.1: configuration #1 chosen from 1 choice
input: HID 0a5c:4502 as /class/input/input18
input,hidraw0: USB HID v1.11 Keyboard [HID 0a5c:4502] on usb-0000:00:1d.2-1=
.1
usb 4-1.2: new full speed USB device using uhci_hcd and address 30
usb 4-1.2: configuration #1 chosen from 1 choice
input: HID 0a5c:4503 as /class/input/input19
input,hidraw1: USB HID v1.11 Mouse [HID 0a5c:4503] on usb-0000:00:1d.2-1.2
usb 4-1.3: new full speed USB device using uhci_hcd and address 31
usb 4-1.3: configuration #1 chosen from 1 choice
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received
usbhid: input irq status -75 received

But it does actually (seem to) work now:

# hciconfig -a hci1
hci1:=09Type: USB
=09BD Address: 00:0A:3A:83:76:DA ACL MTU: 1021:8 SCO MTU: 64:1
=09UP RUNNING PSCAN=20
=09RX bytes:2536 acl:0 sco:0 events:37 errors:0
=09TX bytes:628 acl:0 sco:0 commands:37 errors:0
=09Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
=09Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
=09Link policy: HOLD SNIFF PARK=20
=09Link mode: SLAVE ACCEPT=20
=09Name: 'whatever-1'
=09Class: 0x080104
=09Service Classes: Capturing
=09Device Class: Computer, Desktop workstation
=09HCI Ver: 2.1 (0x4) HCI Rev: 0x5184 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
=09Manufacturer: Broadcom Corporation (15)

Thanks,
Chris
=0A=0A=0A      
