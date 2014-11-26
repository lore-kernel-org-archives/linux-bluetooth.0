Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/5] shared/gatt-db: Add clear functions
Date: Tue, 25 Nov 2014 21:26:49 -0800
Message-Id: <1416979609-3056-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1416979609-3056-1-git-send-email-armansito@chromium.org>
References: <1416979609-3056-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces gatt_db_clear and gatt_db_clear_range functions
for removing services from the database.
---
 src/shared/gatt-db.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b5edd24..4bd1a99 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -303,6 +303,51 @@ bool gatt_db_remove_service(struct gatt_db *db,
 	return true;
 }
 
+bool gatt_db_clear(struct gatt_db *db)
+{
+	if (!db)
+		return false;
+
+	queue_remove_all(db->services, NULL, NULL, gatt_db_service_destroy);
+
+	db->next_handle = 0;
+
+	return true;
+}
+
+struct clear_range {
+	uint16_t start, end;
+};
+
+static bool match_range(const void *a, const void *b)
+{
+	const struct gatt_db_service *service = a;
+	const struct clear_range *range = b;
+	uint16_t svc_start, svc_end;
+
+	svc_start = service->attributes[0]->handle;
+	svc_end = service->attributes[0]->handle + service->num_handles - 1;
+
+	return svc_start <= range->end && svc_end >= range->start;
+}
+
+bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle)
+{
+	struct clear_range range;
+
+	if (!db)
+		return false;
+
+	range.start = start_handle;
+	range.end = end_handle;
+
+	queue_remove_all(db->services, match_range, &range,
+						gatt_db_service_destroy);
+
+	return true;
+}
+
 struct insert_loc_data {
 	struct gatt_db_service *cur;
 	uint16_t start, end;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 4830cbd..dfa641c 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -34,6 +34,9 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 
 bool gatt_db_remove_service(struct gatt_db *db,
 					struct gatt_db_attribute *attrib);
+bool gatt_db_clear(struct gatt_db *db);
+bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle);
 
 struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 							uint16_t handle,
-- 
2.2.0.rc0.207.ga3a616c

