Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 1/8] shared/gatt-db: Add service getter by UUID
Date: Tue, 13 Jan 2015 19:31:00 -0800
Message-Id: <1421206267-26369-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1421206267-26369-1-git-send-email-armansito@chromium.org>
References: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added gatt_db_get_service_with_uuid which checks if the database
contains a service with the given UUID and returns the first result.
---
 src/shared/gatt-db.c | 26 ++++++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index e4a6f73..e8fb52c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1179,6 +1179,32 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 	return service->attributes[handle - service_handle];
 }
 
+static bool find_service_with_uuid(const void *data, const void *user_data)
+{
+	const struct gatt_db_service *service = data;
+	const bt_uuid_t *uuid = user_data;
+	bt_uuid_t svc_uuid;
+
+	gatt_db_attribute_get_service_uuid(service->attributes[0], &svc_uuid);
+
+	return bt_uuid_cmp(uuid, &svc_uuid) == 0;
+}
+
+struct gatt_db_attribute *gatt_db_get_service_with_uuid(struct gatt_db *db,
+							const bt_uuid_t *uuid)
+{
+	struct gatt_db_service *service;
+
+	if (!db || !uuid)
+		return NULL;
+
+	service = queue_find(db->services, find_service_with_uuid, uuid);
+	if (!service)
+		return NULL;
+
+	return service->attributes[0];
+}
+
 const bt_uuid_t *gatt_db_attribute_get_type(
 					const struct gatt_db_attribute *attrib)
 {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 1f4005e..dc1b819 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -151,6 +151,9 @@ bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
 
+struct gatt_db_attribute *gatt_db_get_service_with_uuid(struct gatt_db *db,
+							const bt_uuid_t *uuid);
+
 const bt_uuid_t *gatt_db_attribute_get_type(
 					const struct gatt_db_attribute *attrib);
 
-- 
2.2.0.rc0.207.ga3a616c

