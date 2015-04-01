Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 12/28] android/hog: Replace list of reports with a queue of reports
Date: Wed,  1 Apr 2015 18:40:28 +0200
Message-Id: <1427906444-11769-13-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mariusz Skamra <mariusz.skamra@gmail.com>

Thanks to this patch reports can be now stored in queue. This will help
to clean the code from glib dependencies.
Two helpers for enable/disable notification have been added to be used with
queue_foreach.
---
 android/hog.c | 79 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index e3e79cb..08196d4 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -85,7 +85,7 @@ struct bt_hog {
 	uint16_t		product;
 	uint16_t		version;
 	GAttrib			*attrib;
-	GSList			*reports;
+	struct queue		*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
 	gboolean		has_report_id;
@@ -160,12 +160,35 @@ static void report_ccc_written_cb(uint16_t status, void *user_data)
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
+static void report_enable_notif(void *data, void *user_data)
+{
+	struct report *report = data;
+	struct bt_gatt_client *client = report->hog->client;
+
+	/* Enable notifications only for Input Reports */
+	if (report->type == HOG_REPORT_TYPE_INPUT)
+		report->notifyid = bt_gatt_client_register_notify(client,
+				report->decl->value_handle,
+				report_ccc_written_cb,
+				report_value_cb, report, NULL);
+}
+
+static void report_disable_notif(void *data, void *user_data)
+{
+	struct report *report = data;
+	struct bt_gatt_client *client = report->hog->client;
+
+	if (report->notifyid > 0) {
+		bt_gatt_client_unregister_notify(client, report->notifyid);
+		report->notifyid = 0;
+	}
+}
+
 static void report_reference_cb(bool success, uint8_t status,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
 {
 	struct report *report = user_data;
-	struct bt_gatt_client *client = report->hog->client;
 
 	if (!success) {
 		error("Read Report Reference descriptor failed: %s",
@@ -182,12 +205,7 @@ static void report_reference_cb(bool success, uint8_t status,
 	report->type = value[1];
 	DBG("Report ID: 0x%02x Report type: 0x%02x", value[0], value[1]);
 
-	/* Enable notifications only for Input Reports */
-	if (report->type == HOG_REPORT_TYPE_INPUT)
-		report->notifyid = bt_gatt_client_register_notify(client,
-						report->decl->value_handle,
-						report_ccc_written_cb,
-						report_value_cb, report, NULL);
+	report_enable_notif(report, NULL);
 }
 
 static void external_report_reference_cb(bool success, uint8_t status,
@@ -254,7 +272,7 @@ static struct report *report_new(struct bt_hog *hog, uint16_t value_handle,
 	report->decl = new0(struct gatt_char, 1);
 	report->decl->value_handle = value_handle;
 	report->decl->properties = properties;
-	hog->reports = g_slist_append(hog->reports, report);
+	queue_push_tail(hog->reports, report);
 
 	bt_gatt_client_read_value(hog->client, value_handle,
 						report_read_cb, report, NULL);
@@ -320,10 +338,8 @@ static void external_report_reference_cb(bool success, uint8_t status,
 	queue_foreach(chrs, external_service_char_cb, hog);
 }
 
-static int report_cmp(gconstpointer a, gconstpointer b)
+static int report_cmp(const struct report *ra, const struct report *rb)
 {
-	const struct report *ra = a, *rb = b;
-
 	/* sort by type first.. */
 	if (ra->type != rb->type)
 		return ra->type - rb->type;
@@ -339,14 +355,21 @@ static int report_cmp(gconstpointer a, gconstpointer b)
 static struct report *find_report(struct bt_hog *hog, uint8_t type, uint8_t id)
 {
 	struct report cmp;
-	GSList *l;
+	const struct queue_entry *report_entry;
 
 	cmp.type = type;
 	cmp.id = hog->has_report_id ? id : 0;
 
-	l = g_slist_find_custom(hog->reports, &cmp, report_cmp);
+	report_entry = queue_get_entries(hog->reports);
+	while (report_entry) {
+		struct report *report = report_entry->data;
+
+		if (!report_cmp(report, &cmp))
+			return report;
 
-	return l ? l->data : NULL;
+		report_entry = report_entry->next;
+	}
+	return NULL;
 }
 
 static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
@@ -856,7 +879,7 @@ static void hog_free(void *data)
 	bt_scpp_unref(hog->scpp);
 	bt_dis_unref(hog->dis);
 	bt_uhid_unref(hog->uhid);
-	g_slist_free_full(hog->reports, report_free);
+	queue_destroy(hog->reports, report_free);
 	g_free(hog->name);
 	g_free(hog);
 }
@@ -879,6 +902,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 		return NULL;
 
 	hog->bas = queue_new();
+	hog->reports = queue_new();
 
 	if (fd < 0)
 		hog->uhid = bt_uhid_new_default();
@@ -887,7 +911,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 
 	hog->uhid_fd = fd;
 
-	if (!hog->bas || !hog->uhid) {
+	if (!hog->bas || !hog->uhid || !hog->reports) {
 		hog_free(hog);
 		return NULL;
 	}
@@ -1099,7 +1123,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 		bt_hog_attach(instance, gatt, client);
 	}
 
-	if (hog->reports == NULL) {
+	if (queue_isempty(hog->reports)) {
 		struct gatt_db_attribute *service;
 
 		service = gatt_db_get_attribute(hog->db, hog->service_handle);
@@ -1108,14 +1132,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 		return true;
 	}
 
-	for (l = hog->reports; l; l = l->next) {
-		struct report *r = l->data;
-		if (r->type == HOG_REPORT_TYPE_INPUT)
-			r->notifyid = bt_gatt_client_register_notify(client,
-					r->decl->value_handle,
-					report_ccc_written_cb,
-					report_value_cb, r, NULL);
-	}
+	queue_foreach(hog->reports, report_enable_notif, NULL);
 
 	return true;
 }
@@ -1135,15 +1152,7 @@ void bt_hog_detach(struct bt_hog *hog)
 		bt_hog_detach(instance);
 	}
 
-	for (l = hog->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		if (r->notifyid > 0) {
-			bt_gatt_client_unregister_notify(hog->client,
-								r->notifyid);
-			r->notifyid = 0;
-		}
-	}
+	queue_foreach(hog->reports, report_disable_notif, NULL);
 
 	if (hog->scpp)
 		bt_scpp_detach(hog->scpp);
-- 
1.9.1

