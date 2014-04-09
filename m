Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 04/16] gatt: Remove service functionality
Date: Wed,  9 Apr 2014 09:07:02 +0200
Message-Id: <1397027234-12003-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will remove service with given handle and its attributes.
---
 src/shared/gatt-db.c | 21 +++++++++++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 15e2f95..3ff017c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -51,6 +51,13 @@ struct gatt_db_service {
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
@@ -169,3 +176,17 @@ uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
 
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
index 7c03013..f543a87 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -34,3 +34,5 @@ void gatt_db_destroy(struct gatt_db *db);
 uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					enum gatt_db_service_type service_type,
 					uint16_t num_handles);
+
+bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
-- 
1.8.5.3

