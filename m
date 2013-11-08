Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 2/5] android/hid: Fix set report data format in daemon
Date: Fri,  8 Nov 2013 12:24:28 +0200
Message-Id: <1383906271-23554-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Report data coming to HAL is in ascii format, HAL sends
data in hex to daemon, so convert to binary.
---
 android/hidhost.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index c7b4114..9b4bb15 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -98,6 +98,14 @@ struct hid_device {
 	uint8_t		last_hid_msg;
 };
 
+static void hex2bin(const uint8_t *ascii, int ascii_len, uint8_t *hex)
+{
+	int i;
+
+	for (i = 0; i < ascii_len / 2; i++)
+		sscanf((char *) &ascii[i * 2], "%hhx", &hex[i]);
+}
+
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct hid_device *dev = s;
@@ -900,18 +908,20 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 		return HAL_STATUS_FAILED;
 
 	dev = l->data;
-	req_size = 1 + cmd->len;
+	/* Report data coming to HAL is in ascii format, HAL sends
+	 * data in hex to daemon, so convert to binary. */
+	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return HAL_STATUS_NOMEM;
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
-	memcpy(req + 1, cmd->data, req_size - 1);
+	hex2bin(cmd->data, cmd->len, (req + 1));
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0) {
-		error("error while querying device protocol");
+		error("error while sending report");
 		g_free(req);
 		return HAL_STATUS_FAILED;
 	}
-- 
1.8.3.2

