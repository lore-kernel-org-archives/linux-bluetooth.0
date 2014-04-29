Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 24/40] shared/gatt: Add function to read by type
Date: Tue, 29 Apr 2014 18:47:13 +0200
Message-Id: <1398790049-30303-25-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will return list of attributes with given type.
---
 src/shared/gatt-db.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  20 +++++++++
 2 files changed, 139 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index c3645f1..b716ae6 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -552,3 +552,122 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 
 	queue_foreach(db->services, find_by_type_value, &data);
 }
+
+struct read_by_type_data {
+	struct queue *queue;
+	bt_uuid_t uuid;
+	uint16_t start_handle;
+	uint16_t end_handle;
+};
+
+static void read_by_type(void *data, void *user_data)
+{
+	struct read_by_type_data *search_data = user_data;
+	struct gatt_db_service *service = data;
+	struct gatt_db_attribute *attribute;
+	struct gatt_db_handle_value *value;
+	int i;
+
+	if (!service->active)
+		return;
+
+	for (i = 0; i < service->num_handles; i++) {
+		attribute = service->attributes[i];
+		if (!attribute)
+			continue;
+
+		if (attribute->handle < search_data->start_handle)
+			continue;
+
+		if (attribute->handle > search_data->end_handle)
+			return;
+
+		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
+			continue;
+
+		value = malloc0(sizeof(struct gatt_db_handle_value) +
+							attribute->value_len);
+		if (!value)
+			return;
+
+		value->handle = attribute->handle;
+		value->length = attribute->value_len;
+		if (attribute->value_len)
+			memcpy(value->value, attribute->value, value->length);
+
+		if (!queue_push_tail(search_data->queue, value))
+			free(value);
+	}
+}
+
+void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
+						uint16_t end_handle,
+						const bt_uuid_t type,
+						struct queue *queue)
+{
+	struct read_by_type_data data;
+	data.uuid = type;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.queue = queue;
+
+	queue_foreach(db->services, read_by_type, &data);
+}
+
+
+struct find_information_data {
+	struct queue *queue;
+	uint16_t start_handle;
+	uint16_t end_handle;
+};
+
+static void find_information(void *data, void *user_data)
+{
+	struct find_information_data *search_data = user_data;
+	struct gatt_db_service *service = data;
+	struct gatt_db_attribute *attribute;
+	struct gatt_db_find_information *value;
+	int i;
+
+	if (!service->active)
+		return;
+
+	/* Check if service is in range */
+	if (service->attributes[service->num_handles - 1]->handle <
+						search_data->start_handle)
+		return;
+
+	for (i = 0; i < service->num_handles; i++) {
+		attribute = service->attributes[i];
+		if (!attribute)
+			continue;
+
+		if (attribute->handle < search_data->start_handle)
+			continue;
+
+		if (attribute->handle > search_data->end_handle)
+			return;
+
+		value = new0(struct gatt_db_find_information, 1);
+		if (!value)
+			return;
+
+		value->handle = attribute->handle;
+		value->uuid = attribute->uuid;
+		if (!queue_push_tail(search_data->queue, value))
+			free(value);
+	}
+}
+
+void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							struct queue *queue)
+{
+	struct find_information_data data;
+
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.queue = queue;
+
+	queue_foreach(db->services, find_information, &data);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index e582f83..921e896 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -89,3 +89,23 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 							const uint8_t *value,
 							uint16_t length,
 							struct queue *queue);
+
+struct gatt_db_handle_value {
+	uint16_t handle;
+	uint16_t length;
+	uint8_t value[0];
+};
+
+void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							struct queue *queue);
+
+struct gatt_db_find_information {
+	uint16_t handle;
+	bt_uuid_t uuid;
+};
+
+void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							struct queue *queue);
-- 
1.8.4

