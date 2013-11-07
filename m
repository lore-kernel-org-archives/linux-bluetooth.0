Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 3/3] android/hid: Fix set report data format
Date: Thu,  7 Nov 2013 11:27:01 +0200
Message-Id: <1383816421-18878-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383816421-18878-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383816421-18878-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data is in ascii format from HAL. Convert it to hex and send it to
hid device.
---
 android/hal-msg.h |  2 +-
 android/hid.c     | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a5e5c76..89366df 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -293,7 +293,7 @@ struct hal_cmd_hid_set_report {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
 	uint16_t len;
-	uint8_t  data[670];
+	uint8_t  data[0];
 } __attribute__((packed));
 
 #define HAL_OP_HID_SEND_DATA		0x09
diff --git a/android/hid.c b/android/hid.c
index c38c4c1..e28e22d 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -898,18 +898,24 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
 		return HAL_STATUS_FAILED;
 
 	dev = l->data;
-	req_size = 1 + cmd->len;
+	/* Report data coming from HAL is in ascii format, so convert
+	 * it to hex and calculate length according to it. */
+	req_size = 1 + ((cmd->len + 1) / 2);
 	req = g_try_malloc0(req_size);
 	if (!req)
 		return HAL_STATUS_NOMEM;
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
-	memcpy(req + 1, cmd->data, req_size - 1);
+
+	if (!ascii2hex(cmd->data, cmd->len, (req + 1))) {
+		g_free(req);
+		return HAL_STATUS_FAILED;
+	}
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
 
 	if (write(fd, req, req_size) < 0) {
-		error("error while querying device protocol");
+		error("error while sending report");
 		g_free(req);
 		return HAL_STATUS_FAILED;
 	}
-- 
1.8.3.2

