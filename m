Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 07/11] android/hid: Implement hid set report in daemon
Date: Tue,  5 Nov 2013 00:20:11 +0200
Message-Id: <1383603615-9953-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device to set report.
---
 android/hal-hidhost.c |  1 +
 android/hal-msg.h     |  1 +
 android/hid.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 027e3b8..040d517 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -284,6 +284,7 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 		return BT_STATUS_PARM_INVALID;
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.report = report;
 
 	switch (reportType) {
 	case BTHH_INPUT_REPORT:
diff --git a/android/hal-msg.h b/android/hal-msg.h
index eaa5c9c..e1fd027 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -292,6 +292,7 @@ struct hal_cmd_hid_get_report {
 struct hal_cmd_hid_set_report {
 	uint8_t bdaddr[6];
 	uint8_t type;
+	char *report;
 } __attribute__((packed));
 
 #define HAL_OP_HID_SEND_DATA		0x09
diff --git a/android/hid.c b/android/hid.c
index 6cb9604..2682b21e6 100644
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
+	dev->hid_msg = HID_MSG_SET_REPORT;
+	req_size = 1 + strlen(cmd->report);
+	req = g_try_malloc0(req_size);
+	if (!req)
+		return HAL_STATUS_NOMEM;
+
+	req[0] = HID_MSG_SET_REPORT | cmd->type;
+	memcpy(req + 1, cmd->report, req_size - 1);
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, req, req_size) < 0) {
+		error("error while querying device protocol");
+		g_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	g_free(req);
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
-- 
1.8.1.2

