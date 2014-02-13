Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/hal-ipc-api: Add Get Player Values notification
Date: Thu, 13 Feb 2014 17:18:41 +0200
Message-Id: <1392304728-5061-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 56df5b0..fd687fb 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1324,6 +1324,13 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attribute values: Same as in List Player Attributes
 
+	Opcode 0x85 - Get Player Values notification
+
+		Notification parameters: Number of attributes (1 octet)
+		                         Attribute # (1 octet)
+		                         ...
+
+		Valid attribute values: Same as in List Player Attributes
 
 Bluetooth GATT HAL (ID 9)
 =========================
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 55cea27..d5d91dd 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -895,3 +895,9 @@ struct hal_ev_avrcp_remote_features {
 struct hal_ev_avrcp_list_player_values {
 	uint8_t attr;
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_GET_PLAYER_VALUES		0x85
+struct hal_ev_avrcp_get_player_values {
+	uint8_t number;
+	uint8_t attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

