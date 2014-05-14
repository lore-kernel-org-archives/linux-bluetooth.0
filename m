Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/15] shared/gatt: Retun list of handles in gatt_db_read_by_group_type
Date: Wed, 14 May 2014 12:18:15 +0200
Message-Id: <1400062699-2372-12-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fom now return list of handles instead of specific data.
---
 src/shared/gatt-db.c | 16 ++--------------
 src/shared/gatt-db.h |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2ac9f2d..25661c7 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -423,7 +423,6 @@ static void read_by_group_type(void *data, void *user_data)
 {
 	struct read_by_group_type_data *search_data = user_data;
 	struct gatt_db_service *service = data;
-	struct gatt_db_group *group;
 
 	if (!service->active)
 		return;
@@ -448,19 +447,8 @@ static void read_by_group_type(void *data, void *user_data)
 		return;
 	}
 
-	group = malloc0(sizeof(struct gatt_db_group) +
-					service->attributes[0]->value_len);
-	if (!group)
-		return;
-
-	group->len = service->attributes[0]->value_len;
-	memcpy(group->value, service->attributes[0]->value, group->len);
-	group->handle = service->attributes[0]->handle;
-	group->end_group = service->attributes[0]->handle +
-						service->num_handles - 1;
-
-	if (!queue_push_tail(search_data->queue, group))
-		free(group);
+	queue_push_tail(search_data->queue,
+			UINT_TO_PTR(service->attributes[0]->handle));
 }
 
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 1a18fb7..6ec7e22 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -67,7 +67,6 @@ struct gatt_db_group {
 	uint8_t value[0];
 };
 
-/* Returns queue with struct gatt_db_group */
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
-- 
1.9.0

