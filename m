Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/6] android: Fix non-existing event definition
Date: Tue, 22 Oct 2013 14:46:10 +0200
Message-Id: <1382445973-8285-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
References: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no ERROR notification id.
---
 android/hal-msg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a1b539f..33acd41 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -249,7 +249,6 @@ struct hal_msg_cmd_bt_hid_send_data {
 
 /* Notifications and confirmations */
 
-#define HAL_MSG_EV_BT_ERROR			0x80
 
 #define HAL_MSG_EV_BT_ADAPTER_STATE_CHANGED	0x81
 struct hal_msg_ev_bt_adapter_state_changed {
-- 
1.8.4

