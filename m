Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 19/27] android/bas: Remove tracking pending gatt operations
Date: Fri,  3 Apr 2015 15:43:48 +0200
Message-Id: <1428068636-13073-20-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the use of bt_gatt_client there is no need to queue pending gatt
operations. bt_gatt_client already keeps track on that, so that
on bt_gatt_client_unref the queue of pending requests is destroyed.
---
 android/bas.c | 166 ++++------------------------------------------------------
 1 file changed, 9 insertions(+), 157 deletions(-)

diff --git a/android/bas.c b/android/bas.c
index dcbf9de..c5de3b1 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -55,28 +55,13 @@ struct bt_bas {
 	uint16_t handle;
 	uint16_t ccc_handle;
 	guint id;
-	struct queue *gatt_op;
 };
 
-struct gatt_request {
-	unsigned int id;
-	struct bt_bas *bas;
-	void *user_data;
-};
-
-static void destroy_gatt_req(struct gatt_request *req)
-{
-	queue_remove(req->bas->gatt_op, req);
-	bt_bas_unref(req->bas);
-	free(req);
-}
-
 static void bas_free(struct bt_bas *bas)
 {
 	bt_bas_detach(bas);
 
 	g_free(bas->primary);
-	queue_destroy(bas->gatt_op, (void *) destroy_gatt_req);
 	g_free(bas);
 }
 
@@ -88,12 +73,6 @@ struct bt_bas *bt_bas_new(void *primary)
 	if (!bas)
 		return NULL;
 
-	bas->gatt_op = queue_new();
-	if (!bas->gatt_op) {
-		bas_free(bas);
-		return NULL;
-	}
-
 	if (primary)
 		bas->primary = g_memdup(primary, sizeof(*bas->primary));
 
@@ -121,114 +100,6 @@ void bt_bas_unref(struct bt_bas *bas)
 	bas_free(bas);
 }
 
-static struct gatt_request *create_request(struct bt_bas *bas,
-							void *user_data)
-{
-	struct gatt_request *req;
-
-	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
-	req->user_data = user_data;
-	req->bas = bt_bas_ref(bas);
-
-	return req;
-}
-
-static bool set_and_store_gatt_req(struct bt_bas *bas,
-						struct gatt_request *req,
-						unsigned int id)
-{
-	req->id = id;
-	return queue_push_head(bas->gatt_op, req);
-}
-
-static void write_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					GAttribResultFunc func,
-					gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-	if (!req)
-		return;
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, req);
-
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not write characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-
-}
-
-static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
-				GAttribResultFunc func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-	if (!req)
-		return;
-
-	id = gatt_read_char(attrib, handle, func, req);
-
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not read characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_char(struct bt_bas *bas, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
-				uint16_t start, uint16_t end, bt_uuid_t *uuid,
-				gatt_cb_t func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(bas, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
-	if (set_and_store_gatt_req(bas, req, id))
-		return;
-
-	error("bas: Could not discover descriptor");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
 static void notification_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
@@ -243,10 +114,7 @@ static void read_value_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-
-	destroy_gatt_req(req);
+	struct bt_bas *bas = user_data;
 
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
@@ -268,17 +136,14 @@ static void write_ccc(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	write_char(bas, attrib, handle, value, sizeof(value), ccc_written_cb,
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
 								user_data);
 }
 
 static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
-
-	destroy_gatt_req(req);
+	struct bt_bas *bas = user_data;
 
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
@@ -291,12 +156,9 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
+	struct bt_bas *bas = user_data;
 	struct gatt_desc *desc;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
@@ -306,19 +168,16 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	desc = descs->data;
 	bas->ccc_handle = desc->handle;
 
-	read_char(bas, bas->attrib, desc->handle, ccc_read_cb, bas);
+	gatt_read_char(bas->attrib, desc->handle, ccc_read_cb, bas);
 }
 
 static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_bas *bas = req->user_data;
+	struct bt_bas *bas = user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
 	bt_uuid_t uuid;
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		error("Battery: %s", att_ecode2str(status));
 		return;
@@ -329,14 +188,14 @@ static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	DBG("Battery handle: 0x%04x", bas->handle);
 
-	read_char(bas, bas->attrib, bas->handle, read_value_cb, bas);
+	gatt_read_char(bas->attrib, bas->handle, read_value_cb, bas);
 
 	start = chr->value_handle + 1;
 	end = bas->primary->range.end;
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	discover_desc(bas, bas->attrib, start, end, &uuid,
+	gatt_discover_desc(bas->attrib, start, end, &uuid,
 						discover_descriptor_cb, bas);
 }
 
@@ -350,19 +209,13 @@ bool bt_bas_attach(struct bt_bas *bas, void *attrib)
 	if (bas->handle > 0)
 		return true;
 
-	discover_char(bas, bas->attrib, bas->primary->range.start,
+	gatt_discover_char(bas->attrib, bas->primary->range.start,
 					bas->primary->range.end, NULL,
 					bas_discovered_cb, bas);
 
 	return true;
 }
 
-static void cancel_gatt_req(struct gatt_request *req)
-{
-	if (g_attrib_cancel(req->bas->attrib, req->id))
-		destroy_gatt_req(req);
-}
-
 void bt_bas_detach(struct bt_bas *bas)
 {
 	if (!bas || !bas->attrib)
@@ -373,7 +226,6 @@ void bt_bas_detach(struct bt_bas *bas)
 		bas->id = 0;
 	}
 
-	queue_foreach(bas->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(bas->attrib);
 	bas->attrib = NULL;
 }
-- 
1.9.1

