Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/6] android: Define helper payload field in hal_msg_hdr
Date: Tue, 22 Oct 2013 14:46:09 +0200
Message-Id: <1382445973-8285-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
References: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for convenient access to payload.
---
 android/hal-msg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9dcfbf6..a1b539f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -29,6 +29,7 @@ struct hal_msg_hdr {
 	uint8_t service_id;
 	uint8_t opcode;
 	uint16_t len;
+	uint8_t payload[0];
 } __attribute__((packed));
 
 #define HAL_SERVICE_ID_CORE		0
-- 
1.8.4

