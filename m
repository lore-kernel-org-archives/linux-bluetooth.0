Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v4 24/38] shared/gatt: Add function to find information
Date: Wed, 30 Apr 2014 11:13:55 +0200
Message-Id: <1398849249-5868-25-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will return list of handle and uuid
---
 src/shared/gatt-db.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  9 ++++++++
 2 files changed, 67 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 60d3140..cbdd8a0 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -613,3 +613,61 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 
 	queue_foreach(db->services, read_by_type, &data);
 }
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
+	if ((service->attributes[0]->handle + service->num_handles - 1) <
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
index b5f9073..a91c798 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -95,3 +95,12 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
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

