Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] android/gatt: Extend android2uuid uuid type support
Date: Thu,  8 May 2014 15:30:52 +0200
Message-Id: <1399555853-11553-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now conversion function android2uuid can recognize type of uuid and set
it value by copying significant bytes.
---
 android/gatt.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4ff70e4..da68adc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -55,6 +55,13 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+#define BASE_UUID16_OFFSET     12
+
+static uint8_t BLUETOOTH_UUID[] = {
+	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
 typedef enum {
 	DEVICE_DISCONNECTED = 0,
 	DEVICE_CONNECT_INIT,		/* connection procedure initiated */
@@ -171,14 +178,34 @@ static GIOChannel *listening_io = NULL;
 
 static void bt_le_discovery_stop_cb(void);
 
-static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
+static bool is_bluetooth_uuid(const uint8_t *uuid)
 {
-	uint8_t i;
+	int i;
 
-	dst->type = BT_UUID128;
+	for (i = 0; i < 16; i++) {
+		/* ignore minimal uuid (16) value */
+		if (i == 12 || i == 13)
+			continue;
 
-	for (i = 0; i < 16; i++)
-		dst->value.u128.data[i] = uuid[15 - i];
+		if (uuid[i] != BLUETOOTH_UUID[i])
+			return false;
+	}
+
+	return true;
+}
+
+static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
+{
+	if (is_bluetooth_uuid(uuid)) {
+		/* copy 16 bit uuid value from full android 128bit uuid */
+		dst->type = BT_UUID16;
+		dst->value.u16 = (uuid[13] << 8) + uuid[12];
+	} else {
+		uint8_t i;
+		dst->type = BT_UUID128;
+		for (i = 0; i < 16; i++)
+			dst->value.u128.data[i] = uuid[15 - i];
+	}
 }
 
 static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
-- 
1.9.2

