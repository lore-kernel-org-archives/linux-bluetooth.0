Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/14] shared/shell: Add bt_shell_usage
Date: Mon, 26 Feb 2018 17:53:34 +0200
Message-Id: <20180226155336.25875-13-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_shell_usage can be used to print the usage of the current command
in execution.
---
 src/shared/shell.c | 14 ++++++++++++++
 src/shared/shell.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index cd46532fe..c90d28a9f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -76,6 +76,7 @@ static struct {
 	const struct bt_shell_menu *menu;
 	const struct bt_shell_menu *main;
 	struct queue *submenus;
+	const struct bt_shell_menu_entry *exec;
 
 	struct queue *envs;
 } data;
@@ -325,9 +326,13 @@ optional:
 	wordfree(&w);
 
 exec:
+	data.exec = entry;
+
 	if (entry->func)
 		entry->func(argc, argv);
 
+	data.exec = NULL;
+
 	return 0;
 
 fail:
@@ -451,6 +456,15 @@ void bt_shell_hexdump(const unsigned char *buf, size_t len)
 	util_hexdump(' ', buf, len, print_string, NULL);
 }
 
+void bt_shell_usage()
+{
+	if (!data.exec)
+		return;
+
+	bt_shell_printf("Usage: %s %s\n", data.exec->cmd,
+					data.exec->arg ? data.exec->arg : "");
+}
+
 void bt_shell_prompt_input(const char *label, const char *msg,
 			bt_shell_prompt_input_func func, void *user_data)
 {
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 10747c955..33c31f35b 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -82,6 +82,7 @@ void bt_shell_set_prompt(const char *string);
 void bt_shell_printf(const char *fmt,
 				...) __attribute__((format(printf, 1, 2)));
 void bt_shell_hexdump(const unsigned char *buf, size_t len);
+void bt_shell_usage(void);
 
 void bt_shell_prompt_input(const char *label, const char *msg,
 			bt_shell_prompt_input_func func, void *user_data);
-- 
2.14.3

