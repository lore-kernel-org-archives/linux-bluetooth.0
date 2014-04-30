Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 18/38] gatt: Add some characteristics uuids
Date: Wed, 30 Apr 2014 11:13:49 +0200
Message-Id: <1398849249-5868-19-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These characteristics uuids will be used in following patch
---
 lib/uuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 237145b..814fd92 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -118,6 +118,13 @@ extern "C" {
 #define GATT_CHARAC_RECONNECTION_ADDRESS		0x2A03
 #define GATT_CHARAC_PERIPHERAL_PREF_CONN		0x2A04
 #define GATT_CHARAC_SERVICE_CHANGED			0x2A05
+#define GATT_CHARAC_SYSTEM_ID				0x2A23
+#define GATT_CHARAC_MODEL_NUMBER_STRING			0x2A24
+#define GATT_CHARAC_SERIAL_NUMBER_STRING		0x2A25
+#define GATT_CHARAC_FIRMWARE_REVISION_STRING		0x2A26
+#define GATT_CHARAC_HARDWARE_REVISION_STRING		0x2A27
+#define GATT_CHARAC_SOFTWARE_REVISION_STRING		0x2A28
+#define GATT_CHARAC_MANUFACTURER_NAME_STRING		0x2A29
 
 /* GATT Characteristic Descriptors */
 #define GATT_CHARAC_EXT_PROPER_UUID			0x2900
-- 
1.8.4

