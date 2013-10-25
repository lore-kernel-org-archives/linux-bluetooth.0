Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/15] android: Add missing success status definition to IPC header
Date: Fri, 25 Oct 2013 10:56:17 +0200
Message-ID: <1382691378-31940-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used in HAL callbacks to indicate success.
---
 android/hal-msg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index f6c9e22..089f1d6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -49,6 +49,7 @@ struct hal_hdr {
 
 /* Core Service */
 
+#define HAL_ERROR_SUCCESS		0x00
 #define HAL_ERROR_FAILED		0x01
 #define HAL_ERROR_NOT_READY		0x02
 #define HAL_ERROR_NOMEM			0x03
-- 
1.8.4.1

