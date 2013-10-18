Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/3] android: Fix error in draw line in haltest tool
Date: Fri, 18 Oct 2013 15:15:59 +0200
Message-ID: <1382102160-21532-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes small error that showed up when tab completion inserted
characters before end of line.
Cursor in line was not moved correctly.
---
 android/client/terminal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index 0421633..8dd3a25 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -140,7 +140,7 @@ void terminal_draw_command_line(void)
 		putchar('>');
 
 	/* move cursor to it's place */
-	terminal_move_cursor(line_len - line_buf_ix);
+	terminal_move_cursor(line_buf_ix - line_len);
 }
 
 /* inserts string into command line at cursor position */
-- 
1.7.9.5

