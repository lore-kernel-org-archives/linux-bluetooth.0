Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/14] android: Add missing bond state definition to IPC header
Date: Thu, 31 Oct 2013 02:55:42 +0000
Message-Id: <1383188154-22905-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index d2a0e2a..b0ee73c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -372,6 +372,10 @@ struct hal_ev_ssp_request {
 	uint32_t passkey;
 } __attribute__((packed));
 
+#define HAL_BOND_STATE_NONE 0
+#define HAL_BOND_STATE_BONDING 1
+#define HAL_BOND_STATE_BONDED 2
+
 #define HAL_EV_BOND_STATE_CHANGED	0x88
 struct hal_ev_bond_state_changed {
 	uint8_t status;
-- 
1.8.4.rc3

