Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] meshctl: Add commands autocompletion
Date: Thu,  7 Sep 2017 09:58:30 +0200
Message-Id: <20170907075830.32641-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mesh/util.c |  5 +++++
 mesh/util.h |  1 +
 3 files changed, 48 insertions(+)

diff --git a/mesh/main.c b/mesh/main.c
index 42506a6..c4ede8b 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1985,6 +1985,47 @@ static const struct menu_entry meshctl_cmd_table[] = {
 	{ }
 };
 
+static char *cmd_generator(const char *text, int state)
+{
+	struct menu_entry *cmd_table;
+	static int index, len;
+	const char *cmd;
+
+	cmd_table = get_current_cmd_table();
+	if (!cmd_table)
+		return NULL;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((cmd = cmd_table[index].cmd)) {
+		index++;
+
+		if (!strncmp(cmd, text, len))
+			return strdup(cmd);
+	}
+
+	return NULL;
+}
+
+static char **cmd_completion(const char *text, int start, int end)
+{
+	char **matches = NULL;
+
+	if (start > 0)
+		goto done;
+
+	matches = rl_completion_matches(text, cmd_generator);
+
+done:
+	if (!matches)
+		rl_attempted_completion_over = 1;
+
+	return matches;
+}
+
 static void rl_handler(char *input)
 {
 	char *cmd, *arg;
@@ -2214,6 +2255,7 @@ int main(int argc, char *argv[])
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
 	setlinebuf(stdout);
+	rl_attempted_completion_function = cmd_completion;
 
 	rl_erase_empty_line = 1;
 	rl_callback_handler_install(NULL, rl_handler);
diff --git a/mesh/util.c b/mesh/util.c
index fac4bab..139b1cd 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -191,6 +191,11 @@ void print_cmd_menu(const struct menu_entry *cmd_table)
 
 }
 
+struct menu_entry *get_current_cmd_table(void)
+{
+	return current_cmd_table;
+}
+
 void cmd_menu_cleanup(void)
 {
 	main_cmd_table = NULL;
diff --git a/mesh/util.h b/mesh/util.h
index 7f729ab..ba226df 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -41,6 +41,7 @@ bool switch_cmd_menu(const char *name);
 void set_menu_prompt(const char *prefix, const char * node);
 void process_menu_cmd(const char *cmd, const char *arg);
 void print_cmd_menu(const struct menu_entry *cmd_table);
+struct menu_entry *get_current_cmd_table(void);
 void cmd_menu_cleanup(void);
 void print_byte_array(const char *prefix, const void *ptr, int len);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out_buf,
-- 
2.9.3

