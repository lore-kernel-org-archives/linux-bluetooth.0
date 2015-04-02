Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] shared/gatt-db: Convert uuid32 to uuid128 in le_to_uuid
Date: Thu,  2 Apr 2015 13:15:28 +0200
Message-Id: <1427973328-22329-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch refactor le_to_uuid function and convert 32-bit uuid value to
128-bit value then swap bytes. This is needed since we don't handle
32-bit uuid values.
---
 src/shared/gatt-db.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f103c5a..295d6cc 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -337,25 +337,25 @@ bool gatt_db_isempty(struct gatt_db *db)
 
 static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
 {
+	bt_uuid_t uuid128, uuid32;
 	uint128_t u128;
 
-	if (len == 2) {
+	switch (len) {
+	case 2:
 		bt_uuid16_create(uuid, get_le16(src));
 		return true;
-	}
-
-	if (len == 4) {
-		bt_uuid32_create(uuid, get_le32(src));
+	case 4:
+		bt_uuid32_create(&uuid32, get_le32(src));
+		bt_uuid_to_uuid128(&uuid32, &uuid128);
+		src = uuid128.value.u128.data;
+		/* Fallthrough */
+	case 16:
+		bswap_128(src, &u128);
+		bt_uuid128_create(uuid, u128);
 		return true;
-	}
-
-	if (len != 16)
+	default:
 		return false;
-
-	bswap_128(src, &u128);
-	bt_uuid128_create(uuid, u128);
-
-	return true;
+	}
 }
 
 static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
-- 
2.1.0

