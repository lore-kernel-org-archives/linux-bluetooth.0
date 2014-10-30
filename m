Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/9] shared/gatt-db: Add gatt_db_attribute_get_service_uuid
Date: Thu, 30 Oct 2014 15:57:40 +0200
Message-Id: <1414677465-19862-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 87a0653..bb69032 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -46,6 +46,7 @@ struct gatt_db {
 };
 
 struct gatt_db_attribute {
+	struct gatt_db_service *service;
 	uint16_t handle;
 	bt_uuid_t uuid;
 	uint32_t permissions;
@@ -70,7 +71,8 @@ static bool match_service_by_handle(const void *data, const void *user_data)
 	return service->attributes[0]->handle == PTR_TO_UINT(user_data);
 }
 
-static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
+static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
+							const bt_uuid_t *type,
 							const uint8_t *val,
 							uint16_t len)
 {
@@ -80,6 +82,7 @@ static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
 	if (!attribute)
 		return NULL;
 
+	attribute->service = service;
 	attribute->uuid = *type;
 	attribute->value_len = len;
 	if (len) {
@@ -187,7 +190,7 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 
 	len = uuid_to_le(uuid, value);
 
-	service->attributes[0] = new_attribute(type, value, len);
+	service->attributes[0] = new_attribute(service, type, value, len);
 	if (!service->attributes[0]) {
 		gatt_db_service_destroy(service);
 		return 0;
@@ -297,14 +300,14 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 	len += sizeof(uint16_t);
 	len += uuid_to_le(uuid, &value[3]);
 
-	service->attributes[i] = new_attribute(&characteristic_uuid, value,
-									len);
+	service->attributes[i] = new_attribute(service, &characteristic_uuid,
+								value, len);
 	if (!service->attributes[i])
 		return 0;
 
 	update_attribute_handle(service, i++);
 
-	service->attributes[i] = new_attribute(uuid, NULL, 0);
+	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
 	if (!service->attributes[i]) {
 		free(service->attributes[i - 1]);
 		return 0;
@@ -335,7 +338,7 @@ uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
 	if (!i)
 		return 0;
 
-	service->attributes[i] = new_attribute(uuid, NULL, 0);
+	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
 	if (!service->attributes[i])
 		return 0;
 
@@ -385,8 +388,9 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 	if (!index)
 		return 0;
 
-	service->attributes[index] = new_attribute(&included_service_uuid,
-								value, len);
+	service->attributes[index] = new_attribute(service,
+							&included_service_uuid,
+							value, len);
 	if (!service->attributes[index])
 		return 0;
 
@@ -848,6 +852,27 @@ const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
 bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid)
 {
+	if (!attrib || !uuid)
+		return false;
+
+	if (attrib->value_len == sizeof(uint16_t)) {
+		uint16_t value;
+
+		value = get_le16(attrib->value);
+		bt_uuid16_create(uuid, value);
+
+		return true;
+	}
+
+	if (attrib->value_len == sizeof(uint128_t)) {
+		uint128_t value;
+
+		bswap_128(attrib->value, &value);
+		bt_uuid128_create(uuid, value);
+
+		return true;
+	}
+
 	return false;
 }
 
-- 
1.9.3

