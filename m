Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 22/25] android/scpp: Add queue to keep GATT operations
Date: Tue,  9 Dec 2014 16:11:44 +0100
Message-Id: <1418137907-16981-23-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch SCPP gets queue to track GATT operations and also cancel
requests on SCPP disconnect
---
 android/scpp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/scpp.c b/android/scpp.c
index 9d8bb10..f8587af 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -35,6 +35,7 @@
 
 #include "lib/uuid.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
@@ -58,13 +59,28 @@ struct bt_scpp {
 	uint16_t iwhandle;
 	uint16_t refresh_handle;
 	guint refresh_cb_id;
+	struct queue *gatt_op;
 };
 
+struct gatt_request {
+	unsigned int req_id;
+	struct bt_scpp *scpp;
+	void *user_data;
+};
+
+static void destroy_gatt_req(struct gatt_request *req)
+{
+	queue_remove(req->scpp->gatt_op, req);
+	bt_scpp_unref(req->scpp);
+	free(req);
+}
+
 static void scpp_free(struct bt_scpp *scan)
 {
 	bt_scpp_detach(scan);
 
 	g_free(scan->primary);
+	queue_destroy(scan->gatt_op, (void *) destroy_gatt_req);
 	g_free(scan);
 }
 
@@ -79,6 +95,12 @@ struct bt_scpp *bt_scpp_new(void *primary)
 	scan->interval = SCAN_INTERVAL;
 	scan->window = SCAN_WINDOW;
 
+	scan->gatt_op = queue_new();
+	if (!scan->gatt_op) {
+		scpp_free(scan);
+		return NULL;
+	}
+
 	if (primary)
 		scan->primary = g_memdup(primary, sizeof(*scan->primary));
 
@@ -264,6 +286,12 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 	return true;
 }
 
+static void cancel_gatt_req(struct gatt_request *req)
+{
+	if (g_attrib_cancel(req->scpp->attrib, req->req_id))
+		destroy_gatt_req(req);
+}
+
 void bt_scpp_detach(struct bt_scpp *scan)
 {
 	if (!scan || !scan->attrib)
@@ -274,6 +302,7 @@ void bt_scpp_detach(struct bt_scpp *scan)
 		scan->refresh_cb_id = 0;
 	}
 
+	queue_foreach(scan->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(scan->attrib);
 	scan->attrib = NULL;
 }
-- 
1.8.4

