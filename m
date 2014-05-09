Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] hog: Improve report_value_cb() uHID error handling
Message-Id: <20140509183012.48FBC100D85@puck.mtv.corp.google.com>
Date: Fri,  9 May 2014 11:30:12 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use similar uHID error handling and debug messages as uhid_send_input_report()
in profiles/input/device.c.
---
 profiles/input/hog.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 9f10fa4..a6ffe79 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -112,6 +112,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	struct uhid_event ev;
 	uint16_t report_size = len - 3;
 	uint8_t *buf;
+	ssize_t status;
 
 	if (len < 3) { /* 1-byte opcode + 2-byte handle */
 		error("Malformed ATT notification");
@@ -131,11 +132,21 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 
 	memcpy(buf, &pdu[3], MIN(report_size, UHID_DATA_MAX));
 
-	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
-		error("uHID write failed: %s", strerror(errno));
-	else
-		DBG("Report from HoG device 0x%04X written to uHID fd %d",
-						hogdev->id, hogdev->uhid_fd);
+	status = write(hogdev->uhid_fd, &ev, sizeof(ev));
+	if (status < 0) {
+		error("uHID dev write error: %s (%d)", strerror(errno), errno);
+		return;
+	}
+
+	/* uHID kernel driver does not handle partial writes */
+	if ((size_t) status < sizeof(ev)) {
+		error("uHID dev write error: partial write (%zd of %lu bytes)",
+							status, sizeof(ev));
+		return;
+	}
+
+	DBG("HoG report (%u bytes) -> uHID fd %d", ev.u.input.size,
+							hogdev->uhid_fd);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-- 
1.9.1.423.g4596e3a

