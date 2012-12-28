Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] gdbus: Introduce G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
Date: Fri, 28 Dec 2012 14:51:00 +0200
Message-Id: <1356699069-5469-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark signals as experimental, marked
signals are disabled by default and can be enabled by setting
G_DBUS_FLAG_ENABLE_EXPERIMENTAL using g_dbus_set_flags.
---
 gdbus/gdbus.h  |  8 +++++++-
 gdbus/object.c | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 01ff9d4..edc1f53 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -100,7 +100,8 @@ enum GDBusMethodFlags {
 };
 
 enum GDBusSignalFlags {
-	G_DBUS_SIGNAL_FLAG_DEPRECATED = (1 << 0),
+	G_DBUS_SIGNAL_FLAG_DEPRECATED   = (1 << 0),
+	G_DBUS_SIGNAL_FLAG_EXPERIMENTAL = (1 << 1),
 };
 
 enum GDBusPropertyFlags {
@@ -208,6 +209,11 @@ struct GDBusSecurityTable {
 	.args = _args, \
 	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
 
+#define GDBUS_EXPERIMENTAL_SIGNAL(_name, _args) \
+	.name = _name, \
+	.args = _args, \
+	.flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
+
 void g_dbus_set_flags(int flags);
 
 gboolean g_dbus_register_interface(DBusConnection *connection,
diff --git a/gdbus/object.c b/gdbus/object.c
index 89e2a75..13a183f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -164,6 +164,12 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		gboolean deprecated = signal->flags &
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
+		gboolean experimental = signal->flags &
+					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL;
+
+		if (!(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) &&
+							experimental)
+			continue;
 
 		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr,
@@ -1266,10 +1272,17 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!strcmp(signal->name, name)) {
-			*args = signal->args;
-			return TRUE;
+		if (strcmp(signal->name, name) != 0)
+			continue;
+
+		if (signal->flags & G_DBUS_SIGNAL_FLAG_EXPERIMENTAL) {
+			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
+			if (g_strcmp0(env, "1") != 0)
+				break;
 		}
+
+		*args = signal->args;
+		return TRUE;
 	}
 
 	error("No signal named %s on interface %s", name, interface);
-- 
1.8.0.1

