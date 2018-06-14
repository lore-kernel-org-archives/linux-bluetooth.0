Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] shared/shell: Set shell name on SHELL env
Date: Thu, 14 Jun 2018 14:26:05 +0300
Message-Id: <20180614112606.23634-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set SHELL to the first argument given.
---
 src/shared/shell.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 97d91577e..e87336a0c 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -63,6 +63,7 @@ struct bt_shell_env {
 
 static struct {
 	bool init;
+	char *name;
 	int argc;
 	char **argv;
 	bool mode;
@@ -978,6 +979,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 		index = -1;
 	}
 
+	data.name = strdup(argv[0]);
+	bt_shell_set_env("SHELL", data.name);
+
 	data.argc = argc - optind;
 	data.argv = argv + optind;
 	optind = 0;
@@ -1039,6 +1043,7 @@ void bt_shell_cleanup(void)
 	rl_cleanup();
 
 	data.init = false;
+	free(data.name);
 }
 
 void bt_shell_quit(int status)
-- 
2.17.1

