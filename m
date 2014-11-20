Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/4] android/hid: Support handshake message
Date: Thu, 20 Nov 2014 12:18:50 +0100
Message-Id: <1416482331-3766-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416482331-3766-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416482331-3766-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 657fa8f..75e895b 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -58,6 +58,7 @@
 #define L2CAP_PSM_HIDP_INTR	0x13
 
 /* HID message types */
+#define HID_MSG_HANDSHAKE	0x00
 #define HID_MSG_CONTROL		0x10
 #define HID_MSG_GET_REPORT	0x40
 #define HID_MSG_SET_REPORT	0x50
@@ -65,6 +66,8 @@
 #define HID_MSG_SET_PROTOCOL	0x70
 #define HID_MSG_DATA		0xa0
 
+#define HID_MSG_TYPE_MASK	0xf0
+
 /* HID data types */
 #define HID_DATA_TYPE_INPUT	0x01
 #define HID_DATA_TYPE_OUTPUT	0x02
@@ -391,6 +394,22 @@ send:
 	g_free(ev);
 }
 
+static void bt_hid_notify_handshake(struct hid_device *dev, uint8_t *buf,
+									int len)
+{
+	struct hal_ev_hidhost_handshake ev;
+
+	bdaddr2android(&dev->dst, ev.bdaddr);
+
+	/* crop result code to handshake status range from HAL */
+	ev.status = buf[0];
+	if (ev.status > HAL_HIDHOST_HS_ERROR)
+		ev.status = HAL_HIDHOST_HS_ERROR;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
+				HAL_EV_HIDHOST_HANDSHAKE, sizeof(ev), &ev);
+}
+
 static void bt_hid_notify_virtual_unplug(struct hid_device *dev,
 							uint8_t *buf, int len)
 {
@@ -441,8 +460,17 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 		break;
 	}
 
-	if (buf[0] == (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG))
-		bt_hid_notify_virtual_unplug(dev, buf, bread);
+	switch (buf[0] & HID_MSG_TYPE_MASK) {
+	case HID_MSG_HANDSHAKE:
+		bt_hid_notify_handshake(dev, buf, bread);
+		break;
+	case HID_MSG_CONTROL:
+		if ((buf[0] & !HID_MSG_TYPE_MASK) == HID_VIRTUAL_CABLE_UNPLUG)
+			bt_hid_notify_virtual_unplug(dev, buf, bread);
+		break;
+	default:
+		break;
+	}
 
 	/* reset msg type request */
 	dev->last_hid_msg = 0;
-- 
1.9.1

