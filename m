Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] client: Add discoverable-timeout command
Date: Wed, 25 Jul 2018 13:20:32 +0300
Message-Id: <20180725102035.19439-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds discoverable-timeout command which can be used to get/set
DiscoverableTimeout property:

[bluetooth]# discoverable-timeout 180
Changing discoverable-timeout 180 succeeded
---
 client/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/client/main.c b/client/main.c
index 87323d8f7..59820c6d9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1061,6 +1061,47 @@ static void cmd_discoverable(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void cmd_discoverable_timeout(int argc, char *argv[])
+{
+	uint32_t value;
+	char *endptr = NULL;
+	char *str;
+
+	if (argc < 2) {
+		DBusMessageIter iter;
+
+		if (!g_dbus_proxy_get_property(default_ctrl->proxy,
+					"DiscoverableTimeout", &iter)) {
+			bt_shell_printf("Unable to get DiscoverableTimeout\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		dbus_message_iter_get_basic(&iter, &value);
+
+		bt_shell_printf("DiscoverableTimeout: %d seconds\n", value);
+
+		return;
+	}
+
+	value = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT32_MAX) {
+		bt_shell_printf("Invalid argument\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	str = g_strdup_printf("discoverable-timeout %d", value);
+
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy,
+					"DiscoverableTimeout",
+					DBUS_TYPE_UINT32, &value,
+					generic_callback, str, g_free))
+		return;
+
+	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void cmd_agent(int argc, char *argv[])
 {
 	dbus_bool_t enable;
@@ -2549,6 +2590,8 @@ static const struct bt_shell_menu main_menu = {
 	{ "discoverable", "<on/off>", cmd_discoverable,
 					"Set controller discoverable mode",
 							NULL },
+	{ "discoverable-timeout", "[value]", cmd_discoverable_timeout,
+					"Set discoverable timeout", NULL },
 	{ "agent",        "<on/off/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
-- 
2.17.1

