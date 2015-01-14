Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 6/8] shared/gatt-db: Add "claimed" field to services
Date: Tue, 13 Jan 2015 19:31:05 -0800
Message-Id: <1421206267-26369-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1421206267-26369-1-git-send-email-armansito@chromium.org>
References: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the ability to mark a service as "claimed". This is distinct from
"active", which denotes whether this service should be accessed at all
and is tied to the service added/removed events.
---
 src/shared/gatt-db.c | 20 ++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index e8fb52c..a1b3ffd 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -102,6 +102,7 @@ struct gatt_db_attribute {
 struct gatt_db_service {
 	struct gatt_db *db;
 	bool active;
+	bool claimed;
 	uint16_t num_handles;
 	struct gatt_db_attribute **attributes;
 };
@@ -786,6 +787,25 @@ bool gatt_db_service_get_active(struct gatt_db_attribute *attrib)
 	return attrib->service->active;
 }
 
+bool gatt_db_service_set_claimed(struct gatt_db_attribute *attrib,
+								bool claimed)
+{
+	if (!attrib)
+		return false;
+
+	attrib->service->claimed = claimed;
+
+	return true;
+}
+
+bool gatt_db_service_get_claimed(struct gatt_db_attribute *attrib)
+{
+	if (!attrib)
+		return false;
+
+	return attrib->service->claimed;
+}
+
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index dc1b819..a47882b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -83,6 +83,10 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active);
 bool gatt_db_service_get_active(struct gatt_db_attribute *attrib);
 
+bool gatt_db_service_set_claimed(struct gatt_db_attribute *attrib,
+								bool claimed);
+bool gatt_db_service_get_claimed(struct gatt_db_attribute *attrib);
+
 typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
 							void *user_data);
 
-- 
2.2.0.rc0.207.ga3a616c

