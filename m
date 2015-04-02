Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] shared/gatt-db: Use lib/uuid uuid_to_le function
Date: Thu,  2 Apr 2015 13:15:27 +0200
Message-Id: <1427973328-22329-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replace internal function uuid_to_le with lib/uuid function
which does the same.
---
 src/shared/gatt-db.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2b2090c..f103c5a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -335,20 +335,6 @@ bool gatt_db_isempty(struct gatt_db *db)
 	return queue_isempty(db->services);
 }
 
-static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
-{
-	bt_uuid_t uuid128;
-
-	if (uuid->type == BT_UUID16) {
-		put_le16(uuid->value.u16, dst);
-		return bt_uuid_len(uuid);
-	}
-
-	bt_uuid_to_uuid128(uuid, &uuid128);
-	bswap_128(&uuid128.value.u128, dst);
-	return bt_uuid_len(&uuid128);
-}
-
 static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
 {
 	uint128_t u128;
@@ -400,7 +386,7 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 	else
 		type = &secondary_service_uuid;
 
-	len = uuid_to_le(uuid, value);
+	len = bt_uuid_to_le(uuid, value);
 
 	service->attributes[0] = new_attribute(service, handle, type, value,
 									len);
@@ -698,7 +684,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 	/* We set handle of characteristic value, which will be added next */
 	put_le16(handle, &value[1]);
 	len += sizeof(uint16_t);
-	len += uuid_to_le(uuid, &value[3]);
+	len += bt_uuid_to_le(uuid, &value[3]);
 
 	service->attributes[i] = new_attribute(service, handle - 1,
 							&characteristic_uuid,
-- 
2.1.0

