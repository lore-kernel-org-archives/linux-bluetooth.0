Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 23/25] android/scpp: Keep track on discover characteristic and descriptor
Date: Tue,  9 Dec 2014 16:11:45 +0100
Message-Id: <1418137907-16981-24-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/scpp.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index f8587af..d83ac51 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -75,6 +75,73 @@ static void destroy_gatt_req(struct gatt_request *req)
 	free(req);
 }
 
+static struct gatt_request *create_request(struct bt_scpp *scpp,
+							void *user_data)
+{
+	struct gatt_request *req;
+
+	DBG("");
+
+	req = new0(struct gatt_request, 1);
+	if (!req)
+		return NULL;
+
+	req->user_data = user_data;
+	req->scpp = bt_scpp_ref(scpp);
+
+	return req;
+}
+
+static bool set_and_store_gatt_req(struct bt_scpp *scpp,
+						struct gatt_request *req,
+						unsigned int id)
+{
+	req->req_id = id;
+	return queue_push_head(scpp->gatt_op, req);
+}
+
+static void discover_char(struct bt_scpp *scpp, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(scpp, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+
+	if (set_and_store_gatt_req(scpp, req, id))
+		return;
+
+	error("scpp: Could not discover characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
+				uint16_t start, uint16_t end, bt_uuid_t *uuid,
+				gatt_cb_t func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(scpp, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_desc(attrib, start, end, uuid, func, req);
+	if (set_and_store_gatt_req(scpp, req, id))
+		return;
+
+	error("scpp: Could not discover descriptor");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void scpp_free(struct bt_scpp *scan)
 {
 	bt_scpp_detach(scan);
@@ -154,7 +221,10 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct bt_scpp *scan = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_scpp *scan = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Write Scan Refresh CCC failed: %s",
@@ -200,11 +270,14 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct bt_scpp *scan = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_scpp *scan = req->user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
 	bt_uuid_t uuid;
 
+	destroy_gatt_req(req);
+
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
 		return;
@@ -229,15 +302,18 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	gatt_discover_desc(scan->attrib, start, end, &uuid,
+	discover_desc(scan, scan->attrib, start, end, &uuid,
 					discover_descriptor_cb, user_data);
 }
 
 static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct bt_scpp *scan = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_scpp *scan = req->user_data;
 	struct gatt_char *chr;
 
+	destroy_gatt_req(req);
+
 	if (status) {
 		error("Discover Scan Interval Window: %s",
 						att_ecode2str(status));
@@ -267,7 +343,7 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 								scan->window);
 	else {
 		bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-		gatt_discover_char(scan->attrib, scan->primary->range.start,
+		discover_char(scan, scan->attrib, scan->primary->range.start,
 					scan->primary->range.end, &iwin_uuid,
 					iwin_discovered_cb, scan);
 	}
@@ -278,7 +354,7 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 				refresh_value_cb, scan, NULL);
 	else {
 		bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
-		gatt_discover_char(scan->attrib, scan->primary->range.start,
+		discover_char(scan, scan->attrib, scan->primary->range.start,
 					scan->primary->range.end, &refresh_uuid,
 					refresh_discovered_cb, scan);
 	}
-- 
1.8.4

