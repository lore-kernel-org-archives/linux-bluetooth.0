Return-Path: <cyrus@holtmann.org>
Subject: Re: hci_usb problem after rmmod/modprobe
From: Marcel Holtmann <marcel@holtmann.org>
To: Steffen Pankratz <kratz00@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081230211526.5136a798@hermes>
References: <20081230211526.5136a798@hermes>
Content-Type: text/plain
Date: Tue, 30 Dec 2008 21:22:20 +0100
Message-Id: <1230668540.30789.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

> everything is fine until I unload and reload hci_usb:
> 
> hciconfig hci0 up
> Can't init device hci0: Input/output error (5)
> 
> from dmesg:
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f406cf54 err -2
> 
> I tried 'modprobe hci_usb reset=1' which did not solve the problem.
> 
> To get it working again I have to do:
> 
> rmmod hci_usb bluetooth uhci_hcd
> modprobe uhci_hcd
> modprobe hci_usb
> 
> Not sure what information could be helpful:
> 
> Linux hermes 2.6.28 #2 PREEMPT Tue Dec 30 16:30:47 CET 2008 i686 i686
> i386 GNU/Linux

if you are using 2.6.28 kernel, then just use the btusb driver instead
of hci_usb. The hci_usb will be removed with 2.6.29 anyway.

Regards

Marcel


