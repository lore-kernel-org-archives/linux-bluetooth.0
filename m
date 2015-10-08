Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 2/2] client: add support for new property to list connected profiles
Date: Thu,  8 Oct 2015 09:43:52 +0200
Message-Id: <1444290232-19779-2-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444290232-19779-1-git-send-email-simon.fels@canonical.com>
References: <1444290232-19779-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This modifies the output of the list of available profiles a bit to allow
us to print out multiple lists with UUIDs.
---
 client/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 6863593..1d0704a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -238,15 +238,21 @@ static void print_property(GDBusProxy *proxy, const char *name)
 	print_iter("\t", name, &iter);
 }
 
-static void print_uuids(GDBusProxy *proxy)
+static void print_uuids(GDBusProxy *proxy, const char *name)
 {
 	DBusMessageIter iter, value;
 
-	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) == FALSE)
+	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
 		return;
 
 	dbus_message_iter_recurse(&iter, &value);
 
+	rl_printf("\t%s:\n", name);
+
+	if (!dbus_message_iter_has_next(&value)) {
+		rl_printf("\t  None\n");
+	}
+
 	while (dbus_message_iter_get_arg_type(&value) == DBUS_TYPE_STRING) {
 		const char *uuid, *text;
 
@@ -269,10 +275,10 @@ static void print_uuids(GDBusProxy *proxy)
 				n = sizeof(str) - 1;
 			}
 
-			rl_printf("\tUUID: %s%*c(%s)\n",
+			rl_printf("\t  %s%*c(%s)\n",
 						str, 26 - n, ' ', uuid);
 		} else
-			rl_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+			rl_printf("\t  %*c(%s)\n", 26, ' ', uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -654,7 +660,7 @@ static void cmd_show(const char *arg)
 	print_property(proxy, "Powered");
 	print_property(proxy, "Discoverable");
 	print_property(proxy, "Pairable");
-	print_uuids(proxy);
+	print_uuids(proxy, "UUIDs");
 	print_property(proxy, "Modalias");
 	print_property(proxy, "Discovering");
 }
@@ -1163,8 +1169,9 @@ static void cmd_info(const char *arg)
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_uuids(proxy, "ConnectedProfiles");
 	print_property(proxy, "LegacyPairing");
-	print_uuids(proxy);
+	print_uuids(proxy, "UUIDs");
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
 	print_property(proxy, "ServiceData");
-- 
2.5.0

