Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/9] client: Make commands relative to device
Date: Wed,  4 Feb 2015 17:33:14 +0200
Message-Id: <1423063999-15734-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
References: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case a device is connected make it the default and print to the
prompt, so the user don't have to type in its address.
---
 client/main.c | 153 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 85 insertions(+), 68 deletions(-)

diff --git a/client/main.c b/client/main.c
index 0590266..72223d5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -58,6 +58,7 @@ static GDBusProxy *agent_manager;
 static char *auto_register_agent = NULL;
 
 static GDBusProxy *default_ctrl;
+static GDBusProxy *default_dev;
 static GList *ctrl_list;
 static GList *dev_list;
 
@@ -345,6 +346,27 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	}
 }
 
+static void set_default_device(GDBusProxy *proxy)
+{
+	char *desc = NULL;
+	DBusMessageIter iter;
+
+	default_dev = proxy;
+
+	if (!g_dbus_proxy_get_property(proxy, "Alias", &iter)) {
+		if (!g_dbus_proxy_get_property(proxy, "Address", &iter))
+			goto done;
+	}
+
+	dbus_message_iter_get_basic(&iter, &desc);
+	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", desc);
+
+done:
+	rl_set_prompt(desc ? desc : PROMPT_ON);
+	rl_redisplay();
+	g_free(desc);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -356,6 +378,9 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			dev_list = g_list_remove(dev_list, proxy);
 
 			print_device(proxy, COLORED_DEL);
+
+			if (default_dev == proxy)
+				set_default_device(NULL);
 		}
 	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
 		ctrl_list = g_list_remove(ctrl_list, proxy);
@@ -364,6 +389,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 
 		if (default_ctrl == proxy) {
 			default_ctrl = NULL;
+			set_default_device(NULL);
 
 			g_list_free(dev_list);
 			dev_list = NULL;
@@ -407,6 +433,17 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			} else
 				str = g_strdup("");
 
+			if (strcmp(name, "Connected") == 0) {
+				dbus_bool_t connected;
+
+				dbus_message_iter_get_basic(iter, &connected);
+
+				if (connected && default_dev == NULL)
+					set_default_device(proxy);
+				else if (!connected && default_dev == proxy)
+					set_default_device(NULL);
+			}
+
 			print_iter(str, name, iter);
 			g_free(str);
 		}
@@ -810,23 +847,36 @@ static void cmd_scan(const char *arg)
 	}
 }
 
-static void cmd_info(const char *arg)
+static struct GDBusProxy *find_device(const char *arg)
 {
 	GDBusProxy *proxy;
-	DBusMessageIter iter;
-	const char *address;
 
 	if (!arg || !strlen(arg)) {
+		if (default_dev)
+			return default_dev;
 		rl_printf("Missing device address argument\n");
-		return;
+		return NULL;
 	}
 
 	proxy = find_proxy_by_address(dev_list, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
-		return;
+		return NULL;
 	}
 
+	return proxy;
+}
+
+static void cmd_info(const char *arg)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *address;
+
+	proxy = find_device(arg);
+	if (!proxy)
+		return;
+
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
 		return;
 
@@ -866,16 +916,9 @@ static void cmd_pair(const char *arg)
 {
 	GDBusProxy *proxy;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
-		return;
-	}
 
 	if (g_dbus_proxy_method_call(proxy, "Pair", NULL, pair_reply,
 							NULL, NULL) == FALSE) {
@@ -892,16 +935,9 @@ static void cmd_trust(const char *arg)
 	dbus_bool_t trusted;
 	char *str;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
-		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
 
 	trusted = TRUE;
 
@@ -921,16 +957,9 @@ static void cmd_untrust(const char *arg)
 	dbus_bool_t trusted;
 	char *str;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
-		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
 
 	trusted = FALSE;
 
@@ -950,16 +979,9 @@ static void cmd_block(const char *arg)
 	dbus_bool_t blocked;
 	char *str;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
-		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
 
 	blocked = TRUE;
 
@@ -979,16 +1001,9 @@ static void cmd_unblock(const char *arg)
 	dbus_bool_t blocked;
 	char *str;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
-		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
 
 	blocked = FALSE;
 
@@ -1057,6 +1072,7 @@ static void cmd_remove(const char *arg)
 
 static void connect_reply(DBusMessage *message, void *user_data)
 {
+	GDBusProxy *proxy = user_data;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -1068,6 +1084,8 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	}
 
 	rl_printf("Connection successful\n");
+
+	set_default_device(proxy);
 }
 
 static void cmd_connect(const char *arg)
@@ -1086,7 +1104,7 @@ static void cmd_connect(const char *arg)
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
-							NULL, NULL) == FALSE) {
+							proxy, NULL) == FALSE) {
 		rl_printf("Failed to connect\n");
 		return;
 	}
@@ -1096,6 +1114,7 @@ static void cmd_connect(const char *arg)
 
 static void disconn_reply(DBusMessage *message, void *user_data)
 {
+	GDBusProxy *proxy = user_data;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -1107,25 +1126,23 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	}
 
 	rl_printf("Successful disconnected\n");
+
+	if (proxy != default_dev)
+		return;
+
+	set_default_device(NULL);
 }
 
 static void cmd_disconn(const char *arg)
 {
 	GDBusProxy *proxy;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
+	proxy = find_device(arg);
+	if (!proxy)
 		return;
-	}
-
-	proxy = find_proxy_by_address(dev_list, arg);
-	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
-		return;
-	}
 
 	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_reply,
-							NULL, NULL) == FALSE) {
+							proxy, NULL) == FALSE) {
 		rl_printf("Failed to disconnect\n");
 		return;
 	}
@@ -1233,23 +1250,23 @@ static const struct {
 	{ "default-agent",NULL,       cmd_default_agent,
 				"Set agent as the default one" },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
-	{ "info",         "<dev>",    cmd_info, "Device information",
+	{ "info",         "[dev]",    cmd_info, "Device information",
 							dev_generator },
-	{ "pair",         "<dev>",    cmd_pair, "Pair with device",
+	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
 							dev_generator },
-	{ "trust",        "<dev>",    cmd_trust, "Trust device",
+	{ "trust",        "[dev]",    cmd_trust, "Trust device",
 							dev_generator },
-	{ "untrust",      "<dev>",    cmd_untrust, "Untrust device",
+	{ "untrust",      "[dev]",    cmd_untrust, "Untrust device",
 							dev_generator },
-	{ "block",        "<dev>",    cmd_block, "Block device",
+	{ "block",        "[dev]",    cmd_block, "Block device",
 								dev_generator },
-	{ "unblock",      "<dev>",    cmd_unblock, "Unblock device",
+	{ "unblock",      "[dev]",    cmd_unblock, "Unblock device",
 								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
 	{ "connect",      "<dev>",    cmd_connect, "Connect device",
 							dev_generator },
-	{ "disconnect",   "<dev>",    cmd_disconn, "Disconnect device",
+	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
-- 
2.1.0

