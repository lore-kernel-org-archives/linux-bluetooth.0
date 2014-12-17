Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 12/19] android/bas: Add queue to keep track on GATT operations
Date: Wed, 17 Dec 2014 16:49:10 +0100
Message-Id: <1418831357-23100-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch BAS gets queue to keep GATT operations and cancel
operations on disconnect.
---
 android/bas.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/bas.c b/android/bas.c
index 7342895..dde05ee 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -34,6 +34,7 @@
 
 #include "lib/uuid.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -50,13 +51,28 @@ struct bt_bas {
 	uint16_t handle;
 	uint16_t ccc_handle;
 	guint id;
+	struct queue *gatt_op;
 };
 
+struct gatt_request {
+	unsigned int id;
+	struct bt_bas *bas;
+	void *user_data;
+};
+
+static void destroy_gatt_req(struct gatt_request *req)
+{
+	queue_remove(req->bas->gatt_op, req);
+	bt_bas_unref(req->bas);
+	free(req);
+}
+
 static void bas_free(struct bt_bas *bas)
 {
 	bt_bas_detach(bas);
 
 	g_free(bas->primary);
+	queue_destroy(bas->gatt_op, (void *) destroy_gatt_req);
 	g_free(bas);
 }
 
@@ -68,6 +84,12 @@ struct bt_bas *bt_bas_new(void *primary)
 	if (!bas)
 		return NULL;
 
+	bas->gatt_op = queue_new();
+	if (!bas->gatt_op) {
+		bas_free(bas);
+		return NULL;
+	}
+
 	if (primary)
 		bas->primary = g_memdup(primary, sizeof(*bas->primary));
 
@@ -202,6 +224,12 @@ bool bt_bas_attach(struct bt_bas *bas, void *attrib)
 	return true;
 }
 
+static void cancel_gatt_req(struct gatt_request *req)
+{
+	if (g_attrib_cancel(req->bas->attrib, req->id))
+		destroy_gatt_req(req);
+}
+
 void bt_bas_detach(struct bt_bas *bas)
 {
 	if (!bas || !bas->attrib)
@@ -212,6 +240,7 @@ void bt_bas_detach(struct bt_bas *bas)
 		bas->id = 0;
 	}
 
+	queue_foreach(bas->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(bas->attrib);
 	bas->attrib = NULL;
 }
-- 
1.8.4

