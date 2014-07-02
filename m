Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 1/3] android/hog: Add bt_hog_send_report
Date: Wed,  2 Jul 2014 09:58:10 +0200
Message-Id: <1404287892-13170-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to send data using specified report if one is
available.
---
 android/hog.c | 37 +++++++++++++++++++++++++++++++++++++
 android/hog.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 43bd266..9f8c7e5 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1038,3 +1038,40 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 
 	return 0;
 }
+
+int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
+{
+	struct report *report;
+	GSList *l;
+
+	if (!hog)
+		return -EINVAL;
+
+	if (!hog->attrib)
+		return -ENOTCONN;
+
+	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(type),
+							report_type_cmp);
+	if (!l)
+		return -ENOTSUP;
+
+	report = l->data;
+
+	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
+
+	if (report->decl->properties & GATT_CHR_PROP_WRITE)
+		gatt_write_char(hog->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hog);
+
+	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+		gatt_write_cmd(hog->attrib, report->decl->value_handle,
+						data, size, NULL, NULL);
+
+	for (l = hog->instances; l; l = l->next) {
+		struct bt_hog *instance = l->data;
+
+		bt_hog_send_report(instance, data, size, type);
+	}
+
+	return 0;
+}
diff --git a/android/hog.h b/android/hog.h
index 7cf446b..ddb2cea 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -33,3 +33,4 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt);
 void bt_hog_detach(struct bt_hog *hog);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
+int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
-- 
1.9.1

