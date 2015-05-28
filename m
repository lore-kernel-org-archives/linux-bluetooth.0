Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] monitor: Use black font for white background
Date: Fri, 29 May 2015 00:13:43 +0200
Message-Id: <1432851224-19550-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure that font is always visible on white background.
---
 monitor/display.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/display.h b/monitor/display.h
index e627401..df08362 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -35,7 +35,7 @@ bool use_color(void);
 #define COLOR_MAGENTA	"\x1B[0;35m"
 #define COLOR_CYAN	"\x1B[0;36m"
 #define COLOR_WHITE	"\x1B[0;37m"
-#define COLOR_WHITE_BG	"\x1B[0;47m"
+#define COLOR_WHITE_BG	"\x1B[0;47;30m"
 #define COLOR_HIGHLIGHT	"\x1B[1;39m"
 
 #define COLOR_ERROR	"\x1B[1;31m"
-- 
1.9.3

