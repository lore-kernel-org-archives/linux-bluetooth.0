Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 14/15] shared/gatt: Make 'find_by_type_value' callback compatible
Date: Wed, 14 May 2014 12:18:18 +0200
Message-Id: <1400062699-2372-15-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'Find by type and value' was handling only values written directly to
database and not those returned by callbacks or by Android Framework.
This replaces it with 'find by type' and leaves value verification to
the user.
---
 src/shared/gatt-db.c | 36 +++++++-----------------------------
 src/shared/gatt-db.h | 11 ++---------
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 25661c7..d9f63be 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -473,16 +473,13 @@ struct find_by_type_value_data {
 	bt_uuid_t uuid;
 	uint16_t start_handle;
 	uint16_t end_handle;
-	uint16_t value_length;
-	const uint8_t *value;
 };
 
-static void find_by_type_value(void *data, void *user_data)
+static void find_by_type(void *data, void *user_data)
 {
 	struct find_by_type_value_data *search_data = user_data;
 	struct gatt_db_service *service = data;
 	struct gatt_db_attribute *attribute;
-	struct gatt_db_range *range;
 	int i;
 
 	if (!service->active)
@@ -501,43 +498,24 @@ static void find_by_type_value(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
-		if (attribute->value_len != search_data->value_length)
-			continue;
-
-		if (!memcmp(attribute->value, search_data->value,
-							attribute->value_len))
-			continue;
-
-		range = new0(struct gatt_db_range, 1);
-		if (!range)
-			return;
-
-		range->handle = attribute->handle;
-		range->end_group = service->attributes[0]->handle +
-						service->num_handles - 1;
-
-		if (!queue_push_tail(search_data->queue, range))
-			free(range);
+		queue_push_tail(search_data->queue,
+						UINT_TO_PTR(attribute->handle));
 	}
 }
 
-void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
-							const bt_uuid_t type,
-							const uint8_t *value,
-							uint16_t length,
+							const bt_uuid_t *type,
 							struct queue *queue)
 {
 	struct find_by_type_value_data data;
 
-	data.uuid = type;
+	data.uuid = *type;
 	data.start_handle = start_handle;
 	data.end_handle = end_handle;
 	data.queue = queue;
-	data.value_length = length;
-	data.value = value;
 
-	queue_foreach(db->services, find_by_type_value, &data);
+	queue_foreach(db->services, find_by_type, &data);
 }
 
 struct read_by_type_data {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 529abd0..3d46730 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -65,16 +65,9 @@ void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
 
-struct gatt_db_range {
-	uint16_t handle;
-	uint16_t end_group;
-};
-
-void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
-							const bt_uuid_t type,
-							const uint8_t *value,
-							uint16_t length,
+							const bt_uuid_t *type,
 							struct queue *queue);
 
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
-- 
1.9.0

