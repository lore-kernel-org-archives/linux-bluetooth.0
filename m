Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/12] android/hal-ipc-api: Add Register Notification notification
Date: Thu, 13 Feb 2014 17:18:46 +0200
Message-Id: <1392304728-5061-10-git-send-email-luiz.dentz@gmail.com>
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
index f2427e1..535e880 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1366,6 +1366,13 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attribute values: Same as in Get Element Attribute
 
+	Opcode 0x8a - Register Notification notification
+
+		Notification parameters: Event (1 octet)
+		                         Parameter (4 octets)
+
+		Valid event values: Same as in Register Notification
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9bc2d2a..a7df71a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -926,3 +926,9 @@ struct hal_ev_avrcp_get_element_attrs {
 	uint8_t number;
 	uint8_t attrs[0];
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_REGISTER_NOTIFICATION	0x8a
+struct hal_ev_avrcp_register_notification {
+	uint8_t event;
+	uint32_t param;
+} __attribute__((packed));
-- 
1.8.5.3

