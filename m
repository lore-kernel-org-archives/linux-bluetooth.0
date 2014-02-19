Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/14] android/hal-ipc-api: Use variable length for text attributes
Date: Wed, 19 Feb 2014 18:58:46 +0200
Message-Id: <1392829138-10346-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prevent having to increase the MTU size just to fit all attributes
when in fact some attributes are numbers (3 out of 8) in text format
which should not get even close to use 256 bytes defined by bt_rc.h.
---
 android/hal-ipc-api.txt | 6 ++++--
 android/hal-msg.h       | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ea26d0d..02355dc 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1251,7 +1251,8 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Command parameters: Number of values (1 octet)
 		                    Value # (1 octet)
-		                    Value # text (255 octets)
+		                    Value # text length (1 octet)
+		                    Value # text (variable)
 		                    ...
 
 		In case of an error, the error response will be returned.
@@ -1260,7 +1261,8 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Command parameters: Number of elements (1 octet)
 		                    Element # (1 octet)
-		                    Element # text (255 octets)
+		                    Element # text length (1 octet)
+		                    Element # text (variable)
 		                    ...
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9d396a1..55ffd08 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -830,7 +830,8 @@ struct hal_cmd_avrcp_get_player_attrs {
 
 struct hal_avrcp_player_setting_text {
 	uint8_t id;
-	uint8_t text[255];
+	uint8_t len;
+	uint8_t text[0];
 } __attribute__((packed));
 
 #define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT	0x05
-- 
1.8.5.3

