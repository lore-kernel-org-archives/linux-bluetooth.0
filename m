Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 5/5] shared/gatt-db: manual iteration when appopriate
Date: Mon, 15 Dec 2014 17:03:36 -0800
Message-Id: <1418691816-40271-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Uses queue_get_entries where it is appopriate to do so: focus on
places where there are an unnecessary amount of extra iteration.
---
 src/shared/gatt-db.c | 150 +++++++++++++++++++++------------------------------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 98fb8a0..fce3854 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -444,39 +444,36 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 	return true;
 }
 
-struct insert_loc_data {
-	struct gatt_db_service *cur;
-	uint16_t start, end;
-	bool fail;
-	bool done;
-};
-
-static void search_for_insert_loc(void *data, void *user_data)
+static bool find_insert_loc(struct gatt_db *db, uint16_t start, uint16_t end,
+						struct gatt_db_service **after)
 {
-	struct insert_loc_data *loc_data = user_data;
-	struct gatt_db_service *service = data;
+	const struct queue_entry *services_entry;
+	struct gatt_db_service *service;
 	uint16_t cur_start, cur_end;
 
-	if (loc_data->done)
-		return;
+	*after = NULL;
 
-	gatt_db_service_get_handles(service, &cur_start, &cur_end);
+	services_entry = queue_get_entries(db->services);
 
-	/* Abort if the requested range overlaps with an existing service. */
-	if ((loc_data->start >= cur_start && loc_data->start <= cur_end) ||
-		(loc_data->end >= cur_start && loc_data->end <= cur_end)) {
-		loc_data->fail = true;
-		loc_data->done = true;
-		return;
-	}
+	while (services_entry) {
+		service = services_entry->data;
 
-	/* Check if this is where the service should be inserted. */
-	if (loc_data->end < cur_start) {
-		loc_data->done = true;
-		return;
+		gatt_db_service_get_handles(service, &cur_start, &cur_end);
+
+		if (start >= cur_start && start <= cur_end)
+			return false;
+
+		if (end >= cur_start && end <= cur_end)
+			return false;
+
+		if (end < cur_start)
+			return true;
+
+		*after = service;
+		services_entry = services_entry->next;
 	}
 
-	loc_data->cur = service;
+	return true;
 }
 
 struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
@@ -485,8 +482,9 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 							bool primary,
 							uint16_t num_handles)
 {
-	struct insert_loc_data data;
-	struct gatt_db_service *service;
+	struct gatt_db_service *service, *after;
+
+	after = NULL;
 
 	if (!db || handle < 1)
 		return NULL;
@@ -494,25 +492,19 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
 
-	memset(&data, 0, sizeof(data));
-
-	data.start = handle;
-	data.end = handle + num_handles - 1;
-
-	queue_foreach(db->services, search_for_insert_loc, &data);
-
-	if (data.fail)
+	if (!find_insert_loc(db, handle, handle + num_handles - 1, &after))
 		return NULL;
 
 	service = gatt_db_service_create(uuid, primary, num_handles);
+
 	if (!service)
 		return NULL;
 
-	if (data.cur) {
-		if (!queue_push_after(db->services, data.cur, service))
+	if (after) {
+		if (!queue_push_after(db->services, after, service))
 			goto fail;
 	} else if (!queue_push_head(db->services, service)) {
-			goto fail;
+		goto fail;
 	}
 
 	service->db = db;
@@ -782,70 +774,48 @@ bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
 	return true;
 }
 
-struct read_by_group_type_data {
-	struct queue *queue;
-	bt_uuid_t uuid;
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint16_t uuid_size;
-	bool stop_search;
-};
-
-static void read_by_group_type(void *data, void *user_data)
+void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							struct queue *queue)
 {
-	struct read_by_group_type_data *search_data = user_data;
-	struct gatt_db_service *service = data;
-	uint16_t grp_start, grp_end;
+	const struct queue_entry *services_entry;
+	struct gatt_db_service *service;
+	uint16_t grp_start, grp_end, uuid_size;
 
-	if (!service->active)
-		return;
+	uuid_size = 0;
 
-	/* Don't want more results as they have different size */
-	if (search_data->stop_search)
-		return;
+	services_entry = queue_get_entries(db->services);
 
-	if (bt_uuid_cmp(&search_data->uuid, &service->attributes[0]->uuid))
-		return;
+	while (services_entry) {
+		service = services_entry->data;
 
-	grp_start = service->attributes[0]->handle;
-	grp_end = grp_start + service->num_handles - 1;
+		if (!service->active)
+			goto next_service;
 
-	if (grp_end < search_data->start_handle ||
-				grp_start > search_data->end_handle)
-		return;
+		if (bt_uuid_cmp(&type, &service->attributes[0]->uuid))
+			goto next_service;
 
-	if (service->attributes[0]->handle < search_data->start_handle ||
-		service->attributes[0]->handle > search_data->end_handle)
-		return;
+		grp_start = service->attributes[0]->handle;
+		grp_end = grp_start + service->num_handles - 1;
 
-	/* Remember size of uuid */
-	if (!search_data->uuid_size) {
-		search_data->uuid_size = service->attributes[0]->value_len;
-	} else if (search_data->uuid_size !=
-					service->attributes[0]->value_len) {
-		/* Don't want more results. This is last */
-		search_data->stop_search = true;
-		return;
-	}
+		if (grp_end < start_handle || grp_start > end_handle)
+			goto next_service;
 
-	queue_push_tail(search_data->queue, service->attributes[0]);
-}
+		if (grp_start < start_handle || grp_start > end_handle)
+			goto next_service;
 
-void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
-							uint16_t end_handle,
-							const bt_uuid_t type,
-							struct queue *queue)
-{
-	struct read_by_group_type_data data;
+		if (!uuid_size) {
+			uuid_size = service->attributes[0]->value_len;
+		} else if (uuid_size != service->attributes[0]->value_len) {
+			return;
+		}
 
-	data.uuid = type;
-	data.start_handle = start_handle;
-	data.end_handle = end_handle;
-	data.queue = queue;
-	data.uuid_size = 0;
-	data.stop_search = false;
+		queue_push_tail(queue, service->attributes[0]);
 
-	queue_foreach(db->services, read_by_group_type, &data);
+next_service:
+		services_entry = services_entry->next;
+	}
 }
 
 struct find_by_type_value_data {
-- 
2.2.0.rc0.207.ga3a616c

