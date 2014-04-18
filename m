Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] android/hidhost: Cleanup handle_uhid_output
Date: Fri, 18 Apr 2014 15:40:04 +0200
Message-Id: <1397828406-29951-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
References: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index b8d2d8f..ea83733 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -173,15 +173,14 @@ static void hex2buf(const uint8_t *hex, uint8_t *buf, int num)
 static void handle_uhid_output(struct hid_device *dev,
 						struct uhid_output_req *output)
 {
-	int fd;
-	uint8_t *req = NULL;
-	uint8_t req_size = 0;
+	int fd, req_size;
+	uint8_t *req;
 
-	if (!(dev->ctrl_io))
+	if (!dev->ctrl_io)
 		return;
 
 	req_size = 1 + output->size;
-	req = g_try_malloc0(req_size);
+	req = malloc0(req_size);
 	if (!req)
 		return;
 
@@ -191,10 +190,10 @@ static void handle_uhid_output(struct hid_device *dev,
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0)
-		error("error writing set_report: %s (%d)",
-						strerror(errno), errno);
+		error("hidhost: error writing set_report: %s (%d)",
+							strerror(errno), errno);
 
-	g_free(req);
+	free(req);
 }
 
 static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
-- 
1.9.1

