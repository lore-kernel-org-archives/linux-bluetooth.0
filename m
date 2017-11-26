Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared/shell: Add default argument generator
Date: Sun, 26 Nov 2017 22:21:26 +0200
Message-Id: <20171126202126.27783-4-luiz.dentz@gmail.com>
In-Reply-To: <20171126202126.27783-1-luiz.dentz@gmail.com>
References: <20171126202126.27783-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a default argument generator if the command don't provide
one, the generator will print out the argument list so the user don't
have to always resort to help for checking it.
---
 src/shared/shell.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 73aedaf79..d0cd2e6fe 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -518,6 +518,17 @@ static char *cmd_generator(const char *text, int state)
 	return find_cmd(text, data.menu->entries, &index);
 }
 
+static char *arg_generator(const char *text, int state)
+{
+	if (!text)
+		return NULL;
+
+	if (!state)
+		return strdup(text);
+
+	return NULL;
+}
+
 static char **menu_completion(const struct bt_shell_menu_entry *entry,
 				const char *text, char *input_cmd)
 {
@@ -527,8 +538,12 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 		if (strcmp(entry->cmd, input_cmd))
 			continue;
 
-		if (!entry->gen)
-			continue;
+		if (!entry->gen) {
+			rl_completion_display_matches_hook = NULL;
+			matches = rl_completion_matches(entry->arg,
+							arg_generator);
+			break;
+		}
 
 		rl_completion_display_matches_hook = entry->disp;
 		matches = rl_completion_matches(text, entry->gen);
-- 
2.13.6

