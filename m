Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH v2 2/5] android: Add line editing to haltest
Date: Tue, 15 Oct 2013 15:13:17 +0200
Message-ID: <1381842800-3554-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android does not have readline.
This patch allows to edit command line.
---
 android/Android.mk            |    1 +
 android/hal-client/haltest.c  |   39 +++-
 android/hal-client/terminal.c |  428 +++++++++++++++++++++++++++++++++++++++++
 android/hal-client/terminal.h |   59 ++++++
 4 files changed, 524 insertions(+), 3 deletions(-)
 create mode 100644 android/hal-client/terminal.c
 create mode 100644 android/hal-client/terminal.h

diff --git a/android/Android.mk b/android/Android.mk
index c84fbe3..292c50e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -59,6 +59,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	hal-client/haltest.c \
 	hal-client/pollhandler.c \
+	hal-client/terminal.c \
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
diff --git a/android/hal-client/haltest.c b/android/hal-client/haltest.c
index 11cdd97..edde0ee 100644
--- a/android/hal-client/haltest.c
+++ b/android/hal-client/haltest.c
@@ -19,8 +19,40 @@
 #include <poll.h>
 #include <unistd.h>
 
+#include "terminal.h"
 #include "pollhandler.h"
 
+/*
+ * This function changes input parameter line_buffer so it has
+ * null termination after each token (due to strtok)
+ * Output argv is filled with pointers to arguments
+ * returns number of tokens parsed - argc
+ */
+static int command_line_to_argv(char *line_buffer,
+				char *argv[], int argv_size)
+{
+	static const char *token_breaks = "\r\n\t ";
+	char *token;
+	int argc = 0;
+
+	token = strtok(line_buffer, token_breaks);
+	while (token != NULL && argc < (int)argv_size) {
+		argv[argc++] = token;
+		token = strtok(NULL, token_breaks);
+	}
+
+	return argc;
+}
+
+static void process_line(char *line_buffer)
+{
+	char *argv[10];
+	int argc;
+
+	argc = command_line_to_argv(line_buffer, argv, 10);
+
+	/* TODO: process command line */
+}
 
 /* called when there is something on stdin */
 static void stdin_handler(struct pollfd *pollfd)
