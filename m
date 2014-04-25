Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] gatt: Add start/stop service functionality
Date: Fri, 25 Apr 2014 11:01:12 +0200
Message-Id: <1398416472-7852-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These functions will set active flag in database. Only active
services can be read by client from database.
---
 src/shared/gatt-db.c | 29 +++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index abb5f61..14c7159 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -57,6 +57,7 @@ struct gatt_db_attribute {
 };
 
 struct gatt_db_service {
+	bool active;
 	uint16_t num_handles;
 	struct gatt_db_attribute **attributes;
 };
@@ -359,3 +360,31 @@ uint16_t gatt_db_new_included_service(struct gatt_db *db, uint16_t handle,
 
 	return update_attribute_handle(service, index);
 }
+
+bool gatt_db_start_service(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_service *service;
+
+	service = queue_find(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	service->active = true;
+
+	return true;
+}
+
+bool gatt_db_stop_service(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_service *service;
+
+	service = queue_find(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	service->active = false;
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index cdbbf36..040c3fb 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -54,3 +54,7 @@ uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
 
 uint16_t gatt_db_new_included_service(struct gatt_db *db, uint16_t handle,
 						uint16_t included_handle);
+
+bool gatt_db_start_service(struct gatt_db *db, uint16_t handle);
+
+bool gatt_db_stop_service(struct gatt_db *db, uint16_t handle);
-- 
1.8.5.3

