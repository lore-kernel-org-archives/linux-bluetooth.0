Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 2/5] android/hid: Fix set report data format in daemon
Date: Fri,  8 Nov 2013 14:08:48 +0200
Message-Id: <1383912531-1306-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Report data coming to HAL is in ascii format, HAL sends
data in hex to daemon, so convert to binary.
---
 android/hidhost.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 242fcbc..0e6bae0 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -884,7 +884,7 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
-	int fd;
+	int i, fd;
 	uint8_t *req;
 	uint8_t req_size;
 
@@ -900,13 +900,20 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 		return HAL_STATUS_FAILED;
 
 	dev = l->data;
-	req_size = 1 + cmd->len;
+
+	if (!(dev->ctrl_io))
+		return HAL_STATUS_FAILED;
+
+	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return HAL_STATUS_NOMEM;
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
-	memcpy(req + 1, cmd->data, req_size - 1);
+	/* Report data coming to HAL is in ascii format, HAL sends
+	 * data in hex to daemon, so convert to binary. */
+	for (i = 0; i < (req_size - 1); i++)
+		sscanf((char *) &(cmd->data)[i * 2], "%hhx", &(req + 1)[i]);
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
-- 
1.8.3.2

