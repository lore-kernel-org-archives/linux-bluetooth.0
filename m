Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] hog: Fix report_value_cb() buffer overflow
Message-Id: <20140509183022.24398100D85@puck.mtv.corp.google.com>
Date: Fri,  9 May 2014 11:30:22 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix buffer overflow that would happen in the case:
hogdev->has_report_id == TRUE && report_size == UHID_DATA_MAX
---
 profiles/input/hog.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index a6ffe79..c196f65 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -76,6 +76,7 @@
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
+#define ATT_NOTIFICATION_HEADER_SIZE	3
 
 struct hog_device {
 	uint16_t		id;
@@ -110,28 +111,32 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
 	struct uhid_event ev;
-	uint16_t report_size = len - 3;
 	uint8_t *buf;
 	ssize_t status;
 
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
 	}
 
-	memcpy(buf, &pdu[3], MIN(report_size, UHID_DATA_MAX));
-
 	status = write(hogdev->uhid_fd, &ev, sizeof(ev));
 	if (status < 0) {
 		error("uHID dev write error: %s (%d)", strerror(errno), errno);
-- 
1.9.1.423.g4596e3a

