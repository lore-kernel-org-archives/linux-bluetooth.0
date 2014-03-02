Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/16] android/avrcp: Add passthrough handler for fast forward
Date: Sun,  2 Mar 2014 20:48:22 +0200
Message-Id: <1393786109-6554-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fast forward should be send via HAL not handled directly by uinput
otherwise Android media player might not interpret it correctly.
---
 android/avrcp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 678c321..3d56ccf 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -301,6 +301,27 @@ static void disconnect_cb(void *data)
 	avrcp_device_remove(dev);
 }
 
+static bool handle_fast_forward(struct avrcp *session, bool pressed,
+							void *user_data)
+{
+	struct hal_ev_avrcp_passthrough_cmd ev;
+
+	DBG("pressed %s", pressed ? "true" : "false");
+
+	ev.id = AVC_FAST_FORWARD;
+	ev.state = pressed;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_EV_AVRCP_PASSTHROUGH_CMD, sizeof(ev), &ev);
+
+	return true;
+}
+
+static const struct avrcp_passthrough_handler passthrough_handlers[] = {
+		{ AVC_FAST_FORWARD, handle_fast_forward },
+		{ },
+};
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct avrcp_device *dev;
@@ -350,6 +371,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
+	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers,
+									dev);
 
 	/* FIXME: get the real name of the device */
 	avrcp_init_uinput(dev->session, "bluetooth", address);
-- 
1.8.5.3

