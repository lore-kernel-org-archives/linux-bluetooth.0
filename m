Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 02/12] android/hid: Implement hid set protocol in daemon
Date: Tue,  5 Nov 2013 23:09:08 +0200
Message-Id: <1383685758-3900-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device to set protocol mode and reads
reply message and sends notification to HAL.
---
 android/hid.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 9bfa018..dc44159 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -56,6 +56,7 @@
 
 /* HID message types */
 #define HID_MSG_GET_PROTOCOL	0x60
+#define HID_MSG_SET_PROTOCOL	0x70
 #define HID_MSG_DATA		0xa0
 
 /* HID protocol header parameters */
@@ -299,6 +300,7 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 
 	switch (dev->last_hid_msg) {
 	case HID_MSG_GET_PROTOCOL:
+	case HID_MSG_SET_PROTOCOL:
 		bt_hid_notify_proto_mode(dev, buf, bread);
 		break;
 	}
@@ -697,9 +699,38 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
 static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hid_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+	int fd;
+	uint8_t hdr;
 
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
+	if (dev->boot_dev)
+		return HAL_STATUS_UNSUPPORTED;
+
+	hdr = HID_MSG_SET_PROTOCOL | cmd->mode;
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, &hdr, sizeof(hdr)) < 0) {
+		error("error while setting device protocol");
+		return HAL_STATUS_FAILED;
+	}
+
+	dev->last_hid_msg = HID_MSG_SET_PROTOCOL;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
-- 
1.8.1.2

