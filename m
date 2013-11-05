Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/2] android/client: Fix style and typos
Date: Tue, 5 Nov 2013 10:56:21 +0100
Message-ID: <1383645382-3372-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383645382-3372-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383645382-3372-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes spelling errors and white space style errors.
---
 android/client/history.c       |    3 +++
 android/client/tabcompletion.c |   21 +++++++++++++--------
 android/client/terminal.c      |   26 ++++++++++++++------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/android/client/history.c b/android/client/history.c
index 6481174..ee285da 100644
--- a/android/client/history.c
+++ b/android/client/history.c
@@ -49,13 +49,16 @@ void history_restore(const char *filename)
 	for (;;) {
 		if (fgets(line, 1000, f) != NULL) {
 			int l = strlen(line);
+
 			while (l > 0 && isspace(line[--l]))
 				line[l] = 0;
+
 			if (l > 0)
 				history_add_line(line);
 		} else
 			break;
 	}
+
 	fclose(f);
 }
 
diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index cc1a5d3..4a6329f 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -58,9 +58,9 @@ static void print_matches(enum_func f, void *user, const char *prefix, int len)
 
 /*
  * This function splits command line into linked list of arguments.
- * line_buffer - pointer to input comman line
+ * line_buffer - pointer to input command line
  * size - size of command line to parse
- * buf - output buffer to keep splited arguments list
+ * buf - output buffer to keep split arguments list
  * buf_size_in_bytes - size of buf
  */
 static int split_command(const char *line_buffer, int size, split_arg_t *buf,
@@ -134,12 +134,14 @@ static void tab_completion(struct command_completion_args *args)
 		/* prefix does not match */
 		if (strncmp(enum_name, name, len) != 0)
 			continue;
+
 		/* prefix matches first time */
 		if (count++ == 0) {
 			strcpy(prefix, enum_name);
 			prefix_len = strlen(prefix);
 			continue;
 		}
+
 		/*
 		 * Prefix matches next time
 		 * reduce prefix to common part
@@ -158,12 +160,13 @@ static void tab_completion(struct command_completion_args *args)
 		tab_hit_count = 0;
 		return;
 	}
+
 	/* len == prefix_len => nothing new was added */
 	if (len == prefix_len) {
 		if (count != 1) {
-			if (tab_hit_count == 1)
+			if (tab_hit_count == 1) {
 				putchar('\a');
-			else if (tab_hit_count == 2 ||
+			} else if (tab_hit_count == 2 ||
 					args->help == NULL) {
 				print_matches(args->func,
 						args->user, name, len);
@@ -182,6 +185,7 @@ static void tab_completion(struct command_completion_args *args)
 			prefix[prefix_len++] = ' ';
 			prefix[prefix_len] = '\0';
 		}
+
 		terminal_insert_into_command_line(prefix + len);
 		tab_hit_count = 0;
 	}
@@ -304,7 +308,7 @@ static const char *return_null(void *user, int i)
  * parameter completion function
  * argc - number of elements in arg list
  * arg - list of arguments
- * megthod - method to get completion from (can be NULL)
+ * method - method to get completion from (can be NULL)
  */
 static void param_completion(int argc, const split_arg_t *arg,
 					const struct method *method, int hlpix)
@@ -339,9 +343,9 @@ static void param_completion(int argc, const split_arg_t *arg,
 }
 
 /*
- * This methd gets called when user tapped tab key.
- * line - points to comman line
- * len - size of line that should be used for comletions. This should be
+ * This method gets called when user tapped tab key.
+ * line - points to command line
+ * len - size of line that should be used for completions. This should be
  *   cursor position during tab hit.
  */
 void process_tab(const char *line, int len)
@@ -360,6 +364,7 @@ void process_tab(const char *line, int len)
 		command_completion(buf);
 		return;
 	}
+
 	method = get_command(buf[0].ntcopy);
 	if (method != NULL) {
 		param_completion(argc, buf, method, 1);
diff --git a/android/client/terminal.c b/android/client/terminal.c
index 22a1d8a..b152bf3 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -99,8 +99,8 @@ static const struct ansii_sequence ansii_sequnces[] = {
 #define isseqence(c) ((c) == 0x1B)
 
 /*
- * Number of characters that consist of ANSII sequence
- * Should not be less then longest string in ansii_sequnces
+ * Number of characters that consist of ANSI sequence
+ * Should not be less then longest string in ansi_sequences
  */
 #define MAX_ASCII_SEQUENCE 10
 
@@ -139,7 +139,7 @@ static void terminal_move_cursor(int n)
 void terminal_draw_command_line(void)
 {
 	/*
-	 * this needs to be checked here since line_buf is not cleard
+	 * this needs to be checked here since line_buf is not cleared
 	 * before parsing event though line_len and line_buf_ix are
 	 */
 	if (line_len > 0)
@@ -240,7 +240,7 @@ static void terminal_clear_line(void)
 	terminal_line_replaced();
 }
 
-static void terminal_clear_sceen(void)
+static void terminal_clear_screen(void)
 {
 	line_buf[0] = '\0';
 	line_buf_ix = 0;
@@ -312,7 +312,7 @@ static void terminal_match_hitory(bool back)
 	if (matching_line >= 0) {
 		int pos = line_buf_ix;
 		terminal_get_line_from_history(matching_line);
-		/* move back to cursor position to origianl place */
+		/* move back to cursor position to original place */
 		line_buf_ix = pos;
 		terminal_move_cursor(pos - line_len);
 	}
@@ -328,12 +328,13 @@ static int terminal_convert_sequence(int c)
 
 	/* Not in sequence yet? */
 	if (current_sequence_len == -1) {
-		/* Is ansii sequence detected by 0x1B ? */
+		/* Is ansi sequence detected by 0x1B ? */
 		if (isseqence(c)) {
 			current_sequence_len++;
 			return KEY_SEQUNCE_NOT_FINISHED;
-	       }
-	       return c;
+		}
+
+		return c;
 	}
 
 	/* Inside sequence */
@@ -350,11 +351,12 @@ static int terminal_convert_sequence(int c)
 			current_sequence_len = -1;
 			return ansii_sequnces[i].code;
 		}
+
 		/* partial match (not whole sequence yet) */
 		return KEY_SEQUNCE_NOT_FINISHED;
 	}
 
-	terminal_print("ansii char 0x%X %c\n", c);
+	terminal_print("ansi char 0x%X %c\n", c);
 	/*
 	 * Sequence does not match
 	 * mark that no in sequence any more, return char
@@ -421,7 +423,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 			line_buf_ix--;
 		/* skip all non spaces to the left */
 		while (line_buf_ix > 0 &&
-		       !isspace(line_buf[line_buf_ix - 1]))
+			!isspace(line_buf[line_buf_ix - 1]))
 			line_buf_ix--;
 		/* move cursor to new position */
 		terminal_move_cursor(line_buf_ix - old_pos);
@@ -538,7 +540,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 		}
 		break;
 	case KEY_C_L:
-		terminal_clear_sceen();
+		terminal_clear_screen();
 		break;
 	default:
 		if (!isprint(c)) {
@@ -592,7 +594,7 @@ void terminal_setup(void)
 
 	/*
 	 * Turn off echo since all editing is done by hand,
-	 * Ctrl-c handled internaly
+	 * Ctrl-c handled internally
 	 */
 	tios.c_lflag &= ~(ICANON | ECHO | BRKINT | IGNBRK);
 	tcsetattr(0, TCSANOW, &tios);
-- 
1.7.9.5

