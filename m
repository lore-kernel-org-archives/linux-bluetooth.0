Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Setting bd address in the device-tree era
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
Date: Sun, 12 Aug 2018 17:48:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <68E14287-C186-410C-AF95-5F4FA7A0B4C3@holtmann.org>
References: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
To: Floris Bos <bos@je-eigen-domein.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Floris,

> When using newer upstream Linux kernels on Raspberry Pi 3+ that have the brcm,bcm43438-bt serial slave device-tree entries, all devices get the same BD address 43:45:C0:00:1F:AC.
> 
> What is the recommend way of fixing that up nowadays?
> 
> The vendor's standard start-up script makes up a BD address derived from SoC serial number, and pass that as parameter to hciattach.
> But that doesn't work when the kernel is managing the hci connection instead.
> And cannot find any device-tree parameter to pass address either.

is it actually loading the Bluetooth firmware for the RPi since once that is loaded the address should be configured correctly. Or is the RPi 3+ different in this regard?

If this is really always the same address with the correct firmware loaded, then the driver needs to set the QUIRK_INVALID_BDADDR to indicate that the device is missing the address configuration.

Regards

Marcel
