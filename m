Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?ISO-8859-1?Q?Nicol=F2_Chieffo?= <nicolo.chieffo@gmail.com>
Date: Tue, 21 Apr 2009 18:23:46 +0200
Message-ID: <98391a7b0904210923w2ccba6b1p480dc15fb0298e20@mail.gmail.com>
Subject: hid2hci in udev rule not working
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I own a laptop with a bluetooth which is automatically detected
as a HID device if I switch it on when ubuntu is running.
in lsusb I see those 2 lines, for HID mouse and keyboard

Bus 003 Device 010: ID 413c:8158 Dell Computer Corp.
Bus 003 Device 009: ID 413c:8157 Dell Computer Corp.

the package bluez 4.32 which I have installed from Jaunty, includes
the file /lib/udev/rules.d/62-bluez-hid2hci.rules with the content:
ACTION=="add", ATTRS{idVendor}=="413c",
ATTRS{bInterfaceProtocol}=="02", ATTRS{bmAttributes}=="e0",
RUN+="/usr/sbin/hid2hci --tohci"

unfortunately when I enable the bluetooth switch, the udev rule is not
called. in my dmesg I see:
[ 1090.952069] usb 3-1: new full speed USB device using uhci_hcd and address 15
[ 1091.129216] usb 3-1: configuration #1 chosen from 1 choice
[ 1091.131133] hub 3-1:1.0: USB hub found
[ 1091.134459] hub 3-1:1.0: 3 ports detected
[ 1091.414110] usb 3-1.1: new full speed USB device using uhci_hcd and
address 16
[ 1091.532208] usb 3-1.1: configuration #1 chosen from 1 choice
[ 1091.539342] input: HID 413c:8157 as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/input/input21
[ 1091.565146] generic-usb 0003:413C:8157.0009: input,hidraw0: USB HID
v1.11 Keyboard [HID 413c:8157] on usb-0000:00:1a.0-1.1/input0
[ 1091.641085] usb 3-1.2: new full speed USB device using uhci_hcd and
address 17
[ 1091.763220] usb 3-1.2: configuration #1 chosen from 1 choice
[ 1091.770411] input: HID 413c:8158 as
/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2:1.0/input/input22
[ 1091.805156] generic-usb 0003:413C:8158.000A: input,hidraw1: USB HID
v1.11 Mouse [HID 413c:8158] on usb-0000:00:1a.0-1.2/input0

can you help me on making this rule work?
please CC me to replies since I'm not subscribed to the list.
Thanks
