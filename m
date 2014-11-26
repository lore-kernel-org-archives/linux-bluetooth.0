Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/5] shared/gatt-db: Add gatt_db_insert_service function
Date: Wed, 26 Nov 2014 15:03:11 -0800
Message-Id: <1417042992-10142-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1417042992-10142-1-git-send-email-armansito@chromium.org>
References: <1417042992-10142-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the gatt_db_insert_service function which inserts a
service with a pre-defined handle into the database if the desired
handle range is available.

This is primarily meant to be used by gatt-client, since the handles
in a client database need to perfectly match those returned from a
remote server. This also allows client to handle "Service Changed"
events in which a newly found service can be inserted at the correct
location within the database.
---
 src/shared/gatt-db.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-db.h |   6 +++
 2 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index fe05595..0c24904 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -30,6 +30,10 @@
 #include "src/shared/timeout.h"
 #include "src/shared/gatt-db.h"
 
+#ifndef MAX
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
 #define MAX_CHAR_DECL_VALUE_LEN 19
 #define MAX_INCLUDED_VALUE_LEN 6
 #define ATTRIBUTE_TIMEOUT 1000
@@ -216,27 +220,26 @@ static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
 	return true;
 }
 
-struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
-						const bt_uuid_t *uuid,
-						bool primary,
-						uint16_t num_handles)
+static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
+							bool primary,
+							uint16_t num_handles)
 {
 	struct gatt_db_service *service;
 	const bt_uuid_t *type;
 	uint8_t value[16];
 	uint16_t len;
 
-	if (num_handles < 1 || (num_handles + db->next_handle) > UINT16_MAX)
-		return 0;
+	if (num_handles < 1)
+		return NULL;
 
 	service = new0(struct gatt_db_service, 1);
 	if (!service)
-		return 0;
+		return NULL;
 
 	service->attributes = new0(struct gatt_db_attribute *, num_handles);
 	if (!service->attributes) {
 		free(service);
-		return 0;
+		return NULL;
 	}
 
 	if (primary)
@@ -249,12 +252,29 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 	service->attributes[0] = new_attribute(service, type, value, len);
 	if (!service->attributes[0]) {
 		gatt_db_service_destroy(service);
-		return 0;
+		return NULL;
 	}
 
+	return service;
+}
+
+struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
+						const bt_uuid_t *uuid,
+						bool primary,
+						uint16_t num_handles)
+{
+	struct gatt_db_service *service;
+
+	if (!db || (num_handles + db->next_handle) > UINT16_MAX)
+		return NULL;
+
+	service = gatt_db_service_create(uuid, primary, num_handles);
+	if (!service)
+		return NULL;
+
 	if (!queue_push_tail(db->services, service)) {
 		gatt_db_service_destroy(service);
-		return 0;
+		return NULL;
 	}
 
 	/* TODO now we get next handle from database. We should first look
@@ -285,6 +305,88 @@ bool gatt_db_remove_service(struct gatt_db *db,
 	return true;
 }
 
+struct insert_loc_data {
+	struct gatt_db_service *cur;
+	uint16_t start, end;
+	bool fail;
+	bool done;
+};
+
+static void search_for_insert_loc(void *data, void *user_data)
+{
+	struct insert_loc_data *loc_data = user_data;
+	struct gatt_db_service *service = data;
+	uint16_t cur_start, cur_end;
+
+	if (loc_data->done)
+		return;
+
+	cur_start = service->attributes[0]->handle;
+	cur_end = service->attributes[0]->handle + service->num_handles - 1;
+
+	/* Abort if the requested range overlaps with an existing service. */
+	if ((loc_data->start >= cur_start && loc_data->start <= cur_end) ||
+		(loc_data->end >= cur_start && loc_data->end <= cur_end)) {
+		loc_data->fail = true;
+		loc_data->done = true;
+		return;
+	}
+
+	/* Check if this is where the service should be inserted. */
+	if (loc_data->end < cur_start) {
+		loc_data->done = true;
+		return;
+	}
+
+	loc_data->cur = service;
+}
+
+struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
+							uint16_t handle,
+							const bt_uuid_t *uuid,
+							bool primary,
+							uint16_t num_handles)
+{
+	struct insert_loc_data data;
+	struct gatt_db_service *service;
+
+	if (!db || num_handles < 1 || handle + num_handles > UINT16_MAX)
+		return NULL;
+
+	memset(&data, 0, sizeof(data));
+
+	data.start = handle;
+	data.end = handle + num_handles - 1;
+
+	queue_foreach(db->services, search_for_insert_loc, &data);
+
+	if (data.fail)
+		return NULL;
+
+	service = gatt_db_service_create(uuid, primary, num_handles);
+	if (!service)
+		return NULL;
+
+	if (data.cur) {
+		if (!queue_push_after(db->services, data.cur, service))
+			goto fail;
+	} else if (!queue_push_head(db->services, service)) {
+			goto fail;
+	}
+
+	service->attributes[0]->handle = handle;
+	service->num_handles = num_handles;
+
+	/* Fast-forward next_handle if the new service was added to the end */
+	db->next_handle = MAX(handle + num_handles + 1, db->next_handle);
+
+	return service->attributes[0];
+
+fail:
+	gatt_db_service_destroy(service);
+	return NULL;
+}
+
 static uint16_t get_attribute_index(struct gatt_db_service *service,
 							int end_offset)
 {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index c943ad2..c9e3b59 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -35,6 +35,12 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 bool gatt_db_remove_service(struct gatt_db *db,
 					struct gatt_db_attribute *attrib);
 
+struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
+							uint16_t handle,
+							const bt_uuid_t *uuid,
+							bool primary,
+							uint16_t num_handles);
+
 typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
-- 
2.2.0.rc0.207.ga3a616c

