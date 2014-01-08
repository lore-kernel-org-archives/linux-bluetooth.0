Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 7/7] client: Add unblock command
Date: Wed,  8 Jan 2014 01:02:28 +0100
Message-Id: <1389139348-3552-8-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/main.c b/client/main.c
index 9f9231a..5791e95 100644
--- a/client/main.c
+++ b/client/main.c
@@ -909,6 +909,35 @@ static void cmd_block(const char *arg)
 	g_free(str);
 }
 
+static void cmd_unblock(const char *arg)
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
+	blocked = FALSE;
+
+	str = g_strdup_printf("%s unblock", arg);
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
@@ -1150,6 +1179,8 @@ static const struct {
 							dev_generator },
 	{ "block",        "<dev>",    cmd_block, "Block device",
 								dev_generator },
+	{ "unblock",      "<dev>",    cmd_unblock, "Unblock device",
+								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
 	{ "connect",      "<dev>",    cmd_connect, "Connect device",
-- 
1.8.5.2

