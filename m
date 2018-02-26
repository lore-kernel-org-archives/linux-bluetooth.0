Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/14] shared/shell: Fix not reseting optind
Date: Mon, 26 Feb 2018 17:53:24 +0200
Message-Id: <20180226155336.25875-3-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Not reseting optind may crash the tool if getopt and variants are
called a second time.
---
 src/shared/shell.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 9ecb4c7be..0653c0ea1 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -817,6 +817,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 
 	data.argc = argc - optind;
 	data.argv = argv + optind;
+	optind = 0;
 	data.mode = (data.argc > 0);
 
 	if (data.mode)
-- 
2.14.3

