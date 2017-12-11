Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/4] shared/shell: Fix hidden default menu if no submenu
Message-ID: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Date: Mon, 11 Dec 2017 16:13:57 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also fixes the output of the default menu in the help command of obexctl.
---
 src/shared/shell.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index a4be844b7..f9dbdb194 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -198,8 +198,9 @@ static void shell_print_menu(void)
 		/* Skip menu command if not on main menu or if there are no
 		 * submenus.
 		 */
-		if ((data.menu != data.main && !strcmp(entry->cmd, "menu")) ||
-					queue_isempty(data.submenus))
+		if (!strcmp(entry->cmd, "menu") &&
+			(data.menu != data.main ||
+				queue_isempty(data.submenus)))
 			continue;
 
 		/* Skip back command if on main menu */
-- 
2.14.1

