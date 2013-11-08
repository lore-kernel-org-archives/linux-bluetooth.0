Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 5/5] android/hid: Add virtual unplug implemention in daemon
Date: Fri,  8 Nov 2013 12:24:31 +0200
Message-Id: <1383906271-23554-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send virtual unplug command to hid device and disconnect and remove
hid device details.
---
 android/hidhost.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 612dff4..ac6a3b9 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -55,6 +55,7 @@
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 /* HID message types */
+#define HID_MSG_CONTROL		0x10
 #define HID_MSG_GET_REPORT	0x40
 #define HID_MSG_SET_REPORT	0x50
 #define HID_MSG_GET_PROTOCOL	0x60
@@ -73,6 +74,9 @@
 /* HID GET REPORT Size Field */
 #define HID_GET_REPORT_SIZE_FIELD	0x08
 
+/* HID Virtual Cable Unplug */
+#define HID_VIRTUAL_CABLE_UNPLUG	0x05
+
 static int notification_sk = -1;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
@@ -752,9 +756,46 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
 static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_vp *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct hid_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+	uint8_t hdr;
+	int fd;
 
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
+	hdr = HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG;
+
+	if (!(dev->ctrl_io))
+		return HAL_STATUS_FAILED;
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, &hdr, sizeof(hdr)) < 0) {
+		error("error while virtual unplug command");
+		return HAL_STATUS_FAILED;
+	}
+
+	/* Wait either channels to HUP */
+	if (dev->intr_io)
+		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
+
+	if (dev->ctrl_io)
+		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
+
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
-- 
1.8.3.2

