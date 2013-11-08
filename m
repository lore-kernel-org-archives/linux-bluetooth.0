Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC] android/hid: Handle virtual unplug event from hid device
Date: Fri,  8 Nov 2013 16:14:54 +0200
Message-Id: <1383920094-20498-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If hid host receives the virtual unplug event from hid device
recipient shall destroy or invalidate all bluetooth bonding and
virtual cable information
---
 android/hal-msg.h |  1 +
 android/hidhost.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4c7d344..569c8ea 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -449,6 +449,7 @@ struct hal_ev_hidhost_conn_state {
 } __attribute__((packed));
 
 #define HAL_HIDHOST_STATUS_OK		0x00
+#define HAL_HIDHOST_GENERAL_ERROR	0x06
 
 #define HAL_EV_HIDHOST_INFO			0x82
 struct hal_ev_hidhost_info {
diff --git a/android/hidhost.c b/android/hidhost.c
index d36cb82..683938f 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -379,6 +379,31 @@ send:
 	g_free(ev);
 }
 
+static void bt_hid_notify_virtual_unplug(struct hid_device *dev,
+							uint8_t *buf, int len)
+{
+	struct hal_ev_hidhost_virtual_unplug ev;
+	char address[18];
+
+	ba2str(&dev->dst, address);
+	DBG("device %s", address);
+	bdaddr2android(&dev->dst, ev.bdaddr);
+
+	ev.status = HAL_HIDHOST_GENERAL_ERROR;
+
+	/* Wait either channels to HUP */
+	if (dev->intr_io && dev->ctrl_io) {
+		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
+		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
+		ev.status = HAL_HIDHOST_STATUS_OK;
+	}
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
+			HAL_EV_HIDHOST_VIRTUAL_UNPLUG, sizeof(ev), &ev, -1);
+
+}
+
 static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 {
 	struct hid_device *dev = data;
@@ -404,6 +429,9 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 		break;
 	}
 
+	if (buf[0] == (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG))
+		bt_hid_notify_virtual_unplug(dev, buf, bread);
+
 	/* reset msg type request */
 	dev->last_hid_msg = 0;
 
-- 
1.8.3.2

