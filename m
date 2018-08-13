Return-Path: <bos@je-eigen-domein.nl>
Subject: Re: Setting bd address in the device-tree era
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <f4874a2b-9832-2d11-7c9d-d48e6512f3e8@je-eigen-domein.nl>
 <68E14287-C186-410C-AF95-5F4FA7A0B4C3@holtmann.org>
 <a7a737ae-a169-a833-59cb-880d68bcee8f@je-eigen-domein.nl>
 <4BC92F6C-C5C1-4ED8-8989-DE39F05EE54E@holtmann.org>
From: Floris Bos <bos@je-eigen-domein.nl>
Message-ID: <da4094ab-4ee1-6bdb-8d89-bcaffcac515d@je-eigen-domein.nl>
Date: Mon, 13 Aug 2018 13:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <4BC92F6C-C5C1-4ED8-8989-DE39F05EE54E@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/13/2018 08:38 AM, Marcel Holtmann wrote:
>
>> Apparently, newer versions of the bluetooth firmware are known broken to not read the correct MAC from OTP.
>>
>> https://github.com/raspberrypi/firmware/issues/860
>>
>> And they now just workaround that in the startup script that launches hciattach.
>>
>>
>> Wonder if there shouldn't be a device-tree property offered to specify the BD address, so the boot firmware could set the address.
>> They already seem to do something similar for the Ethernet MAC address ( https://github.com/raspberrypi/firmware/issues/613 ).
> this is total screwup by RPi team allowing to get a firmware that doesn’t do the right thing. And these workaround are messy as well. Especially working around this in u-boot is dump.
>
> We have a local-bd-address property that I think is supported by one Qualcomm driver. It is documented in Documentation/devicetree/bindings/net/bluetooth.txt. So someone needs to add support for that to hci_bcm.c so it will actually configure it correctly. Keep in mind that is formatted as specified in the Bluetooth spec.
>
> 	/* BD address 00:11:22:33:44:55 */
> 	local-bd-address = [ 55 44 33 22 11 00 ];
>
> It is also important that we flag invalid addresses and mark controllers as not ready yet. We do that for a few already, but the RPi’s ones have not yet been on the list. Do we have a list of default addresses since it seems they encode somehow the controller revision.

Don't have an official list.
But think default MAC matches controller model.
Pi 3+ has the newer BCM4345C0 in which I always get 43:45:C0:00:1F:AC
The others in the github issue I linked had the standard Pi 3 or Pi 0W 
with BCM43430A1 and get 43:43:A1:12:1F:AC

>  From userspace you can use btmgmt public-addr to configure your address and the kernel will re-initilize the controller correctly.
>
> The algorithm they used to utilize the serial number seems also fishy to me.

Yeah, their whole MAC assignment strategy leaves to be desired, as the 
serial numbers are not exactly sequentially assigned either but random.
So yes, people even have had multiple Pi with the same Ethernet MAC in 
their network as well... ( 
https://www.raspberrypi.org/forums/viewtopic.php?t=190197 )
They really should do better then that, but that's a different discussion.


Yours sincerely,

Floris Bos
