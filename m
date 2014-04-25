Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/4] gatt: Add included service functionality
Date: Fri, 25 Apr 2014 14:28:43 +0200
Message-Id: <1398428924-6304-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will add included service to service attribute list. It will first
look for included service and then create attribute. In case of error
or if there is no free handle, 0 will be returned.
---
 src/shared/gatt-db.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5e98e3b..6c72c7c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -29,6 +29,7 @@
 #include "src/shared/gatt-db.h"
 
 #define MAX_CHAR_DECL_VALUE_LEN 19
+#define MAX_INCLUDED_VALUE_LEN 6
 
 static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_PRIM_SVC_UUID };
@@ -36,6 +37,8 @@ static const bt_uuid_t secondary_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_SND_SVC_UUID };
 static const bt_uuid_t characteristic_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_CHARAC_UUID };
+static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
+					.value.u16 = GATT_INCLUDE_UUID };
 
 struct gatt_db {
 	uint16_t next_handle;
@@ -321,3 +324,47 @@ uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
 
 	return update_attribute_handle(service, i);
 }
+
+uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
+						uint16_t included_handle)
+{
+	struct gatt_db_service *included_service;
+	uint8_t value[MAX_INCLUDED_VALUE_LEN];
+	uint16_t len = 0;
+	struct gatt_db_service *service;
+	int index;
+
+	service = queue_find(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return 0;
+
+	included_service = queue_find(db->services, match_service_by_handle,
+						INT_TO_PTR(included_handle));
+
+	if (!included_service)
+		return 0;
+
+	put_le16(included_handle, &value[0]);
+	len += sizeof(uint16_t);
+	put_le16(included_handle + included_service->num_handles - 1,
+							&value[2]);
+	len += sizeof(uint16_t);
+	/* Check if is service uuid is bluetooth uuid. If not, don't add it*/
+	if (included_service->attributes[0]->val_len == sizeof(uint16_t)) {
+		memcpy(&value[4], included_service->attributes[0]->value,
+				included_service->attributes[0]->val_len);
+		len += included_service->attributes[0]->val_len;
+	}
+
+	index = get_attribute_index(service, 0);
+	if (!index)
+		return 0;
+
+	service->attributes[index] = new_attribute(&included_service_uuid,
+								value, len);
+	if (!service->attributes[index])
+		return 0;
+
+	return update_attribute_handle(service, index);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index c4ad215..05623ca 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -51,3 +51,6 @@ uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
 						gatt_db_read_t read_func,
 						gatt_db_write_t write_func,
 						void *user_data);
+
+uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
+						uint16_t included_handle);
-- 
1.8.5.3

