Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] shared/shell: Add submenu support
Date: Thu, 16 Nov 2017 12:59:22 +0200
Message-Id: <20171116105925.2117-3-luiz.dentz@gmail.com>
In-Reply-To: <20171116105925.2117-1-luiz.dentz@gmail.com>
References: <20171116105925.2117-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds submenu support so application can have one extra level of
menus to better organize the interface.

Submenus will be show in the output of help command, to select a
submenu:

> menu <name>

To move back to main menu:

> back
---
 client/main.c      |   8 ++-
 src/shared/shell.c | 168 +++++++++++++++++++++++++++++++++++++++++++++--------
 src/shared/shell.h |  11 +++-
 3 files changed, 159 insertions(+), 28 deletions(-)

diff --git a/client/main.c b/client/main.c
index bbdd55a98..cf04047cb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2358,7 +2358,9 @@ static void cmd_set_advertise_timeout(const char *arg)
 	ad_advertise_timeout(dbus_conn, value);
 }
 
-static const struct bt_shell_menu_entry cmd_table[] = {
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
 	{ "list",         NULL,       cmd_list, "List available controllers" },
 	{ "show",         "[ctrl]",   cmd_show, "Controller information",
 							ctrl_generator },
@@ -2482,7 +2484,7 @@ static const struct bt_shell_menu_entry cmd_table[] = {
 	{ "unregister-descriptor", "<UUID/object>",
 					cmd_unregister_descriptor,
 					"Unregister application descriptor" },
-	{ }
+	{ } },
 };
 
 static gboolean parse_agent(const char *key, const char *value,
@@ -2531,7 +2533,7 @@ int main(int argc, char *argv[])
 	g_option_context_free(context);
 
 	bt_shell_init(&argc, &argv);
-	bt_shell_set_menu(cmd_table);
+	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7db629bf1..8c29dd73f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -48,6 +48,9 @@
 #define print_menu(cmd, args, desc) \
 		printf(COLOR_HIGHLIGHT "%s %-*s " COLOR_OFF "%s\n", \
 			cmd, (int)(CMD_LENGTH - strlen(cmd)), args, desc)
+#define print_submenu(cmd, desc) \
+		printf(COLOR_BLUE "%s %-*s " COLOR_OFF "%s\n", \
+			cmd, (int)(CMD_LENGTH - strlen(cmd)), "", desc)
 
 static GMainLoop *main_loop;
 static gboolean option_version = FALSE;
@@ -59,8 +62,9 @@ static struct {
 	bt_shell_prompt_input_func saved_func;
 	void *saved_user_data;
 
-	const struct bt_shell_menu_entry *menu;
-	/* TODO: Add submenus support */
+	const struct bt_shell_menu *menu;
+	const struct bt_shell_menu *main;
+	struct queue *submenus;
 } data;
 
 static void shell_print_menu(void);
@@ -80,7 +84,82 @@ static void cmd_help(const char *arg)
 	shell_print_menu();
 }
 
