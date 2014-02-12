Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] android/hal-ipc-api: Add Register Notification Response
Date: Wed, 12 Feb 2014 16:48:14 +0200
Message-Id: <1392216494-30885-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 19 ++++++++++++++++++-
 android/hal-msg.h       | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index b977957..c1609c9 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1281,7 +1281,24 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid status values: Same as in Get Play Status Response
 
-	Opcode 0x09 - Register Notification command/response
+	Opcode 0x09 - Register Notification Response command/response
+
+		Command parameters: Event (1 octet)
+		                    Type (1 octet)
+		                    Data length (1 octet)
+		                    Data (variable)
+
+		In case of an error, the error response will be returned.
+
+		Valid event values: 0x01 = Status Changed
+		                    0x02 = Track Changed
+		                    0x03 = Track Reached End
+		                    0x04 = Track Reached Start
+		                    0x05 = Position Changed
+		                    0x08 = Setting Changed
+
+		Valid type values : 0x00 = Interim
+		                    0x01 = Changed
 
 	Opcode 0x81 - Get Play Status notification
 	Opcode 0x82 - List Player Application Attributes notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 42b08cd..ca1f6b5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -863,3 +863,21 @@ struct hal_cmd_avrcp_get_element_attrs_text {
 struct hal_cmd_avrcp_set_player_attrs_value {
 	uint8_t status;
 } __attribute__((packed));
+
+#define HAL_AVRCP_EVENT_STATUS_CHANGED		0x01
+#define HAL_AVRCP_EVENT_TRACK_CHANGED		0x02
+#define HAL_AVRCP_EVENT_TRACK_REACHED_END	0x03
+#define HAL_AVRCP_EVENT_TRACK_REACHED_START	0x04
+#define HAL_AVRCP_EVENT_POSITION_CHANGED	0x05
+#define HAL_AVRCP_EVENT_SETTING_CHANGED		0x08
+
+#define HAL_AVRCP_EVENT_TYPE_INTERIM		0x00
+#define HAL_AVRCP_EVENT_TYPE_CHANGED		0x01
+
+#define HAL_OP_AVRCP_REGISTER_NOTIFICATION	0x09
+struct hal_cmd_avrcp_register_notification {
+	uint8_t event;
+	uint8_t type;
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
-- 
1.8.5.3

