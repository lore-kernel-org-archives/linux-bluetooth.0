Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 05/15] shared/gatt-db: Make accessors work on const ptr
Date: Mon,  8 Dec 2014 16:40:45 -0800
Message-Id: <1418085655-7304-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Made gatt_db_attribute accessor functions accept a const pointer.
---
 src/shared/gatt-db.c | 22 ++++++++++++----------
 src/shared/gatt-db.h | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 37ec946..379b4ad 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1151,7 +1151,8 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 	return service->attributes[handle - service_handle];
 }
 
-const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
+const bt_uuid_t *gatt_db_attribute_get_type(
+					const struct gatt_db_attribute *attrib)
 {
 	if (!attrib)
 		return NULL;
@@ -1159,7 +1160,7 @@ const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
 	return &attrib->uuid;
 }
 
-uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib)
+uint16_t gatt_db_attribute_get_handle(const struct gatt_db_attribute *attrib)
 {
 	if (!attrib)
 		return 0;
@@ -1167,7 +1168,7 @@ uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib)
 	return attrib->handle;
 }
 
-bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid)
 {
 	struct gatt_db_service *service;
@@ -1198,9 +1199,10 @@ bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
 	return false;
 }
 
-bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
-							uint16_t *start_handle,
-							uint16_t *end_handle)
+bool gatt_db_attribute_get_service_handles(
+					const struct gatt_db_attribute *attrib,
+					uint16_t *start_handle,
+					uint16_t *end_handle)
 {
 	struct gatt_db_service *service;
 
@@ -1214,7 +1216,7 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 	return true;
 }
 
-bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle,
 							bool *primary,
@@ -1244,7 +1246,7 @@ bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
 	return le_to_uuid(decl->value, decl->value_len, uuid);
 }
 
-bool gatt_db_attribute_get_char_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
 							uint8_t *properties,
@@ -1281,7 +1283,7 @@ bool gatt_db_attribute_get_char_data(struct gatt_db_attribute *attrib,
 	return le_to_uuid(attrib->value + 3, attrib->value_len - 3, uuid);
 }
 
-bool gatt_db_attribute_get_incl_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *start_handle,
 							uint16_t *end_handle)
@@ -1317,7 +1319,7 @@ bool gatt_db_attribute_get_incl_data(struct gatt_db_attribute *attrib,
 	return true;
 }
 
-bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib,
 							uint32_t *permissions)
 {
 	if (!attrib || !permissions)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 987ccf4..b9f12e3 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -139,35 +139,37 @@ bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
 
-const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib);
+const bt_uuid_t *gatt_db_attribute_get_type(
+					const struct gatt_db_attribute *attrib);
 
-uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib);
+uint16_t gatt_db_attribute_get_handle(const struct gatt_db_attribute *attrib);
 
-bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid);
 
-bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
-						uint16_t *start_handle,
-						uint16_t *end_handle);
+bool gatt_db_attribute_get_service_handles(
+					const struct gatt_db_attribute *attrib,
+					uint16_t *start_handle,
+					uint16_t *end_handle);
 
-bool gatt_db_attribute_get_service_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle,
 							bool *primary,
 							bt_uuid_t *uuid);
 
-bool gatt_db_attribute_get_char_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
 							uint8_t *properties,
 							bt_uuid_t *uuid);
 
-bool gatt_db_attribute_get_incl_data(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *start_handle,
 							uint16_t *end_handle);
 
-bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
+bool gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib,
 							uint32_t *permissions);
 
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
-- 
2.2.0.rc0.207.ga3a616c

