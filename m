Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 20/25] android/dis: Keep track on discover and read characteristic
Date: Tue,  9 Dec 2014 16:11:42 +0100
Message-Id: <1418137907-16981-21-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/dis.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/android/dis.c b/android/dis.c
index 2f4a3b9..0200ab8 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -125,13 +125,39 @@ void bt_dis_unref(struct bt_dis *dis)
 	dis_free(dis);
 }
 
+static struct gatt_request *create_request(struct bt_dis *dis,
+							void *user_data)
+{
+	struct gatt_request *req;
+
+	req = new0(struct gatt_request, 1);
+	if (!req)
+		return NULL;
+
+	req->user_data = user_data;
+	req->dis = bt_dis_ref(dis);
+
+	return req;
+}
+
+static bool set_and_store_gatt_req(struct bt_dis *dis,
+						struct gatt_request *req,
+						unsigned int id)
+{
+	req->req_id = id;
+	return queue_push_head(dis->gatt_op, req);
+}
+
 static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct bt_dis *dis = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_dis *dis = req->user_data;
 	uint8_t value[PNP_ID_SIZE];
 	ssize_t vlen;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Error reading PNP_ID value: %s", att_ecode2str(status));
 		return;
@@ -161,12 +187,57 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 						dis->version, dis->notify_data);
 }
 
+static void read_char(struct bt_dis *dis, GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(dis, user_data);
+	if (!req)
+		return;
+
+	id = gatt_read_char(attrib, handle, func, req);
+
+	if (set_and_store_gatt_req(dis, req, id))
+		return;
+
+	error("dis: Could not read characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_char(struct bt_dis *dis, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(dis, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+
+	if (set_and_store_gatt_req(dis, req, id))
+		return;
+
+	error("dis: Could not send discover characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 								void *user_data)
 {
-	struct bt_dis *d = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_dis *d = req->user_data;
 	GSList *l;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Discover deviceinfo characteristics: %s",
 							att_ecode2str(status));
@@ -178,7 +249,7 @@ static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 
 		if (strcmp(c->uuid, PNPID_UUID) == 0) {
 			d->handle = c->value_handle;
-			gatt_read_char(d->attrib, d->handle, read_pnpid_cb, d);
+			read_char(d, d->attrib, d->handle, read_pnpid_cb, d);
 			break;
 		}
 	}
@@ -194,7 +265,7 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 	dis->attrib = g_attrib_ref(attrib);
 
 	if (!dis->handle)
-		gatt_discover_char(dis->attrib, primary->range.start,
+		discover_char(dis, dis->attrib, primary->range.start,
 						primary->range.end, NULL,
 						configure_deviceinfo_cb, dis);
 
-- 
1.8.4

