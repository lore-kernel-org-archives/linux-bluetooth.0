Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros Communications, Inc. AR3012 Bluetooth 4.0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <556486B0.1020104@battlepenguin.com>
Date: Sat, 6 Jun 2015 08:16:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EEAFDBFC-C252-4843-A9E0-3E74EA21B665@holtmann.org>
References: <556486B0.1020104@battlepenguin.com>
To: Sumit's Mailing Lists <lists@battlepenguin.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sumit,

> I'm currently using an MSI WS60 laptop which contains the following
> Bluetooth controller (from lsusb):
> 
> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
> Bluetooth 4.0

assuming that the firmware is present, this is most likely just missing the right VID/PID additions in the drivers. Please prepare a patch for that.

> and the more detailed version:
> 
> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
> Bluetooth 4.0
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
>  bDeviceClass          224 Wireless
>  bDeviceSubClass         1 Radio Frequency
>  bDeviceProtocol         1 Bluetooth
>  bMaxPacketSize0        64
>  idVendor           0x0cf3 Atheros Communications, Inc.
>  idProduct          0x3004 AR3012 Bluetooth 4.0
>  bcdDevice            0.01
>  iManufacturer           0
>  iProduct                0
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:

I actually prefer /sys/kernel/debug/usb/devices output for the devices.

Regards

Marcel

