Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] android/hal-a2dp: Add defines for possible connection states
Date: Thu, 14 Nov 2013 12:18:18 +0200
Message-Id: <1384424301-31265-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 30fe624..44fd5c8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -530,6 +530,11 @@ struct hal_ev_pan_conn_state {
 	uint8_t  remote_role;
 } __attribute__((packed));
 
+#define HAL_A2DP_STATE_DISCONNECTED		0x00
+#define HAL_A2DP_STATE_CONNECTING		0x01
+#define HAL_A2DP_STATE_CONNECTED		0x02
+#define HAL_A2DP_STATE_DISCONNECTING		0x03
+
 #define HAL_EV_A2DP_CONN_STATE			0x81
 struct hal_ev_a2dp_conn_state {
 	uint8_t state;
-- 
1.8.3.1

