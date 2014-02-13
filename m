Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] android/hal-ipc-api: Add List Player Attributes notification
Date: Thu, 13 Feb 2014 17:18:39 +0200
Message-Id: <1392304728-5061-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 5 +++--
 android/hal-msg.h       | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ce50b6c..aa35050 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1314,8 +1314,9 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Notification parameters: <none>
 
-	Opcode 0x83 - List Player Application Attributes notification
-	...
+	Opcode 0x83 - List Player Attributes notification
+
+		Notification parameters: <none>
 
 
 Bluetooth GATT HAL (ID 9)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7dfbf2a..9536b85 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -889,3 +889,4 @@ struct hal_ev_avrcp_remote_features {
 } __attribute__((packed));
 
 #define HAL_EV_AVRCP_GET_PLAY_STATUS		0x82
+#define HAL_EV_AVRCP_LIST_PLAYER_ATTRS		0x83
-- 
1.8.5.3

