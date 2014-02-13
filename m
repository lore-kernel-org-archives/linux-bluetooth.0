Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] android/hal-ipc-api: Add List Player Values notification
Date: Thu, 13 Feb 2014 17:18:40 +0200
Message-Id: <1392304728-5061-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index aa35050..56df5b0 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1318,6 +1318,12 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Notification parameters: <none>
 
+	Opcode 0x84 - List Player Values notification
+
+		Notification parameters: Attribute (1 octet)
+
+		Valid attribute values: Same as in List Player Attributes
+
 
 Bluetooth GATT HAL (ID 9)
 =========================
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9536b85..55cea27 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -890,3 +890,8 @@ struct hal_ev_avrcp_remote_features {
 
 #define HAL_EV_AVRCP_GET_PLAY_STATUS		0x82
 #define HAL_EV_AVRCP_LIST_PLAYER_ATTRS		0x83
+
+#define HAL_EV_AVRCP_LIST_PLAYER_VALUES		0x84
+struct hal_ev_avrcp_list_player_values {
+	uint8_t attr;
+} __attribute__((packed));
-- 
1.8.5.3

