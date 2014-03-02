Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/16] android/avrcp: Add passthrough handler for rewind
Date: Sun,  2 Mar 2014 20:48:23 +0200
Message-Id: <1393786109-6554-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Rewind should be send via HAL not handled directly by uinput otherwise
Android media player might not interpret it correctly.
---
 android/avrcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 3d56ccf..9d86803 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -317,8 +317,25 @@ static bool handle_fast_forward(struct avrcp *session, bool pressed,
 	return true;
 }
 
+static bool handle_rewind(struct avrcp *session, bool pressed,
+							void *user_data)
+{
+	struct hal_ev_avrcp_passthrough_cmd ev;
+
+	DBG("pressed %s", pressed ? "true" : "false");
+
+	ev.id = AVC_REWIND;
+	ev.state = pressed;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+			HAL_EV_AVRCP_PASSTHROUGH_CMD, sizeof(ev), &ev);
+
+	return true;
+}
+
 static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ AVC_FAST_FORWARD, handle_fast_forward },
+		{ AVC_REWIND, handle_rewind },
 		{ },
 };
 
-- 
1.8.5.3

