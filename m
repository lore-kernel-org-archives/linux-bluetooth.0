Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/7] android/handsfree-client: Typo fix in define name
Date: Sun,  9 Nov 2014 01:24:13 +0100
Message-Id: <1415492659-3296-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index eef226e..9c30218 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1074,7 +1074,7 @@ struct hal_cmd_hf_client_dial_memory {
 #define HAL_HF_CLIENT_ACTION_CHUP		0x08
 #define HAL_HF_CLIENT_ACTION_BRTH_0		0x09
 #define HAL_HF_CLIENT_ACTION_BRTH_1		0x0a
-#define HAL_HF_CLIENT_ACTION_BRTH_02		0x0b
+#define HAL_HF_CLIENT_ACTION_BRTH_2		0x0b
 
 #define HAL_OP_HF_CLIENT_CALL_ACTION		0x0a
 struct hal_cmd_hf_client_call_action {
-- 
1.8.4

