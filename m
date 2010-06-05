Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 3/4] log: Remove vinfo function
Date: Fri,  4 Jun 2010 23:23:41 -0300
Message-Id: <1275704622-5917-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275704622-5917-2-git-send-email-gustavo@padovan.org>
References: <1275704622-5917-1-git-send-email-gustavo@padovan.org>
 <1275704622-5917-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was used only once.
---
 src/log.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/src/log.c b/src/log.c
index d667ed0..aefd50f 100644
--- a/src/log.c
+++ b/src/log.c
@@ -33,18 +33,13 @@
 
 #include "log.h"
 
-static inline void vinfo(const char *format, va_list ap)
-{
-	vsyslog(LOG_INFO, format, ap);
-}
-
 void info(const char *format, ...)
 {
 	va_list ap;
 
 	va_start(ap, format);
 
-	vinfo(format, ap);
+	vsyslog(LOG_INFO, format, ap);
 
 	va_end(ap);
 }
-- 
1.7.1

