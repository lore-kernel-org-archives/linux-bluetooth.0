Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog: Rename prepend_id variable
Date: Mon, 10 Dec 2012 17:54:26 -0300
Message-Id: <1355172866-3144-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the hog_device prepend_id field by has_report_id
as long as it is more suitable.

This variable indicates if we should consider the report id (adding
or removing it) before sending it to device or uhid driver.
---
 profiles/input/hog_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a873eac..06dab6d 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -79,7 +79,7 @@ struct hog_device {
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	int			uhid_fd;
-	gboolean		prepend_id;
+	gboolean		has_report_id;
 	guint			uhid_watch_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -120,7 +120,7 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
 
 	buf = ev.u.input.data;
-	if (hogdev->prepend_id) {
+	if (hogdev->has_report_id) {
 		*buf = report->id;
 		buf++;
 		ev.u.input.size++;
@@ -362,7 +362,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		case 0x85:
 		case 0x86:
 		case 0x87:
-			hogdev->prepend_id = TRUE;
+			hogdev->has_report_id = TRUE;
 		}
 
 		if (i % 2 == 0) {
@@ -549,7 +549,7 @@ static void forward_report(struct hog_device *hogdev,
 	int size;
 	guint type;
 
-	if (hogdev->prepend_id) {
+	if (hogdev->has_report_id) {
 		data = ev->u.output.data + 1;
 		size = ev->u.output.size - 1;
 	} else {
-- 
1.8.0.1

