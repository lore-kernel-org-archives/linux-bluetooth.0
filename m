Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android: Remove bogus hal_rsp_register_module structure
Date: Mon, 28 Oct 2013 13:46:15 +0100
Message-ID: <1382964375-7589-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
References: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Core service Register ID command doesn't return any parameter.
---
 android/hal-msg.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 99238ff..03daa51 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -70,9 +70,6 @@ struct hal_status {
 struct hal_cmd_register_module {
 	uint8_t service_id;
 } __attribute__((packed));
-struct hal_rsp_register_module {
-	uint8_t service_id;
-} __attribute__((packed));
 
 #define HAL_OP_UNREGISTER_MODULE	0x02
 struct hal_cmd_unregister_module {
-- 
1.8.4.1

