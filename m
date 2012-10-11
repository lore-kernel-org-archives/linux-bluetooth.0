Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 1/2] hog: Fix characteristic descriptor discovery
Date: Thu, 11 Oct 2012 02:31:22 -0300
Message-Id: <1349933483-10436-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discover descriptors sub-procedure is complete when the error
response is received and the error code is set to "Attribute Not Found"
or the find information response has an attribute handle that is equal
to the last handle in the request. This commit fixes the stop condition
for characteristic descriptor discovery.
---
 profiles/input/hog_device.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a8cc568..a25b8c2 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -96,6 +96,11 @@ struct report {
 	struct hog_device	*hogdev;
 };
 
+struct disc_desc_cb_data {
+	uint16_t end;
+	gpointer data;
+};
+
 static gint report_handle_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct report *report = a;
@@ -199,16 +204,25 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
+	struct disc_desc_cb_data *ddcb_data = user_data;
 	struct report *report;
 	struct hog_device *hogdev;
-	struct att_data_list *list;
+	struct att_data_list *list = NULL;
+	GAttrib *attrib = NULL;
 	uint8_t format;
+	uint16_t handle = 0xffff;
+	uint16_t end = ddcb_data->end;
 	int i;
 
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		DBG("Discover all characteristic descriptors finished");
+		goto done;
+	}
+
 	if (status != 0) {
 		error("Discover all characteristic descriptors failed: %s",
 							att_ecode2str(status));
-		return;
+		goto done;
 	}
 
 	list = dec_find_info_resp(pdu, len, &format);
@@ -219,7 +233,7 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		goto done;
 
 	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16, handle;
+		uint16_t uuid16;
 		uint8_t *value;
 
 		value = list->data[i];
@@ -228,17 +242,20 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 
 		switch (uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report = user_data;
+			report = ddcb_data->data;
+			attrib = report->hogdev->attrib;
 			write_ccc(handle, report->hogdev);
 			break;
 		case GATT_REPORT_REFERENCE:
-			report = user_data;
-			gatt_read_char(report->hogdev->attrib, handle,
+			report = ddcb_data->data;
+			attrib = report->hogdev->attrib;
+			gatt_read_char(attrib, handle,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
-			hogdev = user_data;
-			gatt_read_char(hogdev->attrib, handle,
+			hogdev = ddcb_data->data;
+			attrib = hogdev->attrib;
+			gatt_read_char(attrib, handle,
 					external_report_reference_cb, hogdev);
 			break;
 		}
@@ -246,12 +263,19 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 
 done:
 	att_data_list_free(list);
+
+	if (handle != 0xffff && handle < end)
+		gatt_find_info(attrib, handle + 1, end, discover_descriptor_cb,
+								ddcb_data);
+	else
+		g_free(ddcb_data);
 }
 
 static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 				struct gatt_char *next, gpointer user_data)
 {
 	uint16_t start, end;
+	struct disc_desc_cb_data *ddcb_data;
 
 	start = chr->value_handle + 1;
 	end = (next ? next->handle - 1 : 0xffff);
@@ -259,7 +283,11 @@ static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 	if (start > end)
 		return;
 
-	gatt_find_info(attrib, start, end, discover_descriptor_cb, user_data);
+	ddcb_data = g_new0(struct disc_desc_cb_data, 1);
+	ddcb_data->end = end;
+	ddcb_data->data = user_data;
+
+	gatt_find_info(attrib, start, end, discover_descriptor_cb, ddcb_data);
 }
 
 static void external_service_char_cb(GSList *chars, guint8 status,
-- 
1.7.11.4

