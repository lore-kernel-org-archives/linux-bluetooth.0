Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] client: Add notify command
Date: Fri,  6 Feb 2015 13:03:43 +0200
Message-Id: <1423220624-18861-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This command can be used to start/stop changes on the attribute value,
it only works if an attribute has been selected with select-attribute.
---
 client/gatt.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  1 +
 client/main.c | 16 ++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 207e049..3785452 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -465,3 +465,50 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 	rl_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
+
+static void notify_reply(DBusMessage *message, void *user_data)
+{
+	bool enable = GPOINTER_TO_UINT(user_data);
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to %s notify: %s\n",
+				enable ? "start" : "stop", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
+}
+
+static void notify_attribute(GDBusProxy *proxy, bool enable)
+{
+	const char *method;
+
+	if (enable == TRUE)
+		method = "StartNotify";
+	else
+		method = "StopNotify";
+
+	if (g_dbus_proxy_method_call(proxy, method, NULL, notify_reply,
+				GUINT_TO_POINTER(enable), NULL) == FALSE) {
+		rl_printf("Failed to %s notify\n", enable ? "start" : "stop");
+		return;
+	}
+}
+
+void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, "org.bluez.GattCharacteristic1")) {
+		notify_attribute(proxy, enable);
+		return;
+	}
+
+	rl_printf("Unable to notify attribute %s\n",
+						g_dbus_proxy_get_path(proxy));
+}
diff --git a/client/gatt.h b/client/gatt.h
index b99f0f0..effee5e 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -36,3 +36,4 @@ char *gatt_attribute_generator(const char *text, int state);
 
 void gatt_read_attribute(GDBusProxy *proxy);
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
+void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
diff --git a/client/main.c b/client/main.c
index 56d4750..57b1201 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1301,6 +1301,21 @@ static void cmd_write(const char *arg)
 	gatt_write_attribute(default_attr, arg);
 }
 
+static void cmd_notify(const char *arg)
+{
+	dbus_bool_t enable;
+
+	if (parse_argument_on_off(arg, &enable) == FALSE)
+		return;
+
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_notify_attribute(default_attr, enable ? true : false);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1433,6 +1448,7 @@ static const struct {
 	{ "read",         NULL,       cmd_read, "Read attribute value" },
 	{ "write",        "<data=[xx xx ...]>", cmd_write,
 						"Write attribute value" },
+	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

