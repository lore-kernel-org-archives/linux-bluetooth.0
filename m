Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Fix artifacts related to prompt
Date: Fri, 13 Apr 2018 17:52:12 +0300
Message-Id: <20180413145212.30659-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both bt_shell_prompt_input and bt_shell_input could cause the prompt to
be printed incorrectly, so they now rely on bt_shell_printf which
properly check if input and prompt shall be saved/restored.
---
 src/shared/shell.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index be2a8dfe0..9395598ee 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -475,7 +475,8 @@ void bt_shell_printf(const char *fmt, ...)
 	if (save_input) {
 		saved_point = rl_point;
 		saved_line = rl_copy_text(0, rl_end);
-		rl_save_prompt();
+		if (!data.saved_prompt)
+			rl_save_prompt();
 		rl_replace_line("", 0);
 		rl_redisplay();
 	}
@@ -485,7 +486,8 @@ void bt_shell_printf(const char *fmt, ...)
 	va_end(args);
 
 	if (save_input) {
-		rl_restore_prompt();
+		if (!data.saved_prompt)
+			rl_restore_prompt();
 		rl_replace_line(saved_line, 0);
 		rl_point = saved_point;
 		rl_forced_update_display();
@@ -523,12 +525,12 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 	if (data.saved_prompt)
 		return;
 
-	rl_save_prompt();
-	rl_message(COLOR_RED "[%s]" COLOR_OFF " %s ", label, msg);
-
 	data.saved_prompt = true;
 	data.saved_func = func;
 	data.saved_user_data = user_data;
+
+	rl_save_prompt();
+	bt_shell_printf(COLOR_RED "[%s]" COLOR_OFF " %s ", label, msg);
 }
 
 int bt_shell_release_prompt(const char *input)
@@ -1085,9 +1087,7 @@ void bt_shell_set_prompt(const char *string)
 		return;
 
 	rl_set_prompt(string);
-	printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_printf("\r");
 }
 
 static bool input_read(struct io *io, void *user_data)
-- 
2.14.3

