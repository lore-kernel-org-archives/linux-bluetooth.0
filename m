Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 01/04] android/hid: Implement hid get protocol in daemon
Date: Tue,  5 Nov 2013 14:22:03 +0200
Message-Id: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device protocol mode and reads reply
message and sends notification to hal.
---
v3: Changed hid_msg to last_hid_msg and variable type uint8_t type
---
 android/hid.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index c0c9aeb..97835d9 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -54,6 +54,14 @@
 #define L2CAP_PSM_HIDP_INTR	0x13
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
+/* HID message types */
+#define HID_MSG_GET_PROTOCOL	0x60
+#define HID_MSG_DATA		0xa0
+
+/* HID protocol header parameters */
+#define HID_PROTO_BOOT		0x00
+#define HID_PROTO_REPORT	0x01
+
 static GIOChannel *notification_io = NULL;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
@@ -76,6 +84,7 @@ struct hid_device {
 	guint		intr_watch;
 	int		uhid_fd;
 	guint		uhid_watch_id;
+	uint8_t		last_hid_msg;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -243,12 +252,74 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
+									int len)
+{
+	struct hal_ev_hid_proto_mode ev;
+	char address[18];
+
+	ba2str(&dev->dst, address);
+	DBG("device %s", address);
+
+	memset(&ev, 0, sizeof(ev));
+	bdaddr2android(&dev->dst, ev.bdaddr);
+
+	if (buf[0] == HID_MSG_DATA) {
+		ev.status = HAL_HID_STATUS_OK;
+		if (buf[1] == HID_PROTO_REPORT)
+			ev.mode = HAL_HID_REPORT_PROTOCOL;
+		else if (buf[1] == HID_PROTO_BOOT)
+			ev.mode = HAL_HID_BOOT_PROTOCOL;
+		else
+			ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
+
+	} else {
+		ev.status = buf[0];
+		ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
+	}
+
+	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HID_PROTO_MODE, sizeof(ev), &ev, -1);
+}
+
+static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
+{
+	struct hid_device *dev = data;
+	int fd, bread;
+	uint8_t buf[UHID_DATA_MAX];
+
+	DBG("");
+
+	fd = g_io_channel_unix_get_fd(chan);
+	bread = read(fd, buf, sizeof(buf));
+	if (bread < 0) {
+		error("read: %s(%d)", strerror(errno), -errno);
+		return TRUE;
+	}
+
+	switch (dev->last_hid_msg) {
+	case HID_MSG_GET_PROTOCOL:
+		bt_hid_notify_proto_mode(dev, buf, bread);
+		break;
+	default:
+		DBG("unhandled hid msg type 0x%02x", dev->last_hid_msg);
+	}
+
+	/* reset msg type request */
+	dev->last_hid_msg = 0;
+
+	return TRUE;
+}
+
 static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
 	struct hid_device *dev = data;
 	char address[18];
 
+	if (cond & G_IO_IN)
+		return ctrl_io_watch_cb(chan, data);
+
 	ba2str(&dev->dst, address);
 	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
 
@@ -395,8 +466,8 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	}
 
 	dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					ctrl_watch_cb, dev);
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				ctrl_watch_cb, dev);
 
 	return;
 
@@ -591,9 +662,38 @@ static uint8_t bt_hid_info(struct hal_cmd_hid_set_info *cmd, uint16_t len)
 static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
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
+	hdr[0] = HID_MSG_GET_PROTOCOL | cmd->mode;
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, hdr, sizeof(hdr)) < 0) {
+		error("error while querying device protocol");
+		return HAL_STATUS_FAILED;
+	}
+
+	dev->last_hid_msg = HID_MSG_GET_PROTOCOL;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
-- 
1.8.1.2

