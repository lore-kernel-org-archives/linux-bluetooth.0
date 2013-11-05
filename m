Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 04/04] android/hid: Implement hid set report in daemon
Date: Tue,  5 Nov 2013 14:22:06 +0200
Message-Id: <1383654126-19237-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device to set report.
---
 android/hal-hidhost.c |  2 ++
 android/hal-msg.h     |  6 ++++--
 android/hid.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f554cb2..29e3ee0 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -284,6 +284,8 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 		return BT_STATUS_PARM_INVALID;
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.len = strlen(report);
+	memcpy(cmd.data, report, cmd.len);
 
 	switch (reportType) {
 	case BTHH_INPUT_REPORT:
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bc7df6b..2c3067f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -290,8 +290,10 @@ struct hal_cmd_hid_get_report {
 
 #define HAL_OP_HID_SET_REPORT		0x08
 struct hal_cmd_hid_set_report {
-	uint8_t bdaddr[6];
-	uint8_t type;
+	uint8_t  bdaddr[6];
+	uint8_t  type;
+	uint16_t len;
+	uint8_t  data[670];
 } __attribute__((packed));
 
 #define HAL_OP_HID_SEND_DATA		0x09
diff --git a/android/hid.c b/android/hid.c
index f1bf9e8..25e33fa 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -56,6 +56,7 @@
 
 /* HID message types */
 #define HID_MSG_GET_REPORT	0x40
+#define HID_MSG_SET_REPORT	0x50
 #define HID_MSG_GET_PROTOCOL	0x60
 #define HID_MSG_SET_PROTOCOL	0x70
 #define HID_MSG_DATA		0xa0
@@ -846,9 +847,44 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
 static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hid_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+	int fd;
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
+	req_size = 1 + cmd->len;
+	req = g_try_malloc0(req_size);
+	if (!req)
+		return HAL_STATUS_NOMEM;
+
+	req[0] = HID_MSG_SET_REPORT | cmd->type;
+	memcpy(req + 1, cmd->data, req_size - 1);
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, req, req_size) < 0) {
+		error("error while querying device protocol");
+		g_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	dev->last_hid_msg = HID_MSG_SET_REPORT;
+	g_free(req);
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
-- 
1.8.1.2

