Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] client: Add register-profile command
Date: Tue, 24 Mar 2015 11:37:51 +0200
Message-Id: <1427189873-29770-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
References: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to register-profile command which uses
GattManager1.RegisterProfile.
---
 client/gatt.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |   6 ++++
 client/main.c |  29 ++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 884c4f2..2d35905 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/uio.h>
+#include <wordexp.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -41,6 +42,9 @@
 #include "display.h"
 #include "gatt.h"
 
+#define PROFILE_PATH "/org/bluez/profile"
+#define PROFILE_INTERFACE "org.bluez.GattProfile1"
+
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
@@ -49,6 +53,7 @@
 static GList *services;
 static GList *characteristics;
 static GList *descriptors;
+static GList *managers;
 
 static void print_service(GDBusProxy *proxy, const char *description)
 {
@@ -512,3 +517,102 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
 	rl_printf("Unable to notify attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
+
+static void register_profile_setup(DBusMessageIter *iter, void *user_data)
+{
+	wordexp_t *w = user_data;
+	DBusMessageIter uuids, opt;
+	const char *path = PROFILE_PATH;
+	size_t i;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &uuids);
+	for (i = 0; i < w->we_wordc; i++)
+		dbus_message_iter_append_basic(&uuids, DBUS_TYPE_STRING,
+							&w->we_wordv[i]);
+	dbus_message_iter_close_container(iter, &uuids);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&opt);
+	dbus_message_iter_close_container(iter, &opt);
+
+}
+
+static void register_profile_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to register profile: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Profile registered\n");
+}
+
+void gatt_add_manager(GDBusProxy *proxy)
+{
+	managers = g_list_append(managers, proxy);
+}
+
+void gatt_remove_manager(GDBusProxy *proxy)
+{
+	managers = g_list_remove(managers, proxy);
+}
+
+static int match_proxy(const void *a, const void *b)
+{
+	GDBusProxy *proxy1 = (void *) a;
+	GDBusProxy *proxy2 = (void *) b;
+
+	return strcmp(g_dbus_proxy_get_path(proxy1),
+						g_dbus_proxy_get_path(proxy2));
+}
+
+static DBusMessage *release_profile(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	g_dbus_unregister_interface(conn, PROFILE_PATH, PROFILE_INTERFACE);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_METHOD("Release", NULL, NULL, release_profile) },
+	{ }
+};
+
+void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w)
+{
+	GList *l;
+
+	l = g_list_find_custom(managers, proxy, match_proxy);
+	if (!l) {
+		rl_printf("Unable to find GattManager proxy\n");
+		return;
+	}
+
+	if (g_dbus_register_interface(conn, PROFILE_PATH,
+					PROFILE_INTERFACE, methods,
+					NULL, NULL, NULL, NULL) == FALSE) {
+		rl_printf("Failed to register profile object\n");
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(l->data, "RegisterProfile",
+						register_profile_setup,
+						register_profile_reply, w,
+						NULL) == FALSE) {
+		rl_printf("Failed register profile\n");
+		return;
+	}
+}
diff --git a/client/gatt.h b/client/gatt.h
index effee5e..547e84a 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -37,3 +37,9 @@ char *gatt_attribute_generator(const char *text, int state);
 void gatt_read_attribute(GDBusProxy *proxy);
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
+
+void gatt_add_manager(GDBusProxy *proxy);
+void gatt_remove_manager(GDBusProxy *proxy);
+
+void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
+								wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index 7f1c903..b2c6b41 100644
--- a/client/main.c
+++ b/client/main.c
@@ -32,6 +32,7 @@
 #include <stdbool.h>
 #include <signal.h>
 #include <sys/signalfd.h>
+#include <wordexp.h>
 
 #include <readline/readline.h>
 #include <readline/history.h>
@@ -348,6 +349,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		gatt_add_characteristic(proxy);
 	} else if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
 		gatt_add_descriptor(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
+		gatt_add_manager(proxy);
 	}
 }
 
@@ -443,6 +446,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 
 		if (default_attr == proxy)
 			set_default_attribute(NULL);
+	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
+		gatt_remove_manager(proxy);
 	}
 }
 
@@ -1329,6 +1334,28 @@ static void cmd_notify(const char *arg)
 	gatt_notify_attribute(default_attr, enable ? true : false);
 }
 
+static void cmd_register_profile(const char *arg)
+{
+	wordexp_t w;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (wordexp(arg, &w, WRDE_NOCMD)) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	if (w.we_wordc == 0) {
+		rl_printf("Missing argument\n");
+		return;
+	}
+
+	gatt_register_profile(dbus_conn, default_ctrl, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1462,6 +1489,8 @@ static const struct {
 	{ "write",        "<data=[xx xx ...]>", cmd_write,
 						"Write attribute value" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
+	{ "register-profile", "<UUID ...>", cmd_register_profile,
+						"Register profile to connect" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

