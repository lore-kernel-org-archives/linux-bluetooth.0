Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 09/22] lib: Fix UUID 16/32-bits to 128-bit conversion
Date: Mon, 24 Mar 2014 16:25:30 -0300
Message-Id: <1395689143-11091-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

16 and 32-bit UUIDs are always created using host order. However,
no matter the system type, 128-bit UUID must use big-endian byte
order format (similar to human-readble format).
---
 lib/uuid.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index dbca330..5c3f986 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -32,7 +32,6 @@
 
 #include "uuid.h"
 
-#if __BYTE_ORDER == __BIG_ENDIAN
 static uint128_t bluetooth_base_uuid = {
 	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
@@ -41,33 +40,36 @@ static uint128_t bluetooth_base_uuid = {
 #define BASE_UUID16_OFFSET	2
 #define BASE_UUID32_OFFSET	0
 
-#else
-static uint128_t bluetooth_base_uuid = {
-	.data = {	0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
-			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
-};
-
-#define BASE_UUID16_OFFSET	12
-#define BASE_UUID32_OFFSET	BASE_UUID16_OFFSET
-
-#endif
-
 static void bt_uuid16_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 {
+	uint16_t be16;
+
 	dst->value.u128 = bluetooth_base_uuid;
 	dst->type = BT_UUID128;
 
-	memcpy(&dst->value.u128.data[BASE_UUID16_OFFSET],
-			&src->value.u16, sizeof(src->value.u16));
+	/*
+	 * No matter the system: 128-bit UUIDs should be stored
+	 * as big-endian. 16-bit UUIDs are stored on host order.
+	 */
+
+	be16 = htons(src->value.u16);
+	memcpy(&dst->value.u128.data[BASE_UUID16_OFFSET], &be16, sizeof(be16));
 }
 
 static void bt_uuid32_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 {
+	uint32_t be32;
+
 	dst->value.u128 = bluetooth_base_uuid;
 	dst->type = BT_UUID128;
 
-	memcpy(&dst->value.u128.data[BASE_UUID32_OFFSET],
-				&src->value.u32, sizeof(src->value.u32));
+	/*
+	 * No matter the system: 128-bit UUIDs should be stored
+	 * as big-endian. 32-bit UUIDs are stored on host order.
+	 */
+
+	be32 = htonl(src->value.u32);
+	memcpy(&dst->value.u128.data[BASE_UUID32_OFFSET], &be32, sizeof(be32));
 }
 
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
-- 
1.8.3.1

