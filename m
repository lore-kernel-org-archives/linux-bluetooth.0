Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v4 22/38] shared/gatt: Add function to find by type
Date: Wed, 30 Apr 2014 11:13:53 +0200
Message-Id: <1398849249-5868-23-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will look for attributes with given uuid and value.
---
 src/shared/gatt-db.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 12 +++++++++
 2 files changed, 84 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 26fdc84..c3645f1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -480,3 +480,75 @@ void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 
 	queue_foreach(db->services, read_by_group_type, &data);
 }
+
+struct find_by_type_value_data {
+	struct queue *queue;
+	bt_uuid_t uuid;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint16_t value_length;
+	const uint8_t *value;
+};
+
+static void find_by_type_value(void *data, void *user_data)
+{
+	struct find_by_type_value_data *search_data = user_data;
+	struct gatt_db_service *service = data;
+	struct gatt_db_attribute *attribute;
+	struct gatt_db_range *range;
+	int i;
+
+	if (!service->active)
+		return;
+
+	for (i = 0; i < service->num_handles; i++) {
+		attribute = service->attributes[i];
+
+		if (!attribute)
+			continue;
+
+		if ((attribute->handle < search_data->start_handle) ||
+				(attribute->handle > search_data->end_handle))
+			continue;
+
+		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
+			continue;
+
+		if (attribute->value_len != search_data->value_length)
+			continue;
+
+		if (!memcmp(attribute->value, search_data->value,
+							attribute->value_len))
+			continue;
+
+		range = new0(struct gatt_db_range, 1);
+		if (!range)
+			return;
+
+		range->handle = attribute->handle;
+		range->end_group = service->attributes[0]->handle +
+						service->num_handles - 1;
+
+		if (!queue_push_tail(search_data->queue, range))
+			free(range);
+	}
+}
+
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							const uint8_t *value,
+							uint16_t length,
+							struct queue *queue)
+{
+	struct find_by_type_value_data data;
+
+	data.uuid = type;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.queue = queue;
+	data.value_length = length;
+	data.value = value;
+
+	queue_foreach(db->services, find_by_type_value, &data);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 8c04c0f..9bfdb12 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -72,3 +72,15 @@ void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
+
+struct gatt_db_range {
+	uint16_t handle;
+	uint16_t end_group;
+};
+
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t type,
+							const uint8_t *value,
+							uint16_t length,
+							struct queue *queue);
-- 
1.8.4

