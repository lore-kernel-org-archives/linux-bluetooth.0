Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/hidhost: Handle uhid output and feature events
Date: Mon, 11 Nov 2013 14:15:28 +0200
Message-Id: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data read on uhid events output and feature has to be send through
SET_REPORT request to HID device.
---
 android/hidhost.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 683938f..816fe3e 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -155,7 +155,42 @@ static void hid_device_free(struct hid_device *dev)
 
 static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
 {
-	DBG("UHID_OUTPUT UHID_FEATURE unsupported");
+	int fd;
+	uint8_t *req = NULL;
+	uint8_t req_size = 0;
+
+	if (!(dev->ctrl_io))
+		return;
+
+	switch (ev->type) {
+	case UHID_OUTPUT:
+		req_size = 1 + ev->u.output.size;
+		req = g_try_malloc0(req_size);
+		if (!req)
+			return;
+
+		req[0] = HID_MSG_SET_REPORT | HID_DATA_TYPE_OUTPUT;
+		memcpy(req + 1, ev->u.output.data, ev->u.output.size);
+		break;
+
+	case UHID_FEATURE:
+		req_size = sizeof(struct uhid_feature_req);
+		req = g_try_malloc0(req_size);
+		if (!req)
+			return;
+
+		req[0] = HID_MSG_SET_REPORT | HID_DATA_TYPE_FEATURE;
+		memcpy(req + 1, (ev + sizeof(ev->type)), req_size - 1);
+		break;
+	}
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, req, req_size) < 0)
+		error("error writing hid_set_report: %s (%d)",
+						strerror(errno), errno);
+
+	g_free(req);
 }
 
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
-- 
1.8.3.2

