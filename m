Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/shell: Set shell name on SHELL env
Date: Wed, 13 Jun 2018 17:39:40 +0300
Message-Id: <20180613143941.11139-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set SHELL to the first argument given.
---
 src/shared/shell.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 97d91577e..2353a5e22 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -63,6 +63,7 @@ struct bt_shell_env {
 
 static struct {
 	bool init;
+	char *name;
 	int argc;
 	char **argv;
 	bool mode;
@@ -933,6 +934,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	struct option options[256];
 	char optstr[256];
 	size_t offset;
+	const char *name;
 
 	offset = sizeof(main_options) / sizeof(struct option);
 
@@ -978,6 +980,13 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		index = -1;
 	}
 
+	name = strrchr(argv[0], '/');
+	if (!name)
+		name = argv[0];
+
+	data.name = strdup(name);
+	bt_shell_set_env("SHELL", data.name);
+
 	data.argc = argc - optind;
 	data.argv = argv + optind;
 	optind = 0;
@@ -1039,6 +1048,7 @@ void bt_shell_cleanup(void)
 	rl_cleanup();
 
 	data.init = false;
+	free(data.name);
 }
 
 void bt_shell_quit(int status)
-- 
2.17.1

