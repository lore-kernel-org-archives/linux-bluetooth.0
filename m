Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/3] android: Add handling of Ctrl-c to haltest
Date: Mon, 21 Oct 2013 16:02:15 +0200
Message-ID: <1382364136-13665-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of Ctrl-C so it does not break tool.
To exit tool Ctrl-D is used on empty command line.
Ctrl-D on not empty command line works like Delete key.
---
 android/client/terminal.c |   83 +++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index fb4d5d8..a57068a 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -20,6 +20,7 @@
 #include <ctype.h>
 #include <stdbool.h>
 #include <termios.h>
+#include <stdlib.h>
 
 #include "terminal.h"
 #include "history.h"
@@ -90,6 +91,10 @@ static const struct ansii_sequence ansii_sequnces[] = {
 	{ 0, NULL }
 };
 
+#define KEY_SEQUNCE_NOT_FINISHED -1
+#define KEY_C_C 3
+#define KEY_C_D 4
+
 #define isseqence(c) ((c) == 0x1B)
 
 /*
@@ -224,6 +229,30 @@ static void terminal_line_replaced(void)
 	line_buf_ix = line_len;
 }
 
+static void terminal_clear_line(void)
+{
+	line_buf[0] = '\0';
+	terminal_line_replaced();
+}
+
+static void terminal_delete_char(void)
+{
+	/* delete character under cursor if not at the very end */
+	if (line_buf_ix >= line_len)
+		return;
+	/*
+	 * Prepare buffer with one character missing
+	 * trailing 0 is moved
+	 */
+	line_len--;
+	memmove(line_buf + line_buf_ix, line_buf + line_buf_ix + 1,
+						line_len - line_buf_ix + 1);
+	/* print rest of line from current cursor position */
+	printf("%s \b", line_buf + line_buf_ix);
+	/* move back cursor */
+	terminal_move_cursor(line_buf_ix - line_len);
+}
+
 /*
  * Function tries to replace current line with specified line in history
  * new_line_index - new line to show, -1 to show oldest
@@ -288,7 +317,7 @@ static int terminal_convert_sequence(int c)
 		/* Is ansii sequence detected by 0x1B ? */
 		if (isseqence(c)) {
 			current_sequence_len++;
-			return 0;
+			return KEY_SEQUNCE_NOT_FINISHED;
 	       }
 	       return c;
 	}
@@ -307,7 +336,7 @@ static int terminal_convert_sequence(int c)
 			return ansii_sequnces[i].code;
 		}
 		/* partial match (not whole sequence yet) */
-		return 0;
+		return KEY_SEQUNCE_NOT_FINISHED;
 	}
 	terminal_print("ansii char 0x%X %c\n", c);
 	/*
@@ -326,7 +355,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 	c = terminal_convert_sequence(c);
 
 	switch (c) {
-	case 0:
+	case KEY_SEQUNCE_NOT_FINISHED:
 		break;
 	case KEY_LEFT:
 		/* if not at the beginning move to previous character */
@@ -358,21 +387,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		}
 		break;
 	case KEY_DELETE:
-		/* delete character under cursor if not at the very end */
-		if (line_buf_ix >= line_len)
-			break;
-		/*
-		 * Prepare buffer with one character missing
-		 * trailing 0 is moved
-		 */
-		line_len--;
-		memmove(line_buf + line_buf_ix,
-			line_buf + line_buf_ix + 1,
-			line_len - line_buf_ix + 1);
-		/* print rest of line from current cursor position */
-		printf("%s \b", line_buf + line_buf_ix);
-		/* move back cursor */
-		terminal_move_cursor(line_buf_ix - line_len);
+		terminal_delete_char();
 		break;
 	case KEY_CLEFT:
 		/*
@@ -495,6 +510,17 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		/* Search history backward */
 		terminal_match_hitory(true);
 		break;
+	case KEY_C_C:
+		terminal_clear_line();
+		break;
+	case KEY_C_D:
+		if (line_len > 0) {
+			terminal_delete_char();
+		} else  {
+			puts("");
+			exit(0);
+		}
+		break;
 	default:
 		if (!isprint(c)) {
 			/*
@@ -528,13 +554,28 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 	}
 }
 
+static struct termios origianl_tios;
+
+static void terminal_cleanup(void)
+{
+	tcsetattr(0, TCSANOW, &origianl_tios);
+}
+
 void terminal_setup(void)
 {
 	struct termios tios;
+	tcgetattr(0, &origianl_tios);
+	tios = origianl_tios;
 
-	/* Turn off echo since all editing is done by hand */
-	tcgetattr(0, &tios);
-	tios.c_lflag &= ~(ICANON | ECHO);
+	/*
+	 * Turn off echo since all editing is done by hand,
+	 * Ctrl-c handled internaly
+	 */
+	tios.c_lflag &= ~(ICANON | ECHO | BRKINT | IGNBRK);
 	tcsetattr(0, TCSANOW, &tios);
+
+	/* Restore terminal at exit */
+	atexit(terminal_cleanup);
+
 	printf("%s", prompt);
 }
-- 
1.7.9.5

