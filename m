Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/hidhost: Simplify handle_uhid_output
Date: Mon, 16 Dec 2013 15:37:32 +0100
Message-Id: <1387204652-14850-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387204652-14850-1-git-send-email-szymon.janc@tieto.com>
References: <1387204652-14850-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make it use VLA for req buffer. This makes function simpler and also
fix cutting req to 255 bytes (req_len was uint8_t)
---
 android/hidhost.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 0e0391a..76322af 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -156,29 +156,22 @@ static void hid_device_free(struct hid_device *dev)
 static void handle_uhid_output(struct hid_device *dev,
 						struct uhid_output_req *output)
 {
-	int fd, i;
-	uint8_t *req = NULL;
-	uint8_t req_size = 0;
+	int fd;
+	unsigned int i;
+	uint8_t req[1 + (output->size / 2)];
 
 	if (!(dev->ctrl_io))
 		return;
 
-	req_size = 1 + (output->size / 2);
-	req = g_try_malloc0(req_size);
-	if (!req)
-		return;
-
 	req[0] = HID_MSG_SET_REPORT | output->rtype;
-	for (i = 0; i < (req_size - 1); i++)
+	for (i = 0; i < (sizeof(req) - 1); i++)
 		sscanf((char *) &(output->data)[i * 2], "%hhx", &req[1 + i]);
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
-	if (write(fd, req, req_size) < 0)
+	if (write(fd, req, sizeof(req)) < 0)
 		error("error writing set_report: %s (%d)",
 						strerror(errno), errno);
-
-	g_free(req);
 }
 
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
-- 
1.8.3.2

