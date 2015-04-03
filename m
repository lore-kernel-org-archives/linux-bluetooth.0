Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 24/27] android/hog: Clean the code from attrib dependencies
Date: Fri,  3 Apr 2015 15:43:53 +0200
Message-Id: <1428068636-13073-25-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All the attrib include files can be now removed since all the dependencies
have been removed.
---
 android/hidhost.c |  2 +-
 android/hog.c     | 74 +++++++++++++++++++++++++------------------------------
 android/hog.h     |  2 +-
 unit/test-hog.c   |  2 +-
 4 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index f9b7c24..32789fb 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -812,7 +812,7 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 		goto fail;
 	}
 
-	if (!bt_hog_attach(dev->hog, dev->attrib, dev->client)) {
+	if (!bt_hog_attach(dev->hog, dev->client)) {
 		error("HoG: unable to attach");
 		goto fail;
 	}
diff --git a/android/hog.c b/android/hog.c
index 790f362..fdcd95a 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -50,15 +50,15 @@
 #include "src/shared/gatt-client.h"
 #include "src/log.h"
 
-#include "attrib/att.h"
-#include "attrib/gattrib.h"
-#include "attrib/gatt.h"
-
 #include "android/scpp.h"
 #include "android/dis.h"
 #include "android/bas.h"
 #include "android/hog.h"
 
+#ifndef MIN
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
+
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
@@ -85,7 +85,6 @@ struct bt_hog {
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
-	GAttrib			*attrib;
 	struct queue		*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
@@ -107,6 +106,11 @@ struct bt_hog {
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
@@ -153,8 +157,8 @@ static void report_value_cb(uint16_t value_handle, const uint8_t *value,
 static void report_ccc_written_cb(uint16_t status, void *user_data)
 {
 	if (status != 0) {
-		error("Write report characteristic descriptor failed: %s",
-							att_ecode2str(status));
+		error("Write report characteristic descriptor failed: %d",
+									status);
 		return;
 	}
 
@@ -192,8 +196,8 @@ static void report_reference_cb(bool success, uint8_t status,
 	struct report *report = user_data;
 
 	if (!success) {
-		error("Read Report Reference descriptor failed: %s",
-							att_ecode2str(status));
+		error("Read Report Reference descriptor failed: att_ecode %d",
+								status);
 		return;
 	}
 
@@ -249,8 +253,7 @@ static void report_read_cb(bool success, uint8_t att_ecode,
 	struct report *report = user_data;
 
 	if (!success) {
-		error("Error reading Report value: %s",
-						att_ecode2str(att_ecode));
+		error("Error reading Report value: att_ecode %d", att_ecode);
 		return;
 	}
 
@@ -304,8 +307,8 @@ static void external_report_reference_cb(bool success, uint8_t status,
 	struct queue *chrs;
 
 	if (!success) {
-		error("Read External Report Reference descriptor failed: %s",
-							att_ecode2str(status));
+		error("Read External Report Reference descriptor failed: %d",
+								status);
 		return;
 	}
 
@@ -397,7 +400,7 @@ static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
 static void output_written_cb(bool success, uint8_t status, void *user_data)
 {
 	if (!success) {
-		error("Write output report failed: %s", att_ecode2str(status));
+		error("Write output report failed: att_ecode %d", status);
 		return;
 	}
 }
@@ -408,6 +411,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 	struct report *report;
 	void *data;
 	int size;
+	uint8_t properties;
 
 	report = find_report_by_rtype(hog, ev->u.output.rtype,
 							ev->u.output.data[0]);
@@ -427,12 +431,13 @@ static void forward_report(struct uhid_event *ev, void *user_data)
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
@@ -484,7 +489,7 @@ static void set_report_cb(bool success, uint8_t status, void *user_data)
 	rsp.u.set_report_reply.err = status;
 
 	if (!success)
-		error("Error setting Report value: %s", att_ecode2str(status));
+		error("Error setting Report value: att_ecode %d", status);
 
 	err = bt_uhid_send(hog->uhid, &rsp);
 	if (err < 0)
@@ -556,7 +561,7 @@ static void get_report_cb(bool success, uint8_t status, const uint8_t *value,
 	rsp.u.get_report_reply.id = hog->getrep_id;
 
 	if (!success) {
-		error("Error reading Report value: %s", att_ecode2str(status));
+		error("Error reading Report value: att_ecode %d", status);
 		goto exit;
 	}
 
@@ -732,7 +737,7 @@ static void report_map_read_cb(bool success, uint8_t att_ecode,
 	int i;
 
 	if (!success) {
-		error("Report Map read failed: %s", att_ecode2str(att_ecode));
+		error("Report Map read failed: att_ecode %d", att_ecode);
 		return;
 	}
 
@@ -770,7 +775,7 @@ static void info_read_cb(bool success, uint8_t status, const uint8_t *value,
 	struct bt_hog *hog = user_data;
 
 	if (!success) {
-		error("HID Information read failed: %s", att_ecode2str(status));
+		error("HID Information read failed: att_ecode %d", status);
 		return;
 	}
 
@@ -794,8 +799,8 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 	struct bt_hog *hog = user_data;
 
 	if (!success) {
-		error("Protocol Mode characteristic read failed: %s",
-						att_ecode2str(att_ecode));
+		error("Protocol Mode characteristic read failed: att_ecode %d",
+								att_ecode);
 		return;
 	}
 
@@ -1023,7 +1028,7 @@ static void hog_attach_hog(struct bt_hog *hog, uint16_t service_handle)
 	if (!instance)
 		return;
 
-	bt_hog_attach(instance, hog->attrib, hog->client);
+	bt_hog_attach(instance, hog->client);
 	queue_push_tail(hog->instances, instance);
 }
 
@@ -1050,14 +1055,11 @@ static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
 		hog_attach_bas(hog, service_handle);
 }
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
+bool bt_hog_attach(struct bt_hog *hog, void *client)
 {
-	const struct queue_entry *hog_entry;
-
-	if (hog->attrib || hog->client)
+	if (hog->client)
 		return false;
 
-	hog->attrib = g_attrib_ref(gatt);
 	hog->client = bt_gatt_client_ref(client);
 	hog->db = gatt_db_ref(bt_gatt_client_get_db(hog->client));
 
@@ -1073,13 +1075,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 		bt_dis_attach(hog->dis, hog->client);
 
 	queue_foreach(hog->bas, (void *) bt_bas_attach, hog->client);
-
-	hog_entry = queue_get_entries(hog->instances);
-	while (hog_entry) {
-		struct bt_hog *instance = hog_entry->data;
-
-		bt_hog_attach(instance, gatt, client);
-	}
+	queue_foreach(hog->instances, (void *) bt_hog_attach, hog->client);
 
 	if (queue_isempty(hog->reports)) {
 		struct gatt_db_attribute *service;
@@ -1097,7 +1093,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 
 void bt_hog_detach(struct bt_hog *hog)
 {
-	if (!hog->attrib || !hog->client)
+	if (!hog->client)
 		return;
 
 	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
@@ -1113,8 +1109,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	gatt_db_unref(hog->db);
 	bt_gatt_client_unref(hog->client);
 	hog->client = NULL;
-	g_attrib_unref(hog->attrib);
-	hog->attrib = NULL;
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
@@ -1150,13 +1144,13 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 
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

