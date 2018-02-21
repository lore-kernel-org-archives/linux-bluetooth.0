Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] shared/shell: Set NON_INTERACTIVE env
Date: Wed, 21 Feb 2018 16:14:52 +0200
Message-Id: <20180221141456.6656-4-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets NON_INTERACTIVE environment variable which applications can
then use to query under what mode they are running.
---
 src/shared/shell.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0f6d613bd..85657c250 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -818,6 +818,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	data.argv = argv + optind;
 	data.mode = (data.argc > 0);
 
+	if (data.mode)
+		bt_shell_set_env("NON_INTERACTIVE", &data.mode);
+
 	main_loop = g_main_loop_new(NULL, FALSE);
 
 	rl_init();
-- 
2.14.3

