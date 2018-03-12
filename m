Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/2] tools/bluetooth-player: Add item-generator for
 change-folder
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <053aee30-4bef-c9b6-c7b6-a0f954c7910c@jp.fujitsu.com>
Message-ID: <797ada51-e29d-6e75-52ed-73b0b4ac43fb@jp.fujitsu.com>
Date: Mon, 12 Mar 2018 10:56:45 +0900
MIME-Version: 1.0
In-Reply-To: <053aee30-4bef-c9b6-c7b6-a0f954c7910c@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
Changes since v1
 - separate into two patch which are 1/2 and 2/2.

 tools/bluetooth-player.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 13b70349e..441a934cc 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -952,7 +952,8 @@ static const struct bt_shell_menu main_menu = {
 	{ "scan",         "<alltracks/group/off>", cmd_scan,
 						"Set scan mode"},
 	{ "change-folder", "<item>",  cmd_change_folder,
-						"Change current folder" },
+						"Change current folder",
+							item_generator},
 	{ "list-items", "[start] [end]",  cmd_list_items,
 					"List items of current folder" },
 	{ "search",     "<string>",   cmd_search,
-- 
2.14.1

