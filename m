Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/handsfree-client: Fix connection state defines
Date: Fri,  6 Feb 2015 12:29:52 +0100
Message-Id: <1423222193-27653-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connected state was missing.
---
 android/hal-ipc-api.txt | 5 +++--
 android/hal-msg.h       | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 515cf4e..77f2f57 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2473,8 +2473,9 @@ Notifications:
 
 		Valid State values: 0x00 = Disconnected
 		                    0x01 = Connecting
-		                    0x02 = SLC Connected
-		                    0x03 = Disconnecting
+		                    0x02 = Connected
+		                    0x03 = SLC Connected
+		                    0x04 = Disconnecting
 
 		Peer Features is a bitmask of the supported features. Currently
 		available bits:
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ecc1150..0ec07c7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -2107,8 +2107,9 @@ struct hal_ev_gatt_server_congestion {
 
 #define HAL_HF_CLIENT_CONN_STATE_DISCONNECTED		0x00
 #define HAL_HF_CLIENT_CONN_STATE_CONNECTING		0x01
-#define HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED		0x02
-#define HAL_HF_CLIENT_CONN_STATE_DISCONNECTING		0x03
+#define HAL_HF_CLIENT_CONN_STATE_CONNECTED		0x02
+#define HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED		0x03
+#define HAL_HF_CLIENT_CONN_STATE_DISCONNECTING		0x04
 
 #define HAL_HF_CLIENT_PEER_FEAT_3WAY		0x00000001
 #define HAL_HF_CLIENT_PEER_FEAT_ECNR		0x00000002
-- 
1.9.1

