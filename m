Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 May 2013 16:21:51 +0100
From: Ian Lynagh <igloo@earth.li>
To: linux-bluetooth@vger.kernel.org
Subject: Problems with a Plantronics BT300
Message-ID: <20130527152151.GA465@matrix.chaos.earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi all,

I wonder if anyone could help me to get my USB BlueTooth dongle working
please?

I have the Debian package of bluez 4.99 (Debian version 4.99-2). I also
have the Debian bluez-firmware 1.2-3 package installed.

When I plug it in I see

[587526.800544] usb 2-1.6: new full-speed USB device number 9 using ehci_hcd
[587527.489595] usb 2-1.6: New USB device found, idVendor=047f, idProduct=0415
[587527.489600] usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[587527.489603] usb 2-1.6: Product: Plantronics BT300
[587527.489606] usb 2-1.6: Manufacturer: Plantronics
[587527.489608] usb 2-1.6: SerialNumber: b951b1177409ac4eb2cca3e4f5a37fac
[587527.499341] 9:1:1 : no or invalid class specific endpoint descriptor
[587527.503213] 9:2:1 : no or invalid class specific endpoint descriptor
[587527.616242] generic-usb 0003:047F:0415.0013: hiddev0,hidraw2: USB HID v1.11 Device [Plantronics Plantronics BT300] on usb-0000:00:1d.0-1.6/input3
[587527.665214] input: Plantronics Plantronics BT300 as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11
[587527.665512] generic-usb 0003:047F:0415.0014: input,hidraw3: USB HID v1.11 Device [Plantronics Plantronics BT300] on usb-0000:00:1d.0-1.6/input4

in dmesg. If I then run "hcitool dev" then I get

$ sudo hcitool dev
Devices:
$ 

I'm told that this is because it is in HID rather than HCI mode, so I
try:

$ time sudo /lib/udev/hid2hci --devpath=devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11 --method=csr
sudo /lib/udev/hid2hci  --method=csr  0.00s user 0.00s system 0% cpu 10.070 total
$ echo $?
0
$ 

which takes 10 seconds and adds this line to dmesg:

[587720.123420] usb 2-1.6: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -110

The other 2 methods instantly fail:

$ sudo /lib/udev/hid2hci --devpath=devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11 --method=dell
error: switching device '/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11' failed.
$ echo $?         
0
$ 

$ sudo /lib/udev/hid2hci --devpath=devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11 --method=logitech-hid
error: could not find hiddev device node
$ echo $?         
22
$ 

None of them alter the output of "hcitool dev".

Am I doing something wrong? Or is my dongle just not supported?


Thanks
Ian

