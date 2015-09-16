Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2015 15:23:26 +0800
From: Founder Fang <founder.fang@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hog: fix invalid type cast in discover_descriptor_cb
Message-ID: <20150916072318.GA2599@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

the argument user_data for discover_descriptor_cb can be either
a pointer to report or a pointer to hogdev, it is differentiate by
uuid. when uuid is GATT_EXTERNAL_REPORT_REFERENCE and actual
user_data is a pointer to a report, the user_data is wrongly cast
to hogdev, hence cause memory corruption.
create another function discover_descriptor_no_report_cb, avoid
type cast based on uuid fix the problem.
---
 profiles/input/hog.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index e006add..bea8637 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -219,7 +219,6 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
 	struct report *report;
-	struct hog_device *hogdev;
 	GAttrib *attrib = NULL;
 
 	if (status != 0) {
@@ -244,6 +243,41 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
+			break;
+		}
+	}
+}
+
+static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
+							gpointer user_data)
+{
+	if (start > end)
+		return;
+
+	gatt_discover_desc(attrib, start, end, NULL,
+					discover_descriptor_cb, user_data);
+}
+
+static void discover_descriptor_no_report_cb(uint8_t status, GSList *descs,
+								void *user_data)
+{
+	struct hog_device *hogdev;
+	GAttrib *attrib = NULL;
+
+	if (status != 0) {
+		error("Discover all descriptors failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
+
+		switch (desc->uuid16) {
+		case GATT_CLIENT_CHARAC_CFG_UUID:
+		case GATT_REPORT_REFERENCE:
+			break;
+		case GATT_EXTERNAL_REPORT_REFERENCE:
 			hogdev = user_data;
 			attrib = hogdev->attrib;
 			gatt_read_char(attrib, desc->handle,
@@ -253,16 +287,17 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	}
 }
 
-static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
+static void discover_descriptor_no_report(GAttrib *attrib, uint16_t start, uint16_t end,
 							gpointer user_data)
 {
 	if (start > end)
 		return;
 
 	gatt_discover_desc(attrib, start, end, NULL,
-					discover_descriptor_cb, user_data);
+					discover_descriptor_no_report_cb, user_data);
 }
 
+
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
@@ -824,7 +859,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			DBG("HoG discovering report map");
 			gatt_read_char(hogdev->attrib, chr->value_handle,
 						report_map_read_cb, hogdev);
-			discover_descriptor(hogdev->attrib, start, end, hogdev);
+			discover_descriptor_no_report(hogdev->attrib, start, end, hogdev);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-- 
1.9.1

