Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 04/27] android/hog: Remove tracking gatt operations
Date: Fri,  3 Apr 2015 15:43:33 +0200
Message-Id: <1428068636-13073-5-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the use of bt_gatt_client there is no need to queue pending gatt
operations. bt_gatt_client already keeps track on that, so that
on bt_gatt_client_unref the queue of pending requests is destroyed.
---
 android/hog.c | 283 +++++++---------------------------------------------------
 1 file changed, 33 insertions(+), 250 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 931ac0b..458ddc4 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -106,7 +106,6 @@ struct bt_hog {
 	struct bt_dis		*dis;
 	struct queue		*bas;
 	GSList			*instances;
-	struct queue		*gatt_op;
 	struct bt_gatt_client	*client;
 };
 
@@ -121,168 +120,6 @@ struct report {
 	uint8_t			*value;
 };
 
-struct gatt_request {
-	unsigned int id;
-	struct bt_hog *hog;
-	void *user_data;
-};
-
-static struct gatt_request *create_request(struct bt_hog *hog,
-							void *user_data)
-{
-	struct gatt_request *req;
-
-	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
-	req->user_data = user_data;
-	req->hog = bt_hog_ref(hog);
-
-	return req;
-}
-
-static bool set_and_store_gatt_req(struct bt_hog *hog,
-						struct gatt_request *req,
-						unsigned int id)
-{
-	req->id = id;
-	return queue_push_head(hog->gatt_op, req);
-}
-
-static void destroy_gatt_req(struct gatt_request *req)
-{
-	queue_remove(req->hog->gatt_op, req);
-	bt_hog_unref(req->hog);
-	free(req);
-}
-
-static void write_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					GAttribResultFunc func,
-					gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-				GAttribResultFunc func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_read_char(attrib, handle, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
-				uint16_t start, uint16_t end, gatt_cb_t func,
-				gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_desc(attrib, start, end, NULL, func, req);
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not discover descriptors");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_char(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_primary(attrib, uuid, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not send discover primary");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void find_included(struct bt_hog *hog, GAttrib *attrib,
-					uint16_t start, uint16_t end,
-					gatt_cb_t func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_find_included(attrib, start, end, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("Could not find included");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
@@ -326,12 +163,9 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
+	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
@@ -353,17 +187,14 @@ static void write_ccc(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	write_char(hog, attrib, handle, value, sizeof(value),
+	gatt_write_char(attrib, handle, value, sizeof(value),
 					report_ccc_written_cb, user_data);
 }
 
 static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
+	struct report *report = user_data;
 
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
@@ -376,10 +207,7 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
+	struct report *report = user_data;
 
 	if (status != 0) {
 		error("Read Report Reference descriptor failed: %s",
@@ -398,7 +226,7 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 
 	/* Enable notifications only for Input Reports */
 	if (report->type == HOG_REPORT_TYPE_INPUT)
-		read_char(report->hog, report->hog->attrib, report->ccc_handle,
+		gatt_read_char(report->hog->attrib, report->ccc_handle,
 							ccc_read_cb, report);
 }
 
@@ -407,10 +235,7 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 
 static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-
-	destroy_gatt_req(req);
+	struct bt_hog *hog = user_data;
 
 	if (status != 0) {
 		error("Discover external descriptors failed: %s",
@@ -421,7 +246,7 @@ static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 	for ( ; descs; descs = descs->next) {
 		struct gatt_desc *desc = descs->data;
 
-		read_char(hog, hog->attrib, desc->handle,
+		gatt_read_char(hog->attrib, desc->handle,
 						external_report_reference_cb,
 						hog);
 	}
@@ -438,18 +263,15 @@ static void discover_external(struct bt_hog *hog, GAttrib *attrib,
 
 	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
 
-	discover_desc(hog, attrib, start, end, discover_external_cb,
+	gatt_discover_desc(attrib, start, end, NULL, discover_external_cb,
 								user_data);
 }
 
 static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
+	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Discover report descriptors failed: %s",
 							att_ecode2str(status));
@@ -464,7 +286,7 @@ static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 			report->ccc_handle = desc->handle;
 			break;
 		case GATT_REPORT_REFERENCE:
-			read_char(hog, hog->attrib, desc->handle,
+			gatt_read_char(hog->attrib, desc->handle,
 						report_reference_cb, report);
 			break;
 		}
@@ -478,16 +300,14 @@ static void discover_report(struct bt_hog *hog, GAttrib *attrib,
 	if (start > end)
 		return;
 
-	discover_desc(hog, attrib, start, end, discover_report_cb, user_data);
+	gatt_discover_desc(attrib, start, end, NULL, discover_report_cb,
+								user_data);
 }
 
 static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
+	struct report *report = user_data;
 
 	if (status != 0) {
 		error("Error reading Report value: %s", att_ecode2str(status));
@@ -510,7 +330,7 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 	report->decl = g_memdup(chr, sizeof(*chr));
 	hog->reports = g_slist_append(hog->reports, report);
 
-	read_char(hog, hog->attrib, chr->value_handle, report_read_cb, report);
+	gatt_read_char(hog->attrib, chr->value_handle, report_read_cb, report);
 
 	return report;
 }
@@ -518,14 +338,11 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	struct gatt_primary *primary = hog->primary;
 	struct report *report;
 	GSList *l;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover external service characteristic failed: %s", str);
@@ -552,13 +369,10 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Read External Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -579,7 +393,7 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 
 	bt_uuid16_create(&uuid, uuid16);
-	discover_char(hog, hog->attrib, 0x0001, 0xffff, &uuid,
+	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
 					external_service_char_cb, hog);
 }
 
@@ -637,10 +451,6 @@ static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
 static void output_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Write output report failed: %s", att_ecode2str(status));
 		return;
@@ -673,7 +483,7 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		return;
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		write_char(hog, hog->attrib, report->decl->value_handle,
+		gatt_write_char(hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		gatt_write_cmd(hog->attrib, report->decl->value_handle,
@@ -933,8 +743,7 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
 	ssize_t vlen;
@@ -942,8 +751,6 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i, err;
 	GError *gerr = NULL;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
@@ -1016,13 +823,10 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	uint8_t value[HID_INFO_SIZE];
 	ssize_t vlen;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("HID Information read failed: %s",
 						att_ecode2str(status));
@@ -1046,13 +850,10 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	uint8_t value;
 	ssize_t vlen;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Protocol Mode characteristic read failed: %s",
 							att_ecode2str(status));
@@ -1078,8 +879,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
@@ -1087,8 +887,6 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -1121,7 +919,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report = report_new(hog, chr);
 			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			read_char(hog, hog->attrib, chr->value_handle,
+			gatt_read_char(hog->attrib, chr->value_handle,
 						report_map_read_cb, hog);
 			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
@@ -1134,12 +932,12 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	if (proto_mode_handle) {
 		hog->proto_mode_handle = proto_mode_handle;
-		read_char(hog, hog->attrib, proto_mode_handle,
+		gatt_read_char(hog->attrib, proto_mode_handle,
 						proto_mode_read_cb, hog);
 	}
 
 	if (info_handle)
-		read_char(hog, hog->attrib, info_handle, info_read_cb, hog);
+		gatt_read_char(hog->attrib, info_handle, info_read_cb, hog);
 }
 
 static void report_free(void *data)
@@ -1151,12 +949,6 @@ static void report_free(void *data)
 	g_free(report);
 }
 
-static void cancel_gatt_req(struct gatt_request *req)
-{
-	if (g_attrib_cancel(req->hog->attrib, req->id))
-		destroy_gatt_req(req);
-}
-
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
@@ -1172,7 +964,6 @@ static void hog_free(void *data)
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
 	g_free(hog->primary);
-	queue_destroy(hog->gatt_op, (void *) destroy_gatt_req);
 	g_free(hog);
 }
 
@@ -1194,7 +985,6 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 	if (!hog)
 		return NULL;
 
-	hog->gatt_op = queue_new();
 	hog->bas = queue_new();
 
 	if (fd < 0)
@@ -1204,7 +994,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 
 	hog->uhid_fd = fd;
 
-	if (!hog->gatt_op || !hog->bas || !hog->uhid) {
+	if (!hog->bas || !hog->uhid) {
 		hog_free(hog);
 		return NULL;
 	}
@@ -1246,13 +1036,10 @@ void bt_hog_unref(struct bt_hog *hog)
 
 static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 {
-	struct gatt_request *req = user_data;
 	GSList *l;
 
 	DBG("");
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		const char *str = att_ecode2str(status);
 		DBG("Find included failed: %s", str);
@@ -1321,10 +1108,10 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 
 	if (!hog->primary) {
 		hog->primary = g_memdup(primary, sizeof(*primary));
-		discover_char(hog, hog->attrib, primary->range.start,
+		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
-		find_included(hog, hog->attrib, primary->range.start,
+		gatt_find_included(hog->attrib, primary->range.start,
 				primary->range.end, find_included_cb, hog);
 		return;
 	}
@@ -1334,7 +1121,7 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 	if (!instance)
 		return;
 
-	find_included(instance, hog->attrib, primary->range.start,
+	gatt_find_included(hog->attrib, primary->range.start,
 			primary->range.end, find_included_cb, instance);
 
 	bt_hog_attach(instance, hog->attrib, hog->client);
@@ -1343,15 +1130,12 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hog *hog = user_data;
 	struct gatt_primary *primary;
 	GSList *l;
 
 	DBG("");
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover primary failed: %s", str);
@@ -1398,7 +1182,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 	hog->client = bt_gatt_client_ref(client);
 
 	if (!primary) {
-		discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
+		gatt_discover_primary(hog->attrib, NULL, primary_cb, hog);
 		return true;
 	}
 
@@ -1417,7 +1201,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
 	}
 
 	if (hog->reports == NULL) {
-		discover_char(hog, hog->attrib, primary->range.start,
+		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
 		return true;
@@ -1465,7 +1249,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->dis)
 		bt_dis_detach(hog->dis);
 
-	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	bt_gatt_client_unref(hog->client);
 	hog->client = NULL;
 	g_attrib_unref(hog->attrib);
@@ -1506,7 +1289,7 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		write_char(hog, hog->attrib, report->decl->value_handle,
+		gatt_write_char(hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-- 
1.9.1

