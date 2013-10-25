Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 14/15] android: Add missing success status definition to IPC header
Date: Fri, 25 Oct 2013 12:50:10 +0200
Message-ID: <1382698211-9123-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used in HAL callbacks to indicate success.
---
 android/hal-msg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2a0b670..3703d55 100644
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

