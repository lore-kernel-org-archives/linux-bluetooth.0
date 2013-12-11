Return-Path: <cyrus@holtmann.org>
Message-ID: <1386776083.31076.60.camel@bmurrell-mobl.amr.corp.intel.com>
Subject: Re: mouse not found with bluez5 but was fine with bluez4
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Dec 2013 10:34:43 -0500
In-Reply-To: <20131211092135.GA16525@x220.p-661hnu-f1>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
	 <20131211092135.GA16525@x220.p-661hnu-f1>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-12-11 at 11:21 +0200, Johan Hedberg wrote:
> Hi Brian,

Hi Johan,

> For one thing, it'd be good to determine whether this is a GUI thing (I
> assume you're using the GNOME UI?)

Yeah.

> or something in BlueZ. The way to do
> that would be to use the bluetoothctl tool that's part of BlueZ 5. The
> commands you'd give it would go something like:
> 
> 	agent on
> 	power on
> 	scan on
> 	<wait for mouse to show up>
> 	scan off
> 	pair <mouse addr>	(optional if the mouse doesn't support pairing)
> 	connect <mouse addr>
> 	trust <mouse addr>

Here is what I get:

$ bluetoothctl 
[bluetooth]# agent on
Agent registration enabled
[bluetooth]# power on
No default controller available
[bluetooth]# scan on
No default controller available
[bluetooth]# 
$ lsb
...
Bus 002 Device 002: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)

Unplugging the BT dongle and plugging it back in yields:

[ 1472.102375] usb 2-1: USB disconnect, device number 2
[ 1472.102386] usb 2-1.1: USB disconnect, device number 9
[ 1472.127401] usb 2-1.2: USB disconnect, device number 10
[ 1472.141932] usb 2-1.3: USB disconnect, device number 11
[ 1479.644058] usb 2-1: new full-speed USB device number 12 using ohci-pci
[ 1479.844081] usb 2-1: New USB device found, idVendor=0a5c, idProduct=4500
[ 1479.844093] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 1479.844099] usb 2-1: Product: BCM2046B1
[ 1479.844104] usb 2-1: Manufacturer: Broadcom
[ 1479.847670] hub 2-1:1.0: USB hub found
[ 1479.850082] hub 2-1:1.0: 3 ports detected
[ 1480.151074] usb 2-1.1: new full-speed USB device number 13 using ohci-pci
[ 1480.250070] usb 2-1.1: New USB device found, idVendor=0a5c, idProduct=4502
[ 1480.250077] usb 2-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber
[ 1480.260236] input: HID 0a5c:4502 as /devices/pci0000:00/0000:00:02.0/usb2/2-1
[ 1480.261860] hid-generic 0003:0A5C:4502.0004: input,hidraw1: USB HID v1.11 Key
[ 1480.330068] usb 2-1.2: new full-speed USB device number 14 using ohci-pci
[ 1480.430070] usb 2-1.2: New USB device found, idVendor=0a5c, idProduct=4503
[ 1480.430079] usb 2-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber
[ 1480.441241] input: HID 0a5c:4503 as /devices/pci0000:00/0000:00:02.0/usb2/2-1
[ 1480.442349] hid-generic 0003:0A5C:4503.0005: input,hidraw2: USB HID v1.11 Mou
[ 1480.513076] usb 2-1.3: new full-speed USB device number 15 using ohci-pci
[ 1480.626069] usb 2-1.3: New USB device found, idVendor=0a5c, idProduct=2148
[ 1480.626081] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber
[ 1480.626088] usb 2-1.3: Product: BCM92046DG-CL1ROM
[ 1480.626093] usb 2-1.3: Manufacturer: Broadcom Corp
[ 1480.626098] usb 2-1.3: SerialNumber: XXXXXXXXXXXXXXX

Cheers,
b.


