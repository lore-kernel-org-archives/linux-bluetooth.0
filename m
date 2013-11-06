Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 07/14] android: Remove not needed HAL_MINIMUM_EVENT define
Date: Wed, 6 Nov 2013 15:09:23 +0100
Message-ID: <1383746970-25906-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is no longer needed as correct events ID are verified by
hal_notif_check function.
---
 android/hal-msg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9f36c61..0d7137a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -32,8 +32,6 @@ struct hal_hdr {
 	uint8_t  payload[0];
 } __attribute__((packed));
 
-#define HAL_MINIMUM_EVENT		0x81
-
 #define HAL_SERVICE_ID_CORE		0
 #define HAL_SERVICE_ID_BLUETOOTH	1
 #define HAL_SERVICE_ID_SOCK		2
-- 
1.8.4.2

