Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 3/3] hog: discover the non-HID service characteristic
Date: Mon, 13 Aug 2012 09:23:16 -0300
Message-Id: <1344860596-30617-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
References: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Find the characteristic by the UUID provided on the External Report
Reference descriptor and enable notifications for it. The characteristic
will be handled as a HID report and it's data processed through the uhid
device.
---
 profiles/input/hog_device.c | 76 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index f4cf596..5a1de12 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -170,23 +170,6 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 					report_ccc_written_cb, hogdev);
 }
 
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	if (status != 0) {
-		error("Read External Report Reference descriptor failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	if (plen != 3) {
-		error("Malformed ATT read response");
-		return;
-	}
-
-	DBG("External Report Reference read: 0x%02x 0x%02x", pdu[1], pdu[2]);
-}
-
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -208,6 +191,9 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
 }
 
+static void external_report_reference_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data);
+
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -274,6 +260,62 @@ static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 	gatt_find_info(attrib, start, end, discover_descriptor_cb, user_data);
 }
 
+static void external_service_char_cb(GSList *chars, guint8 status,
+							gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct report *report;
+	GSList *l;
+
+	if (status != 0) {
+		const char *str = att_ecode2str(status);
+		DBG("Discover external service characteristic failed: %s", str);
+		return;
+	}
+
+	for (l = chars; l; l = g_slist_next(l)) {
+		struct gatt_char *chr, *next;
+
+		chr = l->data;
+		next = l->next ? l->next->data : NULL;
+
+		DBG("0x%04x UUID: %s properties: %02x",
+				chr->handle, chr->uuid, chr->properties);
+
+		report = g_new0(struct report, 1);
+		report->hogdev = hogdev;
+		report->decl = g_memdup(chr, sizeof(*chr));
+		hogdev->reports = g_slist_append(hogdev->reports, report);
+		discover_descriptor(hogdev->attrib, chr, next, report);
+	}
+}
+
+static void external_report_reference_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	uint16_t uuid16;
+	bt_uuid_t uuid;
+
+	if (status != 0) {
+		error("Read External Report Reference descriptor failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (plen != 3) {
+		error("Malformed ATT read response");
+		return;
+	}
+
+	uuid16 = att_get_u16(&pdu[1]);
+	DBG("External report reference read, external report characteristic "
+						"UUID: 0x%04x", uuid16);
+	bt_uuid16_create(&uuid, uuid16);
+	gatt_discover_char(hogdev->attrib, 0x00, 0xff, &uuid,
+					external_service_char_cb, hogdev);
+}
+
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-- 
1.7.11.2

