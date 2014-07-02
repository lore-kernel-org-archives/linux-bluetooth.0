Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/hidhost: Use bt_hog_send_report in bt_hid_set_report
Date: Wed,  2 Jul 2014 09:58:11 +0200
Message-Id: <1404287892-13170-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1404287892-13170-1-git-send-email-szymon.janc@tieto.com>
References: <1404287892-13170-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bt_hid_set_report is called for a HoG device send data using
bt_hog_send_report.
---
 android/hidhost.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 0c0d69d..4b718c6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1228,7 +1228,7 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 
 	dev = l->data;
 
-	if (!(dev->ctrl_io)) {
+	if (!dev->ctrl_io && !dev->hog) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -1250,6 +1250,16 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	if (dev->hog) {
+		if (bt_hog_send_report(dev->hog, req + 1, req_size - 1,
+							cmd->type) < 0) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		goto done;
+	}
+
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0) {
@@ -1261,6 +1271,7 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 
 	dev->last_hid_msg = HID_MSG_SET_REPORT;
 
+done:
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.9.1

