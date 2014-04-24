Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/4] gatt: Add remove_service function to gatt-db
Date: Thu, 24 Apr 2014 13:23:47 +0200
Message-Id: <1398338627-32588-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will remove service with given handle. Return true if service
was found and removed, otherwise false.
---
 src/shared/gatt-db.c | 21 +++++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5e478d6..0d3b338 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -50,6 +50,13 @@ struct gatt_db_service {
 	struct gatt_db_attribute **attributes;
 };
 
+static bool match_service_by_handle(const void *data, const void *user_data)
+{
+	const struct gatt_db_service *service = data;
+
+	return service->attributes[0]->handle == PTR_TO_INT(user_data);
+}
+
 struct gatt_db *gatt_db_new(void)
 {
 	struct gatt_db *db;
@@ -170,3 +177,17 @@ uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
 
 	return service->attributes[0]->handle;
 }
+
+bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle)
+{
+	struct gatt_db_service *service;
+
+	service = queue_remove_if(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	gatt_db_service_destroy(service);
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index ee9178a..765e582 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -28,3 +28,4 @@ void gatt_db_destroy(struct gatt_db *db);
 
 uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
+bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
-- 
1.8.5.3

