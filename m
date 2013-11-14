Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] android/hal-a2dp: Use conn_state instead of connection_state
Date: Thu, 14 Nov 2013 12:18:15 +0200
Message-Id: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is shorter and more consistent with other HAL such as HID.
---
 android/hal-a2dp.c | 8 ++++----
 android/hal-msg.h  | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 4fe7c20..cdb5229 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -31,9 +31,9 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_connection_state(void *buf)
+static void handle_conn_state(void *buf)
 {
-	struct hal_ev_a2dp_connection_state *ev = buf;
+	struct hal_ev_a2dp_conn_state *ev = buf;
 
 	if (cbs->connection_state_cb)
 		cbs->connection_state_cb(ev->state,
@@ -55,8 +55,8 @@ void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len)
 		return;
 
 	switch (opcode) {
-	case HAL_EV_A2DP_CONNECTION_STATE:
-		handle_connection_state(buf);
+	case HAL_EV_A2DP_CONN_STATE:
+		handle_conn_state(buf);
 		break;
 	case HAL_EV_A2DP_AUDIO_STATE:
 		handle_audio_state(buf);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 847cc1f..30fe624 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -530,13 +530,13 @@ struct hal_ev_pan_conn_state {
 	uint8_t  remote_role;
 } __attribute__((packed));
 
-#define HAL_EV_A2DP_CONNECTION_STATE	0x81
-struct hal_ev_a2dp_connection_state {
+#define HAL_EV_A2DP_CONN_STATE			0x81
+struct hal_ev_a2dp_conn_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_EV_A2DP_AUDIO_STATE	0x82
+#define HAL_EV_A2DP_AUDIO_STATE			0x82
 struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
-- 
1.8.3.1

