Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Using BDADDR efivar to set bd_addr for bci_hcm devices?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <724b6359-9d30-c7a6-89fb-591a695c49b3@redhat.com>
Date: Mon, 19 Mar 2018 23:13:59 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi <linux-acpi@vger.kernel.org>
Message-Id: <31BC049B-32EE-407F-A11C-1080A54D0FA7@holtmann.org>
References: <724b6359-9d30-c7a6-89fb-591a695c49b3@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> While fixing the bluetooth on the meegopad t08 I noticed that
> it (and other devices) have a BDADDR efivar with the same guid
> as used for the nvram variable which contains the wifi's
> nvram settings for sdio broadcom wifi chips (if present):
> 
> hexdump -C /sys/firmware/efi/efivars/BDADDR-74b00bd9-805a-4d61-b51f-43268123d113
> 00000000  07 00 00 00 ac 83 f3 37  39 af                    |.......79.|
> 
> Booting into Windows shows the bluetooth using
> an address of ac 83 f3 37  39 af, which makes
> sense as the meegopad has an AMPAK AP6234 wifi
> module and the ac 83 f3 prefix belongs to AMPAK.
> 
> Getting the contents from an efivar from within the kernel is
> not that hard, so I was thinking that maybe we need to teach
> the hci_bcm code to check for this and use the bd_addr from
> there so that we have the same bd_addr as Windows, OTOH not
> having the same bd_addr is an advantage because this allows
> devices which can be paired to multiple bt hosts to be paired
> with both Windows and Linux at the same time using a different
> key.
> 
> So what do you think about adding support for the BDADDR efivar
> and using it to set bd_addr?
> 
> 1) Good idea?
> 2) Good idea, but make it optional (compile and/or runtime) ?
> 3) Bad idea ?

I am all for using the BD_ADDR from EFI variables. That way this become how it was intended. If we want to be flexible, we can add a module parameter to disable it and have it stick with the default one.

If we can do it directly from within the kernel automatically, then lets do it. Some similar code was added to hci_ll.c for DT entries from the boot loader. Alternative, this can be always done from userspace via Set Public Address mgmt command.

Regards

Marcel

