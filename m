Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 6/7] client: Add block command
Date: Wed,  8 Jan 2014 01:02:27 +0100
Message-Id: <1389139348-3552-7-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/main.c b/client/main.c
index a6e7906..9f9231a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -880,6 +880,35 @@ static void cmd_untrust(const char *arg)
 	g_free(str);
 }
 
+static void cmd_block(const char *arg)
+{
+	GDBusProxy *proxy;
+	dbus_bool_t blocked;
+	char *str;
+
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing device address argument\n");
+		return;
+	}
+
+	proxy = find_proxy_by_address(dev_list, arg);
+	if (!proxy) {
+		rl_printf("Device %s not available\n", arg);
+		return;
+	}
+
+	blocked = TRUE;
+
+	str = g_strdup_printf("%s block", arg);
+
+	if (g_dbus_proxy_set_property_basic(proxy, "Blocked",
+					DBUS_TYPE_BOOLEAN, &blocked,
+					generic_callback, str, g_free) == TRUE)
+		return;
+
+	g_free(str);
+}
+
 static void remove_device_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -1119,6 +1148,8 @@ static const struct {
 							dev_generator },
 	{ "untrust",      "<dev>",    cmd_untrust, "Untrust device",
 							dev_generator },
+	{ "block",        "<dev>",    cmd_block, "Block device",
+								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
 	{ "connect",      "<dev>",    cmd_connect, "Connect device",
-- 
1.8.5.2

