Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] android/hal-ipc-api: Add Get Player Values Text notification
Date: Thu, 13 Feb 2014 17:18:43 +0200
Message-Id: <1392304728-5061-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0810078..362cdf4 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1340,6 +1340,15 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attribute values: Same as in List Player Attributes
 
+	Opcode 0x87 - Get Player Values Text notification
+
+		Notification parameters: Attribute (1 octet)
+		                         Number of values (1 octet)
+		                         Value # (1 octet)
+		                         ...
+
+		Valid attribute values: Same as in List Player Attributes
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 67fccb9..188e7c2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -907,3 +907,10 @@ struct hal_ev_avrcp_get_player_attrs_text {
 	uint8_t number;
 	uint8_t attrs[0];
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_GET_PLAYER_VALUES_TEXT	0x87
+struct hal_ev_avrcp_get_player_values_text {
+	uint8_t attr;
+	uint8_t number;
+	uint8_t values[0];
+} __attribute__((packed));
-- 
1.8.5.3

