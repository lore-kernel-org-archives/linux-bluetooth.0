Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/3] android/hidhost: Handle uhid output and feature events
Date: Tue, 12 Nov 2013 17:07:13 +0200
Message-Id: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data read on uhid events output and feature has to be send through
SET_REPORT request to HID device.
---
 android/hidhost.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index cba80a6..556e5a5 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -155,7 +155,30 @@ static void hid_device_free(struct hid_device *dev)
 
 static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
 {
-	DBG("UHID_OUTPUT UHID_FEATURE unsupported");
+	int fd, i;
+	uint8_t *req = NULL;
+	uint8_t req_size = 0;
+
+	if (!(dev->ctrl_io))
+		return;
+
+	req_size = 1 + (ev->u.output.size / 2);
+	req = g_try_malloc0(req_size);
+	if (!req)
+		return;
+
+	req[0] = HID_MSG_SET_REPORT | ev->u.output.rtype;
+	for (i = 0; i < (req_size - 1); i++)
+		sscanf((char *) &(ev->u.output.data)[i * 2],
+							"%hhx", &(req + 1)[i]);
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, req, req_size) < 0)
+		error("error writing set_report: %s (%d)",
+						strerror(errno), errno);
+
+	g_free(req);
 }
 
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
-- 
1.8.3.2

