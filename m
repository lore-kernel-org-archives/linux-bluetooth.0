Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 01/14] shared/gatt-db: Add gatt_db_find_by_type_value
Date: Tue, 30 Dec 2014 16:32:19 -0800
Message-Id: <1419985952-18334-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added to support the GATT discovery of services by UUID.
Currently only works for values which are stored within the attribute
structure (not callback-based).
---
 src/shared/gatt-db.c | 27 +++++++++++++++++++++++++++
 src/shared/gatt-db.h |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d2cdacc..bef1308 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -830,6 +830,8 @@ struct find_by_type_value_data {
 	bt_uuid_t uuid;
 	uint16_t start_handle;
 	uint16_t end_handle;
+	const void *value;
+	size_t value_len;
 };
 
 static void find_by_type(void *data, void *user_data)
@@ -855,6 +857,12 @@ static void find_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
+		/* TODO: fix for read-callback based attributes */
+		if (search_data->value && memcmp(attribute->value,
+							search_data->value,
+							search_data->value_len))
+			continue;
+
 		queue_push_tail(search_data->queue, attribute);
 	}
 }
@@ -874,6 +882,25 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 	queue_foreach(db->services, find_by_type, &data);
 }
 
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t *type,
+							const void *value,
+							size_t value_len,
+							struct queue *queue)
+{
+	struct find_by_type_value_data data;
+
+	data.uuid = *type;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.queue = queue;
+	data.value = value;
+	data.value_len = value_len;
+
+	queue_foreach(db->services, find_by_type, &data);
+}
+
 struct read_by_type_data {
 	struct queue *queue;
 	bt_uuid_t uuid;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f188944..9281671 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -93,6 +93,13 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 							const bt_uuid_t *type,
 							struct queue *queue);
 
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+							uint16_t end_handle,
+							const bt_uuid_t *type,
+							const void *value,
+							size_t value_len,
+							struct queue *queue);
+
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
-- 
2.2.0.rc0.207.ga3a616c

