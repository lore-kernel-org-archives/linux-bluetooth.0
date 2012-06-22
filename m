Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 15/19] hog: Handle output reports
Date: Fri, 22 Jun 2012 12:08:03 -0300
Message-Id: <1340377687-4711-16-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch writes the output reports coming from the HID host on the
device's Output Report characteristic.
---
 input/hog_device.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index cd5d1bf..50394e7 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -54,6 +54,9 @@
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
 
+#define HOG_REPORT_TYPE_INPUT	1
+#define HOG_REPORT_TYPE_OUTPUT	2
+
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
@@ -337,6 +340,54 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	}
 }
 
+static void output_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Write output report failed: %s", att_ecode2str(status));
+		return;
+	}
+}
+
+static gint report_type_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct report *report = a;
+	uint8_t type = GPOINTER_TO_UINT(b);
+
+	return report->type - type;
+}
+
+static void forward_report(struct hog_device *hogdev,
+						struct uhid_event *ev)
+{
+	struct report *report;
+	GSList *l;
+	void *data;
+	int size;
+	guint type;
+
+	type = HOG_REPORT_TYPE_OUTPUT;
+	data = ev->u.output.data;
+	size = ev->u.output.size;
+
+	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
+							report_type_cmp);
+	if (!l)
+		return;
+
+	report = l->data;
+
+	DBG("Sending report type %d to device %s handle 0x%X", type,
+				hogdev->path, report->decl->value_handle);
+
+	if (report->decl->properties & ATT_CHAR_PROPER_WRITE)
+		gatt_write_char(hogdev->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hogdev);
+	else if (report->decl->properties & ATT_CHAR_PROPER_WRITE_WITHOUT_RESP)
+		gatt_write_char(hogdev->attrib, report->decl->value_handle,
+						data, size, NULL, NULL);
+}
+
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -360,6 +411,15 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
 
 	DBG("uHID event type %d received", ev.type);
 
+	switch (ev.type) {
+	case UHID_OUTPUT:
+		forward_report(hogdev, &ev);
+		break;
+	default:
+		warn("unexpected uHID event");
+		break;
+	}
+
 	return TRUE;
 
 failed:
-- 
1.7.10.2

