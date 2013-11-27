Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/13] android/hidhost: Use stack buffer in bt_hid_get_report
Date: Wed, 27 Nov 2013 12:55:00 +0100
Message-Id: <1385553305-5807-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Request size can be up to 4 bytes and this can be easily put on stack.
---
 android/hidhost.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 5b98152..b94d284 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -958,8 +958,8 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
-	uint8_t *req;
-	uint8_t req_size;
+	uint8_t req[4];
+	uint8_t req_size = 2;
 
 	DBG("");
 
@@ -972,12 +972,6 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
-	req_size = (cmd->buf_size > 0) ? 4 : 2;
-	req = g_try_malloc0(req_size);
-	if (!req) {
-		status = HAL_STATUS_NOMEM;
-		goto fail;
-	}
 
 	req[0] = HID_MSG_GET_REPORT | cmd->type;
 	req[1] = cmd->id;
@@ -985,6 +979,7 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 	if (cmd->buf_size > 0) {
 		req[0] = req[0] | HID_GET_REPORT_SIZE_FIELD;
 		bt_put_le16(cmd->buf_size, &req[2]);
+		req_size += sizeof(uint16_t);
 	}
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
@@ -992,13 +987,11 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 	if (write(fd, req, req_size) < 0) {
 		error("error writing hid_get_report: %s (%d)",
 						strerror(errno), errno);
-		g_free(req);
 		status = HAL_STATUS_FAILED;
 		goto fail;
 	}
 
 	dev->last_hid_msg = HID_MSG_GET_REPORT;
-	g_free(req);
 
 fail:
 	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
-- 
1.8.3.2

