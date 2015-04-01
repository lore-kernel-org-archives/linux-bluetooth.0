Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 26/28] android/hog: Remove attrib/
Date: Wed,  1 Apr 2015 18:40:42 +0200
Message-Id: <1427906444-11769-27-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All the attrib/ include files can be now removed since all the dependencies
have been previously removed.
---
 android/hidhost.c |  2 +-
 android/hog.c     | 62 +++++++++++++++++++++++++++----------------------------
 android/hog.h     |  2 +-
 unit/test-hog.c   |  2 +-
 4 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3d4ee85..9bd96a1 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -816,7 +816,7 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 		goto fail;
 	}
 
-	if (!bt_hog_attach(dev->hog, dev->attrib, dev->client)) {
+	if (!bt_hog_attach(dev->hog, dev->client)) {
 		error("HoG: unable to attach");
 		goto fail;
 	}
diff --git a/android/hog.c b/android/hog.c
index eb9c9d4..c2017f8 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -50,10 +50,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/log.h"
 
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "attrib/gatt.h"
-
 #include "android/scpp.h"
 #include "android/dis.h"
 #include "android/bas.h"
@@ -94,7 +90,6 @@ struct bt_hog {
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
-	GAttrib			*attrib;
 	struct queue		*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
@@ -116,6 +111,11 @@ struct bt_hog {
 	struct gatt_db		*db;
 };
 
+struct gatt_char {
+	uint8_t properties;
+	uint16_t value_handle;
+};
+
 struct report {
 	struct bt_hog		*hog;
 	uint8_t			id;
@@ -162,8 +162,8 @@ static void report_value_cb(uint16_t value_handle, const uint8_t *value,
 static void report_ccc_written_cb(uint16_t status, void *user_data)
 {
 	if (status != 0) {
-		error("Write report characteristic descriptor failed: %s",
-							att_ecode2str(status));
+		error("Write report characteristic descriptor failed: %d",
+									status);
 		return;
 	}
 
@@ -201,8 +201,8 @@ static void report_reference_cb(bool success, uint8_t status,
 	struct report *report = user_data;
 
 	if (!success) {
-		error("Read Report Reference descriptor failed: %s",
-							att_ecode2str(status));
+		error("Read Report Reference descriptor failed: att_ecode %d",
+								status);
 		return;
 	}
 
@@ -258,8 +258,7 @@ static void report_read_cb(bool success, uint8_t att_ecode,
 	struct report *report = user_data;
 
 	if (!success) {
-		error("Error reading Report value: %s",
-						att_ecode2str(att_ecode));
+		error("Error reading Report value: att_ecode %d", att_ecode);
 		return;
 	}
 
@@ -312,8 +311,8 @@ static void external_report_reference_cb(bool success, uint8_t status,
 	struct queue *chrs;
 
 	if (!success) {
-		error("Read External Report Reference descriptor failed: %s",
-							att_ecode2str(status));
+		error("Read External Report Reference descriptor failed: %d",
+								status);
 		return;
 	}
 
@@ -403,7 +402,7 @@ static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
 static void output_written_cb(bool success, uint8_t status, void *user_data)
 {
 	if (!success) {
-		error("Write output report failed: %s", att_ecode2str(status));
+		error("Write output report failed: att_ecode %d", status);
 		return;
 	}
 }
@@ -414,6 +413,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 	struct report *report;
 	void *data;
 	int size;
+	uint8_t properties;
 
 	report = find_report_by_rtype(hog, ev->u.output.rtype,
 							ev->u.output.data[0]);
@@ -433,12 +433,13 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 	if (hog->client == NULL)
 		return;
 
-	if (report->decl->properties & GATT_CHR_PROP_WRITE)
+	properties = report->decl->properties;
+	if (properties & BT_GATT_CHRC_PROP_WRITE)
 		bt_gatt_client_write_value(hog->client,
 						report->decl->value_handle,
 						data, size, output_written_cb,
 						hog, NULL);
-	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+	else if (properties & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)
 		bt_gatt_client_write_without_response(hog->client,
 						report->decl->value_handle,
 						false, data, size);
@@ -490,7 +491,7 @@ static void set_report_cb(bool success, uint8_t status, void *user_data)
 	rsp.u.set_report_reply.err = status;
 
 	if (!success)
-		error("Error setting Report value: %s", att_ecode2str(status));
+		error("Error setting Report value: att_ecode %d", status);
 
 	err = bt_uhid_send(hog->uhid, &rsp);
 	if (err < 0)
@@ -562,7 +563,7 @@ static void get_report_cb(bool success, uint8_t status, const uint8_t *value,
 	rsp.u.get_report_reply.id = hog->getrep_id;
 
 	if (!success) {
-		error("Error reading Report value: %s", att_ecode2str(status));
+		error("Error reading Report value: att_ecode %d", status);
 		goto exit;
 	}
 
@@ -738,7 +739,7 @@ static void report_map_read_cb(bool success, uint8_t att_ecode,
 	int i;
 
 	if (!success) {
-		error("Report Map read failed: %s", att_ecode2str(att_ecode));
+		error("Report Map read failed: att_ecode %d", att_ecode);
 		return;
 	}
 
@@ -776,7 +777,7 @@ static void info_read_cb(bool success, uint8_t status, const uint8_t *value,
 	struct bt_hog *hog = user_data;
 
 	if (!success) {
-		error("HID Information read failed: %s", att_ecode2str(status));
+		error("HID Information read failed: att_ecode %d", status);
 		return;
 	}
 
@@ -800,8 +801,8 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 	struct bt_hog *hog = user_data;
 
 	if (!success) {
-		error("Protocol Mode characteristic read failed: %s",
-						att_ecode2str(att_ecode));
+		error("Protocol Mode characteristic read failed: att_ecode %d",
+								att_ecode);
 		return;
 	}
 
@@ -1022,7 +1023,7 @@ static void hog_attach_hog(struct bt_hog *hog, uint16_t service_handle)
 	if (!instance)
 		return;
 
-	bt_hog_attach(instance, hog->attrib, hog->client);
+	bt_hog_attach(instance, hog->client);
 	queue_push_tail(hog->instances, instance);
 }
 
@@ -1049,14 +1050,13 @@ static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
 		hog_attach_bas(hog, service_handle);
 }
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
+bool bt_hog_attach(struct bt_hog *hog, void *client)
 {
 	const struct queue_entry *hog_entry;
 
-	if (hog->attrib || hog->client)
+	if (hog->client)
 		return false;
 
-	hog->attrib = g_attrib_ref(gatt);
 	hog->client = bt_gatt_client_ref(client);
 	hog->db = bt_gatt_client_get_db(hog->client);
 
@@ -1077,7 +1077,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 	while (hog_entry) {
 		struct bt_hog *instance = hog_entry->data;
 
-		bt_hog_attach(instance, gatt, client);
+		bt_hog_attach(instance, client);
 	}
 
 	if (queue_isempty(hog->reports)) {
@@ -1096,7 +1096,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 void bt_hog_detach(struct bt_hog *hog)
 {
-	if (!hog->attrib || !hog->client)
+	if (!hog->client)
 		return;
 
 	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
@@ -1111,9 +1111,7 @@ void bt_hog_detach(struct bt_hog *hog)
 
 	gatt_db_unref(hog->db);
 	bt_gatt_client_unref(hog->client);
-	g_attrib_unref(hog->attrib);
 	hog->client = NULL;
-	hog->attrib = NULL;
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
@@ -1149,13 +1147,13 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 
 	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
-	if (report->decl->properties & GATT_CHR_PROP_WRITE)
+	if (report->decl->properties & BT_GATT_CHRC_PROP_WRITE)
 		bt_gatt_client_write_value(hog->client,
 						report->decl->value_handle,
 						data, size, output_written_cb,
 						hog, NULL);
 
-	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+	if (report->decl->properties & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)
 		bt_gatt_client_write_without_response(hog->client,
 						report->decl->value_handle,
 						false, data, size);
diff --git a/android/hog.h b/android/hog.h
index 8fe8422..fa3d114 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -36,7 +36,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client);
+bool bt_hog_attach(struct bt_hog *hog, void *client);
 void bt_hog_detach(struct bt_hog *hog);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 16805e7..81aada2 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -227,7 +227,7 @@ static void test_hog(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
-	g_assert(bt_hog_attach(context->hog, context->attrib, NULL));
+	g_assert(bt_hog_attach(context->hog, NULL));
 }
 
 int main(int argc, char *argv[])
-- 
1.9.1

