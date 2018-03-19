Return-Path: <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-acpi <linux-acpi@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: Using BDADDR efivar to set bd_addr for bci_hcm devices?
Message-ID: <724b6359-9d30-c7a6-89fb-591a695c49b3@redhat.com>
Date: Mon, 19 Mar 2018 22:16:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

While fixing the bluetooth on the meegopad t08 I noticed that
it (and other devices) have a BDADDR efivar with the same guid
as used for the nvram variable which contains the wifi's
nvram settings for sdio broadcom wifi chips (if present):

hexdump -C /sys/firmware/efi/efivars/BDADDR-74b00bd9-805a-4d61-b51f-43268123d113
00000000  07 00 00 00 ac 83 f3 37  39 af                    |.......79.|

Booting into Windows shows the bluetooth using
an address of ac 83 f3 37  39 af, which makes
sense as the meegopad has an AMPAK AP6234 wifi
module and the ac 83 f3 prefix belongs to AMPAK.

Getting the contents from an efivar from within the kernel is
not that hard, so I was thinking that maybe we need to teach
the hci_bcm code to check for this and use the bd_addr from
there so that we have the same bd_addr as Windows, OTOH not
having the same bd_addr is an advantage because this allows
devices which can be paired to multiple bt hosts to be paired
with both Windows and Linux at the same time using a different
key.

So what do you think about adding support for the BDADDR efivar
and using it to set bd_addr?

1) Good idea?
2) Good idea, but make it optional (compile and/or runtime) ?
3) Bad idea ?

Regards,

Hans
