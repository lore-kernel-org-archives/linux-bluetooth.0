Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 4/5] android/hid: Add send data implemention in daemon
Date: Fri,  8 Nov 2013 14:08:50 +0200
Message-Id: <1383912531-1306-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send data on interrupt channel on request from hid host.
---
 android/hidhost.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 0e6bae0..250288c 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -931,9 +931,50 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hid_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+	int i, fd;
+	uint8_t *req;
+	uint8_t req_size;
 
-	return HAL_STATUS_FAILED;
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(devices, &dst, device_cmp);
+	if (!l)
+		return HAL_STATUS_FAILED;
+
+	dev = l->data;
+
+	if (!(dev->intr_io))
+		return HAL_STATUS_FAILED;
+
+	req_size = 1 + (cmd->len / 2);
+	req = g_try_malloc0(req_size);
+	if (!req)
+		return HAL_STATUS_NOMEM;
+
+	req[0] = HID_MSG_DATA | HID_DATA_TYPE_OUTPUT;
+	/* Report data coming to HAL is in ascii format, HAL sends
+	 * data in hex to daemon, so convert to binary. */
+	for (i = 0; i < (req_size - 1); i++)
+		sscanf((char *) &(cmd->data)[i * 2], "%hhx", &(req + 1)[i]);
+
+	fd = g_io_channel_unix_get_fd(dev->intr_io);
+
+	if (write(fd, req, req_size) < 0) {
+		error("error while sending data to device");
+		g_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	g_free(req);
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-- 
1.8.3.2

