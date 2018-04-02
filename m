Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] shared/shell: Add commands to allow shell usage with external mainloop
Date: Sun,  1 Apr 2018 19:34:35 -0700
Message-Id: <20180402023435.30430-2-inga.stotland@intel.com>
In-Reply-To: <20180402023435.30430-1-inga.stotland@intel.com>
References: <20180402023435.30430-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds commands that allow to use bt_shell features when running a non glib
mainloop (e.g., ell based). This allows to bypass starting mainloop from
within the shell and register own io and on-exit operations.
---
 src/shared/shell.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/shell.h |  3 +++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index be2a8dfe0..f552e553d 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -67,7 +67,8 @@ static struct {
 	char **argv;
 	bool mode;
 	int timeout;
-	struct io *input;
+	void *input;
+	bt_shell_menu_cb_t quit_cb;
 
 	bool saved_prompt;
 	bt_shell_prompt_input_func saved_func;
@@ -92,7 +93,10 @@ static void cmd_version(int argc, char *argv[])
 
 static void cmd_quit(int argc, char *argv[])
 {
-	mainloop_quit();
+	if (data.quit_cb)
+		data.quit_cb(argc, argv);
+	else
+		mainloop_quit();
 }
 
 static void cmd_help(int argc, char *argv[])
@@ -1134,6 +1138,7 @@ bool bt_shell_attach(int fd)
 	return true;
 }
 
+
 bool bt_shell_detach(void)
 {
 	if (!data.input)
@@ -1193,3 +1198,36 @@ void *bt_shell_get_env(const char *name)
 
 	return env->value;
 }
+
+bool bt_shell_attach_input_io(void *io)
+{
+	if (data.input)
+		return false;
+
+	data.input = io;
+
+	if (data.mode) {
+		if (shell_exec(data.argc, data.argv) < 0) {
+			bt_shell_noninteractive_quit(EXIT_FAILURE);
+			return true;
+		}
+
+		if (data.timeout)
+			timeout_add(data.timeout * 1000, shell_quit, NULL,
+								NULL);
+	}
+
+	return true;
+}
+
+bool bt_shell_detach_input_io(void)
+{
+	data.input = NULL;
+	return true;
+}
+
+void bt_shell_set_quit_cb(bt_shell_menu_cb_t cb)
+{
+	if (!data.quit_cb)
+		data.quit_cb = cb;
+}
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 8b7cb7f30..84a74a15d 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -95,3 +95,6 @@ void bt_shell_set_env(const char *name, void *value);
 void *bt_shell_get_env(const char *name);
 
 void bt_shell_cleanup(void);
+bool bt_shell_attach_input_io(void *io);
+bool bt_shell_detach_input_io(void);
+void bt_shell_set_quit_cb(bt_shell_menu_cb_t cb);
-- 
2.14.3

