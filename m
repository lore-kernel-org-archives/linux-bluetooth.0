Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 01/11] android/hid: Rename function name set_state to notify_state
Date: Tue,  5 Nov 2013 00:20:05 +0200
Message-Id: <1383603615-9953-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Renaming notification preparation function name from bt_hid_set_state
to bt_hid_notify_state. Rest of the funtions name will have proper
notify* names.
---
 android/hid.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 1ee8ed4..2498d2d 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -194,7 +194,7 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 	return TRUE;
 }
 
-static void bt_hid_set_state(struct hid_device *dev, uint8_t state)
+static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 {
 	struct hal_ev_hid_conn_state ev;
 	char address[18];
@@ -249,7 +249,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 	char address[18];
 
 	ba2str(&dev->dst, address);
-	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
+	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that intr_watch_cb has been queued for dispatching in
@@ -296,6 +296,7 @@ static int uhid_create(struct hid_device *dev)
 	dev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
 	if (dev->uhid_fd < 0) {
 		error("Failed to open uHID device: %s", strerror(errno));
+		bt_hid_notify_state(dev, HAL_HID_STATE_NO_HID);
 		return -errno;
 	}
 
@@ -344,7 +345,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, dev);
 
-	bt_hid_set_state(dev, HAL_HID_STATE_CONNECTED);
+	bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTED);
 
 	return;
 
@@ -374,7 +375,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	DBG("");
 
 	if (conn_err) {
-		bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
+		bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
 		error("%s", conn_err->message);
 		goto failed;
 	}
@@ -491,7 +492,7 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTED);
+	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
 	hid_device_free(dev);
 }
 
@@ -531,7 +532,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 	}
 
 	devices = g_slist_append(devices, dev);
-	bt_hid_set_state(dev, HAL_HID_STATE_CONNECTING);
+	bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -563,7 +564,7 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	if (dev->ctrl_io)
 		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
 
-	bt_hid_set_state(dev, HAL_HID_STATE_DISCONNECTING);
+	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -715,7 +716,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					ctrl_watch_cb, dev);
-		bt_hid_set_state(dev, HAL_HID_STATE_CONNECTING);
+		bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTING);
 		break;
 
 	case L2CAP_PSM_HIDP_INTR:
@@ -728,7 +729,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->intr_watch = g_io_add_watch(dev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, dev);
-		bt_hid_set_state(dev, HAL_HID_STATE_CONNECTED);
+		bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTED);
 		break;
 	}
 }
-- 
1.8.1.2

