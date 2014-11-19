Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 01/15] android/handsfree-client: Fix index type in call action command
Date: Wed, 19 Nov 2014 10:43:34 +0100
Message-Id: <1416390228-28330-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to BT HAL API index should be int.
---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index c86b0a6..c2c659c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1089,7 +1089,7 @@ struct hal_cmd_hf_client_dial_memory {
 #define HAL_OP_HF_CLIENT_CALL_ACTION		0x0a
 struct hal_cmd_hf_client_call_action {
 	uint8_t action;
-	uint8_t index;
+	int32_t index;
 } __attribute__((packed));
 
 #define HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS	0x0b
-- 
1.8.4

