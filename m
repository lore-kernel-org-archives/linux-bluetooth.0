Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/11] shared/shell: Fix parsing of optional parameters
Date: Thu, 14 Dec 2017 10:02:51 -0200
Message-Id: <20171214120300.20018-2-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Optional parameters uses "[]" delimiters.
---
 src/shared/shell.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b4fdf7043..6cdea1c7e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -288,9 +288,9 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	opt = strdup(entry->arg + len + 1);
 
 optional:
-	if (parse_args(opt, &w, "<>", flags) < 0) {
+	if (parse_args(opt, &w, "[]", flags) < 0) {
 		print_text(COLOR_HIGHLIGHT,
-				"Unable to parse mandatory command arguments");
+				"Unable to parse optional command arguments");
 		return -EINVAL;
 	}
 
-- 
2.13.6

