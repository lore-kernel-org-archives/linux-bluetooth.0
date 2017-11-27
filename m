Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] shared/shell: Print usage when no argument generator is set
Date: Mon, 27 Nov 2017 18:17:04 +0200
Message-Id: <20171127161704.14073-4-luiz.dentz@gmail.com>
In-Reply-To: <20171127161704.14073-1-luiz.dentz@gmail.com>
References: <20171127161704.14073-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the command and arguments if the command don't provide
a generator so one don't have to always resort to help for checking it.
---
 src/shared/shell.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 73aedaf79..bd5cf18fc 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -527,8 +527,12 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 		if (strcmp(entry->cmd, input_cmd))
 			continue;
 
-		if (!entry->gen)
-			continue;
+		if (!entry->gen) {
+			if (text[0] == '\0')
+				bt_shell_printf("Usage: %s %s\n", entry->cmd,
+								entry->arg);
+			break;
+		}
 
 		rl_completion_display_matches_hook = entry->disp;
 		matches = rl_completion_matches(text, entry->gen);
-- 
2.13.6

