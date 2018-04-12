Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maico Timmerman <maico.timmerman@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Maico Timmerman <maico.timmerman@gmail.com>
Subject: [PATCH 1/1] Client: Added support for the history file.
Date: Thu, 12 Apr 2018 12:34:32 +0200
Message-Id: <20180412103432.9760-2-maico.timmerman@gmail.com>
In-Reply-To: <20180412103432.9760-1-maico.timmerman@gmail.com>
References: <20180412103432.9760-1-maico.timmerman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Individual interactive tools can set a history file, which will be read
on startup and written on clean-up.
---
 AUTHORS            |  1 +
 client/main.c      |  1 +
 src/shared/shell.c | 23 +++++++++++++++++++++++
 src/shared/shell.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/AUTHORS b/AUTHORS
index df9cb96ad..d2edbf749 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -100,3 +100,4 @@ Bharat Panda <bharat.panda@samsung.com>
 Marie Janssen <jamuraa@chromium.org>
 Jaganath Kanakkassery <jaganath.k@samsung.com>
 Michał Narajowski <michal.narajowski@codecoup.pl>
+Maico Timmerman <maico.timmerman@gmail.com>
diff --git a/client/main.c b/client/main.c
index b96278d45..ed536a720 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2544,6 +2544,7 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_set_history_file(".bluetoothctl_history");
 
 	if (agent_option)
 		auto_register_agent = g_strdup(agent_option);
diff --git a/src/shared/shell.c b/src/shared/shell.c
index be2a8dfe0..39583de1e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -38,6 +38,7 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <pwd.h>
 
 #include "src/shared/mainloop.h"
 #include "src/shared/timeout.h"
@@ -69,6 +70,8 @@ static struct {
 	int timeout;
 	struct io *input;
 
+	char *bt_shell_history;
+
 	bool saved_prompt;
 	bt_shell_prompt_input_func saved_func;
 	void *saved_user_data;
@@ -1027,6 +1030,11 @@ void bt_shell_cleanup(void)
 	bt_shell_release_prompt("");
 	bt_shell_detach();
 
+	if (data.bt_shell_history) {
+		write_history(data.bt_shell_history);
+		history_truncate_file(data.bt_shell_history, 500);
+	}
+
 	if (data.envs) {
 		queue_destroy(data.envs, env_destroy);
 		data.envs = NULL;
@@ -1079,6 +1087,21 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 	return true;
 }
 
+void bt_shell_set_history_file(const char *string)
+{
+	char *homedir;
+
+	// First check HOME env variable, otherwise read homedir from /etc/passwd.
+	if ((homedir = getenv("HOME")) == NULL) {
+		homedir = getpwuid(getuid())->pw_dir;
+	}
+	data.bt_shell_history = strcat(strcat(homedir, "/"), string);;
+
+	// Read history file and set index of history beyond latest position.
+	read_history(data.bt_shell_history);
+	history_set_pos(history_length);
+}
+
 void bt_shell_set_prompt(const char *string)
 {
 	if (!data.init || data.mode)
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 8b7cb7f30..1c4ff0e7b 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -79,6 +79,8 @@ bool bt_shell_remove_submenu(const struct bt_shell_menu *menu);
 
 void bt_shell_set_prompt(const char *string);
 
+void bt_shell_set_history_file(const char *string);
+
 void bt_shell_printf(const char *fmt,
 				...) __attribute__((format(printf, 1, 2)));
 void bt_shell_hexdump(const unsigned char *buf, size_t len);
-- 
2.17.0

