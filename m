Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/12] android/hal-ipc-api: Add Get Element Attributes notification
Date: Thu, 13 Feb 2014 17:18:45 +0200
Message-Id: <1392304728-5061-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 3f7d017..f2427e1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1358,6 +1358,14 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attribute values: Same as in List Player Attributes
 
+	Opcode 0x89 - Get Element Attributes notification
+
+		Notification parameters: Number of attributes (1 octet)
+		                         Attribute # (1 octet)
+		                         ...
+
+		Valid attribute values: Same as in Get Element Attribute
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index fd4b522..9bc2d2a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -920,3 +920,9 @@ struct hal_ev_avrcp_set_player_values {
 	uint8_t number;
 	struct hal_avrcp_player_attr_value attrs[0];
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_GET_ELEMENT_ATTRS		0x89
+struct hal_ev_avrcp_get_element_attrs {
+	uint8_t number;
+	uint8_t attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

