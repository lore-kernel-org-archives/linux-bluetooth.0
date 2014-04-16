Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] android/gatt: Extend android2uuid uuid type support
Date: Wed, 16 Apr 2014 16:52:51 +0200
Message-Id: <1397659972-19065-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now conversion function android2uuid can recognize type of uuid and set
it value by copying significant bytes.
---
 android/gatt.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f52cb36..30530f7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,13 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+#define BASE_UUID16_OFFSET	12
+
+static uint8_t BLUETOOTH_UUID[] = {
+	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
@@ -134,14 +141,35 @@ static struct queue *listen_clients = NULL;
 
 static void bt_le_discovery_stop_cb(void);
 
+static int get_type_from_android_uuid(const uint8_t *uuid)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		/* ignore minimal uuid (16) value */
+		if (i == 12 || i == 13)
+			continue;
+
+		if (uuid[i] != BLUETOOTH_UUID[i])
+			return BT_UUID128;
+	}
+
+	return BT_UUID16;
+}
+
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
 {
 	uint8_t i;
 
-	dst->type = BT_UUID128;
+	dst->type = get_type_from_android_uuid(uuid);
 
-	for (i = 0; i < 16; i++)
-		dst->value.u128.data[i] = uuid[15 - i];
+	if (dst->type == BT_UUID16) {
+		/* copy 16 bit uuid value from full android 128bit uuid */
+		dst->value.u16 = (uuid[13] << 8) + uuid[12];
+	} else {
+		for (i = 0; i < 16; i++)
+			dst->value.u128.data[i] = uuid[15 - i];
+	}
 }
 
 static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
-- 
1.9.1

