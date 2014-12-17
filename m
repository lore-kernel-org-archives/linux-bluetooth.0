Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 11/19] android/hog: Keep track on read/write char and descr
Date: Wed, 17 Dec 2014 16:49:09 +0100
Message-Id: <1418831357-23100-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 20 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 766b66a..bb770c8 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -147,6 +147,48 @@ static void destroy_gatt_req(struct gatt_request *req)
 	free(req);
 }
 
+static void write_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_write_char(attrib, handle, value, vlen, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not read char");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_read_char(attrib, handle, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not read char");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
 				uint16_t start, uint16_t end, gatt_cb_t func,
 				gpointer user_data)
@@ -274,9 +316,12 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct report *report = req->user_data;
 	struct bt_hog *hog = report->hog;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
@@ -291,33 +336,40 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
-static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
+static void write_ccc(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+							void *user_data)
 {
 	uint8_t value[2];
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	gatt_write_char(attrib, handle, value, sizeof(value),
+	write_char(hog, attrib, handle, value, sizeof(value),
 					report_ccc_written_cb, user_data);
 }
 
 static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct report *report = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
 		return;
 	}
 
-	write_ccc(report->hog->attrib, report->ccc_handle, report);
+	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
 }
 
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct report *report = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Read Report Reference descriptor failed: %s",
@@ -336,7 +388,7 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
-		gatt_read_char(report->hog->attrib, report->ccc_handle,
+		read_char(report->hog, report->hog->attrib, report->ccc_handle,
 							ccc_read_cb, report);
 }
 
@@ -359,7 +411,7 @@ static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 	for ( ; descs; descs = descs->next) {
 		struct gatt_desc *desc = descs->data;
 
-		gatt_read_char(hog->attrib, desc->handle,
+		read_char(hog, hog->attrib, desc->handle,
 						external_report_reference_cb,
 						hog);
 	}
@@ -402,7 +454,7 @@ static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 			report->ccc_handle = desc->handle;
 			break;
 		case GATT_REPORT_REFERENCE:
-			gatt_read_char(hog->attrib, desc->handle,
+			read_char(hog, hog->attrib, desc->handle,
 						report_reference_cb, report);
 			break;
 		}
@@ -422,7 +474,10 @@ static void discover_report(struct bt_hog *hog, GAttrib *attrib,
 static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct report *report = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Error reading Report value: %s", att_ecode2str(status));
@@ -445,7 +500,7 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 	report->decl = g_memdup(chr, sizeof(*chr));
 	hog->reports = g_slist_append(hog->reports, report);
 
-	gatt_read_char(hog->attrib, chr->value_handle, report_read_cb, report);
+	read_char(hog, hog->attrib, chr->value_handle, report_read_cb, report);
 
 	return report;
 }
@@ -487,10 +542,13 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Read External Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -547,6 +605,10 @@ static struct report *find_report(struct bt_hog *hog, uint8_t type, uint8_t id)
 static void output_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct gatt_request *req = user_data;
+
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Write output report failed: %s", att_ecode2str(status));
 		return;
@@ -593,7 +655,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		return;
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hog->attrib, report->decl->value_handle,
+		write_char(hog, hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		gatt_write_cmd(hog->attrib, report->decl->value_handle,
@@ -696,7 +758,8 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
 	ssize_t vlen;
@@ -704,6 +767,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i, err;
 	GError *gerr = NULL;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
@@ -774,10 +839,13 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value[HID_INFO_SIZE];
 	ssize_t vlen;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("HID Information read failed: %s",
 						att_ecode2str(status));
@@ -801,10 +869,13 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value;
 	ssize_t vlen;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Protocol Mode characteristic read failed: %s",
 							att_ecode2str(status));
@@ -873,7 +944,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report = report_new(hog, chr);
 			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			gatt_read_char(hog->attrib, chr->value_handle,
+			read_char(hog, hog->attrib, chr->value_handle,
 						report_map_read_cb, hog);
 			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
@@ -886,12 +957,12 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	if (proto_mode_handle) {
 		hog->proto_mode_handle = proto_mode_handle;
-		gatt_read_char(hog->attrib, proto_mode_handle,
+		read_char(hog, hog->attrib, proto_mode_handle,
 						proto_mode_read_cb, hog);
 	}
 
 	if (info_handle)
-		gatt_read_char(hog->attrib, info_handle, info_read_cb, hog);
+		read_char(hog, hog->attrib, info_handle, info_read_cb, hog);
 }
 
 static void report_free(void *data)
@@ -1278,7 +1349,7 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hog->attrib, report->decl->value_handle,
+		write_char(hog, hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-- 
1.8.4

