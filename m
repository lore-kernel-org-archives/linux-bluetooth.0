Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  3/3] tools: Add total-items command for GetTotalNumOfItems
Date: Wed, 24 Jun 2015 14:41:32 +0530
Message-id: <1435137092-19300-4-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
References: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added command "total-items" to send request for
"GetTotalNumOfItems".
---
 tools/bluetooth-player.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 9e19997..66303a7 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -891,6 +891,44 @@ done:
 	rl_printf("Attempting to list items\n");
 }
 
+static void total_items_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to get total number of items: %s\n",
+					error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("TotalItems successful\n");
+}
+
+static void cmd_total_items(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (check_default_player() == FALSE)
+		return;
+
+	proxy = find_folder(g_dbus_proxy_get_path(default_player));
+	if (proxy == NULL) {
+		rl_printf("Operation not supported\n");
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "TotalNumberOfItems", NULL,
+				total_items_reply, NULL, g_free) == FALSE) {
+		rl_printf("Failed to get total number of items\n");
+		return;
+	}
+
+	rl_printf("Attempting to list items\n");
+}
+
 static void search_setup(DBusMessageIter *iter, void *user_data)
 {
 	char *string = user_data;
@@ -1025,6 +1063,8 @@ static const struct {
 					"List items of current folder" },
 	{ "search",     "string",     cmd_search,
 					"Search items containing string" },
+	{ "total-items", NULL, cmd_total_items,
+					"Get total number of items" },
 	{ "queue",       "<item>",    cmd_queue, "Add item to playlist queue" },
 	{ "show-item",   "<item>",    cmd_show_item, "Show item information" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
-- 
1.9.1

