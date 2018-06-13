Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/shell: Add history support
Date: Wed, 13 Jun 2018 17:39:41 +0300
Message-Id: <20180613143941.11139-2-luiz.dentz@gmail.com>
In-Reply-To: <20180613143941.11139-1-luiz.dentz@gmail.com>
References: <20180613143941.11139-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses read_history/write_history to load and save input history.
---
 src/shared/shell.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 2353a5e22..1efe2f99c 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -64,6 +64,7 @@ struct bt_shell_env {
 static struct {
 	bool init;
 	char *name;
+	char history[256];
 	int argc;
 	char **argv;
 	bool mode;
@@ -892,6 +893,41 @@ static struct io *setup_signalfd(void)
 	return io;
 }
 
+static void rl_init_history(void)
+{
+	char *dir;
+
+	memset(data.history, 0, sizeof(data.history));
+
+	dir = getenv("XDG_CACHE_HOME");
+	if (dir) {
+		snprintf(data.history, sizeof(data.history), "%s/.%s_history",
+							dir, data.name);
+		goto done;
+	}
+
+	dir = getenv("HOME");
+	if (dir) {
+		snprintf(data.history, sizeof(data.history),
+				"%s/.cache/.%s_history", dir, data.name);
+		goto done;
+	}
+
+	dir = getenv("PWD");
+	if (dir) {
+		snprintf(data.history, sizeof(data.history), "%s/.%s_history",
+							dir, data.name);
+		goto done;
+	}
+
+	return;
+
+done:
+	printf("HISTORY=%s\n", data.history);
+	read_history(data.history);
+	bt_shell_set_env("HISTORY", data.history);
+}
+
 static void rl_init(void)
 {
 	if (data.mode)
@@ -902,6 +938,8 @@ static void rl_init(void)
 
 	rl_erase_empty_line = 1;
 	rl_callback_handler_install(NULL, rl_handler);
+
+	rl_init_history();
 }
 
 static const struct option main_options[] = {
@@ -1007,6 +1045,9 @@ static void rl_cleanup(void)
 	if (data.mode)
 		return;
 
+	if (data.history[0] != '\0')
+		write_history(data.history);
+
 	rl_message("");
 	rl_callback_handler_remove();
 }
-- 
2.17.1

