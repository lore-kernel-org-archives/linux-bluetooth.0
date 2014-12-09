Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 16/25] android/bas: Keep track read/write GATT operations
Date: Tue,  9 Dec 2014 16:11:38 +0100
Message-Id: <1418137907-16981-17-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bas.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/android/bas.c b/android/bas.c
index bbcd505..9056095 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -117,6 +117,72 @@ void bt_bas_unref(struct bt_bas *bas)
 	bas_free(bas);
 }
 
+static struct gatt_request *create_request(struct bt_bas *bas,
+							void *user_data)
+{
+	struct gatt_request *req;
+
+	req = new0(struct gatt_request, 1);
+	if (!req)
+		return NULL;
+
+	req->user_data = user_data;
+	req->bas = bt_bas_ref(bas);
+
+	return req;
+}
+
+static bool set_and_store_gatt_req(struct bt_bas *bas,
+						struct gatt_request *req,
+						unsigned int id)
+{
+	req->req_id = id;
+	return queue_push_head(bas->gatt_op, req);
+}
+
+static void write_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(bas, user_data);
+	if (!req)
+		return;
+
+	id = gatt_write_char(attrib, handle, value, vlen, func, req);
+
+	if (set_and_store_gatt_req(bas, req, id))
+		return;
+
+	error("bas: Could not write characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+
+}
+
+static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(bas, user_data);
+	if (!req)
+		return;
+
+	id = gatt_read_char(attrib, handle, func, req);
+
+	if (set_and_store_gatt_req(bas, req, id))
+		return;
+
+	error("bas: Could not read characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
@@ -125,7 +191,10 @@ static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct bt_bas *bas = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_bas *bas = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
@@ -139,28 +208,31 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					bas->handle, value_cb, bas, NULL);
 }
 
-static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
+static void write_ccc(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
+							void *user_data)
 {
 	uint8_t value[2];
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+	write_char(bas, attrib, handle, value, sizeof(value), ccc_written_cb,
 								user_data);
 }
 
-
 static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct bt_bas *bas = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_bas *bas = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
 		return;
 	}
 
-	write_ccc(bas->attrib, bas->ccc_handle, bas);
+	write_ccc(bas, bas->attrib, bas->ccc_handle, bas);
 }
 
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
@@ -178,7 +250,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	desc = descs->data;
 	bas->ccc_handle = desc->handle;
 
-	gatt_read_char(bas->attrib, desc->handle, ccc_read_cb, bas);
+	read_char(bas, bas->attrib, desc->handle, ccc_read_cb, bas);
 }
 
 static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-- 
1.8.4

