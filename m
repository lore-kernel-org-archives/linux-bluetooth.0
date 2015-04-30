Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: [PATCH v2 2/3] hog: enable HoG report notifications only after uHID is ready
Message-Id: <20150430214010.B4E29220C1B@puck.mtv.corp.google.com>
Date: Thu, 30 Apr 2015 14:40:10 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HoG report notifications should be enabled only after the uHID device
has been created. uHID layer cannot process HoG reports any earlier.
---
 profiles/input/hog.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 5661e39..ff0c559 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -83,6 +83,7 @@ struct hog_device {
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	struct bt_uhid		*uhid;
+	gboolean		uhid_created;
 	gboolean		has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -168,6 +169,9 @@ static void enable_report_notifications(struct report *report,
 	struct hog_device *hogdev = report->hogdev;
 	uint8_t value[2];
 
+	if (!hogdev->uhid_created)
+		return;
+
 	if (!report->ccc_handle)
 		return;
 
@@ -627,6 +631,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	ssize_t vlen;
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
+	GSList *l;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -696,6 +701,14 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
 	bt_uhid_register(hogdev->uhid, UHID_SET_REPORT, set_report, hogdev);
 	bt_uhid_register(hogdev->uhid, UHID_GET_REPORT, get_report, hogdev);
+
+	hogdev->uhid_created = TRUE;
+
+	for (l = hogdev->reports; l; l = l->next) {
+		struct report *r = l->data;
+
+		enable_report_notifications(r, true);
+	}
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-- 
2.2.0.rc0.207.ga3a616c

