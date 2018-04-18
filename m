Return-Path: <hdegoede@redhat.com>
To: Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: "M. Kristall" <mkpdev@gmail.com>, linux-bluetooth@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Subject: [4.15 stable regression] "Bluetooth: btusb: Fix quirk for Atheros
 1525/QCA6174" breaks bluetooth on some devices
Message-ID: <6c97cffb-751f-466d-cd7b-42624fdb18c7@redhat.com>
Date: Wed, 18 Apr 2018 15:18:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Takashi, Marcel,

It seems that this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.15.y&id=7ec32f585fefd7c154453aa29ccf8fa2a11cc865

Is breaking bluetooth on some devices, see:

https://bugzilla.redhat.com/show_bug.cgi?id=1568911

The problem is the following error now being thrown:

[   28.466248] Bluetooth: hci0: don't support firmware rome 0x1020200

Looking at the code I wonder if maybe we need to mask the ver_rom
with & 0xfff when comparing it to the qca_devices_table[i].rom_version
filed ?

Or maybe the commit is actually wrong, or maybe devices with the
0cf3:3004 USB id need either the BTUSB_QCA_ROM or BTUSB_ATH3012
quirk depending on the device and we need to probe this somehow?

Regards,

Hans
