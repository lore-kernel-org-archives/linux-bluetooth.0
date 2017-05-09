Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/10] shared/gatt-db: Add gatt_db_insert_characteristic
Date: Tue,  9 May 2017 23:48:37 +0300
Message-Id: <20170509204840.3270-8-luiz.dentz@gmail.com>
In-Reply-To: <20170509204840.3270-1-luiz.dentz@gmail.com>
References: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces gatt_db_insert_characteristic which is similar to
gatt_db_service_insert_charactersitic but doesn't require the caller to
know the service where the attribute should be inserted.
---
 src/shared/gatt-db.c | 22 ++++++++++++++++++++++
 src/shared/gatt-db.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 376e705..39892ee 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -733,6 +733,28 @@ service_insert_characteristic(struct gatt_db_service *service,
 }
 
 struct gatt_db_attribute *
+gatt_db_insert_characteristic(struct gatt_db *db,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
+	struct gatt_db_attribute *attrib;
+
+	attrib = gatt_db_get_service(db, handle);
+	if (!attrib)
+		return NULL;
+
+	return service_insert_characteristic(attrib->service, handle, uuid,
+						permissions, properties,
+						read_func, write_func,
+						user_data);
+}
+
+struct gatt_db_attribute *
 gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index fa7897b..6c1ce7a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -78,6 +78,16 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					void *user_data);
 
 struct gatt_db_attribute *
+gatt_db_insert_characteristic(struct gatt_db *db,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
+
+struct gatt_db_attribute *
 gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
-- 
2.9.3

