Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] android/hog: Read initial value of Report characteristic
Date: Mon, 30 Jun 2014 16:47:50 +0300
Message-Id: <1404136079-24846-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is required by following tests:

- TP/HGRF/RH/BV-03-I [Read Report Characteristics – Input Report]
- TP/HGRF/RH/BV-19-I [Read Report Characteristics – Output Report]
- TP/HGRF/RH/BV-07-I [Read Report Characteristics – Feature Report]
---
 android/hog.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 5d33c63..f69fe2a 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -198,7 +198,7 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
 
 	/* Enable notifications only for Input Reports */
-	if (report->type == 0x01)
+	if (report->type == HOG_REPORT_TYPE_INPUT)
 		write_ccc(report->hog->attrib, report->ccc_handle, report);
 }
 
@@ -273,6 +273,27 @@ static void discover_report(GAttrib *attrib, uint16_t start, uint16_t end,
 								user_data);
 }
 
+static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	if (status != 0)
+		error("Error reading Report value: %s", att_ecode2str(status));
+}
+
+static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
+{
+	struct report *report;
+
+	report = g_new0(struct report, 1);
+	report->hog = hog;
+	report->decl = g_memdup(chr, sizeof(*chr));
+	hog->reports = g_slist_append(hog->reports, report);
+
+	gatt_read_char(hog->attrib, chr->value_handle, report_read_cb, report);
+
+	return report;
+}
+
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
@@ -297,10 +318,7 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 		DBG("0x%04x UUID: %s properties: %02x",
 				chr->handle, chr->uuid, chr->properties);
 
-		report = g_new0(struct report, 1);
-		report->hog = hog;
-		report->decl = g_memdup(chr, sizeof(*chr));
-		hog->reports = g_slist_append(hog->reports, report);
+		report = report_new(hog, chr);
 		start = chr->value_handle + 1;
 		end = (next ? next->handle - 1 : primary->range.end);
 		discover_report(hog->attrib, start, end, report);
@@ -640,10 +658,7 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 		end = (next ? next->handle - 1 : primary->range.end);
 
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
-			report = g_new0(struct report, 1);
-			report->hog = hog;
-			report->decl = g_memdup(chr, sizeof(*chr));
-			hog->reports = g_slist_append(hog->reports, report);
+			report = report_new(hog, chr);
 			discover_report(hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hog->attrib, chr->value_handle,
-- 
1.9.3

