Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/12] android/hal-ipc-api: Add Remote Features notification
Date: Thu, 13 Feb 2014 17:18:37 +0200
Message-Id: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 14 ++++++++++++--
 android/hal-msg.h       |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c1609c9..70f947d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1300,8 +1300,18 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		Valid type values : 0x00 = Interim
 		                    0x01 = Changed
 
-	Opcode 0x81 - Get Play Status notification
-	Opcode 0x82 - List Player Application Attributes notification
+	Opcode 0x81 - Remote Features notification
+
+		Notification parameters: Remote address (6 octets)
+		                         Features (1 octet)
+
+		Valid features values : 0x00 = None
+		                        0x01 = Metadata
+		                        0x02 = Absolute Volume
+		                        0x03 = Browse
+
+	Opcode 0x82 - Get Play Status notification
+	Opcode 0x83 - List Player Application Attributes notification
 	...
 
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ca1f6b5..f6cdf58 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -881,3 +881,9 @@ struct hal_cmd_avrcp_register_notification {
 	uint8_t len;
 	uint8_t data[0];
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_REMOTE_FEATURES		0x81
+struct hal_ev_avrcp_remote_features {
+	uint8_t bdaddr[6];
+	uint8_t features;
+} __attribute__((packed));
-- 
1.8.5.3

