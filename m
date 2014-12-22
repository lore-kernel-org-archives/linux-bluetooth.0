Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/scpp: Simplify requests queueing
Date: Mon, 22 Dec 2014 18:20:40 +0100
Message-Id: <1419268840-20902-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to use request structure for tracking queue since
we only need id.
---
 android/scpp.c | 99 ++++++++++------------------------------------------------
 1 file changed, 17 insertions(+), 82 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index 77f48cd..1d5bf7c 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -62,84 +62,35 @@ struct bt_scpp {
 	struct queue *gatt_op;
 };
 
-struct gatt_request {
-	unsigned int id;
-	struct bt_scpp *scpp;
-	void *user_data;
-};
-
-static void destroy_gatt_req(struct gatt_request *req)
-{
-	queue_remove(req->scpp->gatt_op, req);
-	bt_scpp_unref(req->scpp);
-	free(req);
-}
-
-static struct gatt_request *create_request(struct bt_scpp *scpp,
-							void *user_data)
-{
-	struct gatt_request *req;
-
-	DBG("");
-
-	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
-	req->user_data = user_data;
-	req->scpp = bt_scpp_ref(scpp);
-
-	return req;
-}
-
-static bool set_and_store_gatt_req(struct bt_scpp *scpp,
-						struct gatt_request *req,
-						unsigned int id)
-{
-	req->id = id;
-	return queue_push_head(scpp->gatt_op, req);
-}
-
 static void discover_char(struct bt_scpp *scpp, GAttrib *attrib,
 						uint16_t start, uint16_t end,
 						bt_uuid_t *uuid, gatt_cb_t func,
 						gpointer user_data)
 {
-	struct gatt_request *req;
 	unsigned int id;
 
-	req = create_request(scpp, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+	id = gatt_discover_char(attrib, start, end, uuid, func, user_data);
 
-	if (set_and_store_gatt_req(scpp, req, id))
+	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
 		return;
 
 	error("scpp: Could not discover characteristic");
 	g_attrib_cancel(attrib, id);
-	free(req);
 }
 
 static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
 				uint16_t start, uint16_t end, bt_uuid_t *uuid,
 				gatt_cb_t func, gpointer user_data)
 {
-	struct gatt_request *req;
 	unsigned int id;
 
-	req = create_request(scpp, user_data);
-	if (!req)
-		return;
+	id = gatt_discover_desc(attrib, start, end, uuid, func, user_data);
 
-	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
-	if (set_and_store_gatt_req(scpp, req, id))
+	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
 		return;
 
 	error("scpp: Could not discover descriptor");
 	g_attrib_cancel(attrib, id);
-	free(req);
 }
 
 static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
@@ -147,21 +98,15 @@ static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
 					GAttribResultFunc func,
 					gpointer user_data)
 {
-	struct gatt_request *req;
 	unsigned int id;
 
-	req = create_request(scan, user_data);
-	if (!req)
-		return;
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, req);
+	id = gatt_write_char(attrib, handle, value, vlen, func, user_data);
 
-	if (set_and_store_gatt_req(scan, req, id))
+	if (queue_push_head(scan->gatt_op, UINT_TO_PTR(id)))
 		return;
 
 	error("scpp: Could not read char");
 	g_attrib_cancel(attrib, id);
-	free(req);
 }
 
 static void scpp_free(struct bt_scpp *scan)
@@ -169,7 +114,7 @@ static void scpp_free(struct bt_scpp *scan)
 	bt_scpp_detach(scan);
 
 	g_free(scan->primary);
-	queue_destroy(scan->gatt_op, (void *) destroy_gatt_req);
+	queue_destroy(scan->gatt_op, NULL); /* cleared in bt_scpp_detach */
 	g_free(scan);
 }
 
@@ -243,10 +188,7 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_scpp *scan = req->user_data;
-
-	destroy_gatt_req(req);
+	struct bt_scpp *scan = user_data;
 
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
@@ -275,12 +217,9 @@ static void write_ccc(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_scpp *scan = req->user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_desc *desc;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
@@ -295,14 +234,11 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_scpp *scan = req->user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
 	bt_uuid_t uuid;
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
 		return;
@@ -333,12 +269,9 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_scpp *scan = req->user_data;
+	struct bt_scpp *scan = user_data;
 	struct gatt_char *chr;
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		error("Discover Scan Interval Window: %s",
 						att_ecode2str(status));
@@ -387,10 +320,12 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 	return true;
 }
 
-static void cancel_gatt_req(struct gatt_request *req)
+static void cancel_gatt_req(void *data, void *user_data)
 {
-	if (g_attrib_cancel(req->scpp->attrib, req->id))
-		destroy_gatt_req(req);
+	unsigned int id = PTR_TO_UINT(data);
+	struct bt_scpp *scan = user_data;
+
+	g_attrib_cancel(scan->attrib, id);
 }
 
 void bt_scpp_detach(struct bt_scpp *scan)
@@ -403,7 +338,7 @@ void bt_scpp_detach(struct bt_scpp *scan)
 		scan->refresh_cb_id = 0;
 	}
 
-	queue_foreach(scan->gatt_op, (void *) cancel_gatt_req, NULL);
+	queue_foreach(scan->gatt_op, cancel_gatt_req, scan);
 	g_attrib_unref(scan->attrib);
 	scan->attrib = NULL;
 }
-- 
1.9.3

