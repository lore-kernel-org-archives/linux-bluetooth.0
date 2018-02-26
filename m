Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/14] shared/shell: Fix parsing of mandatory arguments
Date: Mon, 26 Feb 2018 17:53:35 +0200
Message-Id: <20180226155336.25875-14-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In certain cases the arguments may no start with the mandatory commands
such as when the command handler expects getopt arguments first.
---
 src/shared/shell.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c90d28a9f..9ae5af79e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -291,11 +291,22 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	}
 
 	len = man - entry->arg;
-	man = strndup(entry->arg, len + 1);
+	if (entry->arg[0] == '<')
+		man = strndup(entry->arg, len + 1);
+	else {
+		/* Find where mandatory arguments start */
+		opt = strrchr(entry->arg, '<');
+		/* Skip if mandatory arguments are not in the right format */
+		if (!opt || opt > man) {
+			opt = strdup(entry->arg);
+			goto optional;
+		}
+		man = strndup(opt, man - opt + 1);
+	}
 
 	if (parse_args(man, &w, "<>", flags) < 0) {
 		print_text(COLOR_HIGHLIGHT,
-				"Unable to parse mandatory command arguments");
+			"Unable to parse mandatory command arguments: %s", man );
 		return -EINVAL;
 	}
 
@@ -312,7 +323,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 optional:
 	if (parse_args(opt, &w, "[]", flags) < 0) {
 		print_text(COLOR_HIGHLIGHT,
-				"Unable to parse optional command arguments");
+			"Unable to parse optional command arguments: %s", opt);
 		return -EINVAL;
 	}
 
-- 
2.14.3

