Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 5/8] android/client: Split terminal_process_char
Date: Fri, 8 Nov 2013 13:48:27 +0100
Message-ID: <1383914910-2304-6-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the way input characters are handled in function
terminal_process_char from big switch statement to smaller functions.
No functionality is changed in this patch.
Splitting to smaller functions will make easier to change behaviour
of terminal for prompt handling when user will be asked for something
and history substitution or auto completion will not be used.
---
 android/client/terminal.c |  538 +++++++++++++++++++++++++++++----------------
 android/client/terminal.h |    4 +-
 2 files changed, 347 insertions(+), 195 deletions(-)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index b152bf3..3674f89 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -118,6 +118,8 @@ static int line_len = 0;
 static int line_index = 0;
 
 static char prompt_buf[10] = "> ";
+static const char *const noprompt = "";
+static const char *current_prompt = prompt_buf;
 static const char *prompt = prompt_buf;
 /*
  * Moves cursor to right or left
@@ -232,6 +234,7 @@ static void terminal_line_replaced(void)
 	/* set up indexes to new line */
 	line_len = strlen(line_buf);
 	line_buf_ix = line_len;
+	fflush(stdout);
 }
 
 static void terminal_clear_line(void)
@@ -365,217 +368,361 @@ static int terminal_convert_sequence(int c)
 	return c;
 }
 
-void terminal_process_char(int c, void (*process_line)(char *line))
+typedef void (*terminal_action)(int c, line_callback process_line);
+
+#define TERMINAL_ACTION(n) \
+	static void n(int c, void (*process_line)(char *line))
+
+TERMINAL_ACTION(terminal_action_null)
 {
-	int refresh_from = -1;
-	int old_pos;
+}
 
-	c = terminal_convert_sequence(c);
+/* Mapping between keys and function */
+typedef struct {
+	int key;
+	terminal_action func;
+} KeyAction;
+
+int action_keys[] = {
+	KEY_SEQUNCE_NOT_FINISHED,
+	KEY_LEFT,
+	KEY_RIGHT,
+	KEY_HOME,
+	KEY_END,
+	KEY_DELETE,
+	KEY_CLEFT,
+	KEY_CRIGHT,
+	KEY_SUP,
+	KEY_SDOWN,
+	KEY_UP,
+	KEY_DOWN,
+	KEY_BACKSPACE,
+	KEY_INSERT,
+	KEY_PGUP,
+	KEY_PGDOWN,
+	KEY_CUP,
+	KEY_CDOWN,
+	KEY_SLEFT,
+	KEY_SRIGHT,
+	KEY_MLEFT,
+	KEY_MRIGHT,
+	KEY_MUP,
+	KEY_MDOWN,
+	KEY_STAB,
+	KEY_M_n,
+	KEY_M_p,
+	KEY_C_C,
+	KEY_C_D,
+	KEY_C_L,
+	'\t',
+	'\r',
+	'\n',
+};
 
