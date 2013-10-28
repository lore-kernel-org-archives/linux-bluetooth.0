Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android: Fix HAL_OP_REMOVE_BOND value
Date: Mon, 28 Oct 2013 13:46:14 +0100
Message-ID: <1382964375-7589-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
References: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a copy-and-paste mistake.
---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a0a8390..99238ff 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -163,7 +163,7 @@ struct hal_cmd_create_bond {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_REMOVE_BOND		0x0d
+#define HAL_OP_REMOVE_BOND		0x0e
 struct hal_cmd_remove_bond {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
-- 
1.8.4.1

