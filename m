Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] client: Add attribute-info command
Date: Fri,  6 Feb 2015 13:03:39 +0200
Message-Id: <1423220624-18861-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

attribute-info can be used to print out attribute information.
---
 client/main.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/client/main.c b/client/main.c
index 1481694..614efca 100644
--- a/client/main.c
+++ b/client/main.c
@@ -160,7 +160,6 @@ static void print_iter(const char *label, const char *name,
 	dbus_int16_t vals16;
 	const char *valstr;
 	DBusMessageIter subiter;
-	int type;
 
 	if (iter == NULL) {
 		rl_printf("%s%s is nil\n", label, name);
@@ -193,23 +192,23 @@ static void print_iter(const char *label, const char *name,
 		dbus_message_iter_get_basic(iter, &vals16);
 		rl_printf("%s%s: %d\n", label, name, vals16);
 		break;
+	case DBUS_TYPE_VARIANT:
+		dbus_message_iter_recurse(iter, &subiter);
+		print_iter(label, name, &subiter);
+		break;
 	case DBUS_TYPE_ARRAY:
 		dbus_message_iter_recurse(iter, &subiter);
-		rl_printf("%s%s:\n", label, name);
-
-		do {
-			type = dbus_message_iter_get_arg_type(&subiter);
-			if (type == DBUS_TYPE_INVALID)
-				break;
-
-			if (type == DBUS_TYPE_STRING) {
-				dbus_message_iter_get_basic(&subiter, &valstr);
-				rl_printf("\t%s\n", valstr);
-			}
-
+		while (dbus_message_iter_get_arg_type(&subiter) !=
+							DBUS_TYPE_INVALID) {
+			print_iter(label, name, &subiter);
 			dbus_message_iter_next(&subiter);
-		} while(true);
-
+		}
+		break;
+	case DBUS_TYPE_DICT_ENTRY:
+		dbus_message_iter_recurse(iter, &subiter);
+		dbus_message_iter_get_basic(&subiter, &valstr);
+		dbus_message_iter_next(&subiter);
+		print_iter(label, valstr, &subiter);
 		break;
 	default:
 		rl_printf("%s%s has unsupported type\n", label, name);
@@ -1212,6 +1211,71 @@ static void cmd_select_attribute(const char *arg)
 		set_default_attribute(proxy);
 }
 
+static struct GDBusProxy *find_attribute(const char *arg)
+{
+	GDBusProxy *proxy;
+
+	if (!arg || !strlen(arg)) {
+		if (default_attr)
+			return default_attr;
+		rl_printf("Missing attribute argument\n");
+		return NULL;
+	}
+
+	proxy = gatt_select_attribute(arg);
+	if (!proxy) {
+		rl_printf("Attribute %s not available\n", arg);
+		return NULL;
+	}
+
+	return proxy;
+}
+
+static void cmd_attribute_info(const char *arg)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *iface, *uuid, *text;
+
+	proxy = find_attribute(arg);
+	if (!proxy)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	text = uuidstr_to_str(uuid);
+	if (!text)
+		text = g_dbus_proxy_get_path(proxy);
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, "org.bluez.GattService1")) {
+		rl_printf("Service - %s\n", text);
+
+		print_property(proxy, "UUID");
+		print_property(proxy, "Primary");
+		print_property(proxy, "Characteristics");
+		print_property(proxy, "Includes");
+	} else if (!strcmp(iface, "org.bluez.GattCharacteristic1")) {
+		rl_printf("Characteristic - %s\n", text);
+
+		print_property(proxy, "UUID");
+		print_property(proxy, "Service");
+		print_property(proxy, "Value");
+		print_property(proxy, "Notifying");
+		print_property(proxy, "Flags");
+		print_property(proxy, "Descriptors");
+	} else if (!strcmp(iface, "org.bluez.GattDescriptor1")) {
+		rl_printf("Descriptor - %s\n", text);
+
+		print_property(proxy, "UUID");
+		print_property(proxy, "Characteristic");
+		print_property(proxy, "Value");
+	}
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1339,6 +1403,8 @@ static const struct {
 							dev_generator },
 	{ "select-attribute", "<attribute>",  cmd_select_attribute,
 				"Select attribute", attribute_generator },
+	{ "attribute-info", "[attribute]",  cmd_attribute_info,
+				"Select attribute", attribute_generator },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

