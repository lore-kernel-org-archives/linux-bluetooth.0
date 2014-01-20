Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH 2/2] tools/bluetooth-player: check CT for searchable value
Date: Mon, 20 Jan 2014 15:04:38 +0200
Message-Id: <1390223078-29096-2-git-send-email-sebastianx.chlad@intel.com>
In-Reply-To: <1390223078-29096-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390223078-29096-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simple check if the remote client is searchable.
---
 tools/bluetooth-player.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 32d295c..13471c2 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -945,6 +945,7 @@ static void cmd_search(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	char *string;
+	DBusMessageIter iter;
 
 	if (argc < 2) {
 		rl_printf("Missing string argument\n");
@@ -962,6 +963,11 @@ static void cmd_search(int argc, char *argv[])
 
 	string = g_strdup(argv[1]);
 
+	if (g_dbus_proxy_get_property(proxy, "Searchable", &iter) == FALSE) {
+		rl_printf("Search not supported on the client side\n");
+		return;
+	}
+
 	if (g_dbus_proxy_method_call(proxy, "Search", search_setup,
 				search_reply, string, g_free) == FALSE) {
 		rl_printf("Failed to search\n");
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

