Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v4 23/38] shared/gatt: Add function to read by type
Date: Wed, 30 Apr 2014 11:13:54 +0200
Message-Id: <1398849249-5868-24-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will return list of attributes with given type.
---
 src/shared/gatt-db.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 11 ++++++++++
 2 files changed, 72 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index c3645f1..60d3140 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -552,3 +552,64 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 
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
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 9bfdb12..b5f9073 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -84,3 +84,14 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
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
-- 
1.8.4

