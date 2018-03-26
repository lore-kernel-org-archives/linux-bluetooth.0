Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/shell: Add export command
Date: Mon, 26 Mar 2018 16:33:02 +0300
Message-Id: <20180326133304.14531-2-luiz.dentz@gmail.com>
In-Reply-To: <20180326133304.14531-1-luiz.dentz@gmail.com>
References: <20180326133304.14531-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds export command to default menu which can be used to print
the environment variables that have been set.
---
 src/shared/shell.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 241878b30..552e066d7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -198,6 +198,17 @@ static bool cmd_back_exists(const struct bt_shell_menu *menu)
 	return true;
 }
 
+static void cmd_export(int argc, char *argv[])
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(data.envs); entry; entry = entry->next) {
+		struct bt_shell_env *env = entry->data;
+
+		print_text(COLOR_HIGHLIGHT, "%s=%p", env->name, env->value);
+	}
+}
+
 static const struct bt_shell_menu_entry default_menu[] = {
 	{ "back",         NULL,       cmd_back, "Return to main menu", NULL,
 							NULL, cmd_back_exists },
@@ -209,6 +220,8 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
 	{ "help",         NULL,       cmd_help,
 					"Display help about this program" },
+	{ "export",       NULL,       cmd_export,
+						"Print evironment variables" },
 	{ }
 };
 
-- 
2.14.3

