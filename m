Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 34/62] lib: Fix UUID 16/32-bits to 128-bit conversion
Date: Thu, 20 Mar 2014 11:42:59 -0300
Message-Id: <1395326607-27068-35-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

16 and 32-bit UUIDs are always created using host order. However,
no matter the system type, 128-bit UUID must use big-endian byte
order format (similar to human-readble format).
---
 lib/uuid.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index dbca330..0d3b204 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -30,9 +30,9 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#include "src/shared/util.h"
 #include "uuid.h"
 
-#if __BYTE_ORDER == __BIG_ENDIAN
 static uint128_t bluetooth_base_uuid = {
 	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
@@ -41,24 +41,17 @@ static uint128_t bluetooth_base_uuid = {
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
 	dst->value.u128 = bluetooth_base_uuid;
 	dst->type = BT_UUID128;
 
-	memcpy(&dst->value.u128.data[BASE_UUID16_OFFSET],
-			&src->value.u16, sizeof(src->value.u16));
+	/*
+	 * No matter the system: 128-bit UUIDs should be stored
+	 * as big-endian. 16-bit UUIDs are stored on host order.
+	 */
+
+	put_be16(src->value.u16, &dst->value.u128.data[BASE_UUID16_OFFSET]);
 }
 
 static void bt_uuid32_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
@@ -66,8 +59,12 @@ static void bt_uuid32_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 	dst->value.u128 = bluetooth_base_uuid;
 	dst->type = BT_UUID128;
 
-	memcpy(&dst->value.u128.data[BASE_UUID32_OFFSET],
-				&src->value.u32, sizeof(src->value.u32));
+	/*
+	 * No matter the system: 128-bit UUIDs should be stored
+	 * as big-endian. 32-bit UUIDs are stored on host order.
+	 */
+
+	put_be32(src->value.u32, &dst->value.u128.data[BASE_UUID32_OFFSET]);
 }
 
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
-- 
1.8.3.1

