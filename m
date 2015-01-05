Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 02/12] shared/gatt-db: Add gatt_db_find_by_type_value
Date: Mon,  5 Jan 2015 13:32:44 -0800
Message-Id: <1420493574-37305-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added to support the GATT discovery of services by UUID.
Currently only works for values which are stored within the attribute
structure (not callback-based).
---
 src/shared/gatt-db.c | 29 +++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f519bcb..e8f78fd 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -831,6 +831,8 @@ struct find_by_type_value_data {
 	uint16_t end_handle;
 	gatt_db_attribute_cb_t func;
 	void *user_data;
+	const void *value;
+	size_t value_len;
 };
 
 static void find_by_type(void *data, void *user_data)
@@ -856,6 +858,12 @@ static void find_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
+		/* TODO: fix for read-callback based attributes */
+		if (search_data->value && memcmp(attribute->value,
+							search_data->value,
+							search_data->value_len))
+			continue;
+
 		search_data->func(attribute, search_data->user_data);
 	}
 }
@@ -877,6 +885,27 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 	queue_foreach(db->services, find_by_type, &data);
 }
 
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+						uint16_t end_handle,
+						const bt_uuid_t *type,
+						const void *value,
+						size_t value_len,
+						gatt_db_attribute_cb_t func,
+						void *user_data)
+{
+	struct find_by_type_value_data data;
+
+	data.uuid = *type;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+	data.func = func;
+	data.user_data = user_data;
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
index 9fc1b11..2edd13f 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -97,6 +97,14 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 						gatt_db_attribute_cb_t func,
 						void *user_data);
 
+void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+						uint16_t end_handle,
+						const bt_uuid_t *type,
+						const void *value,
+						size_t value_len,
+						gatt_db_attribute_cb_t func,
+						void *user_data);
+
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
-- 
2.2.0.rc0.207.ga3a616c

