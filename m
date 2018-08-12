Return-Path: <bos@je-eigen-domein.nl>
Subject: Re: Setting bd address in the device-tree era
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
 <68E14287-C186-410C-AF95-5F4FA7A0B4C3@holtmann.org>
From: Floris Bos <bos@je-eigen-domein.nl>
Message-ID: <a7a737ae-a169-a833-59cb-880d68bcee8f@je-eigen-domein.nl>
Date: Sun, 12 Aug 2018 18:11:03 +0200
MIME-Version: 1.0
In-Reply-To: <68E14287-C186-410C-AF95-5F4FA7A0B4C3@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/12/2018 05:48 PM, Marcel Holtmann wrote:
>> When using newer upstream Linux kernels on Raspberry Pi 3+ that have the brcm,bcm43438-bt serial slave device-tree entries, all devices get the same BD address 43:45:C0:00:1F:AC.
>>
>> What is the recommend way of fixing that up nowadays?
>>
>> The vendor's standard start-up script makes up a BD address derived from SoC serial number, and pass that as parameter to hciattach.
>> But that doesn't work when the kernel is managing the hci connection instead.
>> And cannot find any device-tree parameter to pass address either.
> is it actually loading the Bluetooth firmware for the RPi since once that is loaded the address should be configured correctly. Or is the RPi 3+ different in this regard?

Yes. It loads the firmware file in /lib/firmware/brcm fine.

==
Aug 12 15:06:46 raspberrypi kernel: [    7.172969] Bluetooth: hci0: BCM: 
chip id 107
Aug 12 15:06:46 raspberrypi kernel: [    7.175092] Bluetooth: hci0: BCM: 
features 0x2f
Aug 12 15:06:46 raspberrypi kernel: [    7.198320] Bluetooth: hci0: 
BCM4345C0
Aug 12 15:06:46 raspberrypi kernel: [    7.198343] Bluetooth: hci0: 
BCM4345C0 (003.001.025) build 0000
==

And apart from the BD address, it works fine.

> If this is really always the same address with the correct firmware loaded, then the driver needs to set the QUIRK_INVALID_BDADDR to indicate that the device is missing the address configuration.

Apparently, newer versions of the bluetooth firmware are known broken to 
not read the correct MAC from OTP.

https://github.com/raspberrypi/firmware/issues/860

And they now just workaround that in the startup script that launches 
hciattach.


Wonder if there shouldn't be a device-tree property offered to specify 
the BD address, so the boot firmware could set the address.
They already seem to do something similar for the Ethernet MAC address ( 
https://github.com/raspberrypi/firmware/issues/613 ).


Yours sincerely,

Floris Bos
