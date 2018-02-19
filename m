Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] Bluetooth: btusb: Use DMI matching for QCA reset_resume quirk
Date: Mon, 19 Feb 2018 15:37:28 +0100
Message-Id: <20180219143729.15985-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

As discussed here is a patch to move the reset_resume quirk adding for QCA
devices over from usb-id (chipset) to dmi (platform) matching.

Note this is still a RFC atm, because I still need to get feedback from
the reporter with the Yoga 920.

Kai-Heng, can you extend the dmi table with info from the device with
the problem you have and then either send me a new version with both
entries, or prepare a follow-up patch ?

Regards,

Hans
