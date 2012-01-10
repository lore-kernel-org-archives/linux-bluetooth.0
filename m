Return-Path: <cyrus@holtmann.org>
Message-ID: <1326214276.6454.212.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0489:e031]
From: Marcel Holtmann <marcel@holtmann.org>
To: harv@gmx.de
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 10 Jan 2012 08:51:16 -0800
In-Reply-To: <4F0C355E.5050609@gmx.de>
References: <4F0ACADF.1060906@cestona.ro>
	  <1326137984.6454.152.camel@aeonflux> <4F0BE4CB.30907@gmx.de>
	 <1326183061.6454.194.camel@aeonflux> <4F0C355E.5050609@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

> >>   From a short look in the Windows inf. file:
> >> Fujitsu is listed there in a separate section called RAMUSBE031. There
> >> is also this "BCM20702A0_001.001.024.0023.0055.hex" file copied along
> >> with the driver, which is then referenced in the registry as
> >> "RAMPatchFileName". There is a long list of other 20702 adapters divided
> >> in those that need a 'RAM patch' or not. Maybe you could complete your
> >> list of compatible devices bases on this.
> >
> > this most likely means that your device is a ROM chip that needs some
> > patching (kinda firmware download) to fix some bugs in the ROM mask.
> >
> > Have a USB sniffer handy and figure out on how they upload this file
> > into the chip. Most likely they are some HCI vendor commands.
> 
> Can you suggest one which is especially helpful for this task? I will 
> try this in a virtualbox xp machine if possible. BTW, I'm not really a 
> crack but will try to do my best to help here if you want me to.

virtualbox and then running either usbmon or Wireshark on your Linux
system should work just fine.

Regards

Marcel


