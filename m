Return-Path: <cyrus@holtmann.org>
Message-ID: <1343431747.1803.12.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Another vendor specific ID for BCM20702A0
 [0a5c:21f1]
From: Marcel Holtmann <marcel@holtmann.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Jul 2012 16:29:07 -0700
In-Reply-To: <1343424081-2157-1-git-send-email-mmarek@suse.cz>
References: <1343424081-2157-1-git-send-email-mmarek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> Bus 002 Device 003: ID 0a5c:21f1 Broadcom Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         1
>   bDeviceProtocol         1
>   bMaxPacketSize0        64
>   idVendor           0x0a5c Broadcom Corp.
>   idProduct          0x21f1
>   bcdDevice            1.12
>   iManufacturer           1 Broadcom Corp
>   iProduct                2 BCM20702A0
>   iSerial                 3 9CB70DCFF833
>   bNumConfigurations      1

as usual include /sys/kernel/debug/usb/devices details for this device.
I want the full set of endpoint descriptors in a simple compact format
in the commit messages for reference.

Regards

Marcel


