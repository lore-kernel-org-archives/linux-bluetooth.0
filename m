Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] tools/bluetooth-player: current-folder command
Date: Mon, 13 Jan 2014 19:23:44 +0200
Message-Id: <1389633824-6871-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add current-folder command listing path to the current folder
---
 tools/bluetooth-player.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index f10d9be..1c0348e 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -891,6 +891,23 @@ done:
 	rl_printf("Attempting to list items\n");
 }
 
+static void cmd_current_folder(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	GDBusProxy *folder;
+
+	if (check_default_player() == FALSE)
+		return;
+
+	proxy = default_player;
+	folder = find_folder(g_dbus_proxy_get_path(proxy));
+
+	if (folder == NULL)
+		return;
+
+	print_property(folder, "Name");
+}
+
 static void search_setup(DBusMessageIter *iter, void *user_data)
 {
 	char *string = user_data;
@@ -1023,6 +1040,8 @@ static const struct {
 						"Change current folder" },
 	{ "list-items", "[start] [end]",  cmd_list_items,
 					"List items of current folder" },
+	{ "current-folder", NULL,     cmd_current_folder,
+					"Show current folder name and path" },
 	{ "search",     "string",     cmd_search,
 					"Search items containing string" },
 	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

