Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 02/13] Bluetooth: btrtl: add MODULE_FIRMWARE declarations
Date: Sun, 27 May 2018 21:04:46 +0200
Message-Id: <20180527190457.2632-3-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This makes the firmware names show up in modinfo.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btrtl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 437f080deaab..c08f63e3bc14 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -528,3 +528,12 @@ MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
-- 
2.17.0
