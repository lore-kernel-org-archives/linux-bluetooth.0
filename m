Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/hog: Write all report characteristics for bt_hog_send
Date: Tue,  1 Jul 2014 15:44:18 +0200
Message-Id: <1404222260-3936-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to write all hog report characeteristics (input, output,
feature). This is only test command designed for test purposes
e.g. PTS Write Report Characteristics.
---
 android/hog.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 319cb2a..019cd57 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1039,31 +1039,26 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 	return 0;
 }
 
-int bt_hog_send(struct bt_hog *hog, void *data, size_t size)
+static int write_report(struct bt_hog *hog, void *data, size_t size,
+							int report_type)
 {
 	struct report *report;
 	GSList *l;
 
-	if (!hog)
-		return -EINVAL;
-
-	if (!hog->attrib)
-		return -ENOTCONN;
-
-	l = g_slist_find_custom(hog->reports,
-				GUINT_TO_POINTER(HOG_REPORT_TYPE_OUTPUT),
-				report_type_cmp);
+	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(report_type),
+							report_type_cmp);
 	if (!l)
 		return -ENOTSUP;
 
 	report = l->data;
 
-	DBG("Sending data to handle 0x%X", report->decl->value_handle);
+	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
 		gatt_write_char(hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
-	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+
+	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		gatt_write_cmd(hog->attrib, report->decl->value_handle,
 						data, size, NULL, NULL);
 
@@ -1075,3 +1070,23 @@ int bt_hog_send(struct bt_hog *hog, void *data, size_t size)
 
 	return 0;
 }
+
+int bt_hog_send(struct bt_hog *hog, void *data, size_t size)
+{
+	if (!hog)
+		return -EINVAL;
+
+	if (!hog->attrib)
+		return -ENOTCONN;
+
+	if (write_report(hog, data, size, HOG_REPORT_TYPE_OUTPUT) < 0)
+		error("hog: can't write output report: %s", strerror(ENOTSUP));
+
+	if (write_report(hog, data, size, HOG_REPORT_TYPE_INPUT) < 0)
+		error("hog: can't write input report: %s", strerror(ENOTSUP));
+
+	if (write_report(hog, data, size, HOG_REPORT_TYPE_FEATURE) < 0)
+		error("hog: can't write feature report: %s", strerror(ENOTSUP));
+
+	return 0;
+}
-- 
1.9.3

