Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/9] android/hal-ipc-api: Add List Player Values Response
Date: Wed, 12 Feb 2014 16:48:08 +0200
Message-Id: <1392216494-30885-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 9 ++++++++-
 android/hal-msg.h       | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ae58fda..2e4ecbe 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1216,7 +1216,14 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		                  0x03 = Shuffle
 		                  0x04 = Scan
 
-	Opcode 0x03 - List Player Application Values command/response
+	Opcode 0x03 - List Player Values Response command/response
+
+		Command parameters: Number of values (1 octet)
+		                    Value # (1 octet)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x04 - Get Player Application Values command/response
 	Opcode 0x05 - Get Player Application Attributes Text command/response
 	Opcode 0x06 - Get Player Application Values Text command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4a438d1..2dcdafc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -810,3 +810,9 @@ struct hal_cmd_avrcp_list_player_attrs {
 	uint8_t number;
 	uint8_t attrs[0];
 } __attribute__((packed));
+
+#define HAL_OP_AVRCP_LIST_PLAYER_VALUES	0x03
+struct hal_cmd_avrcp_list_player_values {
+	uint8_t number;
+	uint8_t values[0];
+} __attribute__((packed));
-- 
1.8.5.3

