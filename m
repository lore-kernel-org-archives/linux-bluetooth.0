Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/12] android/hog: Add bt_hog_send
Date: Mon, 30 Jun 2014 16:47:48 +0300
Message-Id: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to send data using Output Report if one is
available.
---
 android/hog.c | 37 +++++++++++++++++++++++++++++++++++++
 android/hog.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 7e61790..5d33c63 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1009,3 +1009,40 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 
 	return 0;
 }
+
+int bt_hog_send(struct bt_hog *hog, void *data, size_t size)
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
+	l = g_slist_find_custom(hog->reports,
+				GUINT_TO_POINTER(HOG_REPORT_TYPE_OUTPUT),
+				report_type_cmp);
+	if (!l)
+		return -ENOTSUP;
+
+	report = l->data;
+
+	DBG("Sending data to handle 0x%X", report->decl->value_handle);
+
+	if (report->decl->properties & GATT_CHR_PROP_WRITE)
+		gatt_write_char(hog->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hog);
+	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+		gatt_write_cmd(hog->attrib, report->decl->value_handle,
+						data, size, NULL, NULL);
+
+	for (l = hog->instances; l; l = l->next) {
+		struct bt_hog *instance = l->data;
+
+		bt_hog_send(instance, data, size);
+	}
+
+	return 0;
+}
diff --git a/android/hog.h b/android/hog.h
index 7cf446b..4ebc83e 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -33,3 +33,4 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt);
 void bt_hog_detach(struct bt_hog *hog);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
+int bt_hog_send(struct bt_hog *hog, void *data, size_t size);
-- 
1.9.3

