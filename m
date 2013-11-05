Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Fallback to 80 columns terminal if not able to get real size
Date: Tue, 5 Nov 2013 14:22:53 +0100
Message-ID: <1383657773-13597-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes num_columns always return valid number of columns, which is
expected by print_packets function.

This also fix garbage prints while using btmon via adb shell.
---
 monitor/display.c | 8 ++++----
 monitor/display.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/monitor/display.c b/monitor/display.c
index b8dce1f..af4171f 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -58,10 +58,10 @@ int num_columns(void)
 	if (__builtin_expect(!!(cached_num_columns < 0), 0)) {
 		struct winsize ws;
 
-		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0)
-			return -1;
-
-		if (ws.ws_col > 0)
+		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
+								ws.ws_col == 0)
+			cached_num_columns = FALLBACK_TERMINAL_WIDTH;
+		else
 			cached_num_columns = ws.ws_col;
 	}
 
diff --git a/monitor/display.h b/monitor/display.h
index 6139cc2..885eb34 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -40,6 +40,8 @@ bool use_color(void);
 
 #define COLOR_ERROR	"\x1B[1;31m"
 
+#define FALLBACK_TERMINAL_WIDTH 80
+
 #define print_indent(indent, color1, prefix, title, color2, fmt, args...) \
 do { \
 	printf("%*c%s%s%s%s" fmt "%s\n", (indent), ' ', \
-- 
1.8.4.1

