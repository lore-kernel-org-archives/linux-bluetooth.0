Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] android/hal-ipc-api: Add Volume Changed notification
Date: Thu, 13 Feb 2014 17:18:47 +0200
Message-Id: <1392304728-5061-11-git-send-email-luiz.dentz@gmail.com>
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
index 535e880..99ecede 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1373,6 +1373,13 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid event values: Same as in Register Notification
 
+	Opcode 0x8b - Volume Changed notification
+
+		Notification parameters: Volume (1 octet)
+		                         Type (1 octet)
+
+		Valid type values: Same as in Register Notification
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a7df71a..0561894 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -932,3 +932,9 @@ struct hal_ev_avrcp_register_notification {
 	uint8_t event;
 	uint32_t param;
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_VOLUME_CHANGED		0x8b
+struct hal_ev_avrcp_volume_changed {
+	uint8_t volume;
+	uint8_t type;
+} __attribute__((packed));
-- 
1.8.5.3

