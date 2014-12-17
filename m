Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 14/19] android/bas: Keep track on discover characteristic and descriptor
Date: Wed, 17 Dec 2014 16:49:12 +0100
Message-Id: <1418831357-23100-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bas.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/android/bas.c b/android/bas.c
index 87402c1..e5e9837 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -183,6 +183,48 @@ static void read_char(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
 	free(req);
 }
 
+static void discover_char(struct bt_bas *bas, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(bas, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+
+	if (set_and_store_gatt_req(bas, req, id))
+		return;
+
+	error("bas: Could not discover characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
+				uint16_t start, uint16_t end, bt_uuid_t *uuid,
+				gatt_cb_t func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(bas, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
+	if (set_and_store_gatt_req(bas, req, id))
+		return;
+
+	error("bas: Could not discover descriptor");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
@@ -238,9 +280,12 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct bt_bas *bas = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_bas *bas = req->user_data;
 	struct gatt_desc *desc;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
@@ -255,11 +300,14 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct bt_bas *bas = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_bas *bas = req->user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
 	bt_uuid_t uuid;
 
+	destroy_gatt_req(req);
+
 	if (status) {
 		error("Battery: %s", att_ecode2str(status));
 		return;
@@ -275,7 +323,7 @@ static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	gatt_discover_desc(bas->attrib, start, end, &uuid,
+	discover_desc(bas, bas->attrib, start, end, &uuid,
 						discover_descriptor_cb, bas);
 }
 
@@ -289,7 +337,7 @@ bool bt_bas_attach(struct bt_bas *bas, void *attrib)
 	if (bas->handle > 0)
 		return true;
 
-	gatt_discover_char(bas->attrib, bas->primary->range.start,
+	discover_char(bas, bas->attrib, bas->primary->range.start,
 					bas->primary->range.end, NULL,
 					bas_discovered_cb, bas);
 
-- 
1.8.4

