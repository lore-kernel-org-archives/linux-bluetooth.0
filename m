Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 14/28] android/hog: Replace GSList of hog instances with queue of instances
Date: Wed,  1 Apr 2015 18:40:30 +0200
Message-Id: <1427906444-11769-15-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks to this patch hog instances can be now stored in queue.
This will help to clean the code from glib dependencies.
---
 android/hog.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index e1ccaf3..9f4ca44 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -106,7 +106,7 @@ struct bt_hog {
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
 	struct queue		*bas;
-	GSList			*instances;
+	struct queue		*instances;
 	struct bt_gatt_client	*client;
 	struct gatt_db		*db;
 };
@@ -870,7 +870,7 @@ static void hog_free(void *data)
 	bt_hog_detach(hog);
 
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
-	g_slist_free_full(hog->instances, hog_free);
+	queue_destroy(hog->instances, hog_free);
 
 	bt_scpp_unref(hog->scpp);
 	bt_dis_unref(hog->dis);
@@ -899,6 +899,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 
 	hog->bas = queue_new();
 	hog->reports = queue_new();
+	hog->instances = queue_new();
 
 	if (fd < 0)
 		hog->uhid = bt_uhid_new_default();
@@ -907,7 +908,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 
 	hog->uhid_fd = fd;
 
-	if (!hog->bas || !hog->uhid || !hog->reports) {
+	if (!hog->bas || !hog->uhid || !hog->reports || !hog->instances) {
 		hog_free(hog);
 		return NULL;
 	}
@@ -1021,7 +1022,7 @@ static void hog_attach_hog(struct bt_hog *hog, uint16_t service_handle)
 		return;
 
 	bt_hog_attach(instance, hog->attrib, hog->client);
-	hog->instances = g_slist_append(hog->instances, instance);
+	queue_push_tail(hog->instances, instance);
 }
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
@@ -1090,7 +1091,7 @@ static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
 
 bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 {
-	GSList *l;
+	const struct queue_entry *hog_entry;
 
 	if (hog->attrib || hog->client)
 		return false;
@@ -1113,8 +1114,9 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
 
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
+	hog_entry = queue_get_entries(hog->instances);
+	while (hog_entry) {
+		struct bt_hog *instance = hog_entry->data;
 
 		bt_hog_attach(instance, gatt, client);
 	}
@@ -1135,19 +1137,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 void bt_hog_detach(struct bt_hog *hog)
 {
-	GSList *l;
-
 	if (!hog->attrib || !hog->client)
 		return;
 
 	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
-
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
-
-		bt_hog_detach(instance);
-	}
-
+	queue_foreach(hog->instances, (void *) bt_hog_detach, NULL);
 	queue_foreach(hog->reports, report_disable_notif, NULL);
 
 	if (hog->scpp)
@@ -1182,7 +1176,7 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 {
 	struct report *report;
-	GSList *l;
+	const struct queue_entry *hog_entry;
 
 	if (!hog)
 		return -EINVAL;
@@ -1207,10 +1201,12 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 						report->decl->value_handle,
 						false, data, size);
 
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
+	hog_entry = queue_get_entries(hog->instances);
+	while (hog_entry) {
+		struct bt_hog *instance = hog_entry->data;
 
 		bt_hog_send_report(instance, data, size, type);
+		hog_entry = hog_entry->next;
 	}
 
 	return 0;
-- 
1.9.1

