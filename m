Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/6] android/handsfree-client: Fix defines for action command
Date: Fri, 19 Sep 2014 16:30:47 +0200
Message-Id: <1411137051-28904-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index ba213b7..eba47df 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1026,13 +1026,13 @@ struct hal_cmd_hf_client_dial_memory {
 #define HAL_HF_CLIENT_ACTION_CHLD_2		0x02
 #define HAL_HF_CLIENT_ACTION_CHLD_3		0x03
 #define HAL_HF_CLIENT_ACTION_CHLD_4		0x04
-#define HAL_HF_CLIENT_ACTION_CHLD_1x	0x05
-#define HAL_HF_CLIENT_ACTION_CHLD_2x	0x06
+#define HAL_HF_CLIENT_ACTION_CHLD_1x		0x05
+#define HAL_HF_CLIENT_ACTION_CHLD_2x		0x06
 #define HAL_HF_CLIENT_ACTION_ATA		0x07
 #define HAL_HF_CLIENT_ACTION_CHUP		0x08
 #define HAL_HF_CLIENT_ACTION_BRTH_0		0x09
-#define HAL_HF_CLIENT_ACTION_BRTH_1		0x10
-#define HAL_HF_CLIENT_ACTION_BRTH_02	0x11
+#define HAL_HF_CLIENT_ACTION_BRTH_1		0x0a
+#define HAL_HF_CLIENT_ACTION_BRTH_02		0x0b
 
 #define HAL_OP_HF_CLIENT_CALL_ACTION		0x0a
 struct hal_cmd_hf_client_call_action {
-- 
1.8.4

