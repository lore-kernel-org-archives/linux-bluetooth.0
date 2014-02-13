Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] android/hal-ipc-api: Add Set Player Values notification
Date: Thu, 13 Feb 2014 17:18:44 +0200
Message-Id: <1392304728-5061-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 362cdf4..3f7d017 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1349,6 +1349,15 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attribute values: Same as in List Player Attributes
 
+	Opcode 0x88 - Set Player Values notification
+
+		Notification parameters: Number of attributes (1 octet)
+		                         Attribute # (1 octet)
+		                         Value # (1 octet)
+		                         ...
+
+		Valid attribute values: Same as in List Player Attributes
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 188e7c2..fd4b522 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -914,3 +914,9 @@ struct hal_ev_avrcp_get_player_values_text {
 	uint8_t number;
 	uint8_t values[0];
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_SET_PLAYER_VALUES		0x88
+struct hal_ev_avrcp_set_player_values {
+	uint8_t number;
+	struct hal_avrcp_player_attr_value attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

