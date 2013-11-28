Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/6] android: Make HAL logging wrapper print to stderr instead of stdout
Date: Thu, 28 Nov 2013 10:42:50 +0100
Message-Id: <1385631770-3858-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

This is used for testing and for user it makes no difference. This
will allow to switch on/off verbose logging from automated android
tester.
---
 android/hal-log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-log.h b/android/hal-log.h
index 9bd024d..63ff61b 100644
--- a/android/hal-log.h
+++ b/android/hal-log.h
@@ -25,7 +25,7 @@
 #define LOG_WARN " W"
 #define LOG_ERROR " E"
 #define LOG_DEBUG " D"
-#define ALOG(pri, tag, fmt, arg...) printf(tag pri": " fmt"\n", ##arg)
+#define ALOG(pri, tag, fmt, arg...) fprintf(stderr, tag pri": " fmt"\n", ##arg)
 #endif
 
 #define info(fmt, arg...) ALOG(LOG_INFO, LOG_TAG, fmt, ##arg)
-- 
1.8.4.2

