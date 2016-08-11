Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] client: Add advertise command
Date: Thu, 11 Aug 2016 15:14:48 +0300
Message-Id: <1470917692-8878-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds advertise command which uses org.bluez.LEAdvertisingManager1 to
add an advertising instance:

[bluetooth]# advertise
broadcast   off         on          peripheral
[bluetooth]# advertise on
Advertising object registered

@ Advertising Added: 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 3
        Flags: 0x02
          LE General Discoverable Mode

[bluetooth]# advertise off
Advertising object unregistered

@ Advertising Removed: 1
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
        Advertising: Disabled (0x00)
---
 Makefile.tools       |   2 +
 client/advertising.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++
 client/main.c        |  93 ++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 client/advertising.c

diff --git a/Makefile.tools b/Makefile.tools
index 0d5f143..7706dc7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -5,6 +5,8 @@ bin_PROGRAMS += client/bluetoothctl
 client_bluetoothctl_SOURCES = client/main.c \
 					client/display.h client/display.c \
 					client/agent.h client/agent.c \
+					client/advertising.h \
+					client/advertising.c \
 					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
diff --git a/client/advertising.c b/client/advertising.c
new file mode 100644
index 0000000..34e3f59
--- /dev/null
+++ b/client/advertising.c
@@ -0,0 +1,179 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2016  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <readline/readline.h>
+#include <wordexp.h>
+
+#include "gdbus/gdbus.h"
+#include "display.h"
+#include "advertising.h"
+
+#define AD_PATH "/org/bluez/advertising"
+#define AD_IFACE "org.bluez.LEAdvertisement1"
+
+static gboolean registered = FALSE;
+static char *ad_type = NULL;
+
+static void ad_release(DBusConnection *conn)
+{
+	registered = FALSE;
+
+	g_dbus_unregister_interface(conn, AD_PATH, AD_IFACE);
+}
+
+static DBusMessage *release_advertising(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	rl_printf("Advertising released\n");
+
+	ad_release(conn);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable ad_methods[] = {
+	{ GDBUS_METHOD("Release", NULL, NULL, release_advertising) },
+	{ }
+};
+
+static void register_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	const char *path = AD_PATH;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void register_reply(DBusMessage *message, void *user_data)
+{
+	DBusConnection *conn = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == FALSE) {
+		registered = TRUE;
+		rl_printf("Advertising object registered\n");
+	} else {
+		rl_printf("Failed to register advertisement: %s\n", error.name);
+		dbus_error_free(&error);
+
+		if (g_dbus_unregister_interface(conn, AD_PATH,
+						AD_IFACE) == FALSE)
+			rl_printf("Failed to unregister advertising object\n");
+	}
+}
+
+static gboolean get_type(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	const char *type = "peripheral";
+
+	if (!ad_type || strlen(ad_type) > 0)
+		type = ad_type;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable ad_props[] = {
+	{ "Type", "s", get_type },
+	{ }
+};
+
+void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
+{
+	if (registered == TRUE) {
+		rl_printf("Advertisement is already registered\n");
+		return;
+	}
+
+	ad_type = g_strdup(type);
+
+	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
+					NULL, ad_props, NULL, NULL) == FALSE) {
+		rl_printf("Failed to register advertising object\n");
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(manager, "RegisterAdvertisement",
+					register_setup, register_reply,
+					conn, NULL) == FALSE) {
+		rl_printf("Failed to register advertising\n");
+		return;
+	}
+}
+
+static void unregister_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = AD_PATH;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void unregister_reply(DBusMessage *message, void *user_data)
+{
+	DBusConnection *conn = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == FALSE) {
+		registered = FALSE;
+		rl_printf("Advertising object unregistered\n");
+		if (g_dbus_unregister_interface(conn, AD_PATH,
+							AD_IFACE) == FALSE)
+			rl_printf("Failed to unregister advertising object\n");
+	} else {
+		rl_printf("Failed to unregister advertisement: %s\n",
+								error.name);
+		dbus_error_free(&error);
+	}
+}
+
+void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
+{
+	if (!manager)
+		ad_release(conn);
+
+	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
+					unregister_setup, unregister_reply,
+					conn, NULL) == FALSE) {
+		rl_printf("Failed to unregister advertisement method\n");
+		return;
+	}
+}
diff --git a/client/main.c b/client/main.c
index 056331f..471879f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -43,6 +43,7 @@
 #include "agent.h"
 #include "display.h"
 #include "gatt.h"
+#include "advertising.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -58,6 +59,8 @@ static DBusConnection *dbus_conn;
 static GDBusProxy *agent_manager;
 static char *auto_register_agent = NULL;
 
+static GDBusProxy *ad_manager;
+
 static GDBusProxy *default_ctrl;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
@@ -77,6 +80,14 @@ static const char * const agent_arguments[] = {
 	NULL
 };
 
+static const char * const ad_arguments[] = {
+	"on",
+	"off",
+	"peripheral",
+	"broadcast",
+	NULL
+};
+
 static void proxy_leak(gpointer data)
 {
 	printf("Leaking proxy %p\n", data);
@@ -445,6 +456,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		gatt_add_descriptor(proxy);
 	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
 		gatt_add_manager(proxy);
+	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
+		ad_manager = proxy;
 	}
 }
 
@@ -509,6 +522,11 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			set_default_attribute(NULL);
 	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
 		gatt_remove_manager(proxy);
+	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
+		if (ad_manager == proxy) {
+			agent_manager = NULL;
+			ad_unregister(dbus_conn, NULL);
+		}
 	}
 }
 
@@ -1783,6 +1801,78 @@ static char *capability_generator(const char *text, int state)
 	return NULL;
 }
 
+static gboolean parse_argument_advertise(const char *arg, dbus_bool_t *value,
+							const char **type)
+{
+	const char * const *opt;
+
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing on/off/type argument\n");
+		return FALSE;
+	}
+
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+		*value = TRUE;
+		*type = "";
+		return TRUE;
+	}
+
+	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	for (opt = ad_arguments; *opt; opt++) {
+		if (strcmp(arg, *opt) == 0) {
+			*value = TRUE;
+			*type = *opt;
+			return TRUE;
+		}
+	}
+
+	rl_printf("Invalid argument %s\n", arg);
+	return FALSE;
+}
+
+static void cmd_advertise(const char *arg)
+{
+	dbus_bool_t enable;
+	const char *type;
+
+	if (parse_argument_advertise(arg, &enable, &type) == FALSE)
+		return;
+
+	if (!ad_manager) {
+		rl_printf("LEAdvertisingManager not found\n");
+		return;
+	}
+
+	if (enable == TRUE)
+		ad_register(dbus_conn, ad_manager, type);
+	else
+		ad_unregister(dbus_conn, ad_manager);
+}
+
+static char *ad_generator(const char *text, int state)
+{
+	static int index, len;
+	const char *arg;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((arg = ad_arguments[index])) {
+		index++;
+
+		if (!strncmp(arg, text, len))
+			return strdup(arg);
+	}
+
+	return NULL;
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -1811,6 +1901,9 @@ static const struct {
 							capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent,
 				"Set agent as the default one" },
+	{ "advertise",    "<on/off/type>", cmd_advertise,
+				"Enable/disable advertising with given type",
+							ad_generator},
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.7.4

