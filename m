Return-Path: <cyrus@holtmann.org>
Message-ID: <55ACE3D9.8090908@gmail.com>
Date: Mon, 20 Jul 2015 15:04:41 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: =?UTF-8?B?UmFwaGHDq2wgSmFrc2U=?= <raphael.jakse@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: AR9462: ath3k and btusb: support for device 04ca:300d
 makes it disconnect/reconnect indefinitely
References: <55AC1C43.6030301@gmail.com>
In-Reply-To: <55AC1C43.6030301@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

> [X.] Other notes, patches, fixes, workarounds:
> 
> A workaround to this bug is to blacklist ath3k and btusb, and have two versions of them:
> 
> 1) The patched versions, which contains the following lines:
> 
> in btusb.c:
>     { USB_DEVICE(0x04CA, 0x300d) },
> 
> in ath3k.c:
>     { USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
>     { USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
> 2) The unpatched versions, same modules without these lines.
> 
> The workaround is to insmod the patched versions (which load the
> firmware), rmmod them after a second, and insmod the unpatched versions.
>  After that  Bluetooth is working until next computer suspend or halt.
> The firmware is not kept loaded after suspend or halt, but it is kept
> loaded after a reboot. Using the unpatched versions without the firmware being loaded makes Bluetooth look activated but unusable.
> 
> I also noticed that iProduct = 0 for the 04ca:300d device.
> 
> This is my first bug report to the kernel, so please tell me if I did anything wrong.
> 
> Cheers,
> 
> Raphaël.
> 

This looks like a bug in ath3k module. It loads firmware, but after that hangs.
That is why when you load btusb after that, BT works.

iProduct is 0 for all new AR3012 devices. It is not a criterion now to distinguish AR3011 and AR3012.
