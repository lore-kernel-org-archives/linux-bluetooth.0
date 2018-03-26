Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/shell: Don't allocate any data if env value is NULL
Date: Mon, 26 Mar 2018 16:33:01 +0300
Message-Id: <20180326133304.14531-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If value is NULL there is no point in allocating any data if value is
NULL since bt_shell_get_env would return NULL anyway, also this makes
sure the existing value is freed which means passing NULL can remove
an env like it was intended.
---
 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 33bc0d980..241878b30 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1142,6 +1142,8 @@ void bt_shell_set_env(const char *name, void *value)
 	struct bt_shell_env *env;
 
 	if (!data.envs) {
+		if (!value)
+			return;
 		data.envs = queue_new();
 		goto done;
 	}
@@ -1150,6 +1152,10 @@ void bt_shell_set_env(const char *name, void *value)
 	if (env)
 		env_destroy(env);
 
+	/* Don't create an env if value is not set */
+	if (!value)
+		return;
+
 done:
 	env = new0(struct bt_shell_env, 1);
 	env->name = strdup(name);
-- 
2.14.3

