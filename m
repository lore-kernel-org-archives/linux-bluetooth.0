Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] shared/gatt-db: Use bt_uuid_to_le instead of local function
Date: Fri, 27 Mar 2015 16:39:19 +0100
Message-Id: <1427470759-30114-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427470759-30114-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427470759-30114-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch use lib/uuid library for uuids instead of local functions.
---
 src/shared/gatt-db.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2b2090c..323ce91 100644
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
@@ -379,8 +365,8 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 {
 	struct gatt_db_service *service;
 	const bt_uuid_t *type;
+	bt_uuid_t uuid128;
 	uint8_t value[16];
-	uint16_t len;
 
 	if (num_handles < 1)
 		return NULL;
@@ -400,10 +386,23 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 	else
 		type = &secondary_service_uuid;
 
-	len = uuid_to_le(uuid, value);
+	switch (uuid->type) {
+	case BT_UUID16:
+	case BT_UUID128:
+		bt_uuid_to_le(uuid, value);
+		break;
+	case BT_UUID32:
+		bt_uuid_to_uuid128(uuid, &uuid128);
+		bt_uuid_to_le(&uuid128, value);
+		break;
+	case BT_UUID_UNSPEC:
+	default:
+		gatt_db_service_destroy(service);
+		return NULL;
+	}
 
 	service->attributes[0] = new_attribute(service, handle, type, value,
-									len);
+								uuid->type/8);
 	if (!service->attributes[0]) {
 		gatt_db_service_destroy(service);
 		return NULL;
@@ -698,7 +697,8 @@ service_insert_characteristic(struct gatt_db_service *service,
 	/* We set handle of characteristic value, which will be added next */
 	put_le16(handle, &value[1]);
 	len += sizeof(uint16_t);
-	len += uuid_to_le(uuid, &value[3]);
+	len += uuid->type/8;
+	bt_uuid_to_le(uuid, &value[3]);
 
 	service->attributes[i] = new_attribute(service, handle - 1,
 							&characteristic_uuid,
-- 
2.1.0

