Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>,
	Petri Gynther <pgynther@google.com>
Subject: [PATCH 1/2] hog: add more debugging to HoG device init
Date: Fri,  4 Sep 2015 11:29:59 -0700
Message-Id: <1441391400-24990-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add more debugging to HoG device init, so that it is easier to see
whether the HoG device init completes successfully.
---
 profiles/input/hog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 4be9fd2..bd35830 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -633,6 +633,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i, err;
 	GSList *l;
 
+	DBG("HoG inspecting report map");
+
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
@@ -703,6 +705,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	bt_uhid_register(hogdev->uhid, UHID_GET_REPORT, get_report, hogdev);
 
 	hogdev->uhid_created = TRUE;
+	DBG("HoG created uHID device");
 
 	for (l = hogdev->reports; l; l = l->next) {
 		struct report *r = l->data;
@@ -780,6 +783,8 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
 
+	DBG("HoG inspecting characteristics");
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -816,6 +821,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 								report);
 			discover_descriptor(hogdev->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
+			DBG("HoG discovering report map");
 			gatt_read_char(hogdev->attrib, chr->value_handle,
 						report_map_read_cb, hogdev);
 			discover_descriptor(hogdev->attrib, start, end, hogdev);
@@ -849,6 +855,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	hogdev->attrib = g_attrib_ref(attrib);
 
 	if (hogdev->reports == NULL) {
+		DBG("HoG discovering characteristics");
 		gatt_discover_char(hogdev->attrib, prim->range.start,
 						prim->range.end, NULL,
 						char_discovered_cb, hogdev);
-- 
2.5.0.457.gab17608

