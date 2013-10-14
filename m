Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/5] android: Add history to line editor in haltest
Date: Mon, 14 Oct 2013 11:59:52 +0200
Message-ID: <1381744794-17994-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1381744794-17994-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1381744794-17994-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added simple history to editor to save time.
---
 android/Android.mk            |    1 +
 android/hal_client/history.c  |  104 ++++++++++++++++++++++++++++++++++++++++
 android/hal_client/history.h  |   27 +++++++++++
 android/hal_client/terminal.c |  106 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 android/hal_client/history.c
 create mode 100644 android/hal_client/history.h

diff --git a/android/Android.mk b/android/Android.mk
index c75187d..b26a766 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -40,6 +40,7 @@ LOCAL_SRC_FILES := \
 	hal_client/haltest.c \
 	hal_client/pollhandler.c \
 	hal_client/terminal.c \
+	hal_client/history.c \
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
diff --git a/android/hal_client/history.c b/android/hal_client/history.c
new file mode 100644
index 0000000..71c1e73
--- /dev/null
+++ b/android/hal_client/history.c
@@ -0,0 +1,104 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+
+#include "history.h"
+
+/*
+ * Very simple history storage for easy usage of tool
+ */
+
+#define HISTORY_DEPTH 20
+#define LINE_SIZE 100
+static char lines[HISTORY_DEPTH][LINE_SIZE];
+static int last_line = 0;
+static int history_size = 0;
+
+/* TODO: Storing history not implemented yet */
+void history_store(const char *filename)
+{
+}
+
+/* Restoring history from file */
+void history_restore(const char *filename)
+{
+	char line[1000];
+	FILE *f = fopen(filename, "rt");
+
+	if (f == NULL)
+		return;
+
+	for (;;) {
+		if (fgets(line, 1000, f) != NULL) {
+			int l = strlen(line);
+			while (l > 0 && isspace(line[--l]))
+				line[l] = 0;
+			if (l > 0)
+				history_add_line(line);
+		} else
+			break;
+	}
+	fclose(f);
+}
+
+/* Add new line to history buffer */
+void history_add_line(const char *line)
+{
+	if (line == NULL || strlen(line) == 0)
+		return;
+
+	if (strcmp(line, lines[last_line]) == 0)
+		return;
+
+	last_line = (last_line + 1) % HISTORY_DEPTH;
+	strncpy(&lines[last_line][0], line, LINE_SIZE - 1);
+	if (history_size < HISTORY_DEPTH)
+		history_size++;
+}
+
+/*
+ * Get n-th line from history
+ * 0 - means latest
+ * -1 - means oldest
+ * return -1 if there is no such line
+ */
+int history_get_line(int n, char *buf, int buf_size)
+{
+	if (n == -1)
+		n = history_size - 1;
+
+	if (n >= history_size || buf_size == 0 || n < 0)
+		return -1;
+
+	strncpy(buf,
+		&lines[(HISTORY_DEPTH + last_line - n) % HISTORY_DEPTH][0],
+		buf_size - 1);
+	buf[buf_size - 1] = 0;
+
+	return n;
+}
+
diff --git a/android/hal_client/history.h b/android/hal_client/history.h
new file mode 100644
index 0000000..981f81e
--- /dev/null
+++ b/android/hal_client/history.h
@@ -0,0 +1,27 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+void history_store(const char *filename);
+void history_restore(const char *filename);
+void history_add_line(const char *line);
+int history_get_line(int n, char *buf, int buf_size);
diff --git a/android/hal_client/terminal.c b/android/hal_client/terminal.c
index e48a413..837e459 100644
--- a/android/hal_client/terminal.c
+++ b/android/hal_client/terminal.c
@@ -28,6 +28,7 @@
 #include <termios.h>
 
 #include "terminal.h"
+#include "history.h"
 
 /*
  * Character sequences recognized by code in this file
@@ -113,6 +114,9 @@ static int line_buf_ix = 0;
 /* current length of input line */
 static int line_len = 0;
 
