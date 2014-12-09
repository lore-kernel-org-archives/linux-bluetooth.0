Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/25] android/hog: Cancel all GATT operations on disconnect
Date: Tue,  9 Dec 2014 16:11:32 +0100
Message-Id: <1418137907-16981-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that HOG cancels its GATT requests before
removing his attrib reference.

However some request might not be possible to cancel. It will be handled
in following patches
---
 android/hog.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index 95b7cb0..80bcc2e 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -111,6 +111,19 @@ struct report {
 	uint8_t			*value;
 };
 
+struct gatt_request {
+	unsigned int req_id;
+	struct bt_hog *hog;
+	void *user_data;
+};
+
+static void destroy_gatt_req(struct gatt_request *req)
+{
+	queue_remove(req->hog->gatt_op, req);
+	bt_hog_unref(req->hog);
+	free(req);
+}
+
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
@@ -774,6 +787,13 @@ static void report_free(void *data)
 	g_free(report);
 }
 
+static void cancel_gatt_req(struct gatt_request *req)
+{
+	DBG("Canceling ID %u", req->req_id);
+	if (g_attrib_cancel(req->hog->attrib, req->req_id))
+		destroy_gatt_req(req);
+}
+
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
@@ -789,7 +809,7 @@ static void hog_free(void *data)
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
 	g_free(hog->primary);
-	queue_destroy(hog->gatt_op, NULL);
+	queue_destroy(hog->gatt_op, (void *) destroy_gatt_req);
 	g_free(hog);
 }
 
@@ -1101,6 +1121,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->bas)
 		bt_bas_detach(hog->bas);
 
+	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.8.4

