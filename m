Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/11] hog: Discover descriptors using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:35 +0200
Message-Id: <1399028262-17187-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog.c | 52 ++++++++++++----------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ae2affd..f79f977 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -199,74 +199,46 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data);
 
 
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_descriptor_cb(uint8_t status, GSList *descs,
+								void *user_data)
 {
 	struct disc_desc_cb_data *ddcb_data = user_data;
 	struct report *report;
 	struct hog_device *hogdev;
-	struct att_data_list *list = NULL;
 	GAttrib *attrib = NULL;
-	uint8_t format;
-	uint16_t handle = 0xffff;
-	uint16_t end = ddcb_data->end;
-	int i;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
-		DBG("Discover all characteristic descriptors finished");
-		goto done;
-	}
 
 	if (status != 0) {
-		error("Discover all characteristic descriptors failed: %s",
+		error("Discover all descriptors failed: %s",
 							att_ecode2str(status));
 		goto done;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16;
-		uint8_t *value;
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
 
-		value = list->data[i];
-		handle = get_le16(value);
-		uuid16 = get_le16(&value[2]);
-
-		switch (uuid16) {
+		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
 			report = ddcb_data->data;
 			attrib = report->hogdev->attrib;
-			write_ccc(handle, report);
+			write_ccc(desc->handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
 			report = ddcb_data->data;
 			attrib = report->hogdev->attrib;
-			gatt_read_char(attrib, handle,
+			gatt_read_char(attrib, desc->handle,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
 			hogdev = ddcb_data->data;
 			attrib = hogdev->attrib;
-			gatt_read_char(attrib, handle,
+			gatt_read_char(attrib, desc->handle,
 					external_report_reference_cb, hogdev);
 			break;
 		}
 	}
 
 done:
-	att_data_list_free(list);
-
-	if (handle != 0xffff && handle < end)
-		gatt_discover_char_desc(attrib, handle + 1, end,
-					discover_descriptor_cb, ddcb_data);
-	else
-		g_free(ddcb_data);
+	g_free(ddcb_data);
 }
 
 static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -281,8 +253,8 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 	ddcb_data->end = end;
 	ddcb_data->data = user_data;
 
-	gatt_discover_char_desc(attrib, start, end, discover_descriptor_cb,
-								ddcb_data);
+	gatt_discover_desc(attrib, start, end, NULL,
+					discover_descriptor_cb, ddcb_data);
 }
 
 static void external_service_char_cb(uint8_t status, GSList *chars,
-- 
1.9.2

