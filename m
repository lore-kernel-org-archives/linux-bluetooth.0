Return-Path: <skronenberger@web.de>
Date: Fri, 13 Aug 2004 21:03:46 +0200
From: Sigrid Kronenberger <skronenberger@web.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
Message-Id: <20040813210346.6c40aed3@localhost>
In-Reply-To: <1092336801.28711.172.camel@pegasus>
References: <20040811231204.18574a27@localhost>
	<1092262417.4564.259.camel@pegasus>
	<20040812194818.7d3d1ce6@localhost>
	<1092334021.28711.169.camel@pegasus>
	<20040812203428.0bd25290@localhost>
	<1092336801.28711.172.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: skronenberger@web.de
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 12 Aug 2004 20:53:21 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

Hi Marcel, 

> Hi Sigrid,
> 
> > Bluetooth: Core ver 2.3
> > NET: Registered protocol family 31
> > Bluetooth: HCI device and connection manager initialized
> > Bluetooth: HCI socket layer initialized
> > Bluetooth: BlueFRITZ! USB driver ver 1.1
> > bfusb_probe: Firmware request failed
> > bfusb: probe of 1-2:1.0 failed with error -5
> > drivers/usb/core/usb.c: registered new driver bfusb
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000028
> >  printing eip:
> > c016b532
> > *pde = 00000000
> > Oops: 0000 [#1]
> > CPU:    0

[...]
> 
> and this is the problem. The firmware loading generates an oops. You
> must install a newer kernel (at least 2.6.8-rc3) before we can
> proceed.

Now, I have updated to 2.6.8-0.rc2.2mdk (sorry, but I'm not used in
compiling my own kernel, so I prefer rpm-packages, is easier... ;))


Now, it looks a little bit better: 

/var/log/dmesg (partly)

uhci_hcd 0000:00:07.3: irq 11, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using address 2
usb 1-2: configuration #1 chosen from 2 choices
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: BlueFRITZ! USB driver ver 1.1
bfusb_probe: Firmware request failed
bfusb: probe of 1-2:1.0 failed with error -5
usbcore: registered new driver bfusb
Adding 506008k swap on /dev/hda5.  Priority:-1 extents:1
Adding 511520k swap on /dev/hde1.  Priority:-2 extents:1
Adding 818960k swap on /dev/hdg7.  Priority:-3 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 32M @ 0xd8000000

No kernel-oops :)
Should I change the firmware again? Do you know which version of the
AVM-firmware have problems with the kernel? The first version I've
tested, was 3-18-39, after that, I've changed to 3-17-53. 

Regards

Sigrid
