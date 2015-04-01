Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 08/28] android/hog: Replace gatt_write_char with bt_gatt_client_write_value
Date: Wed,  1 Apr 2015 18:40:24 +0200
Message-Id: <1427906444-11769-9-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index bcda1af..85a2b6a 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -411,10 +411,9 @@ static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
 	return find_report(hog, type, id);
 }
 
-static void output_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void output_written_cb(bool success, uint8_t status, void *user_data)
 {
-	if (status != 0) {
+	if (!success) {
 		error("Write output report failed: %s", att_ecode2str(status));
 		return;
 	}
@@ -442,12 +441,14 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->decl->value_handle);
 
-	if (hog->attrib == NULL)
+	if (hog->client == NULL)
 		return;
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hog->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hog);
+		bt_gatt_client_write_value(hog->client,
+						report->decl->value_handle,
+						data, size, output_written_cb,
+						hog, NULL);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		bt_gatt_client_write_without_response(hog->client,
 						report->decl->value_handle,
@@ -486,8 +487,7 @@ done:
 		error("bt_uhid_send: %s", strerror(-err));
 }
 
-static void set_report_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void set_report_cb(bool success, uint8_t status, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct uhid_event rsp;
@@ -500,7 +500,7 @@ static void set_report_cb(guint8 status, const guint8 *pdu,
 	rsp.u.set_report_reply.id = hog->setrep_id;
 	rsp.u.set_report_reply.err = status;
 
-	if (status != 0)
+	if (!success)
 		error("Error setting Report value: %s", att_ecode2str(status));
 
 	err = bt_uhid_send(hog->uhid, &rsp);
@@ -518,7 +518,7 @@ static void set_report(struct uhid_event *ev, void *user_data)
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->setrep_att) {
-		g_attrib_cancel(hog->attrib, hog->setrep_att);
+		bt_gatt_client_cancel(hog->client, hog->setrep_att);
 		hog->setrep_att = 0;
 	}
 
@@ -541,13 +541,13 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->decl->value_handle);
 
-	if (hog->attrib == NULL)
+	if (hog->client == NULL)
 		return;
 
-	hog->setrep_att = gatt_write_char(hog->attrib,
-						report->decl->value_handle,
-						data, size, set_report_cb,
-						hog);
+	hog->setrep_att = bt_gatt_client_write_value(hog->client,
+					report->decl->value_handle, data, size,
+					set_report_cb, hog, NULL);
+
 	if (!hog->setrep_att) {
 		err = ENOMEM;
 		goto fail;
@@ -556,7 +556,7 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	return;
 fail:
 	/* cancel the request on failure */
-	set_report_cb(err, NULL, 0, hog);
+	set_report_cb(false, err, hog);
 }
 
 static void get_report_cb(bool success, uint8_t status, const uint8_t *value,
@@ -1239,8 +1239,10 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hog->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hog);
+		bt_gatt_client_write_value(hog->client,
+						report->decl->value_handle,
+						data, size, output_written_cb,
+						hog, NULL);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		bt_gatt_client_write_without_response(hog->client,
-- 
1.9.1

