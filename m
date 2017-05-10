Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/3] shared/gatt-db: Remove services with match function
Date: Wed, 10 May 2017 21:41:35 +0200
Message-Id: <1494445297-11552-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow remove services using match callback.
---
 src/shared/gatt-db.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8ef6f3b..ded7561 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -408,6 +408,47 @@ bool gatt_db_remove_service(struct gatt_db *db,
 	return true;
 }
 
+struct remove_services_data {
+	gatt_db_attribute_match_cb_t func;
+	void *user_data;
+};
+
+static bool remove_services_match(const void *data, const void *match_data)
+{
+	const struct remove_services_data *remove_svc_data = match_data;
+	const struct gatt_db_service *service = data;
+	struct gatt_db_attribute *attrib = service->attributes[0];
+
+	return remove_svc_data->func(attrib, remove_svc_data->user_data);
+}
+
+bool gatt_db_remove_services(struct gatt_db *db,
+					gatt_db_attribute_match_cb_t func,
+					void *user_data)
+{
+	if (!db)
+		return false;
+
+	if (func) {
+		struct remove_services_data remove_services_data = {
+			.func = func,
+			.user_data = user_data,
+		};
+
+		queue_remove_all(db->services, remove_services_match,
+						&remove_services_data,
+						gatt_db_service_destroy);
+	} else {
+		queue_remove_all(db->services, NULL, NULL,
+						gatt_db_service_destroy);
+	}
+
+	if (gatt_db_isempty(db))
+		db->next_handle = 0;
+
+	return true;
+}
+
 bool gatt_db_clear(struct gatt_db *db)
 {
 	return gatt_db_clear_range(db, 1, UINT16_MAX);
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 134ec63..4e049cd 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -38,6 +38,13 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 
 bool gatt_db_remove_service(struct gatt_db *db,
 					struct gatt_db_attribute *attrib);
+
+typedef bool (*gatt_db_attribute_match_cb_t)(struct gatt_db_attribute *attrib,
+							void *user_data);
+
+bool gatt_db_remove_services(struct gatt_db *db,
+					gatt_db_attribute_match_cb_t func,
+					void *user_data);
 bool gatt_db_clear(struct gatt_db *db);
 bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle);
-- 
2.4.3

