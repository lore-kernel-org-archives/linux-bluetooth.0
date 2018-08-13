Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Setting bd address in the device-tree era
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a7a737ae-a169-a833-59cb-880d68bcee8f@je-eigen-domein.nl>
Date: Mon, 13 Aug 2018 08:38:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4BC92F6C-C5C1-4ED8-8989-DE39F05EE54E@holtmann.org>
References: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
 <68E14287-C186-410C-AF95-5F4FA7A0B4C3@holtmann.org>
 <a7a737ae-a169-a833-59cb-880d68bcee8f@je-eigen-domein.nl>
To: Floris Bos <bos@je-eigen-domein.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Floris,

>>> When using newer upstream Linux kernels on Raspberry Pi 3+ that have the brcm,bcm43438-bt serial slave device-tree entries, all devices get the same BD address 43:45:C0:00:1F:AC.
>>> 
>>> What is the recommend way of fixing that up nowadays?
>>> 
>>> The vendor's standard start-up script makes up a BD address derived from SoC serial number, and pass that as parameter to hciattach.
>>> But that doesn't work when the kernel is managing the hci connection instead.
>>> And cannot find any device-tree parameter to pass address either.
>> is it actually loading the Bluetooth firmware for the RPi since once that is loaded the address should be configured correctly. Or is the RPi 3+ different in this regard?
> 
> Yes. It loads the firmware file in /lib/firmware/brcm fine.
> 
> ==
> Aug 12 15:06:46 raspberrypi kernel: [    7.172969] Bluetooth: hci0: BCM: chip id 107
> Aug 12 15:06:46 raspberrypi kernel: [    7.175092] Bluetooth: hci0: BCM: features 0x2f
> Aug 12 15:06:46 raspberrypi kernel: [    7.198320] Bluetooth: hci0: BCM4345C0
> Aug 12 15:06:46 raspberrypi kernel: [    7.198343] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> ==
> 
> And apart from the BD address, it works fine.
> 
>> If this is really always the same address with the correct firmware loaded, then the driver needs to set the QUIRK_INVALID_BDADDR to indicate that the device is missing the address configuration.
> 
> Apparently, newer versions of the bluetooth firmware are known broken to not read the correct MAC from OTP.
> 
> https://github.com/raspberrypi/firmware/issues/860
> 
> And they now just workaround that in the startup script that launches hciattach.
> 
> 
> Wonder if there shouldn't be a device-tree property offered to specify the BD address, so the boot firmware could set the address.
> They already seem to do something similar for the Ethernet MAC address ( https://github.com/raspberrypi/firmware/issues/613 ).

this is total screwup by RPi team allowing to get a firmware that doesn’t do the right thing. And these workaround are messy as well. Especially working around this in u-boot is dump.

We have a local-bd-address property that I think is supported by one Qualcomm driver. It is documented in Documentation/devicetree/bindings/net/bluetooth.txt. So someone needs to add support for that to hci_bcm.c so it will actually configure it correctly. Keep in mind that is formatted as specified in the Bluetooth spec.

	/* BD address 00:11:22:33:44:55 */
	local-bd-address = [ 55 44 33 22 11 00 ];

It is also important that we flag invalid addresses and mark controllers as not ready yet. We do that for a few already, but the RPi’s ones have not yet been on the list. Do we have a list of default addresses since it seems they encode somehow the controller revision.

>From userspace you can use btmgmt public-addr to configure your address and the kernel will re-initilize the controller correctly.

The algorithm they used to utilize the serial number seems also fishy to me.

A Raspberry Pi 3B+ serial number 000000003250ab5a booted under Raspbian has

	• eth b8:27:eb:50:ab:5a : low 24 bits match the serial number
	• wifi b8:27:eb:05:fe:0f : low 24 bits are serial number XORd with 0x555555
	• bt b8:27:eb:fa:01:f0 : low 24 bits are serial number XORd with 0xAAAAAA

A Raspberry Pi 3B with serial number 00000000685e14b0 (cat /proc/cpuinfo | grep Serial) has these addresses:

	• eth b8:27:eb:5e:14:b0 : low 24 bits match the serial number
	• wifi b8:27:eb:0b:41:e5 : low 24 bits are serial number XORd with 0x555555
	• bt b8:27:eb:f4:be:1a : low 24-bits are serial number XORd with 0xAAAAAA

All 3 addresses are suppose to be unique and guaranteed to be different from each other.

Regards

Marcel