@@ -33,15 +65,16 @@ static void stdin_handler(struct pollfd *pollfd)
 		if (count > 0) {
 			int i;
 
-			for (i = 0; i < count; ++i) {
-				/* TODO: process input */
-			}
+			for (i = 0; i < count; ++i)
+				terminal_process_char(buf[i], process_line);
 		}
 	}
 }
 
 int main(int argc, char **argv)
 {
+	terminal_setup();
+
 	/* Register command line handler */
 	poll_register_fd(0, POLLIN, stdin_handler);
 
diff --git a/android/hal-client/terminal.c b/android/hal-client/terminal.c
new file mode 100644
index 0000000..e449c71
--- /dev/null
+++ b/android/hal-client/terminal.c
@@ -0,0 +1,428 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdbool.h>
+#include <termios.h>
+
+#include "terminal.h"
+
+/*
+ * Character sequences recognized by code in this file
+ * Leading ESC 0x1B is not included
+ */
+#define SEQ_INSERT "[2~"
+#define SEQ_DELETE "[3~"
+#define SEQ_HOME   "OH"
+#define SEQ_END    "OF"
+#define SEQ_PGUP   "[5~"
+#define SEQ_PGDOWN "[6~"
+#define SEQ_LEFT   "[D"
+#define SEQ_RIGHT  "[C"
+#define SEQ_UP     "[A"
+#define SEQ_DOWN   "[B"
+#define SEQ_STAB   "[Z"
+#define SEQ_M_n    "n"
+#define SEQ_M_p    "p"
+#define SEQ_CLEFT  "[1;5D"
+#define SEQ_CRIGHT "[1;5C"
+#define SEQ_CUP    "[1;5A"
+#define SEQ_CDOWN  "[1;5B"
+#define SEQ_SLEFT  "[1;2D"
+#define SEQ_SRIGHT "[1;2C"
+#define SEQ_SUP    "[1;2A"
+#define SEQ_SDOWN  "[1;2B"
+#define SEQ_MLEFT  "[1;3D"
+#define SEQ_MRIGHT "[1;3C"
+#define SEQ_MUP    "[1;3A"
+#define SEQ_MDOWN  "[1;3B"
+
+#define KEY_SEQUENCE(k) { KEY_##k, SEQ_##k }
+struct ansii_sequence {
+	int code;
+	const char *sequence;
+};
+
+/* Table connects single int key codes with character sequences */
+static const struct ansii_sequence ansii_sequnces[] = {
+	KEY_SEQUENCE(INSERT),
+	KEY_SEQUENCE(DELETE),
+	KEY_SEQUENCE(HOME),
+	KEY_SEQUENCE(END),
+	KEY_SEQUENCE(PGUP),
+	KEY_SEQUENCE(PGDOWN),
+	KEY_SEQUENCE(LEFT),
+	KEY_SEQUENCE(RIGHT),
+	KEY_SEQUENCE(UP),
+	KEY_SEQUENCE(DOWN),
+	KEY_SEQUENCE(CLEFT),
+	KEY_SEQUENCE(CRIGHT),
+	KEY_SEQUENCE(CUP),
+	KEY_SEQUENCE(CDOWN),
+	KEY_SEQUENCE(SLEFT),
+	KEY_SEQUENCE(SRIGHT),
+	KEY_SEQUENCE(SUP),
+	KEY_SEQUENCE(SDOWN),
+	KEY_SEQUENCE(MLEFT),
+	KEY_SEQUENCE(MRIGHT),
+	KEY_SEQUENCE(MUP),
+	KEY_SEQUENCE(MDOWN),
+	KEY_SEQUENCE(STAB),
+	KEY_SEQUENCE(M_p),
+	KEY_SEQUENCE(M_n),
+	{ 0, NULL }
+};
+
+#define isseqence(c) ((c) == 0x1B)
+
+/*
+ * Number of characters that consist of ANSII sequence
+ * Should not be less then longest string in ansii_sequnces
+ */
+#define MAX_ASCII_SEQUENCE 10
+
+static char current_sequence[MAX_ASCII_SEQUENCE];
+static int current_sequence_len = -1;
+
+/* single line typed by user goes here */
+static char line_buf[LINE_BUF_MAX];
+/* index of cursor in input line */
+static int line_buf_ix = 0;
+/* current length of input line */
+static int line_len = 0;
+
+/*
+ * Moves cursor to right or left
+ *
+ * n - positive - moves cursor right
+ * n - negative - moves cursor left
+ */
+static void terminal_move_cursor(int n)
+{
+	if (n < 0) {
+		for (; n < 0; n++)
+			putchar('\b');
+	} else if (n > 0)
+		printf("%*s", n, line_buf + line_buf_ix);
+}
+
+/* Draw command line */
+void terminal_draw_command_line(void)
+{
+	/*
+	 * this needs to be checked here since line_buf is not cleard
+	 * before parsing event though line_len and line_buf_ix are
+	 */
+	if (line_len > 0)
+		printf(">%s", line_buf);
+	else
+		putchar('>');
+
+	/* move cursor to it's place */
+	terminal_move_cursor(line_len - line_buf_ix);
+}
+
+/* inserts string into command line at cursor position */
+void terminal_insert_into_command_line(const char *p)
+{
+	int len = strlen(p);
+
+	if (line_len == line_buf_ix) {
+		strcat(line_buf, p);
+		printf("%s", p);
+		line_buf_ix = line_len = line_len + len;
+	} else {
+		memmove(line_buf + line_buf_ix + len,
+			line_buf + line_buf_ix, line_len - line_buf_ix + 1);
+		memmove(line_buf + line_buf_ix, p, len);
+		printf("%s", line_buf + line_buf_ix);
+		line_buf_ix += len;
+		line_len += len;
+		terminal_move_cursor(line_buf_ix - line_len);
+	}
+}
+
+/* Prints string and redraws command line */
+int terminal_print(const char *format, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, format);
+
+	ret = terminal_vprint(format, args);
+
+	va_end(args);
+	return ret;
+}
+
+/* Prints string and redraws command line */
+int terminal_vprint(const char *format, va_list args)
+{
+	int ret;
+
+	printf("\r%*s\r", (int)line_len + 1, " ");
+
+	ret = vprintf(format, args);
+
+	terminal_draw_command_line();
+
+	return ret;
+}
+
+/*
+ * Converts terminal character sequences to single value representing
+ * keyboard keys
+ */
+static int terminal_convert_sequence(int c)
+{
+	int i;
+
+	/* Not in sequence yet? */
+	if (current_sequence_len == -1) {
+		/* Is ansii sequence detected by 0x1B ? */
+		if (isseqence(c)) {
+			current_sequence_len++;
+			return 0;
+	       }
+	       return c;
+	}
+	/* Inside sequence */
+	current_sequence[current_sequence_len++] = c;
+	current_sequence[current_sequence_len] = '\0';
+	for (i = 0; ansii_sequnces[i].code; ++i) {
+		/* Matches so far? */
+		if (0 != strncmp(current_sequence,
+			ansii_sequnces[i].sequence, current_sequence_len))
+			continue;
+
+		/* Matches as a whole? */
+		if (ansii_sequnces[i].sequence[current_sequence_len] == 0) {
+			current_sequence_len = -1;
+			return ansii_sequnces[i].code;
+		}
+		/* partial match (not whole sequence yet) */
+		return 0;
+	}
+	terminal_print("ansii char 0x%X %c\n", c);
+	/*
+	 * Sequence does not match
+	 * mark that no in sequence any more, return char
+	 */
+	current_sequence_len = -1;
+	return c;
+}
+
+void terminal_process_char(int c, void (*process_line)(char *line))
+{
+	int refresh_from = -1;
+	int old_pos;
+
+	c = terminal_convert_sequence(c);
+
+	switch (c) {
+	case 0:
+		break;
+	case KEY_LEFT:
+		/* if not at the beginning move to previous character */
+		if (line_buf_ix <= 0)
+			break;
+		line_buf_ix--;
+		terminal_move_cursor(-1);
+		break;
+	case KEY_RIGHT:
+		/*
+		 * If not at the end, just print current character
+		 * and modify position
+		 */
+		if (line_buf_ix < line_len)
+			putchar(line_buf[line_buf_ix++]);
+		break;
+	case KEY_HOME:
+		/* move to beginning of line and update position */
+		putchar('\r');
+		putchar('>');
+		line_buf_ix = 0;
+		break;
+	case KEY_END:
+		/* if not at the end of line */
+		if (line_buf_ix < line_len) {
+			/* print everything from cursor */
+			printf("%s", line_buf + line_buf_ix);
+			/* just modify current position */
+			line_buf_ix = line_len;
+		}
+		break;
+	case KEY_DELETE:
+		/* delete character under cursor if not at the very end */
+		if (line_buf_ix >= line_len)
+			break;
+		/*
+		 * Prepare buffer with one character missing
+		 * trailing 0 is moved
+		 */
+		line_len--;
+		memmove(line_buf + line_buf_ix,
+			line_buf + line_buf_ix + 1,
+			line_len - line_buf_ix + 1);
+		/* print rest of line from current cursor position */
+		printf("%s \b", line_buf + line_buf_ix);
+		/* move back cursor */
+		terminal_move_cursor(line_buf_ix - line_len);
+		break;
+	case KEY_CLEFT:
+		/*
+		 * Move by word left
+		 *
+		 * Are we at the beginning of line?
+		 */
+		if (line_buf_ix <= 0)
+			break;
+
+		old_pos = line_buf_ix;
+		line_buf_ix--;
+		/* skip spaces left */
+		while (line_buf_ix && isspace(line_buf[line_buf_ix]))
+			line_buf_ix--;
+		/* skip all non spaces to the left */
+		while (line_buf_ix > 0 &&
+		       !isspace(line_buf[line_buf_ix - 1]))
+			line_buf_ix--;
+		/* move cursor to new position */
+		terminal_move_cursor(line_buf_ix - old_pos);
+		break;
+	case KEY_CRIGHT:
+		/*
+		 * Move by word right
+		 *
+		 * are we at the end of line?
+		 */
+		if (line_buf_ix >= line_len)
+			break;
+
+		old_pos = line_buf_ix;
+		/* skip all spaces */
+		while (line_buf_ix < line_len &&
+			isspace(line_buf[line_buf_ix]))
+			line_buf_ix++;
+		/* skip all non spaces */
+		while (line_buf_ix < line_len &&
+			!isspace(line_buf[line_buf_ix]))
+			line_buf_ix++;
+		/*
+		 * Move cursor to right by printing text
+		 * between old cursor and new
+		 */
+		if (line_buf_ix > old_pos)
+			printf("%.*s", (int)(line_buf_ix - old_pos),
+				line_buf + old_pos);
+		break;
+	case KEY_UP:
+	case KEY_DOWN:
+		break;
+	case '\n':
+	case '\r':
+		line_len = line_buf_ix = 0;
+		/* print new line */
+		putchar(c);
+		process_line(line_buf);
+		/* clear current line */
+		line_buf[0] = '\0';
+		putchar('>');
+		break;
+	case '\t':
+		/* tab processing */
+		/* TODO Add completion here */
+		break;
+	case KEY_BACKSPACE:
+		if (line_buf_ix <= 0)
+			break;
+
+		if (line_buf_ix == line_len) {
+			printf("\b \b");
+			line_len = --line_buf_ix;
+			line_buf[line_len] = 0;
+		} else {
+			putchar('\b');
+			refresh_from = --line_buf_ix;
+			line_len--;
+			memmove(line_buf + line_buf_ix,
+				line_buf + line_buf_ix + 1,
+				line_len - line_buf_ix + 1);
+		}
+		break;
+	case KEY_INSERT:
+	case KEY_PGUP:
+	case KEY_PGDOWN:
+	case KEY_CUP:
+	case KEY_CDOWN:
+	case KEY_SLEFT:
+	case KEY_SRIGHT:
+	case KEY_MLEFT:
+	case KEY_MRIGHT:
+	case KEY_MUP:
+	case KEY_MDOWN:
+	case KEY_STAB:
+	case KEY_M_n:
+	case KEY_M_p:
+		break;
+	default:
+		if (!isprint(c)) {
+			/*
+			 * TODO: remove this print once all meaningful sequences
+			 * are identified
+			 */
+			printf("char-0x%02x\n", c);
+			break;
+		}
+		if (line_buf_ix < LINE_BUF_MAX - 1) {
+			if (line_len == line_buf_ix) {
+				putchar(c);
+				line_buf[line_buf_ix++] = (char)c;
+				line_len++;
+				line_buf[line_len] = '\0';
+			} else {
+				memmove(line_buf + line_buf_ix + 1,
+					line_buf + line_buf_ix,
+					line_len - line_buf_ix + 1);
+				line_buf[line_buf_ix] = c;
+				refresh_from = line_buf_ix++;
+				line_len++;
+			}
+		}
+		break;
+	}
+
+	if (refresh_from >= 0) {
+		printf("%s \b", line_buf + refresh_from);
+		terminal_move_cursor(line_buf_ix - line_len);
+	}
+}
+
+void terminal_setup(void)
+{
+	struct termios tios;
+
+	/* Turn off echo since all editing is done by hand */
+	tcgetattr(0, &tios);
+	tios.c_lflag &= ~(ICANON | ECHO);
+	tcsetattr(0, TCSANOW, &tios);
+	putchar('>');
+}
+
diff --git a/android/hal-client/terminal.h b/android/hal-client/terminal.h
new file mode 100644
index 0000000..e53750f
--- /dev/null
+++ b/android/hal-client/terminal.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdarg.h>
+
+/* size of supported line */
+#define LINE_BUF_MAX 1024
+
+enum key_codes {
+	KEY_BACKSPACE = 0x7F,
+	KEY_INSERT = 1000, /* arbitrary value */
+	KEY_DELETE,
+	KEY_HOME,
+	KEY_END,
+	KEY_PGUP,
+	KEY_PGDOWN,
+	KEY_LEFT,
+	KEY_RIGHT,
+	KEY_UP,
+	KEY_DOWN,
+	KEY_CLEFT,
+	KEY_CRIGHT,
+	KEY_CUP,
+	KEY_CDOWN,
+	KEY_SLEFT,
+	KEY_SRIGHT,
+	KEY_SUP,
+	KEY_SDOWN,
+	KEY_MLEFT,
+	KEY_MRIGHT,
+	KEY_MUP,
+	KEY_MDOWN,
+	KEY_STAB,
+	KEY_M_p,
+	KEY_M_n
+};
+
+void terminal_setup(void);
+int terminal_print(const char *format, ...);
+int terminal_vprint(const char *format, va_list args);
+void terminal_process_char(int c, void (*process_line)(char *line));
+void terminal_insert_into_command_line(const char *p);
+void terminal_draw_command_line(void);
+
+void process_tab(const char *line, int len);
-- 
1.7.9.5

