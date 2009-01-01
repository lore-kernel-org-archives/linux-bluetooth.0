Return-Path: <cyrus@holtmann.org>
Subject: Re: hci_usb problem after rmmod/modprobe
From: Marcel Holtmann <marcel@holtmann.org>
To: Steffen Pankratz <kratz00@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081231104354.1bf8f381@hermes>
References: <20081230211526.5136a798@hermes>
	 <1230668540.30789.1.camel@californication> <20081231104354.1bf8f381@hermes>
Content-Type: text/plain
Date: Thu, 01 Jan 2009 09:59:01 +0100
Message-Id: <1230800341.4530.4.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

> > > everything is fine until I unload and reload hci_usb:
> > > 
> > > hciconfig hci0 up
> > > Can't init device hci0: Input/output error (5)
> > > 
> > > from dmesg:
> > > hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f406cf54 err -2
> > > 
> > > I tried 'modprobe hci_usb reset=1' which did not solve the problem.
> > > 
> > > To get it working again I have to do:
> > > 
> > > rmmod hci_usb bluetooth uhci_hcd
> > > modprobe uhci_hcd
> > > modprobe hci_usb
> > > 
> > > Not sure what information could be helpful:
> > > 
> > > Linux hermes 2.6.28 #2 PREEMPT Tue Dec 30 16:30:47 CET 2008 i686 i686
> > > i386 GNU/Linux
> > 
> > if you are using 2.6.28 kernel, then just use the btusb driver instead
> > of hci_usb. The hci_usb will be removed with 2.6.29 anyway.
> 
> thanks for your suggestion.
> I am now using the btusb driver but the problem remains,
> except the kernel message has changed:
> 
> btusb_submit_intr_urb: hci0 urb f61e37c0 submission failed (2)

run "hcidump -X -V" and see what is going on and what exactly fails.

Regards

Marcel


