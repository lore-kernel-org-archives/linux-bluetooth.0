Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/gatt: Extend android2uuid uuid type support
Date: Wed, 16 Apr 2014 12:06:52 +0200
Message-Id: <1397642813-18424-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now conversion function android2uuid can recognize type of uuid and set
it value by copying significant bytes.
---
 android/gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 243e02f..9163f6d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,14 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+#define BASE_UUID16_OFFSET	12
+#define BASE_UUID32_OFFSET	10
+
+static uint8_t BLUETOOTH_UUID[] = {
+	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
@@ -132,14 +140,48 @@ static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
 static void bt_le_discovery_stop_cb(void);
 
+static int get_type_from_android_uuid(const uint8_t *uuid)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		/* minimal uuid (16) value */
+		if (i == 12 || i == 13)
+			continue;
+
+		if (uuid[i] != BLUETOOTH_UUID[i])
+			break;
+	}
+
+	if (i < 12)
+		return BT_UUID128;
+	if (i < 14)
+		return BT_UUID32;
+	return BT_UUID16;
+}
+
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
 {
 	uint8_t i;
 
-	dst->type = BT_UUID128;
-
-	for (i = 0; i < 16; i++)
-		dst->value.u128.data[i] = uuid[15 - i];
+	dst->type = get_type_from_android_uuid(uuid);
+
+	switch (dst->type) {
+	case BT_UUID16:
+		memcpy(&dst->value.u16, &uuid[BASE_UUID16_OFFSET],
+							sizeof(dst->value.u16));
+		break;
+	case BT_UUID32:
+		memcpy(&dst->value.u32, &uuid[BASE_UUID32_OFFSET],
+							sizeof(dst->value.u32));
+		break;
+	case BT_UUID128:
+		for (i = 0; i < 16; i++)
+			dst->value.u128.data[i] = uuid[15 - i];
+		break;
+	default:
+		error("gatt: Wrong uuid type");
+	}
 }
 
 static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
-- 
1.9.1

