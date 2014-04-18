Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android/hidhost: Check if hex2buf succed
Date: Fri, 18 Apr 2014 15:40:06 +0200
Message-Id: <1397828406-29951-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
References: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fail if received string contains illegal characters.
---
 android/hidhost.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index ab7f7a8..65c8de5 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1129,7 +1129,7 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
-	uint8_t *req;
+	uint8_t *req = NULL;
 	uint8_t req_size;
 	uint8_t status;
 
@@ -1177,24 +1177,27 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
 	/* Report data coming to HAL is in ascii format, HAL sends
 	 * data in hex to daemon, so convert to binary. */
-	hex2buf(cmd->data, req + 1, req_size - 1);
+	if (!hex2buf(cmd->data, req + 1, req_size - 1)) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0) {
 		error("error writing hid_set_report: %s (%d)",
 						strerror(errno), errno);
-		g_free(req);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
 	dev->last_hid_msg = HID_MSG_SET_REPORT;
-	g_free(req);
 
 	status = HAL_STATUS_SUCCESS;
 
 failed:
+	g_free(req);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
 									status);
 }
@@ -1206,7 +1209,7 @@ static void bt_hid_send_data(const void *buf, uint16_t len)
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
-	uint8_t *req;
+	uint8_t *req = NULL;
 	uint8_t req_size;
 	uint8_t status;
 
@@ -1244,23 +1247,25 @@ static void bt_hid_send_data(const void *buf, uint16_t len)
 	req[0] = HID_MSG_DATA | HID_DATA_TYPE_OUTPUT;
 	/* Report data coming to HAL is in ascii format, HAL sends
 	 * data in hex to daemon, so convert to binary. */
-	hex2buf(cmd->data, req + 1, req_size - 1);
+	if (!hex2buf(cmd->data, req + 1, req_size - 1)) {
+		status = HAL_STATUS_INVALID;
+		goto failed;
+	}
 
 	fd = g_io_channel_unix_get_fd(dev->intr_io);
 
 	if (write(fd, req, req_size) < 0) {
 		error("error writing data to HID device: %s (%d)",
 						strerror(errno), errno);
-		g_free(req);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	g_free(req);
-
 	status = HAL_STATUS_SUCCESS;
 
 failed:
+	g_free(req);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
 									status);
 }
-- 
1.9.1

