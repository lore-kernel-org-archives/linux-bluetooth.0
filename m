Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/4] shared/shell: Create command_isskipped()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Message-ID: <2fe7c74e-5828-2a70-e532-0cf277e84fda@jp.fujitsu.com>
Date: Mon, 11 Dec 2017 16:17:12 +0900
MIME-Version: 1.0
In-Reply-To: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/shell.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f9dbdb194..26194f758 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -169,6 +169,22 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ }
 };
 
+static bool command_isskipped(const char *cmd)
+{
+	/* Skip menu command if not on main menu or if there are no
+	 * submenus.
+	 */
+	if (!strcmp(cmd, "menu") &&
+		(data.menu != data.main || queue_isempty(data.submenus)))
+		return true;
+
+	/* Skip back command if on main menu */
+	if (data.menu == data.main && !strcmp(cmd, "back"))
+		return true;
+
+	return false;
+}
+
 static void shell_print_menu(void)
 {
 	const struct bt_shell_menu_entry *entry;
@@ -195,16 +211,7 @@ static void shell_print_menu(void)
 	}
 
 	for (entry = default_menu; entry->cmd; entry++) {
-		/* Skip menu command if not on main menu or if there are no
-		 * submenus.
-		 */
-		if (!strcmp(entry->cmd, "menu") &&
-			(data.menu != data.main ||
-				queue_isempty(data.submenus)))
-			continue;
-
-		/* Skip back command if on main menu */
-		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
+		if (command_isskipped(entry->cmd))
 			continue;
 
 		print_menu(entry->cmd, entry->arg ? : "", entry->desc ? : "");
-- 
2.14.1

