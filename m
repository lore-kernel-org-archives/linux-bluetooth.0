Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <526F8804.9060906@canonical.com>
Date: Tue, 29 Oct 2013 12:16:58 +0100
Cc: Tedd An <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	xiong.y.zhang@intel.com,
	"Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org>
References: <526F8804.9060906@canonical.com>
To: Hui Wang <hui.wang@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hui,

> The problem is:
> On the machine which has Intel 7260 BT module, i use it to connect a bluetooth headset,
> it can successfully scan and connect to the headset, when i play sound to the bt headset,
> the problem comes, if the bt module is connected to the XHCI, it can work very well.
> 
> u@u-Lenovo-B4400:~$ lsusb -t
> 1-7:1.0: No such file or directory
> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>    |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
>    |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
>    |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>    |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
> 
> But if the bt module is connected to the EHCI, it always fails to play sound.
> 
> u@u-Lenovo-B4400:~$ lsusb -t
> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>        |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>        |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>        |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>        |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M

can you paste /sys/kernel/debug/usb/devices here.

If the uvcvideo driver is also using ISOC URBs, we might have just exhausted the bandwidth of the USB bus here or these two devices just do not play nice with each other.

Try to unload the uvcvideo driver and try it again.

Regards

Marcel

