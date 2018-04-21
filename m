Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tarvi Verro <tarvi.verro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tarvi Verro <tarvi.verro@gmail.com>
Subject: [PATCH BlueZ] shared/shell: Fix non-interactive mode with no input stream
Date: Sat, 21 Apr 2018 15:14:06 +0200
Message-Id: <20180421131406.6415-1-tarvi.verro@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the input stream doesn't support epoll, the non-interactive mode
should still print its output.

Showed up when a script was run as a systemd service. For testing
consider that the following command should report a version string:

btmgmt version < /dev/null
Version 5.49
---
 src/shared/shell.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index e7f17e021..aa20c30f7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -460,9 +460,6 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
-	if (!data.input)
-		return;
-
 	if (data.mode) {
 		va_start(args, fmt);
 		vprintf(fmt, args);
@@ -470,6 +467,9 @@ void bt_shell_printf(const char *fmt, ...)
 		return;
 	}
 
+	if (!data.input)
+		return;
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
-- 
2.17.0

