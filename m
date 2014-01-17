Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/hal-msg: Add defines for each audio state
Date: Fri, 17 Jan 2014 15:33:04 +0200
Message-Id: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index ceaa3b2..cfb5460 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -564,6 +564,10 @@ struct hal_ev_a2dp_conn_state {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_AUDIO_SUSPEND			0x00
+#define HAL_AUDIO_STOPPED			0x01
+#define HAL_AUDIO_STARTED			0x02
+
 #define HAL_EV_A2DP_AUDIO_STATE			0x82
 struct hal_ev_a2dp_audio_state {
 	uint8_t state;
-- 
1.8.4.2

