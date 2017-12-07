Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] tools/bluetooth-player: Fix arg format for search command
Date: Thu,  7 Dec 2017 10:21:51 -0200
Message-Id: <20171207122152.29743-6-luiz.dentz@gmail.com>
In-Reply-To: <20171207122152.29743-1-luiz.dentz@gmail.com>
References: <20171207122152.29743-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Mandatory command should always be quoted with <>.
---
 tools/bluetooth-player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index f13d8187f..92235ac8e 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -967,7 +967,7 @@ static const struct bt_shell_menu main_menu = {
 						"Change current folder" },
 	{ "list-items", "[start] [end]",  cmd_list_items,
 					"List items of current folder" },
-	{ "search",     "string",     cmd_search,
+	{ "search",     "<string>",   cmd_search,
 					"Search items containing string" },
 	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
 	{ "show-item",   "<item>",    cmd_show_item, "Show item information" },
-- 
2.13.6

