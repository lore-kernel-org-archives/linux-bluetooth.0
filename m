Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/14] shared/shell: Add bt_shell_{noninteractive_}quit
Date: Mon, 26 Feb 2018 17:53:23 +0200
Message-Id: <20180226155336.25875-2-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The functions can be used to tell the shell to stop running.
---
 src/shared/shell.c | 16 ++++++++++++++++
 src/shared/shell.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 6cc797cdb..9ecb4c7be 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -866,6 +866,22 @@ void bt_shell_run(void)
 	data.init = false;
 }
 
+void bt_shell_quit(int status)
+{
+	if (status == EXIT_SUCCESS)
+		mainloop_exit_success();
+	else
+		mainloop_exit_failure();
+}
+
+void bt_shell_noninteractive_quit(int status)
+{
+	if (!data.mode || data.timeout)
+		return;
+
+	bt_shell_quit(status);
+}
+
 bool bt_shell_set_menu(const struct bt_shell_menu *menu)
 {
 	if (!menu)
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 359629896..10747c955 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -68,6 +68,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt);
 
 void bt_shell_run(void);
 
+void bt_shell_quit(int status);
+void bt_shell_noninteractive_quit(int status);
+
 bool bt_shell_set_menu(const struct bt_shell_menu *menu);
 
 bool bt_shell_add_submenu(const struct bt_shell_menu *menu);
-- 
2.14.3

