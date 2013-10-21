Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/3] android: Add space in prompt in haltest
Date: Mon, 21 Oct 2013 16:02:14 +0200
Message-ID: <1382364136-13665-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes prompt more consistent with other bluez tools.
This also fixes small issue when prompt was printed twice.
---
 android/client/terminal.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index 8dd3a25..fb4d5d8 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -111,6 +111,8 @@ static int line_len = 0;
 /* line index used for fetching lines from history */
 static int line_index = 0;
 
+static char prompt_buf[10] = "> ";
+static const char *prompt = prompt_buf;
 /*
  * Moves cursor to right or left
  *
@@ -135,9 +137,9 @@ void terminal_draw_command_line(void)
 	 * before parsing event though line_len and line_buf_ix are
 	 */
 	if (line_len > 0)
-		printf(">%s", line_buf);
+		printf("%s%s", prompt, line_buf);
 	else
-		putchar('>');
+		printf("%s", prompt);
 
 	/* move cursor to it's place */
 	terminal_move_cursor(line_buf_ix - line_len);
@@ -216,7 +218,7 @@ static void terminal_line_replaced(void)
 			putchar(' ');
 	}
 	/* draw new line */
-	printf("\r>%s", line_buf);
+	printf("\r%s%s", prompt, line_buf);
 	/* set up indexes to new line */
 	line_len = strlen(line_buf);
 	line_buf_ix = line_len;
@@ -343,8 +345,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		break;
 	case KEY_HOME:
 		/* move to beginning of line and update position */
-		putchar('\r');
-		putchar('>');
+		printf("\r%s", prompt);
 		line_buf_ix = 0;
 		break;
 	case KEY_END:
@@ -446,10 +447,12 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		line_index = -1;
 		/* print new line */
 		putchar(c);
+		prompt = "";
 		process_line(line_buf);
 		/* clear current line */
 		line_buf[0] = '\0';
-		putchar('>');
+		prompt = prompt_buf;
+		printf("%s", prompt);
 		break;
 	case '\t':
 		/* tab processing */
@@ -533,5 +536,5 @@ void terminal_setup(void)
 	tcgetattr(0, &tios);
 	tios.c_lflag &= ~(ICANON | ECHO);
 	tcsetattr(0, TCSANOW, &tios);
-	putchar('>');
+	printf("%s", prompt);
 }
-- 
1.7.9.5

