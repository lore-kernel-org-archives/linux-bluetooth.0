Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 2/4] shared/gatt-db: Add service added/removed events.
Date: Wed,  3 Dec 2014 11:32:26 -0800
Message-Id: <1417635148-32546-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1417635148-32546-1-git-send-email-armansito@chromium.org>
References: <1417635148-32546-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to gatt-db for sending events when services are
added to and removed from the database:

  1. Added the gatt_db_register function which can be used to register
     service_added and service_removed callbacks.

  2. Added the gatt_db_unregister function which can be used to
     unregister previously added callbacks. This function can be safely
     called from within a service added/removed callback.

  3. The service added/removed callbacks are tied to
     gatt_db_service_set_active. The added callback is called when a
     service gets marked as active and vice versa.

  4. The service_removed callback will get called if a service is
     removed from the database.
---
 src/shared/gatt-db.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-db.h |  39 +++++++-----
 2 files changed, 176 insertions(+), 31 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 238872c..701f5a4 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -51,6 +51,17 @@ struct gatt_db {
 	int ref_count;
 	uint16_t next_handle;
 	struct queue *services;
+
+	struct queue *notify_list;
+	unsigned int next_notify_id;
+};
+
+struct notify {
+	unsigned int id;
+	gatt_db_attribute_cb_t service_added;
+	gatt_db_attribute_cb_t service_removed;
+	gatt_db_destroy_func_t destroy;
+	void *user_data;
 };
 
 struct pending_read {
@@ -89,6 +100,7 @@ struct gatt_db_attribute {
 };
 
 struct gatt_db_service {
+	struct gatt_db *db;
 	bool active;
 	uint16_t num_handles;
 	struct gatt_db_attribute **attributes;
@@ -168,16 +180,79 @@ struct gatt_db *gatt_db_new(void)
 		return NULL;
 	}
 
+	db->notify_list = queue_new();
+	if (!db->notify_list) {
+		queue_destroy(db->services, NULL);
+		free(db);
+		return NULL;
+	}
+
 	db->next_handle = 0x0001;
 
 	return gatt_db_ref(db);
 }
 
+static void notify_destroy(void *data)
+{
+	struct notify *notify = data;
+
+	if (notify->destroy)
+		notify->destroy(notify->user_data);
+
+	free(notify);
+}
+
+static bool match_notify_id(const void *a, const void *b)
+{
+	const struct notify *notify = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify->id == id;
+}
+
+struct notify_data {
+	struct gatt_db_attribute *attr;
+	bool added;
+};
+
+static void handle_notify(void *data, void *user_data)
+{
+	struct notify *notify = data;
+	struct notify_data *notify_data = user_data;
+
+	if (notify_data->added)
+		notify->service_added(notify_data->attr, notify->user_data);
+	else
+		notify->service_removed(notify_data->attr, notify->user_data);
+}
+
+static void notify_service_changed(struct gatt_db *db,
+						struct gatt_db_service *service,
+						bool added)
+{
+	struct notify_data data;
+
+	if (queue_isempty(db->notify_list))
+		return;
+
+	data.attr = service->attributes[0];
+	data.added = added;
+
+	gatt_db_ref(db);
+
+	queue_foreach(db->notify_list, handle_notify, &data);
+
+	gatt_db_unref(db);
+}
+
 static void gatt_db_service_destroy(void *data)
 {
 	struct gatt_db_service *service = data;
 	int i;
 
+	if (service->active)
+		notify_service_changed(service->db, service, false);
+
 	for (i = 0; i < service->num_handles; i++)
 		attribute_destroy(service->attributes[i]);
 
@@ -190,6 +265,11 @@ static void gatt_db_destroy(struct gatt_db *db)
 	if (!db)
 		return;
 
+	/*
+	 * Clear the notify list before clearing the services to prevent the
+	 * latter from sending service_removed events.
+	 */
+	queue_destroy(db->notify_list, notify_destroy);
 	queue_destroy(db->services, gatt_db_service_destroy);
 	free(db);
 }
@@ -433,6 +513,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 			goto fail;
 	}
 
+	service->db = db;
 	service->attributes[0]->handle = handle;
 	service->num_handles = num_handles;
 
@@ -455,6 +536,56 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 								num_handles);
 }
 
