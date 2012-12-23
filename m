Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] gdbus: Introduce G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
Date: Sun, 23 Dec 2012 22:15:12 +0200
Message-Id: <1356293718-9348-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
References: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark signals as experimental, the marked
signals with this flag can be enabled by setting the environment variable
GDBUS_EXPERIMENTAL=1
---
 gdbus/gdbus.h  |  8 +++++++-
 gdbus/object.c | 21 ++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 00fbb1c..e6b51cd 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -96,7 +96,8 @@ enum GDBusMethodFlags {
 };
 
 enum GDBusSignalFlags {
-	G_DBUS_SIGNAL_FLAG_DEPRECATED = (1 << 0),
+	G_DBUS_SIGNAL_FLAG_DEPRECATED   = (1 << 0),
+	G_DBUS_SIGNAL_FLAG_EXPERIMENTAL = (1 << 1),
 };
 
 enum GDBusPropertyFlags {
@@ -204,6 +205,11 @@ struct GDBusSecurityTable {
 	.args = _args, \
 	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
 
+#define GDBUS_EXPERIMENTAL_SIGNAL(_name, _args) \
+	.name = _name, \
+	.args = _args, \
+	.flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
diff --git a/gdbus/object.c b/gdbus/object.c
index 30dbbc2..20f7db9 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -165,6 +165,14 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		gboolean deprecated = signal->flags &
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
+		gboolean experimental = signal->flags &
+					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL;
+
+		if (experimental) {
+			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
+			if (g_strcmp0(env, "1") != 0)
+				continue;
+		}
 
 		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr,
@@ -1267,10 +1275,17 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
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
1.7.11.7

