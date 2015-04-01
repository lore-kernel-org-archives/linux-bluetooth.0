Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 17/28] android/scpp: Remove tracking pending gatt operations
Date: Wed,  1 Apr 2015 18:40:33 +0200
Message-Id: <1427906444-11769-18-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mariusz Skamra <mariusz.skamra@gmail.com>

Since the use of bt_gatt_client there is no need to queue pending gatt
operations. bt_gatt_client already keeps track on that, so that
on bt_gatt_client_unref the queue of pending requests is destroyed.
---
 android/scpp.c | 72 ++++------------------------------------------------------
 1 file changed, 4 insertions(+), 68 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index f8f81f3..a28fbb6 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -62,62 +62,13 @@ struct bt_scpp {
 	uint16_t iwhandle;
 	uint16_t refresh_handle;
 	guint refresh_cb_id;
-	struct queue *gatt_op;
 };
 
-static void discover_char(struct bt_scpp *scpp, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	unsigned int id;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, user_data);
-
-	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
-}
-
-static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
-				uint16_t start, uint16_t end, bt_uuid_t *uuid,
-				gatt_cb_t func, gpointer user_data)
-{
-	unsigned int id;
-
-	id = gatt_discover_desc(attrib, start, end, uuid, func, user_data);
-
-	if (queue_push_head(scpp->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not discover descriptor");
-	g_attrib_cancel(attrib, id);
-}
-
-static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					GAttribResultFunc func,
-					gpointer user_data)
-{
-	unsigned int id;
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, user_data);
-
-	if (queue_push_head(scan->gatt_op, UINT_TO_PTR(id)))
-		return;
-
-	error("scpp: Could not read char");
-	g_attrib_cancel(attrib, id);
-}
-
 static void scpp_free(struct bt_scpp *scan)
 {
 	bt_scpp_detach(scan);
 
 	g_free(scan->primary);
-	queue_destroy(scan->gatt_op, NULL); /* cleared in bt_scpp_detach */
 	g_free(scan);
 }
 
@@ -132,12 +83,6 @@ struct bt_scpp *bt_scpp_new(void *primary)
 	scan->interval = SCAN_INTERVAL;
 	scan->window = SCAN_WINDOW;
 
-	scan->gatt_op = queue_new();
-	if (!scan->gatt_op) {
-		scpp_free(scan);
-		return NULL;
-	}
-
 	if (primary)
 		scan->primary = g_memdup(primary, sizeof(*scan->primary));
 
@@ -213,7 +158,7 @@ static void write_ccc(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	write_char(scan, attrib, handle, value, sizeof(value), ccc_written_cb,
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
 								user_data);
 }
 
@@ -266,7 +211,7 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
-	discover_desc(scan, scan->attrib, start, end, &uuid,
+	gatt_discover_desc(scan->attrib, start, end, &uuid,
 					discover_descriptor_cb, user_data);
 }
 
@@ -304,7 +249,7 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 								scan->window);
 	else {
 		bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-		discover_char(scan, scan->attrib, scan->primary->range.start,
+		gatt_discover_char(scan->attrib, scan->primary->range.start,
 					scan->primary->range.end, &iwin_uuid,
 					iwin_discovered_cb, scan);
 	}
@@ -315,7 +260,7 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 				refresh_value_cb, scan, NULL);
 	else {
 		bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
-		discover_char(scan, scan->attrib, scan->primary->range.start,
+		gatt_discover_char(scan->attrib, scan->primary->range.start,
 					scan->primary->range.end, &refresh_uuid,
 					refresh_discovered_cb, scan);
 	}
@@ -323,14 +268,6 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 	return true;
 }
 
-static void cancel_gatt_req(void *data, void *user_data)
-{
-	unsigned int id = PTR_TO_UINT(data);
-	struct bt_scpp *scan = user_data;
-
-	g_attrib_cancel(scan->attrib, id);
-}
-
 void bt_scpp_detach(struct bt_scpp *scan)
 {
 	if (!scan || !scan->attrib)
@@ -341,7 +278,6 @@ void bt_scpp_detach(struct bt_scpp *scan)
 		scan->refresh_cb_id = 0;
 	}
 
-	queue_foreach(scan->gatt_op, cancel_gatt_req, scan);
 	g_attrib_unref(scan->attrib);
 	scan->attrib = NULL;
 }
-- 
1.9.1

