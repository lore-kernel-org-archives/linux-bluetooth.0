Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android: Add missing adapter state values to IPC header
Date: Wed, 23 Oct 2013 15:46:22 +0200
Message-ID: <1382535986-30684-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
References: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9ff0510..2840a92 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -252,6 +252,9 @@ struct hal_msg_cmd_bt_hid_send_data {
 /* Notifications and confirmations */
 
 
+#define HAL_BT_ADAPTER_STATE_OFF	0x00
+#define HAL_BT_ADAPTER_STATE_ON		0x01
+
 #define HAL_MSG_EV_BT_ADAPTER_STATE_CHANGED	0x81
 struct hal_msg_ev_bt_adapter_state_changed {
 	uint8_t state;
-- 
1.8.4

