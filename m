Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 4/6] android: Define minimum legal notification event ID
Date: Tue, 22 Oct 2013 14:46:11 +0200
Message-Id: <1382445973-8285-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
References: <1382445973-8285-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All legal events IDs should be above this value.
---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 33acd41..9ff0510 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -32,6 +32,8 @@ struct hal_msg_hdr {
 	uint8_t payload[0];
 } __attribute__((packed));
 
+#define HAL_MSG_MINIMUM_EVENT		0x81
+
 #define HAL_SERVICE_ID_CORE		0
 #define HAL_SERVICE_ID_BLUETOOTH	1
 #define HAL_SERVICE_ID_SOCK		2
-- 
1.8.4

