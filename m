Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 22/40] shared/gatt: Add function to read by group type
Date: Tue, 29 Apr 2014 18:47:11 +0200
Message-Id: <1398790049-30303-23-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will return list of gropu values, starting handle, end handle and
service attrtbute value.
---
 src/shared/gatt-db.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 13 ++++++++++
 2 files changed, 84 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8675dcc..26fdc84 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -409,3 +409,74 @@ bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
 
 	return true;
 }
+
+struct read_by_group_type_data {
+	struct queue *queue;
+	bt_uuid_t uuid;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint16_t uuid_size;
+	bool stop_search;
+};
+
+static void read_by_group_type(void *data, void *user_data)
+{
+	struct read_by_group_type_data *search_data = user_data;
+	struct gatt_db_service *service = data;
+	struct gatt_db_group *group;
+
+	if (!service->active)
+		return;
+
+	/* Don't want more results as they have different size*/
+	if (search_data->stop_search)
+		return;
+
+	if (bt_uuid_cmp(&search_data->uuid, &service->attributes[0]->uuid))
+		return;
+
+	if (service->attributes[0]->handle < search_data->start_handle)
+		return;
+
+	/* Remember size of uuid */
+	if (!search_data->uuid_size) {
+		search_data->uuid_size = service->attributes[0]->value_len;
+	} else if (search_data->uuid_size !=
+					service->attributes[0]->value_len) {
+
+		/* Don't want more results. This is last */
+		search_data->stop_search = true;
+		return;
+	}
+
+	group = malloc0(sizeof(struct gatt_db_group) +
+					service->attributes[0]->value_len);
+	if (!group)
+		return;
+
+	group->len = service->attributes[0]->value_len;
+	memcpy(group->value, service->attributes[0]->value, group->len);
+	group->handle = service->attributes[0]->handle;
+	group->end_group = service->attributes[0]->handle +
+						service->num_handles - 1;
+
+	if (!queue_push_tail(search_data->queue, group))
+		free(group);
+}
+
+void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							struct queue *queue)
+{
+	struct read_by_group_type_data data;
+
+	data.uuid = type;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.queue = queue;
+	data.uuid_size = 0;
+	data.stop_search = false;
+
+	queue_foreach(db->services, read_by_group_type, &data);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index c1b7b41..b6e963d 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -64,3 +64,16 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 
 bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
 								bool active);
+
+struct gatt_db_group {
+	uint16_t handle;
+	uint16_t end_group;
+	uint16_t len;
+	uint8_t value[0];
+};
+
+/* Returns queue with struct gatt_db_group */
+void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							struct queue *queue);
-- 
1.8.4

