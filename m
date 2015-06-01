Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] client: main: add support for ConnectProfile
Date: Mon,  1 Jun 2015 10:51:07 -0700
Message-Id: <1433181067-31612-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds set-connect-profile command to sample DBus client
that might be used to modify how connect method behaves. Instead of
using "Connect" DBus method, "ConnectProfile" would be used if
set-connect-profile was set.

Sample output:
[bluetooth]# set-connect-profile 0000babe-0000-1000-8000-00805f9b34fb
Connect profile set to 0000babe-0000-1000-8000-00805f9b34fb
[bluetooth]# connect 60:D3:7E:0C:F7:3E
Attempting to connect to 60:D3:7E:0C:F7:3E to profile 0000babe-0000-1000-8000-00805f9b34fb
[bluetooth]# set-connect-profile
Connect profile cleared
[bluetooth]# connect 60:D3:7E:0C:F7:3E
Attempting to connect to 60:D3:7E:0C:F7:3E
---
 client/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/client/main.c b/client/main.c
index 41e95b2..96b340d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1345,6 +1345,31 @@ static void cmd_remove(const char *arg)
 	}
 }
 
+static char *connect_profile;
+
+static void cmd_set_connect_profile(const char *arg)
+{
+	if (!arg || !strlen(arg)) {
+		if (connect_profile != NULL) {
+			g_free(connect_profile);
+			connect_profile = NULL;
+		}
+
+		rl_printf("Connect profile cleared\n");
+		return;
+	}
+
+	connect_profile = g_strdup(arg);
+	rl_printf("Connect profile set to %s\n", arg);
+}
+
+static void connect_profile_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+}
+
 static void connect_reply(DBusMessage *message, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -1378,6 +1403,21 @@ static void cmd_connect(const char *arg)
 		return;
 	}
 
+	if (connect_profile != NULL) {
+		char *uuid = g_strdup(connect_profile);
+
+		if (g_dbus_proxy_method_call(proxy, "ConnectProfile",
+		connect_profile_setup, connect_reply, uuid, g_free) == FALSE) {
+			rl_printf("Failed to connect to profile\n");
+			g_free(uuid);
+			return;
+		}
+
+		rl_printf("Attempting to connect to %s to profile %s\n", arg,
+							      connect_profile);
+		return;
+	}
+
 	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
 							proxy, NULL) == FALSE) {
 		rl_printf("Failed to connect\n");
@@ -1720,6 +1760,8 @@ static const struct {
 								dev_generator },
 	{ "remove",       "<dev>",    cmd_remove, "Remove device",
 							dev_generator },
+	{ "set-connect-profile", "<uuid>", cmd_set_connect_profile,
+				"Set profile to connect to",	dev_generator },
 	{ "connect",      "<dev>",    cmd_connect, "Connect device",
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
-- 
2.2.0.rc0.207.ga3a616c

