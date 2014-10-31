Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/9] shared/gatt-db: Expose gatt_db_attribute
Date: Fri, 31 Oct 2014 15:39:46 +0200
Message-Id: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is the new API to reduce the lookups in gatt_db and make it
a little bit more convenient for batch operations, so the general idea
is to be able to get a hold of it via gatt_db_get_attribute but also
replace the handles in the queues with proper attributes so the server
code don't have to lookup again when reading/writing, checking
permissions, or any other operation that can be done directly.
---
v2: Address problems gatt_db_attribute_read and gatt_db_attribute_write
pointed out by Arman.
v3: Allow gatt_db_attribute_read to work if offset equals to value length.
v4: Fix using attribute handle for service related operations.

 src/shared/gatt-db.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 6b5e84c..3ade7a9 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -802,3 +802,54 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 	return true;
 
 }
+
+struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
+							uint16_t handle)
+{
+	return NULL;
+}
+
+const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
+{
+	return NULL;
+}
+
+uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib)
+{
+	return 0;
+}
+
+bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
+							bt_uuid_t *uuid)
+{
+	return false;
+}
+
+bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
+						uint16_t *start_handle,
+						uint16_t *end_handle)
+{
+	return false;
+}
+
+bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
+							uint32_t *permissions)
+{
+	return false;
+}
+
+bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
+				uint8_t opcode, bdaddr_t *bdaddr,
+				gatt_db_attribute_read_t func, void *user_data)
+{
+	return false;
+}
+
+bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					gatt_db_attribute_write_t func,
+					void *user_data)
+{
+	return false;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 8d18434..15be67f 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -96,3 +96,39 @@ bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
 
 bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 							uint32_t *permissions);
+
+struct gatt_db_attribute;
+
+struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
+							uint16_t handle);
+
+const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib);
+
+uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib);
+
+bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
+							bt_uuid_t *uuid);
+
+bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
+						uint16_t *start_handle,
+						uint16_t *end_handle);
+
+bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
+							uint32_t *permissions);
+
+typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
+					int err, uint8_t *value, size_t length,
+					void *user_data);
+
+bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
+				uint8_t opcode, bdaddr_t *bdaddr,
+				gatt_db_attribute_read_t func, void *user_data);
+
+typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
+						int err, void *user_data);
+
+bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, bdaddr_t *bdaddr,
+					gatt_db_attribute_write_t func,
+					void *user_data);
-- 
1.9.3

