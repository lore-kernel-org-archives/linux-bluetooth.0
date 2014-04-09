Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/16] gatt: Add start/stop service functionality
Date: Wed,  9 Apr 2014 09:07:11 +0200
Message-Id: <1397027234-12003-14-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only active services can be read by client.
---
 src/shared/gatt-db.c | 28 ++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2886bb8..976885a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -358,3 +358,31 @@ uint16_t gatt_db_new_included_service(struct gatt_db *db, uint16_t handle,
 
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
index a421e9e..ff371e6 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -61,3 +61,7 @@ uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
 
 uint16_t gatt_db_new_included_service(struct gatt_db *db, uint16_t handle,
 						uint16_t included_handle);
+
+bool gatt_db_start_service(struct gatt_db *db, uint16_t handle);
+
+bool gatt_db_stop_service(struct gatt_db *db, uint16_t handle);
-- 
1.8.5.3

