Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] android/hidhost: Fix handle_uhid_output
Date: Fri, 18 Apr 2014 15:40:03 +0200
Message-Id: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data from kernel is not in form of hex string. Just copy it instead of
converting from hex string.
---
 android/hidhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index d45e1bd..b8d2d8f 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -180,13 +180,13 @@ static void handle_uhid_output(struct hid_device *dev,
 	if (!(dev->ctrl_io))
 		return;
 
-	req_size = 1 + (output->size / 2);
+	req_size = 1 + output->size;
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return;
 
 	req[0] = HID_MSG_SET_REPORT | output->rtype;
-	hex2buf(output->data, req + 1, req_size - 1);
+	memcpy(req + 1, output->data, req_size - 1);
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
-- 
1.9.1

