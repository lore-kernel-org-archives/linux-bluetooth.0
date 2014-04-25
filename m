Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/4] gatt: Add method to set service active
Date: Fri, 25 Apr 2014 14:28:44 +0200
Message-Id: <1398428924-6304-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will set active flag in database. Only active
services can be read by client from database. This falg will be
checked when remote will read attributes from this database.
Non-active services won't be exposed.
---
 src/shared/gatt-db.c | 16 ++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 6c72c7c..96e58be 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -57,6 +57,7 @@ struct gatt_db_attribute {
 };
 
 struct gatt_db_service {
+	bool active;
 	uint16_t num_handles;
 	struct gatt_db_attribute **attributes;
 };
@@ -368,3 +369,18 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 
 	return update_attribute_handle(service, index);
 }
+
+bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
+								bool active)
+{
+	struct gatt_db_service *service;
+
+	service = queue_find(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	service->active = active;
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 05623ca..fa86870 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -54,3 +54,6 @@ uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
 
 uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 						uint16_t included_handle);
+
+bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
+								bool active);
-- 
1.8.5.3

