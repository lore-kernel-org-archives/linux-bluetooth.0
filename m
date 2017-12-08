Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] shared/shell: Omit menu command if there are no submenus
Date: Fri,  8 Dec 2017 08:52:47 -0200
Message-Id: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no need to show menu as a command if there are no submenus
to select.
---
 src/shared/shell.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0878cad3b..d262f534b 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -195,8 +195,11 @@ static void shell_print_menu(void)
 	}
 
 	for (entry = default_menu; entry->cmd; entry++) {
-		/* Skip menu command if not on main menu */
-		if (data.menu != data.main && !strcmp(entry->cmd, "menu"))
+		/* Skip menu command if not on main menu or if there are no
+		 * submenus.
+		 */
+		if ((data.menu != data.main && !strcmp(entry->cmd, "menu")) ||
+					queue_isempty(data.submenus))
 			continue;
 
 		/* Skip back command if on main menu */
-- 
2.13.6