+/* line index used for fetching lines from history */
+static int line_index = 0;
+
 /*
  * Moves cursor to right or left
  *
@@ -193,6 +197,86 @@ int terminal_vprint(const char *format, va_list args)
 }
 
 /*
+ * Call this when text in line_buf was changed
+ * and line needs to be redrawn
+ */
+static void terminal_line_replaced(void)
+{
+	int len = strlen(line_buf);
+
+	/* line is shorter that previous */
+	if (len < line_len) {
+		/* if new line is shorter move cursor to end of new end */
+		while (line_buf_ix > len) {
+			putchar('\b');
+			line_buf_ix--;
+		}
+		/* If cursor was not at the end, move it to the end */
+		if (line_buf_ix < line_len)
+			printf("%.*s", line_len - line_buf_ix,
+					line_buf + line_buf_ix);
+		/* over write end of previous line */
+		while (line_len >= len++)
+			putchar(' ');
+	}
+	/* draw new line */
+	printf("\r>%s", line_buf);
+	/* set up indexes to new line */
+	line_len = line_buf_ix = strlen(line_buf);
+}
+
+/*
+ * Function tries to replace current line with specified line in history
+ * new_line_index - new line to show, -1 to show oldest
+ */
+static void terminal_get_line_from_history(int new_line_index)
+{
+	new_line_index = history_get_line(new_line_index,
+						line_buf, LINE_BUF_MAX);
+
+	if (new_line_index >= 0) {
+		terminal_line_replaced();
+		line_index = new_line_index;
+	}
+}
+
+/*
+ * Function searches history back or forward for command line that starts
+ * with characters up to cursor position
+ *
+ * back - true - searches backward
+ * back - false - searches forward (more recent commands)
+ */
+static void terminal_match_hitory(bool back)
+{
+	char buf[line_buf_ix + 1];
+	int line;
+	int matching_line = -1;
+	int dir = back ? 1 : -1;
+
+	line = line_index + dir;
+	while (matching_line == -1 && line >= 0) {
+		int new_line_index;
+
+		new_line_index = history_get_line(line, buf, line_buf_ix + 1);
+		if (new_line_index < 0)
+			break;
+
+		if (0 == strncmp(line_buf, buf, line_buf_ix))
+			matching_line = line;
+		line += dir;
+	}
+
+	if (matching_line >= 0) {
+		int pos = line_buf_ix;
+		terminal_get_line_from_history(matching_line);
+		/* move back to cursor position to origianl place */
+		line_buf_ix = pos;
+		terminal_move_cursor(pos - line_len);
+	}
+}
+
+/*
  * Converts terminal character sequences to single value representing
  * keyboard keys
  */
@@ -339,12 +423,29 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 			printf("%.*s", (int)(line_buf_ix - old_pos),
 				line_buf + old_pos);
 		break;
+	case KEY_SUP:
+		terminal_get_line_from_history(-1);
+		break;
+	case KEY_SDOWN:
+		if (line_index > 0)
+			terminal_get_line_from_history(0);
+		break;
 	case KEY_UP:
+		terminal_get_line_from_history(line_index + 1);
+		break;
 	case KEY_DOWN:
+		if (line_index > 0)
+			terminal_get_line_from_history(line_index - 1);
 		break;
 	case '\n':
 	case '\r':
+		/*
+		 * On new line add line to history
+		 * forget history position
+		 */
+		history_add_line(line_buf);
 		line_len = line_buf_ix = 0;
+		line_index = -1;
 		/* print new line */
 		putchar(c);
 		process_line(line_buf);
@@ -386,7 +487,12 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 	case KEY_MDOWN:
 	case KEY_STAB:
 	case KEY_M_n:
+		/* Search history forward */
+		terminal_match_hitory(false);
+		break;
 	case KEY_M_p:
+		/* Search history backward */
+		terminal_match_hitory(true);
 		break;
 	default:
 		if (!isprint(c)) {
-- 
1.7.9.5