+static const struct bt_shell_menu *find_menu(const char *name)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(data.submenus); entry;
+						entry = entry->next) {
+		struct bt_shell_menu *menu = entry->data;
+
+		if (!strcmp(menu->name, name))
+			return menu;
+	}
+
+	return NULL;
+}
+
+static char *menu_generator(const char *text, int state)
+{
+	static unsigned int index, len;
+	static struct queue_entry *entry;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+		entry = (void *) queue_get_entries(data.submenus);
+	}
+
+	for (; entry; entry = entry->next) {
+		struct bt_shell_menu *menu = entry->data;
+
+		index++;
+
+		if (!strncmp(menu->name, text, len)) {
+			entry = entry->next;
+			return strdup(menu->name);
+		}
+	}
+
+	return NULL;
+}
+
+static void cmd_menu(const char *arg)
+{
+	const struct bt_shell_menu *menu;
+
+	if (!arg || !strlen(arg)) {
+		bt_shell_printf("Missing name argument\n");
+		return;
+	}
+
+	menu = find_menu(arg);
+	if (!menu) {
+		bt_shell_printf("Unable find menu with name: %s\n", arg);
+		return;
+	}
+
+	bt_shell_set_menu(menu);
+
+	shell_print_menu();
+}
+
+static void cmd_back(const char *arg)
+{
+	if (data.menu == data.main) {
+		bt_shell_printf("Already on main menu\n");
+		return;
+	}
+
+	bt_shell_set_menu(data.main);
+
+	shell_print_menu();
+}
+
 static const struct bt_shell_menu_entry default_menu[] = {
+	{ "back",         NULL,       cmd_back, "Return to main menu" },
+	{ "menu",         "<name>",   cmd_menu, "Select submenu",
+							menu_generator },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
@@ -92,49 +171,74 @@ static const struct bt_shell_menu_entry default_menu[] = {
 static void shell_print_menu(void)
 {
 	const struct bt_shell_menu_entry *entry;
+	const struct queue_entry *submenu;
 
 	if (!data.menu)
 		return;
 
+	print_text(COLOR_HIGHLIGHT, "Menu %s:", data.menu->name);
 	print_text(COLOR_HIGHLIGHT, "Available commands:");
 	print_text(COLOR_HIGHLIGHT, "-------------------");
-	for (entry = data.menu; entry->cmd; entry++) {
+
+	if (data.menu == data.main) {
+		for (submenu = queue_get_entries(data.submenus); submenu;
+						submenu = submenu->next) {
+			struct bt_shell_menu *menu = submenu->data;
+
+			print_submenu(menu->name, "Submenu");
+		}
+	}
+
+	for (entry = data.menu->entries; entry->cmd; entry++) {
 		print_menu(entry->cmd, entry->arg ? : "", entry->desc ? : "");
 	}
 
 	for (entry = default_menu; entry->cmd; entry++) {
+		/* Skip menu command if not on main menu */
+		if (data.menu != data.main && !strcmp(entry->cmd, "menu"))
+			continue;
+
+		/* Skip back command if on main menu */
+		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
+			continue;
+
 		print_menu(entry->cmd, entry->arg ? : "", entry->desc ? : "");
 	}
 }
 
-static void shell_exec(const char *cmd, const char *arg)
+static int menu_exec(const struct bt_shell_menu_entry *entry,
+			const char *cmd, const char *arg)
 {
-	const struct bt_shell_menu_entry *entry;
-
-	if (!data.menu || !cmd)
-		return;
-
-	for (entry = data.menu; entry->cmd; entry++) {
+	for (; entry->cmd; entry++) {
 		if (strcmp(cmd, entry->cmd))
 			continue;
 
-		if (entry->func) {
-			entry->func(arg);
-			return;
-		}
-	}
+		/* Skip menu command if not on main menu */
+		if (data.menu != data.main && !strcmp(entry->cmd, "menu"))
+			continue;
 
-	for (entry = default_menu; entry->cmd; entry++) {
-		if (strcmp(cmd, entry->cmd))
+		/* Skip back command if on main menu */
+		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
 			continue;
 
 		if (entry->func) {
 			entry->func(arg);
-			return;
+			return 0;
 		}
 	}
 
-	print_text(COLOR_HIGHLIGHT, "Invalid command");
+	return -ENOENT;
+}
+
+static void shell_exec(const char *cmd, const char *arg)
+{
+	if (!data.menu || !cmd)
+		return;
+
+	if (menu_exec(default_menu, cmd, arg) < 0) {
+		if (menu_exec(data.menu->entries, cmd, arg) < 0)
+			print_text(COLOR_HIGHLIGHT, "Invalid command");
+	}
 }
 
 void bt_shell_printf(const char *fmt, ...)
@@ -308,7 +412,7 @@ static char *cmd_generator(const char *text, int state)
 	if (state)
 		return NULL;
 
-	entry = data.menu;
+	entry = data.menu->entries;
 	index = 0;
 
 	return cmd_generator(text, 1);
@@ -319,7 +423,7 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 {
 	char **matches = NULL;
 
-	for (entry = data.menu; entry->cmd; entry++) {
+	for (; entry->cmd; entry++) {
 		if (strcmp(entry->cmd, input_cmd))
 			continue;
 
@@ -347,7 +451,7 @@ static char **shell_completion(const char *text, int start, int end)
 		input_cmd = strndup(rl_line_buffer, start - 1);
 		matches = menu_completion(default_menu, text, input_cmd);
 		if (!matches)
-			matches = menu_completion(data.menu, text,
+			matches = menu_completion(data.menu->entries, text,
 							input_cmd);
 
 		free(input_cmd);
@@ -513,13 +617,29 @@ void bt_shell_run(void)
 	rl_cleanup();
 }
 
-bool bt_shell_set_menu(const struct bt_shell_menu_entry *menu)
+bool bt_shell_set_menu(const struct bt_shell_menu *menu)
 {
-	if (data.menu || !menu)
+	if (!menu)
 		return false;
 
 	data.menu = menu;
 
+	if (!data.main)
+		data.main = menu;
+
+	return true;
+}
+
+bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
+{
+	if (!menu)
+		return false;
+
+	if (!data.submenus)
+		data.submenus = queue_new();
+
+	queue_push_tail(data.submenus, (void *) menu);
+
 	return true;
 }
 
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 843335784..114219cdf 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -45,11 +45,20 @@ struct bt_shell_menu_entry {
 	bt_shell_menu_disp_t disp;
 };
 
+struct bt_shell_menu {
+	const char *name;
+	const struct bt_shell_menu_entry entries[];
+};
+
 void bt_shell_init(int *argc, char ***argv);
 
 void bt_shell_run(void);
 
-bool bt_shell_set_menu(const struct bt_shell_menu_entry *menu);
+bool bt_shell_set_menu(const struct bt_shell_menu *menu);
+
+bool bt_shell_add_submenu(const struct bt_shell_menu *menu);
+
+bool bt_shell_remove_submenu(const struct bt_shell_menu *menu);
 
 void bt_shell_set_prompt(const char *string);
 
-- 
2.13.6

