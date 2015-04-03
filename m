Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 14/27] android/dis: Remove tracking pending gatt operations
Date: Fri,  3 Apr 2015 15:43:43 +0200
Message-Id: <1428068636-13073-15-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the use of bt_gatt_client there is no need to queue pending gatt
operations. bt_gatt_client already keeps track on that, so that
on bt_gatt_client_unref the queue of pending requests is destroyed.
---
 android/dis.c | 107 +++-------------------------------------------------------
 1 file changed, 4 insertions(+), 103 deletions(-)

diff --git a/android/dis.c b/android/dis.c
index 75dbe3d..f699046 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -57,7 +57,6 @@ struct bt_dis {
 	struct gatt_primary	*primary;	/* Primary details */
 	bt_dis_notify		notify;
 	void			*notify_data;
-	struct queue		*gatt_op;
 };
 
 struct characteristic {
@@ -65,25 +64,11 @@ struct characteristic {
 	struct bt_dis		*d;	/* deviceinfo where the char belongs */
 };
 
-struct gatt_request {
-	unsigned int id;
-	struct bt_dis *dis;
-	void *user_data;
-};
-
-static void destroy_gatt_req(struct gatt_request *req)
-{
-	queue_remove(req->dis->gatt_op, req);
-	bt_dis_unref(req->dis);
-	free(req);
-}
-
 static void dis_free(struct bt_dis *dis)
 {
 	bt_dis_detach(dis);
 
 	g_free(dis->primary);
-	queue_destroy(dis->gatt_op, (void *) destroy_gatt_req);
 	g_free(dis);
 }
 
@@ -95,12 +80,6 @@ struct bt_dis *bt_dis_new(void *primary)
 	if (!dis)
 		return NULL;
 
-	dis->gatt_op = queue_new();
-	if (!dis->gatt_op) {
-		dis_free(dis);
-		return NULL;
-	}
-
 	if (primary)
 		dis->primary = g_memdup(primary, sizeof(*dis->primary));
 
@@ -128,39 +107,13 @@ void bt_dis_unref(struct bt_dis *dis)
 	dis_free(dis);
 }
 
-static struct gatt_request *create_request(struct bt_dis *dis,
-							void *user_data)
-{
-	struct gatt_request *req;
-
-	req = new0(struct gatt_request, 1);
-	if (!req)
-		return NULL;
-
-	req->user_data = user_data;
-	req->dis = bt_dis_ref(dis);
-
-	return req;
-}
-
-static bool set_and_store_gatt_req(struct bt_dis *dis,
-						struct gatt_request *req,
-						unsigned int id)
-{
-	req->id = id;
-	return queue_push_head(dis->gatt_op, req);
-}
-
 static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_dis *dis = req->user_data;
+	struct bt_dis *dis = user_data;
 	uint8_t value[PNP_ID_SIZE];
 	ssize_t vlen;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Error reading PNP_ID value: %s", att_ecode2str(status));
 		return;
@@ -190,57 +143,12 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 						dis->version, dis->notify_data);
 }
 
-static void read_char(struct bt_dis *dis, GAttrib *attrib, uint16_t handle,
-				GAttribResultFunc func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(dis, user_data);
-	if (!req)
-		return;
-
-	id = gatt_read_char(attrib, handle, func, req);
-
-	if (set_and_store_gatt_req(dis, req, id))
-		return;
-
-	error("dis: Could not read characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_char(struct bt_dis *dis, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(dis, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	if (set_and_store_gatt_req(dis, req, id))
-		return;
-
-	error("dis: Could not send discover characteristic");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
 static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 								void *user_data)
 {
-	struct gatt_request *req = user_data;
-	struct bt_dis *d = req->user_data;
+	struct bt_dis *d = user_data;
 	GSList *l;
 
-	destroy_gatt_req(req);
-
 	if (status != 0) {
 		error("Discover deviceinfo characteristics: %s",
 							att_ecode2str(status));
@@ -252,7 +160,7 @@ static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 
 		if (strcmp(c->uuid, PNPID_UUID) == 0) {
 			d->handle = c->value_handle;
-			read_char(d, d->attrib, d->handle, read_pnpid_cb, d);
+			gatt_read_char(d->attrib, d->handle, read_pnpid_cb, d);
 			break;
 		}
 	}
@@ -268,25 +176,18 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 	dis->attrib = g_attrib_ref(attrib);
 
 	if (!dis->handle)
-		discover_char(dis, dis->attrib, primary->range.start,
+		gatt_discover_char(dis->attrib, primary->range.start,
 						primary->range.end, NULL,
 						configure_deviceinfo_cb, dis);
 
 	return true;
 }
 
-static void cancel_gatt_req(struct gatt_request *req)
-{
-	if (g_attrib_cancel(req->dis->attrib, req->id))
-		destroy_gatt_req(req);
-}
-
 void bt_dis_detach(struct bt_dis *dis)
 {
 	if (!dis->attrib)
 		return;
 
-	queue_foreach(dis->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(dis->attrib);
 	dis->attrib = NULL;
 }
-- 
1.9.1

