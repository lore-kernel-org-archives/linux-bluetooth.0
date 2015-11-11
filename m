Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] android/hog: Port fixes to profiles HoG
Date: Wed, 11 Nov 2015 16:05:10 +0200
Message-Id: <1447250715-10804-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This align the 2 copies of Hog since the plan is to merge android
version back to profiles and just reuse from there.

The fix for incomplete discover is modified so the reports are keep
while attempting to discover.
---
 android/hog.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index 22f4228..3af9329 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -88,6 +88,7 @@ struct bt_hog {
 	GSList			*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
+	bool			uhid_created;
 	gboolean		has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -496,9 +497,23 @@ static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 	report->len = len;
 }
 
+static int report_chrc_cmp(const void *data, const void *user_data)
+{
+	const struct report *report = data;
+	const struct gatt_char *decl = user_data;
+
+	return report->decl->handle - decl->handle;
+}
+
 static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 {
 	struct report *report;
+	GSList *l;
+
+	/* Skip if report already exists */
+	l = g_slist_find_custom(hog->reports, chr, report_chrc_cmp);
+	if (l)
+		return l->data;
 
 	report = g_new0(struct report, 1);
 	report->hog = hog;
@@ -939,6 +954,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	destroy_gatt_req(req);
 
+	DBG("HoG inspecting report map");
+
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
@@ -1006,6 +1023,10 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
 	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
 	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
+
+	hog->uhid_created = true;
+
+	DBG("HoG created uHID device");
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -1084,6 +1105,8 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	destroy_gatt_req(req);
 
+	DBG("HoG inspecting characteristics");
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -1116,6 +1139,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report = report_new(hog, chr);
 			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
+			DBG("HoG discovering report map");
 			read_char(hog, hog->attrib, chr->value_handle,
 						report_map_read_cb, hog);
 			discover_external(hog, hog->attrib, start, end, hog);
@@ -1404,7 +1428,8 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		bt_hog_attach(instance, gatt);
 	}
 
-	if (hog->reports == NULL) {
+	if (!hog->uhid_created) {
+		DBG("HoG discovering characteristics");
 		discover_char(hog, hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
-- 
2.4.3

