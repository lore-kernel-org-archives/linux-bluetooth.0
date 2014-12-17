Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 08/19] android/hog: Cancel all GATT operations on disconnect
Date: Wed, 17 Dec 2014 16:49:06 +0100
Message-Id: <1418831357-23100-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that HOG cancels its GATT requests before
removing his attrib reference.

However some request might not be possible to cancel. It will be handled
in following patches
---
 android/hog.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index b87fd2f..0e0eafe 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -111,6 +111,19 @@ struct report {
 	uint8_t			*value;
 };
 
+struct gatt_request {
+	unsigned int id;
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
@@ -770,6 +783,12 @@ static void report_free(void *data)
 	g_free(report);
 }
 
+static void cancel_gatt_req(struct gatt_request *req)
+{
+	if (g_attrib_cancel(req->hog->attrib, req->id))
+		destroy_gatt_req(req);
+}
+
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
@@ -785,7 +804,7 @@ static void hog_free(void *data)
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
 	g_free(hog->primary);
-	queue_destroy(hog->gatt_op, NULL);
+	queue_destroy(hog->gatt_op, (void *) destroy_gatt_req);
 	g_free(hog);
 }
 
@@ -1093,6 +1112,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->bas)
 		bt_bas_detach(hog->bas);
 
+	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.8.4

