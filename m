Return-Path: <martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: mark.rutland@arm.com,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	gregkh@linuxfoundation.org,
	jslaby@suse.com,
	johan@kernel.org,
	linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net,
	carlo@endlessm.com,
	drake@endlessm.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v2 3/9] Bluetooth: btrtl: add MODULE_FIRMWARE declarations
Date: Mon,  1 Jan 2018 21:42:11 +0100
Message-Id: <20180101204217.26165-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This makes the firmware names show up in modinfo.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/bluetooth/btrtl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6e2ad748abba..3e5296287808 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -477,3 +477,12 @@ MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
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
2.15.1
