Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 02/04] android/hid: Implement hid set protocol in daemon
Date: Tue,  5 Nov 2013 14:22:04 +0200
Message-Id: <1383654126-19237-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device to set protocol mode and reads
reply message and sends notification to hal.
---
 android/hid.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 97835d9..d387d6d 100644
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
 	default:
@@ -699,9 +701,38 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
 static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hid_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+	int fd;
+	uint8_t hdr[1];
 
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
+	hdr[0] = HID_MSG_SET_PROTOCOL | cmd->mode;
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, hdr, sizeof(hdr)) < 0) {
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

