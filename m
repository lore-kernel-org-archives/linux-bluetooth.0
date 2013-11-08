Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 6/8] android/client: Add prompting for answer
Date: Fri, 8 Nov 2013 13:48:28 +0100
Message-ID: <1383914910-2304-7-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to switch to prompt mode where user will be asked
to supply some information.
---
 android/client/terminal.c |   67 +++++++++++++++++++++++++++++++++++++++++++++
 android/client/terminal.h |    1 +
 2 files changed, 68 insertions(+)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index 3674f89..f7b56de 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -684,6 +684,9 @@ TERMINAL_ACTION(terminal_action_default)
 		terminal_insert_into_command_line(str);
 }
 
+/* Callback to call when user hit enter during prompt for */
+static line_callback prompt_callback;
+
 static KeyAction normal_actions[] = {
 	{ 0, terminal_action_default },
 	{ KEY_LEFT, terminal_action_left },
@@ -709,6 +712,59 @@ static KeyAction normal_actions[] = {
 	{ 0, NULL },
 };
 
+TERMINAL_ACTION(terminal_action_answer)
+{
+	putchar(c);
+
+	terminal_set_actions(normal_actions);
+	/* Restore default prompt */
+	current_prompt = prompt_buf;
+
+	/* No prompt for prints */
+	prompt = noprompt;
+	line_buf_ix = 0;
+	line_len = 0;
+	/* Call user function with what was typed */
+	prompt_callback(line_buf);
+
+	line_buf[0] = 0;
+	/* promot_callback could change current_prompt */
+	prompt = current_prompt;
+
+	printf("%s", prompt);
+}
+
+TERMINAL_ACTION(terminal_action_prompt_ctrl_c)
+{
+	printf("^C\n");
+	line_buf_ix = 0;
+	line_len = 0;
+	line_buf[0] = 0;
+
+	current_prompt = prompt_buf;
+	prompt = current_prompt;
+	terminal_set_actions(normal_actions);
+
+	printf("%s", prompt);
+}
+
+static KeyAction prompt_actions[] = {
+	{ 0, terminal_action_default },
+	{ KEY_LEFT, terminal_action_left },
+	{ KEY_RIGHT, terminal_action_right },
+	{ KEY_HOME, terminal_action_home },
+	{ KEY_END, terminal_action_end },
+	{ KEY_DELETE, terminal_action_del },
+	{ KEY_CLEFT, terminal_action_word_left },
+	{ KEY_CRIGHT, terminal_action_word_right },
+	{ KEY_BACKSPACE, terminal_action_backspace },
+	{ KEY_C_C, terminal_action_prompt_ctrl_c },
+	{ KEY_C_D, terminal_action_ctrl_d },
+	{ '\r', terminal_action_answer },
+	{ '\n', terminal_action_answer },
+	{ 0, NULL },
+};
+
 void terminal_process_char(int c, line_callback process_line)
 {
 	KeyAction *a;
@@ -726,6 +782,17 @@ void terminal_process_char(int c, line_callback process_line)
 	fflush(stdout);
 }
 
+void terminal_prompt_for(const char *s, line_callback process_line)
+{
+	current_prompt = s;
+	if (prompt != noprompt) {
+		prompt = s;
+		terminal_clear_line();
+	}
+	prompt_callback = process_line;
+	terminal_set_actions(prompt_actions);
+}
+
 static struct termios origianl_tios;
 
 static void terminal_cleanup(void)
diff --git a/android/client/terminal.h b/android/client/terminal.h
index b5e402d..0e63936 100644
--- a/android/client/terminal.h
+++ b/android/client/terminal.h
@@ -57,5 +57,6 @@ int terminal_vprint(const char *format, va_list args);
 void terminal_process_char(int c, line_callback process_line);
 void terminal_insert_into_command_line(const char *p);
 void terminal_draw_command_line(void);
+void terminal_prompt_for(const char *s, line_callback process_line);
 
 void process_tab(const char *line, int len);
-- 
1.7.9.5

