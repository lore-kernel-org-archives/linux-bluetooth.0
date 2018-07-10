Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/9] Bluetooth: Add RTL8723BS support
Date: Tue, 10 Jul 2018 10:11:08 +0200
Message-Id: <20180710081117.25078-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Here is v2 of my series of patches adding support for RTL8723BS'
bluetooth component through serdev enumeration.

This builds on the great work done on this by Martin Blumenstingl
which makes the btrtl.c code also support firmware+config loading
for the RTL8723BS, as well as Jeremy's Cline work to add ACPI
enumeration support on top of this.

Marcel, I've not seen any feedback on v2 of this series and I believe
this series is ready for merging now, can we get this merged please?

New in v3:
-Fix build error when CONFIG_RTL_BT is not set, reported by Paul Cercueil

New in v2:
-Dropped devicetree specific patches
 (these can be reposted later by someone who can actually test them)
-Add the option to pass a postfix for the config firmware filename,
 to btrtl_initialize() (new patch). For ACPI serdev enumerated
 devies this will be set to the ACPI HID, so the filename becomes e.g.
 rtl_bt/rtl8732bs_config-OBDA8723.bin
 This is done because the config is board specific and we may need a
 different file for e.g. ARM boards

I've tested this series on several Intel boards with a RTL8723BS chip.

Regards,

Hans
