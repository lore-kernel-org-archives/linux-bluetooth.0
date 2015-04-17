Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] hog: rework HoG report notification enable
Message-Id: <20150417220033.1BD45220209@puck.mtv.corp.google.com>
Date: Fri, 17 Apr 2015 15:00:32 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. Add client characteristic configuration handle (ccc_handle) to
   HoG report structure.
2. Rename write_ccc() to enable_report_notification().
3. Rename report_ccc_written_cb() to report_notification_enable_cb().
4. In enable_report_notification(), first register the callback for
   HoG report notifications and then enable the notification on the
   HoG device.
5. In report_notification_enable_cb(), improve the emitted messages.
---
 profiles/input/hog.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 3d23d5b..c55443c 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -98,6 +98,7 @@ struct hog_device {
 struct report {
 	uint8_t			id;
 	uint8_t			type;
+	uint16_t		ccc_handle;
 	guint			notifyid;
 	struct gatt_char	*decl;
 	struct hog_device	*hogdev;
@@ -146,34 +147,40 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	DBG("HoG report (%u bytes)", ev.u.input.size);
 }
 
-static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
+static void report_notification_enable_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
 	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
 
 	if (status != 0) {
-		error("Write report characteristic descriptor failed: %s",
-							att_ecode2str(status));
+		error("Report 0x%04x client characteristic configuration "
+		      "write failed: %s",
+				report->decl->handle, att_ecode2str(status));
 		return;
 	}
 
-	report->notifyid = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					report->decl->value_handle,
-					report_value_cb, report, NULL);
-
-	DBG("Report characteristic descriptor written: notifications enabled");
+	DBG("Report 0x%04x client characteristic configuration written: "
+	    "notifications enabled", report->decl->handle);
 }
 
-static void write_ccc(uint16_t handle, gpointer user_data)
+static void enable_report_notification(struct report *report)
 {
-	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
-	uint8_t value[] = { 0x01, 0x00 };
+	uint8_t value[2];
+
+	if (!report->ccc_handle)
+		return;
+
+	/* Register callback for HoG report notifications */
+	report->notifyid = g_attrib_register(hogdev->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					report->decl->value_handle,
+					report_value_cb, report, NULL);
 
-	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, report);
+	/* Enable the HoG report notification */
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	gatt_write_char(hogdev->attrib, report->ccc_handle, value,
+			sizeof(value), report_notification_enable_cb, report);
 }
 
 static void report_reference_cb(guint8 status, const guint8 *pdu,
@@ -220,7 +227,8 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
 			report = user_data;
-			write_ccc(desc->handle, report);
+			report->ccc_handle = desc->handle;
+			enable_report_notification(report);
 			break;
 		case GATT_REPORT_REFERENCE:
 			report = user_data;
-- 
2.2.0.rc0.207.ga3a616c

