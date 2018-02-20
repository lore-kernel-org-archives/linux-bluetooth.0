Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/shell: Fix history display with no saved prompt
Date: Tue, 20 Feb 2018 12:09:40 +0100
Message-Id: <20180220110940.6293-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prompt needs to be restored always since default prompt is provided.
This fix issues with history line being clobbered by offset of prompt
length.

[bluetooth]# connect 9C:5C:F9:AB:C5:82
Attempting to connect to 9C:5C:F9:AB:C5:82
[bluetooth]# disconnect 9C:5C:F9:AB:C5:82
Attempting to disconnect from 9C:5C:F9:AB:C5:82
Failed to connect: org.bluez.Error.Failed
Successful disconnected
[bluetooth]# discoverable on
Changing discoverable on succeeded
[CHG] Controller 5C:E0:C5:34:AE:1C Discoverable: yes
[bluetooth]# disconnect discoverable on

after pressing up-down
[bluetooth]# disconnect dis5C:F9:AB:C5:82
---
 src/shared/shell.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 12330ff53..0ac492886 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -378,11 +378,9 @@ void bt_shell_printf(const char *fmt, ...)
 	if (save_input) {
 		saved_point = rl_point;
 		saved_line = rl_copy_text(0, rl_end);
-		if (!data.saved_prompt) {
-			rl_save_prompt();
-			rl_replace_line("", 0);
-			rl_redisplay();
-		}
+		rl_save_prompt();
+		rl_replace_line("", 0);
+		rl_redisplay();
 	}
 
 	va_start(args, fmt);
@@ -390,8 +388,7 @@ void bt_shell_printf(const char *fmt, ...)
 	va_end(args);
 
 	if (save_input) {
-		if (!data.saved_prompt)
-			rl_restore_prompt();
+		rl_restore_prompt();
 		rl_replace_line(saved_line, 0);
 		rl_point = saved_point;
 		rl_forced_update_display();
-- 
2.14.3

