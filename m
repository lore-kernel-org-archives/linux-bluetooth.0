Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] client: Add unregister-profile command
Date: Tue, 24 Mar 2015 11:37:53 +0200
Message-Id: <1427189873-29770-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
References: <1427189873-29770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to unregister-profile command which uses
GattManager1.UnregisterProfile.
---
 client/gatt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  1 +
 client/main.c | 10 ++++++++++
 3 files changed, 55 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 2d35905..737ecea 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -616,3 +616,47 @@ void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
 		return;
 	}
 }
+
+static void unregister_profile_reply(DBusMessage *message, void *user_data)
+{
+	DBusConnection *conn = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to unregister profile: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Profile unregistered\n");
+
+	g_dbus_unregister_interface(conn, PROFILE_PATH, PROFILE_INTERFACE);
+}
+
+static void unregister_profile_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = PROFILE_PATH;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+void gatt_unregister_profile(DBusConnection *conn, GDBusProxy *proxy)
+{
+	GList *l;
+
+	l = g_list_find_custom(managers, proxy, match_proxy);
+	if (!l) {
+		rl_printf("Unable to find GattManager proxy\n");
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(l->data, "UnregisterProfile",
+						unregister_profile_setup,
+						unregister_profile_reply, conn,
+						NULL) == FALSE) {
+		rl_printf("Failed unregister profile\n");
+		return;
+	}
+}
diff --git a/client/gatt.h b/client/gatt.h
index 547e84a..689bb4d 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -43,3 +43,4 @@ void gatt_remove_manager(GDBusProxy *proxy);
 
 void gatt_register_profile(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
+void gatt_unregister_profile(DBusConnection *conn, GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index b2c6b41..4360930 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1356,6 +1356,14 @@ static void cmd_register_profile(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_unregister_profile(const char *arg)
+{
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	gatt_unregister_profile(dbus_conn, default_ctrl);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1491,6 +1499,8 @@ static const struct {
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "register-profile", "<UUID ...>", cmd_register_profile,
 						"Register profile to connect" },
+	{ "unregister-profile", NULL, cmd_unregister_profile,
+						"Unregister profile" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

