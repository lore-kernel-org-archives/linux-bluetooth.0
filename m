Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Rework API
Date: Mon,  3 Nov 2014 18:06:16 +0200
Message-Id: <1415030776-5440-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Send as RFC to collect for feedback regarding API decisions, the
question is if we shall expose gatt_db_service or let the user access
it via gatt_db_attrib since it is quite easy to access it internally.

Either way this will end up in heavy changes to android/gatt.c since it
is very dependent on access by handle.
---
 src/shared/gatt-db.h | 97 ++++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 15be67f..4d9bfc1 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -22,43 +22,62 @@
  */
 
 struct gatt_db;
+struct gatt_db_service;
+struct gatt_db_attribute;
 
 struct gatt_db *gatt_db_new(void);
 void gatt_db_destroy(struct gatt_db *db);
 
-uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
-					bool primary, uint16_t num_handles);
-bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
+struct gatt_db_service *gatt_db_add_service(struct gatt_db *db,
+						const bt_uuid_t *uuid,
+						bool primary,
+						uint16_t num_handles);
+bool gatt_db_remove_service(struct gatt_db *db,
+					struct gatt_db_service *service);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
-					void *user_data);
+uint16_t gatt_db_service_get_handle(struct gatt_db_service *service);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
+typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
+					int err, uint8_t *value, size_t length,
 					void *user_data);
 
-uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						uint8_t properties,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data);
+typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
+				uint16_t offset, uint8_t opcode,
+				bdaddr_t *bdaddr,
+				gatt_db_attribute_read_t func, void *func_data,
+				void *user_data);
 
-uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data);
+typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
+						int err, void *user_data);
+
+typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
+				uint16_t offset, const uint8_t *value,
+				size_t len, uint8_t opcode, bdaddr_t *bdaddr,
+				gatt_db_attribute_write_t func, void *func_data,
+				void *user_data);
+
+struct gatt_db_attribute *
+gatt_db_service_add_characteristic(struct gatt_db_service *service,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
 
-uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
-						uint16_t included_handle);
+struct gatt_db_attribute *
+gatt_db_service_add_descriptor(struct gatt_db_service *service,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
+
+struct gatt_db_attribute *
+gatt_db_service_add_included(struct gatt_db_service *service,
+					struct gatt_db_service *include);
 
-bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
-								bool active);
+bool gatt_db_service_set_active(struct gatt_db_service *service, bool active);
 
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
@@ -79,25 +98,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue);
 
-bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
-					uint8_t **value, int *length);
-
-bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr);
-
-const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
-							uint16_t handle);
-
-uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
-bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
-							bt_uuid_t *uuid);
-
-bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
-							uint32_t *permissions);
-
-struct gatt_db_attribute;
 
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
@@ -116,17 +116,10 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
 							uint32_t *permissions);
 
-typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
-					int err, uint8_t *value, size_t length,
-					void *user_data);
-
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
 				gatt_db_attribute_read_t func, void *user_data);
 
-typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
-						int err, void *user_data);
-
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
-- 
1.9.3

