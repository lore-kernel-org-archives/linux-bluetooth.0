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
Subject: [PATCH v2 0/9] Bluetooth: Add RTL8723BS support
Date: Sat, 16 Jun 2018 20:40:48 +0200
Message-Id: <20180616184057.14825-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Here is v2 of my series of patches adding support for RTL8723BS'
bluetooth component through serdev enumeration.

This builds on the great work done on this by Martin Blumenstingl
which makes the btrtl.c code also support firmware+config loading
for the RTL8723BS, as well as Jeremy's Cline work to add ACPI
enumeration support on top of this.

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
