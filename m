Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Graham Burnside <graham@somethingshocking.com>,
	Al Cho <acho@suse.com>
Subject: Re: ralink rt3290/3298 pcie
Date: Wed, 20 Mar 2013 22:53:21 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <514A09AD.20809@somethingshocking.com> <514A108C.9000102@somethingshocking.com>
In-Reply-To: <514A108C.9000102@somethingshocking.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201303202253.21510.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 20. März 2013, 20:39:56 schrieb Graham Burnside:

> hciconfig gives no ouput.
> 
> The directory /sys/kernel/debug/usb/devices does not exist. I'm not sure
> what else might be useful?
> 
> 
> Here is the relevant output from lspci -v (note there is no kernel
> driver being loaded for the bluetooth device).
> 
> 01:00.0 Network controller: Ralink corp. Device 3290
>     Subsystem: Hewlett-Packard Company Device 18ec
>     Flags: bus master, fast devsel, latency 0, IRQ 16
>     Memory at c2510000 (32-bit, non-prefetchable) [size=64K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>     Capabilities: [70] Express Endpoint, MSI 00
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [140] Device Serial Number 00-00-4d-fa-a8-23-94-68
>     Kernel driver in use: rt2800pci
> 
> 01:00.1 Bluetooth: Ralink corp. Device 3298
>     Subsystem: Hewlett-Packard Company Device 18ec
>     Flags: bus master, fast devsel, latency 0, IRQ 11
>     Memory at c2500000 (32-bit, non-prefetchable) [size=64K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>     Capabilities: [70] Express Endpoint, MSI 00
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [140] Device Serial Number 00-00-4e-fa-a8-23-94-68

The device is indeed PCI and different to anything else in the world.
It doesn't use the normal HC commands. The registers are not documented.
I am afraid you are out of luck with this device.

	Regards
		Oliver
