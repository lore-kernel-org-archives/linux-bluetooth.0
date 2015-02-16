Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] shared/gatt-db: Extend API for find attribute requests
Date: Mon, 16 Feb 2015 13:36:44 +0100
Message-Id: <1424090205-13432-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424090205-13432-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424090205-13432-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At the moment if there is no entries matching in data base for
find_by_type or find_by_type_value, user will not be notified about that
fact.

With this patch gatt_db_find_by_type and gatt_db_find_by_type_value will
return number of found matching entries
---
 src/shared/gatt-db.c | 11 +++++++++--
 src/shared/gatt-db.h |  5 +++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f72d58e..d9ea765 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -858,6 +858,7 @@ struct find_by_type_value_data {
 	void *user_data;
 	const void *value;
 	size_t value_len;
+	unsigned int num_of_res;
 };
 
 static void find_by_type(void *data, void *user_data)
@@ -889,11 +890,12 @@ static void find_by_type(void *data, void *user_data)
 							search_data->value_len))
 			continue;
 
+		search_data->num_of_res++;
 		search_data->func(attribute, search_data->user_data);
 	}
 }
 
-void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
+unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 						uint16_t end_handle,
 						const bt_uuid_t *type,
 						gatt_db_attribute_cb_t func,
@@ -910,9 +912,12 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 	data.user_data = user_data;
 
 	queue_foreach(db->services, find_by_type, &data);
+
+	return data.num_of_res;
 }
 
-void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
+						uint16_t start_handle,
 						uint16_t end_handle,
 						const bt_uuid_t *type,
 						const void *value,
@@ -931,6 +936,8 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 	data.value_len = value_len;
 
 	queue_foreach(db->services, find_by_type, &data);
+
+	return data.num_of_res;
 }
 
 struct read_by_type_data {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 37df4d5..e38b37d 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -95,13 +95,14 @@ void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
 
-void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
+unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 						uint16_t end_handle,
 						const bt_uuid_t *type,
 						gatt_db_attribute_cb_t func,
 						void *user_data);
 
-void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
+unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
+						uint16_t start_handle,
 						uint16_t end_handle,
 						const bt_uuid_t *type,
 						const void *value,
-- 
1.8.4

