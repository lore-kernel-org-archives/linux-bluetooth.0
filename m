Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/11] hog: Remove redundant struct
Date: Fri,  2 May 2014 12:57:42 +0200
Message-Id: <1399028262-17187-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since complete descriptor discovery is now performed inside gatt code,
there's no need to store end handle for characteristics and thus we can
remove disc_desc_cb_data.
---
 profiles/input/hog.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f79f977..12bc19a 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -102,11 +102,6 @@ struct report {
 	struct hog_device	*hogdev;
 };
 
-struct disc_desc_cb_data {
-	uint16_t end;
-	gpointer data;
-};
-
 static gboolean suspend_supported = FALSE;
 static GSList *devices = NULL;
 
@@ -202,7 +197,6 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct disc_desc_cb_data *ddcb_data = user_data;
 	struct report *report;
 	struct hog_device *hogdev;
 	GAttrib *attrib = NULL;
@@ -210,7 +204,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	if (status != 0) {
 		error("Discover all descriptors failed: %s",
 							att_ecode2str(status));
-		goto done;
+		return;
 	}
 
 	for ( ; descs; descs = descs->next) {
@@ -218,43 +212,34 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report = ddcb_data->data;
+			report = user_data;
 			attrib = report->hogdev->attrib;
 			write_ccc(desc->handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
-			report = ddcb_data->data;
+			report = user_data;
 			attrib = report->hogdev->attrib;
 			gatt_read_char(attrib, desc->handle,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
-			hogdev = ddcb_data->data;
+			hogdev = user_data;
 			attrib = hogdev->attrib;
 			gatt_read_char(attrib, desc->handle,
 					external_report_reference_cb, hogdev);
 			break;
 		}
 	}
-
-done:
-	g_free(ddcb_data);
 }
 
 static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 							gpointer user_data)
 {
-	struct disc_desc_cb_data *ddcb_data;
-
 	if (start > end)
 		return;
 
-	ddcb_data = g_new0(struct disc_desc_cb_data, 1);
-	ddcb_data->end = end;
-	ddcb_data->data = user_data;
-
 	gatt_discover_desc(attrib, start, end, NULL,
-					discover_descriptor_cb, ddcb_data);
+					discover_descriptor_cb, user_data);
 }
 
 static void external_service_char_cb(uint8_t status, GSList *chars,
-- 
1.9.2

