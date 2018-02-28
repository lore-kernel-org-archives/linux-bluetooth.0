Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/1] Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table
Date: Wed, 28 Feb 2018 11:57:49 +0100
Message-Id: <20180228105750.6491-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

So Brian Norris was right and the problems on the Yoga 920 have been
caused all along by the initial QCA Rome suspend/resume fix issues.

So we can remove the Yoga 920 from the btusb_needs_reset_resume_table,
note after this the table is empty.

I've decided to keep the empty table around to make adding new entries
easier. Kai-Heng AFAIK you said that you have at least one model laptop
which does really need the reset-resume quirk for QCA? Can you submit
a patch adding this model to the btusb_needs_reset_resume_table please?

Regards,

Hans