+unsigned int gatt_db_register(struct gatt_db *db,
+					gatt_db_attribute_cb_t service_added,
+					gatt_db_attribute_cb_t service_removed,
+					void *user_data,
+					gatt_db_destroy_func_t destroy)
+{
+	struct notify *notify;
+
+	if (!db || !(service_added || service_removed))
+		return 0;
+
+	notify = new0(struct notify, 1);
+	if (!notify)
+		return 0;
+
+	notify->service_added = service_added;
+	notify->service_removed = service_removed;
+	notify->destroy = destroy;
+	notify->user_data = user_data;
+
+	if (db->next_notify_id < 1)
+		db->next_notify_id = 1;
+
+	notify->id = db->next_notify_id++;
+
+	if (!queue_push_tail(db->notify_list, notify)) {
+		free(notify);
+		return 0;
+	}
+
+	return notify->id;
+}
+
+bool gatt_db_unregister(struct gatt_db *db, unsigned int id)
+{
+	struct notify *notify;
+
+	if (!db || !id)
+		return false;
+
+	notify = queue_find(db->notify_list, match_notify_id, UINT_TO_PTR(id));
+	if (!notify)
+		return false;
+
+	queue_remove(db->notify_list, notify);
+	notify_destroy(notify);
+
+	return true;
+}
+
 static uint16_t get_attribute_index(struct gatt_db_service *service,
 							int end_offset)
 {
@@ -636,10 +767,15 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
 {
+	struct gatt_db_service *service;
+
 	if (!attrib)
 		return false;
 
-	attrib->service->active = active;
+	service = attrib->service;
+	service->active = active;
+
+	notify_service_changed(service->db, service, active);
 
 	return true;
 }
@@ -858,14 +994,14 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 	queue_foreach(db->services, find_information, &data);
 }
 
-void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
+void gatt_db_foreach_service(struct gatt_db *db, gatt_db_attribute_cb_t func,
 							void *user_data)
 {
 	gatt_db_foreach_service_in_range(db, func, user_data, 0x0001, 0xffff);
 }
 
 struct foreach_data {
-	gatt_db_foreach_t func;
+	gatt_db_attribute_cb_t func;
 	void *user_data;
 	uint16_t start, end;
 };
@@ -885,10 +1021,10 @@ static void foreach_service_in_range(void *data, void *user_data)
 }
 
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
-							gatt_db_foreach_t func,
-							void *user_data,
-							uint16_t start_handle,
-							uint16_t end_handle)
+						gatt_db_attribute_cb_t func,
+						void *user_data,
+						uint16_t start_handle,
+						uint16_t end_handle)
 {
 	struct foreach_data data;
 
@@ -904,9 +1040,9 @@ void gatt_db_foreach_service_in_range(struct gatt_db *db,
 }
 
 void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
-							const bt_uuid_t *uuid,
-							gatt_db_foreach_t func,
-							void *user_data)
+						const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *attr;
@@ -930,15 +1066,15 @@ void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
 }
 
 void gatt_db_service_foreach_char(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data)
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
 	gatt_db_service_foreach(attrib, &characteristic_uuid, func, user_data);
 }
 
 void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data)
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *attr;
@@ -970,8 +1106,8 @@ void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
 }
 
 void gatt_db_service_foreach_incl(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data)
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
 	gatt_db_service_foreach(attrib, &included_service_uuid, func,
 								user_data);
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 5db9f9b..987ccf4 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -102,30 +102,39 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							struct queue *queue);
 
 
-typedef void (*gatt_db_foreach_t)(struct gatt_db_attribute *attrib,
+typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
 							void *user_data);
-void gatt_db_foreach_service(struct gatt_db *db, gatt_db_foreach_t func,
+
+void gatt_db_foreach_service(struct gatt_db *db, gatt_db_attribute_cb_t func,
 							void *user_data);
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
-							gatt_db_foreach_t func,
-							void *user_data,
-							uint16_t start_handle,
-							uint16_t end_handle);
+						gatt_db_attribute_cb_t func,
+						void *user_data,
+						uint16_t start_handle,
+						uint16_t end_handle);
 
 void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
-							const bt_uuid_t *uuid,
-							gatt_db_foreach_t func,
-							void *user_data);
+						const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data);
 void gatt_db_service_foreach_char(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data);
+						gatt_db_attribute_cb_t func,
+						void *user_data);
 void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data);
+						gatt_db_attribute_cb_t func,
+						void *user_data);
 void gatt_db_service_foreach_incl(struct gatt_db_attribute *attrib,
-							gatt_db_foreach_t func,
-							void *user_data);
+						gatt_db_attribute_cb_t func,
+						void *user_data);
+
+typedef void (*gatt_db_destroy_func_t)(void *user_data);
 
+unsigned int gatt_db_register(struct gatt_db *db,
+					gatt_db_attribute_cb_t service_added,
+					gatt_db_attribute_cb_t service_removed,
+					void *user_data,
+					gatt_db_destroy_func_t destroy);
+bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
-- 
2.2.0.rc0.207.ga3a616c

