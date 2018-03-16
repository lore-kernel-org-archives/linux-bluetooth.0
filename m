Return-Path: <hdegoede@redhat.com>
Subject: Re: Problem with naming of broadcom bt patchram firmware files
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>,
 rhowell@uwyo.edu
References: <359ee843-2c7c-456d-7cb7-fc3496e190c6@redhat.com>
 <717D36B1-2023-4342-A043-8D5D713AC8AC@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <420f5119-7b2c-bc97-6574-080b26782d66@redhat.com>
Date: Fri, 16 Mar 2018 19:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <717D36B1-2023-4342-A043-8D5D713AC8AC@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 03/16/2018 01:58 PM, Marcel Holtmann wrote:
> Hi Hans,
> 
>> I've been working recently on adding support for serialport /
>> serdev attached brcm bt devices on more (x86) boards.
>>
>> This is going well in general, but I just noticed a problem
>> with this.
>>
>> Currently on for example both the Raspberry Pi 3 and the
>> Chuwi Vi8 Plus, we will load brcm/BCM43430A1.hcd as patchram
>> file. Ideally this file will be in linux-firmware (*) so things
>> will just work.
>>
>> But it turns out there are 2 different builds of the firmware,
>> one for boards which use a 26MHz crystal and one for boards which
>> use a 37.4Mhz crystal and guess what the RPi 3 uses 37.4Mhz
>> and the Chuwi Vi8 Plus 26Mhz.
>>
>> So this causes 2 problems:
>>
>> 1) We need a -xxmhz postfix to the firmware name I believe,
>> but this will break existing setups, so I guess we first
>> try to load with the postfix, and then fallback to the old
>> name?
>>
>> 2) A bigger problem is how to figure out which frequency we
>> need. The wifi driver knows this as there is an xtalfreq=26000
>> or xtalfreq=37400 in the nvram file it loads. We could come
>> up with a mechanism to use this, but this will not be pretty and
>> it assumes that the uart attached bcm bt is always combined
>> with a wifi part which uses nvram from /lib/firmware.
>>
>> Looking at all the devices I'm aware of atm there is no
>> real heuristic for this, but if we only look at x86 we can
>> get away with a per chip default, which we set in the
>> bcm_uart_subver_table.
>>
>> So the direction I'm thinking in atm is:
>>
>> 1) Let hci_bcm.c tell btbcm.c which frequency to use, with an
>> option for it to pass "don't know use default"
>>
>> 2) For ARM allow setting the frequency through a devicetree property
>> which gets set on the serdev device-node (the node with the
>> "brcm,bcm43438-bt" compatible), with a fallback to the default
>> if not set.
>>
>> 3) On x86 rely on the defaults and if ever necessary use DMI
>> quirks to override
>>
>> Note for this to work, the default for the BCM43430A1.hcd needs
>> to be 26 MHz and the RPi needs to have an updated devicetree
>> setting the freq to 37.4.
>>
>> So what are your thoughts on this?
> 
> we need to move towards a modalias:firmware file name mapping table so that you can also just put all the firmware files you find in the Windows driver into lib/firmware and stop worrying about it. That is what Windows actually does, the PnP ID maps to the firmware file. They do that even for USB. Some time ago, I have written code for that and seems like I need to dust this off since now it is needed.
> 
> Here is what I had for /lib/firmware/brcm/bcmbtfw.map table that I used for testing.
> 
> usb:v0930p0223*         BCM20702A1_001.002.014.1483.1674.hex
> usb:v0A5Cp21E8*         BCM20702A1_001.002.014.1443.1459.hex
> usb:v0A5Cp21EC*         BCM20702A1_001.002.014.1443.1460.hex
> usb:v0B05p17CB*         BCM20702A1_001.002.014.1443.1467.hex
> usb:v19FFp0239*         BCM20702B0_002.001.014.0527.0557.hex

I think we are already doing something like this for USB devices,
that is we already put the USB ids in the filename we look for, right?

with that said having a map like this so that we can directly use
windows firmware filenames sounds like we might want it, otoh
they embed a specific version in the filename which makes
pushing out updated versions problematic, if we update the map,
then things will break until the user install the new version,
likewise if ever get these in linux-firmware (which I'm hopefully
we do) then if we push a new version to linux-firmware we break
things unless we also keep the old version there.

TL;DR: I don't think using the Windows filenames as is is a good
idea as they embed firmware version info in the filename which
we do not want.

> And we can stick ACPI and DT modalias entries in there as well.

That would have the same problem with versions, also I
would prefer to have to have the 26 / 37.4 MHz explicit
in the filename, I think that there will be versions
where there is both a 26MHz and 37.4MHz build of that version.

I do agree that using the ACPI HID (which is in the modalias)
likely is a good way to detect 26 vs 37.4 MHz, at least
I hope there is a 1:1 mapping between those 2.

> In addition, I am really thinking we should let hci_bcm.c be what it is and move towards the btuart.c serdev only driver that I posted a few days ago. That way we
> can try to keep this clean and don’t have to deal with TTY line discipline legacy.
> 
> Do you have a good reference for the Broadcom Windows driver that includes UART based devices.

You mean a download link, or?

> And I wonder if the Apple UART devices use ROM patching or if they are RAM based like their USB counterparts.

No idea.

Regards,

Hans
