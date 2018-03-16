Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with naming of broadcom bt patchram firmware files
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <359ee843-2c7c-456d-7cb7-fc3496e190c6@redhat.com>
Date: Fri, 16 Mar 2018 13:58:57 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi <linux-acpi@vger.kernel.org>, rhowell@uwyo.edu
Message-Id: <717D36B1-2023-4342-A043-8D5D713AC8AC@holtmann.org>
References: <359ee843-2c7c-456d-7cb7-fc3496e190c6@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> I've been working recently on adding support for serialport /
> serdev attached brcm bt devices on more (x86) boards.
> 
> This is going well in general, but I just noticed a problem
> with this.
> 
> Currently on for example both the Raspberry Pi 3 and the
> Chuwi Vi8 Plus, we will load brcm/BCM43430A1.hcd as patchram
> file. Ideally this file will be in linux-firmware (*) so things
> will just work.
> 
> But it turns out there are 2 different builds of the firmware,
> one for boards which use a 26MHz crystal and one for boards which
> use a 37.4Mhz crystal and guess what the RPi 3 uses 37.4Mhz
> and the Chuwi Vi8 Plus 26Mhz.
> 
> So this causes 2 problems:
> 
> 1) We need a -xxmhz postfix to the firmware name I believe,
> but this will break existing setups, so I guess we first
> try to load with the postfix, and then fallback to the old
> name?
> 
> 2) A bigger problem is how to figure out which frequency we
> need. The wifi driver knows this as there is an xtalfreq=26000
> or xtalfreq=37400 in the nvram file it loads. We could come
> up with a mechanism to use this, but this will not be pretty and
> it assumes that the uart attached bcm bt is always combined
> with a wifi part which uses nvram from /lib/firmware.
> 
> Looking at all the devices I'm aware of atm there is no
> real heuristic for this, but if we only look at x86 we can
> get away with a per chip default, which we set in the
> bcm_uart_subver_table.
> 
> So the direction I'm thinking in atm is:
> 
> 1) Let hci_bcm.c tell btbcm.c which frequency to use, with an
> option for it to pass "don't know use default"
> 
> 2) For ARM allow setting the frequency through a devicetree property
> which gets set on the serdev device-node (the node with the
> "brcm,bcm43438-bt" compatible), with a fallback to the default
> if not set.
> 
> 3) On x86 rely on the defaults and if ever necessary use DMI
> quirks to override
> 
> Note for this to work, the default for the BCM43430A1.hcd needs
> to be 26 MHz and the RPi needs to have an updated devicetree
> setting the freq to 37.4.
> 
> So what are your thoughts on this?

we need to move towards a modalias:firmware file name mapping table so that you can also just put all the firmware files you find in the Windows driver into lib/firmware and stop worrying about it. That is what Windows actually does, the PnP ID maps to the firmware file. They do that even for USB. Some time ago, I have written code for that and seems like I need to dust this off since now it is needed.

Here is what I had for /lib/firmware/brcm/bcmbtfw.map table that I used for testing.

usb:v0930p0223*         BCM20702A1_001.002.014.1483.1674.hex
usb:v0A5Cp21E8*         BCM20702A1_001.002.014.1443.1459.hex
usb:v0A5Cp21EC*         BCM20702A1_001.002.014.1443.1460.hex
usb:v0B05p17CB*         BCM20702A1_001.002.014.1443.1467.hex
usb:v19FFp0239*         BCM20702B0_002.001.014.0527.0557.hex

And we can stick ACPI and DT modalias entries in there as well.

In addition, I am really thinking we should let hci_bcm.c be what it is and move towards the btuart.c serdev only driver that I posted a few days ago. That way we 
can try to keep this clean and don’t have to deal with TTY line discipline legacy.

Do you have a good reference for the Broadcom Windows driver that includes UART based devices. And I wonder if the Apple UART devices use ROM patching or if they are RAM based like their USB counterparts.

Regards

Marcel