-	switch (c) {
-	case KEY_SEQUNCE_NOT_FINISHED:
-		break;
-	case KEY_LEFT:
-		/* if not at the beginning move to previous character */
-		if (line_buf_ix <= 0)
-			break;
-		line_buf_ix--;
-		terminal_move_cursor(-1);
-		break;
-	case KEY_RIGHT:
-		/*
-		 * If not at the end, just print current character
-		 * and modify position
-		 */
-		if (line_buf_ix < line_len)
-			putchar(line_buf[line_buf_ix++]);
-		break;
-	case KEY_HOME:
-		/* move to beginning of line and update position */
-		printf("\r%s", prompt);
-		line_buf_ix = 0;
-		break;
-	case KEY_END:
-		/* if not at the end of line */
-		if (line_buf_ix < line_len) {
-			/* print everything from cursor */
-			printf("%s", line_buf + line_buf_ix);
-			/* just modify current position */
-			line_buf_ix = line_len;
-		}
-		break;
-	case KEY_DELETE:
-		terminal_delete_char();
-		break;
-	case KEY_CLEFT:
+#define NELEM(x) ((int) (sizeof(x) / sizeof((x)[0])))
+
+/*
+ * current_actions holds all recognizable kes and actions for them
+ * additional element (index 0) is used for default action
+ */
+static KeyAction current_actions[NELEM(action_keys) + 1];
+
+/* KeyAction comparator by key, for qsort and bsearch */
+static int KeyActionKeyCompare(const void *a, const void *b)
+{
+	return ((const KeyAction *) a)->key - ((const KeyAction *) b)->key;
+}
+
+/* Find action by key, NULL if no action for this key */
+static KeyAction *terminal_get_action(int key)
+{
+	KeyAction a = { .key = key };
+
+	return bsearch(&a, current_actions + 1, NELEM(action_keys), sizeof(a),
+							KeyActionKeyCompare);
+}
+
+/* Sets new set of actions to use */
+static void terminal_set_actions(const KeyAction *actions)
+{
+	int i;
+
+	/* Make map with empty function for every key */
+	for (i = 0; i < NELEM(action_keys); ++i) {
 		/*
-		 * Move by word left
-		 *
-		 * Are we at the beginning of line?
+		 * + 1 due to 0 index reserved for default action that is
+		 * called for non mapped key
 		 */
-		if (line_buf_ix <= 0)
-			break;
+		current_actions[i + 1].key = action_keys[i];
+		current_actions[i + 1].func = terminal_action_null;
+	}
+
+	/* Sort action from 1 (index 0 - default action) */
+	qsort(current_actions + 1, NELEM(action_keys), sizeof(KeyAction),
+							KeyActionKeyCompare);
+	/* Set default action (first in array) */
+	current_actions[0] = *actions++;
+
+	/* Copy rest of actions into their places */
+	for (; actions->key; ++actions) {
+		KeyAction *place = terminal_get_action(actions->key);
+
+		if (place)
+			place->func = actions->func;
+	}
+}
+
+TERMINAL_ACTION(terminal_action_left)
+{
+	/* if not at the beginning move to previous character */
+	if (line_buf_ix <= 0)
+		return;
+	line_buf_ix--;
+	terminal_move_cursor(-1);
+}
+
+TERMINAL_ACTION(terminal_action_right)
+{
+	/*
+	 * If not at the end, just print current character
+	 * and modify position
+	 */
+	if (line_buf_ix < line_len)
+		putchar(line_buf[line_buf_ix++]);
+}
+
+TERMINAL_ACTION(terminal_action_home)
+{
+	/* move to beginning of line and update position */
+	printf("\r%s", prompt);
+	line_buf_ix = 0;
+}
+
+TERMINAL_ACTION(terminal_action_end)
+{
+	/* if not at the end of line */
+	if (line_buf_ix < line_len) {
+		/* print everything from cursor */
+		printf("%s", line_buf + line_buf_ix);
+		/* just modify current position */
+		line_buf_ix = line_len;
+	}
+}
+
+TERMINAL_ACTION(terminal_action_del)
+{
+	terminal_delete_char();
+}
+
+TERMINAL_ACTION(terminal_action_word_left)
+{
+	int old_pos;
+	/*
+	 * Move by word left
+	 *
+	 * Are we at the beginning of line?
+	 */
+	if (line_buf_ix <= 0)
+		return;
 
-		old_pos = line_buf_ix;
+	old_pos = line_buf_ix;
+	line_buf_ix--;
+	/* skip spaces left */
+	while (line_buf_ix && isspace(line_buf[line_buf_ix]))
 		line_buf_ix--;
-		/* skip spaces left */
-		while (line_buf_ix && isspace(line_buf[line_buf_ix]))
-			line_buf_ix--;
-		/* skip all non spaces to the left */
-		while (line_buf_ix > 0 &&
+
+	/* skip all non spaces to the left */
+	while (line_buf_ix > 0 &&
 			!isspace(line_buf[line_buf_ix - 1]))
-			line_buf_ix--;
-		/* move cursor to new position */
-		terminal_move_cursor(line_buf_ix - old_pos);
-		break;
-	case KEY_CRIGHT:
-		/*
-		 * Move by word right
-		 *
-		 * are we at the end of line?
-		 */
-		if (line_buf_ix >= line_len)
-			break;
+		line_buf_ix--;
 
-		old_pos = line_buf_ix;
-		/* skip all spaces */
-		while (line_buf_ix < line_len &&
-			isspace(line_buf[line_buf_ix]))
-			line_buf_ix++;
-		/* skip all non spaces */
-		while (line_buf_ix < line_len &&
-			!isspace(line_buf[line_buf_ix]))
-			line_buf_ix++;
-		/*
-		 * Move cursor to right by printing text
-		 * between old cursor and new
-		 */
-		if (line_buf_ix > old_pos)
-			printf("%.*s", (int) (line_buf_ix - old_pos),
+	/* move cursor to new position */
+	terminal_move_cursor(line_buf_ix - old_pos);
+}
+
+TERMINAL_ACTION(terminal_action_word_right)
+{
+	int old_pos;
+	/*
+	 * Move by word right
+	 *
+	 * are we at the end of line?
+	 */
+	if (line_buf_ix >= line_len)
+		return;
+
+	old_pos = line_buf_ix;
+	/* skip all spaces */
+	while (line_buf_ix < line_len && isspace(line_buf[line_buf_ix]))
+		line_buf_ix++;
+
+	/* skip all non spaces */
+	while (line_buf_ix < line_len && !isspace(line_buf[line_buf_ix]))
+		line_buf_ix++;
+	/*
+	 * Move cursor to right by printing text
+	 * between old cursor and new
+	 */
+	if (line_buf_ix > old_pos)
+		printf("%.*s", (int) (line_buf_ix - old_pos),
 							line_buf + old_pos);
-		break;
-	case KEY_SUP:
-		terminal_get_line_from_history(-1);
-		break;
-	case KEY_SDOWN:
-		if (line_index > 0)
-			terminal_get_line_from_history(0);
-		break;
-	case KEY_UP:
-		terminal_get_line_from_history(line_index + 1);
-		break;
-	case KEY_DOWN:
-		if (line_index > 0)
-			terminal_get_line_from_history(line_index - 1);
-		break;
-	case '\n':
-	case '\r':
-		/*
-		 * On new line add line to history
-		 * forget history position
-		 */
-		history_add_line(line_buf);
-		line_len = 0;
-		line_buf_ix = 0;
-		line_index = -1;
-		/* print new line */
-		putchar(c);
-		prompt = "";
-		process_line(line_buf);
-		/* clear current line */
-		line_buf[0] = '\0';
-		prompt = prompt_buf;
-		printf("%s", prompt);
-		break;
-	case '\t':
-		/* tab processing */
-		process_tab(line_buf, line_buf_ix);
-		break;
-	case KEY_BACKSPACE:
-		if (line_buf_ix <= 0)
-			break;
+}
 
-		if (line_buf_ix == line_len) {
-			printf("\b \b");
-			line_len = --line_buf_ix;
-			line_buf[line_len] = 0;
-		} else {
-			putchar('\b');
-			refresh_from = --line_buf_ix;
-			line_len--;
-			memmove(line_buf + line_buf_ix,
+TERMINAL_ACTION(terminal_action_history_begin)
+{
+	terminal_get_line_from_history(-1);
+}
+
+TERMINAL_ACTION(terminal_action_history_end)
+{
+	if (line_index > 0)
+		terminal_get_line_from_history(0);
+}
+
+TERMINAL_ACTION(terminal_action_history_up)
+{
+	terminal_get_line_from_history(line_index + 1);
+}
+
+TERMINAL_ACTION(terminal_action_history_down)
+{
+	if (line_index > 0)
+		terminal_get_line_from_history(line_index - 1);
+}
+
+TERMINAL_ACTION(terminal_action_tab)
+{
+	/* tab processing */
+	process_tab(line_buf, line_buf_ix);
+}
+
+
+TERMINAL_ACTION(terminal_action_backspace)
+{
+	if (line_buf_ix <= 0)
+		return;
+
+	if (line_buf_ix == line_len) {
+		printf("\b \b");
+		line_len = --line_buf_ix;
+		line_buf[line_len] = 0;
+	} else {
+		putchar('\b');
+		line_buf_ix--;
+		line_len--;
+		memmove(line_buf + line_buf_ix,
 				line_buf + line_buf_ix + 1,
 				line_len - line_buf_ix + 1);
-		}
-		break;
-	case KEY_INSERT:
-	case KEY_PGUP:
-	case KEY_PGDOWN:
-	case KEY_CUP:
-	case KEY_CDOWN:
-	case KEY_SLEFT:
-	case KEY_SRIGHT:
-	case KEY_MLEFT:
-	case KEY_MRIGHT:
-	case KEY_MUP:
-	case KEY_MDOWN:
-	case KEY_STAB:
-	case KEY_M_n:
-		/* Search history forward */
-		terminal_match_hitory(false);
-		break;
-	case KEY_M_p:
-		/* Search history backward */
-		terminal_match_hitory(true);
-		break;
-	case KEY_C_C:
-		terminal_clear_line();
-		break;
-	case KEY_C_D:
-		if (line_len > 0) {
-			terminal_delete_char();
-		} else  {
-			puts("");
-			exit(0);
-		}
-		break;
-	case KEY_C_L:
-		terminal_clear_screen();
-		break;
-	default:
-		if (!isprint(c)) {
-			/*
-			 * TODO: remove this print once all meaningful sequences
-			 * are identified
-			 */
-			printf("char-0x%02x\n", c);
-			break;
-		}
-
-		if (line_buf_ix < LINE_BUF_MAX - 1) {
-			if (line_len == line_buf_ix) {
-				putchar(c);
-				line_buf[line_buf_ix++] = (char) c;
-				line_len++;
-				line_buf[line_len] = '\0';
-			} else {
-				memmove(line_buf + line_buf_ix + 1,
-					line_buf + line_buf_ix,
-					line_len - line_buf_ix + 1);
-				line_buf[line_buf_ix] = c;
-				refresh_from = line_buf_ix++;
-				line_len++;
-			}
-		}
-		break;
+		printf("%s \b", line_buf + line_buf_ix);
+		terminal_move_cursor(line_buf_ix - line_len);
 	}
+}
 
-	if (refresh_from >= 0) {
-		printf("%s \b", line_buf + refresh_from);
-		terminal_move_cursor(line_buf_ix - line_len);
+TERMINAL_ACTION(terminal_action_find_history_forward)
+{
+	/* Search history forward */
+	terminal_match_hitory(false);
+}
+
+TERMINAL_ACTION(terminal_action_find_history_backward)
+{
+	/* Search history forward */
+	terminal_match_hitory(true);
+}
+
+TERMINAL_ACTION(terminal_action_ctrl_c)
+{
+	terminal_clear_line();
+}
+
+TERMINAL_ACTION(terminal_action_ctrl_d)
+{
+	if (line_len > 0) {
+		terminal_delete_char();
+	} else  {
+		puts("");
+		exit(0);
 	}
+}
+
+TERMINAL_ACTION(terminal_action_clear_screen)
+{
+	terminal_clear_screen();
+}
+
+TERMINAL_ACTION(terminal_action_enter)
+{
+	/*
+	 * On new line add line to history
+	 * forget history position
+	 */
+	history_add_line(line_buf);
+	line_len = 0;
+	line_buf_ix = 0;
+	line_index = -1;
+	/* print new line */
+	putchar(c);
+	prompt = noprompt;
+	process_line(line_buf);
+	/* clear current line */
+	line_buf[0] = '\0';
+	prompt = current_prompt;
+	printf("%s", prompt);
+}
+
+TERMINAL_ACTION(terminal_action_default)
+{
+	char str[2] = { c, 0 };
+
+	if (!isprint(c))
+		/*
+		 * TODO: remove this print once all meaningful sequences
+		 * are identified
+		 */
+		printf("char-0x%02x\n", c);
+	else if (line_buf_ix < LINE_BUF_MAX - 1)
+		terminal_insert_into_command_line(str);
+}
 
-	/* Flush output after all user input */
+static KeyAction normal_actions[] = {
+	{ 0, terminal_action_default },
+	{ KEY_LEFT, terminal_action_left },
+	{ KEY_RIGHT, terminal_action_right },
+	{ KEY_HOME, terminal_action_home },
+	{ KEY_END, terminal_action_end },
+	{ KEY_DELETE, terminal_action_del },
+	{ KEY_CLEFT, terminal_action_word_left },
+	{ KEY_CRIGHT, terminal_action_word_right },
+	{ KEY_SUP, terminal_action_history_begin },
+	{ KEY_SDOWN, terminal_action_history_end },
+	{ KEY_UP, terminal_action_history_up },
+	{ KEY_DOWN, terminal_action_history_down },
+	{ '\t', terminal_action_tab },
+	{ KEY_BACKSPACE, terminal_action_backspace },
+	{ KEY_M_n, terminal_action_find_history_forward },
+	{ KEY_M_p, terminal_action_find_history_backward },
+	{ KEY_C_C, terminal_action_ctrl_c },
+	{ KEY_C_D, terminal_action_ctrl_d },
+	{ KEY_C_L, terminal_action_clear_screen },
+	{ '\r', terminal_action_enter },
+	{ '\n', terminal_action_enter },
+	{ 0, NULL },
+};
+
+void terminal_process_char(int c, line_callback process_line)
+{
+	KeyAction *a;
+
+	c = terminal_convert_sequence(c);
+
+	/* Get action for this key */
+	a = terminal_get_action(c);
+
+	/* No action found, get default one */
+	if (a == NULL)
+		a = &current_actions[0];
+
+	a->func(c, process_line);
 	fflush(stdout);
 }
 
@@ -589,6 +736,9 @@ static void terminal_cleanup(void)
 void terminal_setup(void)
 {
 	struct termios tios;
+
+	terminal_set_actions(normal_actions);
+
 	tcgetattr(0, &origianl_tios);
 	tios = origianl_tios;
 
diff --git a/android/client/terminal.h b/android/client/terminal.h
index e53750f..b5e402d 100644
--- a/android/client/terminal.h
+++ b/android/client/terminal.h
@@ -49,10 +49,12 @@ enum key_codes {
 	KEY_M_n
 };
 
+typedef void (*line_callback)(char *);
+
 void terminal_setup(void);
 int terminal_print(const char *format, ...);
 int terminal_vprint(const char *format, va_list args);
-void terminal_process_char(int c, void (*process_line)(char *line));
+void terminal_process_char(int c, line_callback process_line);
 void terminal_insert_into_command_line(const char *p);
 void terminal_draw_command_line(void);
 
-- 
1.7.9.5

