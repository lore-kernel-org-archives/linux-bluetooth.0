Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/25] android/hog: Keep track on primary and include service search
Date: Tue,  9 Dec 2014 16:11:34 +0100
Message-Id: <1418137907-16981-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 8823f21..cc81bfa 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -126,6 +126,29 @@ struct gatt_request {
 	void *user_data;
 };
 
+static struct gatt_request *create_request(struct bt_hog *hog,
+							void *user_data)
+{
+	struct gatt_request *req;
+
+	req = new0(struct gatt_request, 1);
+	if (!req)
+		return NULL;
+
+	req->user_data = user_data;
+	req->hog = bt_hog_ref(hog);
+
+	return req;
+}
+
+static bool set_and_store_gatt_req(struct bt_hog *hog,
+						struct gatt_request *req,
+						unsigned int id)
+{
+	req->req_id = id;
+	return queue_push_head(hog->gatt_op, req);
+}
+
 static void destroy_gatt_req(struct gatt_request *req)
 {
 	queue_remove(req->hog->gatt_op, req);
@@ -133,6 +156,48 @@ static void destroy_gatt_req(struct gatt_request *req)
 	free(req);
 }
 
+static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_primary(attrib, uuid, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not send discover primary");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void find_included(struct bt_hog *hog, GAttrib *attrib,
+					uint16_t start, uint16_t end,
+					gatt_cb_t func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_find_included(attrib, start, end, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("Could not find included");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
@@ -920,12 +985,15 @@ void bt_hog_unref(struct bt_hog *hog)
 static void find_included_cb(uint8_t status, GSList *services,
 							void *user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	struct gatt_included *include;
 	GSList *l;
 
 	DBG("");
 
+	destroy_gatt_req(req);
+
 	if (!hog_is_connected(hog))
 		return;
 
@@ -954,8 +1022,10 @@ static void find_included_cb(uint8_t status, GSList *services,
 		for (l = services; l; l = l->next) {
 			include = l->data;
 
-			gatt_find_included(hog->attrib, include->range.start,
-				include->range.end, find_included_cb, hog);
+			find_included(hog, hog->attrib,
+					include->range.start,
+					include->range.end, find_included_cb,
+					hog);
 		}
 		return;
 	}
@@ -1041,12 +1111,15 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	struct gatt_primary *primary;
 	GSList *l;
 
 	DBG("");
 
+	destroy_gatt_req(req);
+
 	if (!hog_is_connected(hog))
 		return;
 
@@ -1089,9 +1162,8 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	for (l = services; l; l = l->next) {
 		primary = l->data;
 
-		gatt_find_included(hog->attrib, primary->range.start,
-				primary->range.end, find_included_cb,
-				hog);
+		find_included(hog, hog->attrib, primary->range.start,
+				primary->range.end, find_included_cb, hog);
 	}
 }
 
@@ -1106,7 +1178,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	hog->attrib = g_attrib_ref(gatt);
 
 	if (!primary) {
-		gatt_discover_primary(hog->attrib, NULL, primary_cb, hog);
+		discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
 		return true;
 	}
 
-- 
1.8.4

