Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH] android/log: Fix compilation error in AOSP
Date: Wed, 11 Nov 2015 19:09:51 +0100
Message-Id: <1447265391-26817-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_debug() has new parameter introduced in dcfdc556.
---
 android/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/log.c b/android/log.c
index 8013eba..35917c6 100644
--- a/android/log.c
+++ b/android/log.c
@@ -139,7 +139,7 @@ void error(const char *format, ...)
 	va_end(ap);
 }
 
-void btd_debug(const char *format, ...)
+void btd_debug(uint16_t index, const char *format, ...)
 {
 	va_list ap;
 
-- 
2.6.2

