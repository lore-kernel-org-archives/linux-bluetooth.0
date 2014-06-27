Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 11/12] android/hog: Enable notifications only for Input Reports
Date: Fri, 27 Jun 2014 21:08:59 +0300
Message-Id: <1403892540-21222-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HoG spec has the following statement:

  "The Report Host shall enable notifications, via the Client
   Characteristic Configuration descriptor, of the Report characteristic
   for all instances of the Report characteristic where the Report Type
   as defined in the Report Reference characteristic descriptor
   refers to an Input Report."
---
 android/hog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index ad4eee5..83f5d53 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -102,6 +102,7 @@ struct report {
 	struct bt_hog		*hog;
 	uint8_t			id;
 	uint8_t			type;
+	uint16_t		ccc_handle;
 	guint			notifyid;
 	struct gatt_char	*decl;
 };
@@ -195,6 +196,10 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 	report->id = pdu[1];
 	report->type = pdu[2];
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+
+	/* Enable notifications only for Input Reports */
+	if (report->type == 0x01)
+		write_ccc(report->hog->attrib, report->ccc_handle, report);
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
@@ -248,7 +253,7 @@ static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
-			write_ccc(hog->attrib, desc->handle, report);
+			report->ccc_handle = desc->handle;
 			break;
 		case GATT_REPORT_REFERENCE:
 			gatt_read_char(hog->attrib, desc->handle,
-- 
1.9.3

