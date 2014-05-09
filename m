Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hog: Fix report_value_cb()
Message-Id: <20140509014001.0A027100DB2@puck.mtv.corp.google.com>
Date: Thu,  8 May 2014 18:40:00 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. Fix potential buffer overflow. It would happen in the case:
   hogdev->has_report_id == TRUE && report_size == UHID_DATA_MAX

2. Adjust function signature to match GAttribNotifyFunc.

3. Adjust uHID error handling to mimic uhid_send_input_report() in
   profiles/input/device.c
---
 profiles/input/hog.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 12bc19a..671dab5 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -76,6 +76,7 @@
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
+#define ATT_NOTIFICATION_HEADER_SIZE	3
 
 struct hog_device {
 	uint16_t		id;
@@ -105,38 +106,51 @@ struct report {
 static gboolean suspend_supported = FALSE;
 static GSList *devices = NULL;
 
-static void report_value_cb(const uint8_t *pdu, uint16_t len,
-							gpointer user_data)
+static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
 	struct uhid_event ev;
-	uint16_t report_size = len - 3;
 	uint8_t *buf;
+	ssize_t status;
 
-	if (len < 3) { /* 1-byte opcode + 2-byte handle */
+	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
 		error("Malformed ATT notification");
 		return;
 	}
 
+	pdu += ATT_NOTIFICATION_HEADER_SIZE;
+	len -= ATT_NOTIFICATION_HEADER_SIZE;
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
-	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
-
 	buf = ev.u.input.data;
+
 	if (hogdev->has_report_id) {
-		*buf = report->id;
-		buf++;
-		ev.u.input.size++;
+		buf[0] = report->id;
+		len = MIN(len, sizeof(ev.u.input.data) - 1);
+		memcpy(buf + 1, pdu, len);
+		ev.u.input.size = ++len;
+	} else {
+		len = MIN(len, sizeof(ev.u.input.data));
+		memcpy(buf, pdu, len);
+		ev.u.input.size = len;
+	}
+
+	status = write(hogdev->uhid_fd, &ev, sizeof(ev));
+	if (status < 0) {
+		error("uHID dev write error: %s (%d)", strerror(errno), errno);
+		return;
 	}
 
-	memcpy(buf, &pdu[3], MIN(report_size, UHID_DATA_MAX));
+	/* uHID kernel driver does not handle partial writes */
+	if ((size_t) status < sizeof(ev)) {
+		error("uHID dev write error: partial write (%zd of %lu bytes)",
+							status, sizeof(ev));
+		return;
+	}
 
-	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
-		error("uHID write failed: %s", strerror(errno));
-	else
-		DBG("Report from HoG device 0x%04X written to uHID fd %d",
-						hogdev->id, hogdev->uhid_fd);
+	DBG("HoG report (%u bytes) -> uHID fd %d", len, hogdev->uhid_fd);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-- 
1.9.1.423.g4596e3a

