Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/25] android/hog: Keep track on discover characteristic and descriptors
Date: Tue,  9 Dec 2014 16:11:35 +0100
Message-Id: <1418137907-16981-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index cc81bfa..ea80db4 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -156,6 +156,48 @@ static void destroy_gatt_req(struct gatt_request *req)
 	free(req);
 }
 
+static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
+				uint16_t start, uint16_t end, gatt_cb_t func,
+				gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_desc(attrib, start, end, NULL, func, req);
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not discover descriptors");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_char(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
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
+	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not discover characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
 						bt_uuid_t *uuid, gatt_cb_t func,
 						gpointer user_data)
@@ -325,7 +367,10 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 static void discover_external_cb(uint8_t status, GSList *descs,
 							void *user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (!hog_is_connected(hog))
 		return;
@@ -340,12 +385,14 @@ static void discover_external_cb(uint8_t status, GSList *descs,
 		struct gatt_desc *desc = descs->data;
 
 		gatt_read_char(hog->attrib, desc->handle,
-					external_report_reference_cb, hog);
+						external_report_reference_cb,
+						hog);
 	}
 }
 
-static void discover_external(GAttrib *attrib, uint16_t start, uint16_t end,
-							gpointer user_data)
+static void discover_external(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						gpointer user_data)
 {
 	bt_uuid_t uuid;
 
@@ -354,16 +401,19 @@ static void discover_external(GAttrib *attrib, uint16_t start, uint16_t end,
 
 	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
 
-	gatt_discover_desc(attrib, start, end, NULL, discover_external_cb,
+	discover_desc(hog, attrib, start, end, discover_external_cb,
 								user_data);
 }
 
 static void discover_report_cb(uint8_t status, GSList *descs,
 							void *user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct report *report = req->user_data;
 	struct bt_hog *hog = report->hog;
 
+	destroy_gatt_req(req);
+
 	if (!hog_is_connected(hog))
 		return;
 
@@ -388,14 +438,14 @@ static void discover_report_cb(uint8_t status, GSList *descs,
 	}
 }
 
-static void discover_report(GAttrib *attrib, uint16_t start, uint16_t end,
+static void discover_report(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
 							gpointer user_data)
 {
 	if (start > end)
 		return;
 
-	gatt_discover_desc(attrib, start, end, NULL, discover_report_cb,
-								user_data);
+	discover_desc(hog, attrib, start, end, discover_report_cb, user_data);
 }
 
 static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
@@ -435,11 +485,14 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	struct gatt_primary *primary = hog->primary;
 	struct report *report;
 	GSList *l;
 
+	destroy_gatt_req(req);
+
 	if (!hog_is_connected(hog))
 		return;
 
@@ -462,7 +515,7 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 		report = report_new(hog, chr);
 		start = chr->value_handle + 1;
 		end = (next ? next->handle - 1 : primary->range.end);
-		discover_report(hog->attrib, start, end, report);
+		discover_report(hog, hog->attrib, start, end, report);
 	}
 }
 
@@ -496,11 +549,10 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
+	discover_char(hog, hog->attrib, 0x0001, 0xffff, &uuid,
 					external_service_char_cb, hog);
 }
 
-
 static int report_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct report *ra = a, *rb = b;
@@ -827,7 +879,8 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void char_discovered_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct bt_hog *hog = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
@@ -835,9 +888,11 @@ static void char_discovered_cb(uint8_t status, GSList *chars,
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
 
+	destroy_gatt_req(req);
 
 	if (!hog_is_connected(hog))
 		return;
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -868,11 +923,11 @@ static void char_discovered_cb(uint8_t status, GSList *chars,
 
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
 			report = report_new(hog, chr);
-			discover_report(hog->attrib, start, end, report);
+			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hog->attrib, chr->value_handle,
 						report_map_read_cb, hog);
-			discover_external(hog->attrib, start, end, hog);
+			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
@@ -1034,7 +1089,7 @@ static void find_included_cb(uint8_t status, GSList *services,
 	memcpy(hog->primary->uuid, include->uuid, sizeof(include->uuid));
 	memcpy(&hog->primary->range, &include->range, sizeof(include->range));
 
-	gatt_discover_char(hog->attrib, hog->primary->range.start,
+	discover_char(hog, hog->attrib, hog->primary->range.start,
 						hog->primary->range.end, NULL,
 						char_discovered_cb, hog);
 }
@@ -1094,7 +1149,7 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 
 	if (!hog->primary) {
 		hog->primary = g_memdup(primary, sizeof(*primary));
-		gatt_discover_char(hog->attrib, primary->range.start,
+		discover_char(hog, hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
 		return;
@@ -1198,7 +1253,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	}
 
 	if (hog->reports == NULL) {
-		gatt_discover_char(hog->attrib, primary->range.start,
+		discover_char(hog, hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
 		return true;
-- 
1.8.4

