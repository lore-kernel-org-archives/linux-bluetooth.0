Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH 01/13] dt-bindings: net: bluetooth: add support for
 Realtek Bluetooth chips
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3bac3b64-21cb-82a2-4470-71b4816c5c99@redhat.com>
Date: Mon, 11 Jun 2018 15:32:50 +0200
Cc: Rob Herring <robh@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-acpi <linux-acpi@vger.kernel.org>,
        devicetree@vger.kernel.org
Message-Id: <A054D5CF-0EE4-4667-9E99-D05FFBB20009@holtmann.org>
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-2-hdegoede@redhat.com>
 <7A22F14E-9F45-4779-B7E5-CEB330A5601E@holtmann.org>
 <16b7e10b-6816-f441-00e5-9e86d1df33a7@redhat.com>
 <20180531164214.GA12210@rob-hp-laptop>
 <0d99e890-b93c-df55-ae43-8fc910778243@redhat.com>
 <14D10B2C-319C-4676-AE84-1D76AA603C3B@holtmann.org>
 <94b57c4a-985e-250a-f91f-e0f0cd97be1e@redhat.com>
 <9F05431A-7FEF-4EFB-B35C-AA0E1BAA98EE@holtmann.org>
 <3bac3b64-21cb-82a2-4470-71b4816c5c99@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

>>>>> Hmm that is actually no entirely true, for broadcom the
>>>>> bluetooth patchram file depends on the clockcrystal freq
>>>>> used on the board, so there are 2 versions of it for a
>>>>> single chip, 1 for each of the 2 different freqs used.
>>>> are you using .hex or .hcd files for Broadcom? The .hex files are pure patchram, while the .hcd can actually contain extra HCI commands. I remember that some .hcd files contain also HCI commands to do extra settings. Maybe we need a tool that shows the details of these files. We have this for nokfw and rtlfw now.
>>> 
>>> I'm using hcd files for broadcom.
>> so I added tools/bcmfw to analyze HCD files. We might also need a compare HCD files option. However you might be able to compare the HCD files that you think are different for some of your hardware.
> 
> The problem is that I don't think I can get the exact same
> version / build of the patchram in 26MHz and 37.4 Mhz versions
> and comparing different versions is not really going to be useful.
> 
> All I really know here is that I can usually take any 37.4MHz build,
> as indicated by the build string in the hcd file, e.g. :
> 
> BCM43438A1 37.4MHz Raspberry Pi 3-0043O
> 
> And use that on a board where the wifi nvram file says the
> crystal is 37.4MHz and things will work fine. Where as any
> hcd with 26Mhz in the buildstring will not work.
> 
> My work on the brcm bluetooth code has left me to believe
> that the ACPI HID is (supposed to be) unique per board.

for ACPI it is really suppose to be unique. Do you happen to have a link for a good download of the latest Broadcom firmware?

> I'm thinking of adding a postfix string as driver_data
> in the acpi_match_id table for ACPI HIDs which I can test
> and then make the bcm-bt code first try e.g. firmware_request
> BCM4356A2-26M.hcd before calling BCM4356A2.hcd .
> 
> I could instead simply postfix the ACPI HID (as I plan to
> do for the realtek btconfig) but as said in all my testing
> simply using the latest build, with the right crystal
> freq seems to work best. So I would prefer to go with
> e.g. BCM4356A2-26M.hcd rather then BCM4356A2-BCM2E74.hcd
> this way we will only need 2 hcd files (26M and 37.4M) per
> chipset rather a whole lot of them.
> 
> Marcel, what do you think of this, would you accept a (to-be-written)
> patchset adding -26M / -37.4M postfixes as described above?

I am not in favor of it. I prefer giving the vendor the chance to list the right firmware for their hardware instead of us guessing. Whatever comes out of the Broadcom Windows driver should be all least passed certification.

> This is all aimed at getting the hcd files into linux-firmware,
> where less files definitely would be more. Note I'm only talking
> about serdev attached bcm-bt devices here. For usb we can keep
> using the existing scheme or come up with a new scheme.

Seems that Broadcom opted for per ACPI HID firmware files. This is in contrast to Intel for example where we read hardware information and pick the firmware based on that information.

Regards

Marcel

