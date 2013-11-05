Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 03/04] android/hid: Implement hid get report in daemon
Date: Tue,  5 Nov 2013 14:22:05 +0200
Message-Id: <1383654126-19237-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch requests hid device report and reads reply
message and sends notification to hal.
---
 android/hal-hidhost.c |   1 +
 android/hid.c         | 105 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 13928e6..f554cb2 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -251,6 +251,7 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 	cmd.id = reportId;
+	cmd.buf = bufferSize;
 
 	switch (reportType) {
 	case BTHH_INPUT_REPORT:
diff --git a/android/hid.c b/android/hid.c
index d387d6d..f1bf9e8 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -55,14 +55,23 @@
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 /* HID message types */
+#define HID_MSG_GET_REPORT	0x40
 #define HID_MSG_GET_PROTOCOL	0x60
 #define HID_MSG_SET_PROTOCOL	0x70
 #define HID_MSG_DATA		0xa0
 
+/* HID data types */
+#define HID_DATA_TYPE_INPUT	0x01
+#define HID_DATA_TYPE_OUTPUT	0x02
+#define HID_DATA_TYPE_FEATURE	0x03
+
 /* HID protocol header parameters */
 #define HID_PROTO_BOOT		0x00
 #define HID_PROTO_REPORT	0x01
 
+/* HID GET REPORT Size Field */
+#define HID_GET_REPORT_SIZE_FIELD	0x08
+
 static GIOChannel *notification_io = NULL;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
@@ -283,6 +292,52 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 				HAL_EV_HID_PROTO_MODE, sizeof(ev), &ev, -1);
 }
 
+static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
+									int len)
+{
+	struct hal_ev_hid_get_report *ev;
+	int ev_len;
+	char address[18];
+
+	ba2str(&dev->dst, address);
+	DBG("device %s", address);
+
+	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hid_get_report) + 1;
+
+	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
+			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
+			(buf[0]	== (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
+		ev = g_malloc(len);
+		memset(ev, 0, ev_len);
+		ev->status = buf[0];
+		bdaddr2android(&dev->dst, ev->bdaddr);
+		goto send;
+	}
+
+	/* Report porotocol mode reply contains id after hdr, in boot
+	 * protocol mode id doesn't exist */
+	ev_len += (dev->boot_dev) ? (len - 1) : (len - 2);
+	ev = g_malloc(ev_len);
+	memset(ev, 0, ev_len);
+	ev->status = HAL_HID_STATUS_OK;
+	bdaddr2android(&dev->dst, ev->bdaddr);
+
+	/* Report porotocol mode reply contains id after hdr, in boot
+	 * protocol mode id doesn't exist */
+	if (dev->boot_dev) {
+		ev->len = len - 1;
+		memcpy(ev->data, buf + 1, ev->len);
+	} else {
+		ev->len = len - 2;
+		memcpy(ev->data, buf + 2, ev->len);
+	}
+
+send:
+	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_GET_REPORT,
+						ev_len, ev, -1);
+	g_free(ev);
+}
+
 static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 {
 	struct hid_device *dev = data;
@@ -303,6 +358,9 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 	case HID_MSG_SET_PROTOCOL:
 		bt_hid_notify_proto_mode(dev, buf, bread);
 		break;
+	case HID_MSG_GET_REPORT:
+		bt_hid_notify_get_report(dev, buf, bread);
+		break;
 	default:
 		DBG("unhandled hid msg type 0x%02x", dev->last_hid_msg);
 	}
@@ -738,9 +796,51 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
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
+	req_size = (cmd->buf > 0) ? 4 : 2;
+	req = g_try_malloc0(req_size);
+	if (!req)
+		return HAL_STATUS_NOMEM;
+
+	req[0] = HID_MSG_GET_REPORT | cmd->type;
+
+	if (cmd->buf > 0)
+		req[0] = req[0] | HID_GET_REPORT_SIZE_FIELD;
+
+	req[1] = cmd->id;
+
+	if (cmd->buf > 0)
+		bt_put_le16(cmd->buf, (req + 2));
+
+	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
+
+	if (write(fd, req, req_size) < 0) {
+		error("error while querying device protocol");
+		g_free(req);
+		return HAL_STATUS_FAILED;
+	}
+
+	dev->last_hid_msg = HID_MSG_GET_REPORT;
+	g_free(req);
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
-- 
1.8.1.2

