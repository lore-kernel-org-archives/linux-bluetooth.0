Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 19/25] android/dis: Add queue to keep track on GATT operations
Date: Tue,  9 Dec 2014 16:11:41 +0100
Message-Id: <1418137907-16981-20-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch GATT operation queue has been added together with
canceling ongoing GATT operations on disconnect
---
 android/dis.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/dis.c b/android/dis.c
index 0a2a18e..2f4a3b9 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -33,6 +33,7 @@
 
 #include "lib/uuid.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -53,6 +54,7 @@ struct bt_dis {
 	struct gatt_primary	*primary;	/* Primary details */
 	bt_dis_notify		notify;
 	void			*notify_data;
+	struct queue		*gatt_op;
 };
 
 struct characteristic {
@@ -60,11 +62,25 @@ struct characteristic {
 	struct bt_dis		*d;	/* deviceinfo where the char belongs */
 };
 
+struct gatt_request {
+	unsigned int req_id;
+	struct bt_dis *dis;
+	void *user_data;
+};
+
+static void destroy_gatt_req(struct gatt_request *req)
+{
+	queue_remove(req->dis->gatt_op, req);
+	bt_dis_unref(req->dis);
+	free(req);
+}
+
 static void dis_free(struct bt_dis *dis)
 {
 	bt_dis_detach(dis);
 
 	g_free(dis->primary);
+	queue_destroy(dis->gatt_op, (void *) destroy_gatt_req);
 	g_free(dis);
 }
 
@@ -76,6 +92,12 @@ struct bt_dis *bt_dis_new(void *primary)
 	if (!dis)
 		return NULL;
 
+	dis->gatt_op = queue_new();
+	if (!dis->gatt_op) {
+		dis_free(dis);
+		return NULL;
+	}
+
 	if (primary)
 		dis->primary = g_memdup(primary, sizeof(*dis->primary));
 
@@ -179,11 +201,18 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 	return true;
 }
 
+static void cancel_gatt_req(struct gatt_request *req)
+{
+	if (g_attrib_cancel(req->dis->attrib, req->req_id))
+		destroy_gatt_req(req);
+}
+
 void bt_dis_detach(struct bt_dis *dis)
 {
 	if (!dis->attrib)
 		return;
 
+	queue_foreach(dis->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(dis->attrib);
 	dis->attrib = NULL;
 }
-- 
1.8.4

