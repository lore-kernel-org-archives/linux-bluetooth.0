Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix annoying delay in command line
Date: Mon, 4 Nov 2013 12:33:44 +0100
Message-ID: <1383564824-32337-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move fflush(stdout) to after prints and user input.
This removes delay of showing prompt.
---
Same effect could be achieved by calling setbuf(stdout, NULL)
in terminal_setup() then all fflush calls could be removed.

If you think this should be better approach, I will change it.

 android/client/pollhandler.c |    5 -----
 android/client/terminal.c    |    6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/android/client/pollhandler.c b/android/client/pollhandler.c
index dd0d09f..6160921 100644
--- a/android/client/pollhandler.c
+++ b/android/client/pollhandler.c
@@ -68,11 +68,6 @@ void poll_dispatch_loop(void)
 			if (cur_fds_count != fds_count)
 				break;
 		}
-		/*
-		 * This seems to be needed for correct output handling
-		 * when all waiting is performed in poll
-		 */
-		fflush(stdout);
 	}
 }
 
diff --git a/android/client/terminal.c b/android/client/terminal.c
index e721160..22a1d8a 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -197,6 +197,8 @@ int terminal_vprint(const char *format, va_list args)
 
 	terminal_draw_command_line();
 
+	fflush(stdout);
+
 	return ret;
 }
 
@@ -570,6 +572,9 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		printf("%s \b", line_buf + refresh_from);
 		terminal_move_cursor(line_buf_ix - line_len);
 	}
+
+	/* Flush output after all user input */
+	fflush(stdout);
 }
 
 static struct termios origianl_tios;
@@ -596,4 +601,5 @@ void terminal_setup(void)
 	atexit(terminal_cleanup);
 
 	printf("%s", prompt);
+	fflush(stdout);
 }
-- 
1.7.9.5

