Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/12] client: Add support for GattService1
Date: Fri,  6 Feb 2015 13:03:33 +0200
Message-Id: <1423220624-18861-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add support for GattService1 interface detection and prints when
they are added or removed
---
 Makefile.tools |  1 +
 client/gatt.c  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h  | 25 ++++++++++++++++
 client/main.c  | 30 ++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 client/gatt.c
 create mode 100644 client/gatt.h

diff --git a/Makefile.tools b/Makefile.tools
index e42e42d..64da54f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -5,6 +5,7 @@ bin_PROGRAMS += client/bluetoothctl
 client_bluetoothctl_SOURCES = client/main.c \
 					client/display.h client/display.c \
 					client/agent.h client/agent.c \
+					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
 				-lreadline
diff --git a/client/gatt.c b/client/gatt.c
new file mode 100644
index 0000000..7de5c7b
--- /dev/null
+++ b/client/gatt.c
@@ -0,0 +1,90 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "monitor/uuid.h"
+#include "display.h"
+#include "gatt.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+#define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
+
+static GList *services;
+
+static void print_service(GDBusProxy *proxy, const char *description)
+{
+	DBusMessageIter iter;
+	const char *uuid, *text;
+	dbus_bool_t primary;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (g_dbus_proxy_get_property(proxy, "Primary", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &primary);
+
+	text = uuidstr_to_str(uuid);
+	if (!text)
+		text = uuid;
+
+	rl_printf("%s%s%sService %s %s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				g_dbus_proxy_get_path(proxy),
+				text, primary ? "(Primary)" : "(Secondary)");
+}
+
+void gatt_add_service(GDBusProxy *proxy)
+{
+	services = g_list_append(services, proxy);
+
+	print_service(proxy, COLORED_NEW);
+}
+
+void gatt_remove_service(GDBusProxy *proxy)
+{
+	services = g_list_remove(services, proxy);
+
+	print_service(proxy, COLORED_DEL);
+}
diff --git a/client/gatt.h b/client/gatt.h
new file mode 100644
index 0000000..f049039
--- /dev/null
+++ b/client/gatt.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+void gatt_add_service(GDBusProxy *proxy);
+void gatt_remove_service(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index ea80ee7..ab644ba 100644
--- a/client/main.c
+++ b/client/main.c
@@ -41,6 +41,7 @@
 #include "monitor/uuid.h"
 #include "agent.h"
 #include "display.h"
+#include "gatt.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -284,6 +285,29 @@ static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
 	return FALSE;
 }
 
+static gboolean service_is_child(GDBusProxy *service)
+{
+	GList *l;
+	DBusMessageIter iter;
+	const char *device, *path;
+
+	if (g_dbus_proxy_get_property(service, "Device", &iter) == FALSE)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &device);
+
+	for (l = dev_list; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+
+		path = g_dbus_proxy_get_path(proxy);
+
+		if (!strcmp(path, device))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -311,6 +335,9 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 				agent_register(dbus_conn, agent_manager,
 							auto_register_agent);
 		}
+	} else if (!strcmp(interface, "org.bluez.GattService1")) {
+		if (service_is_child(proxy))
+			gatt_add_service(proxy);
 	}
 }
 
@@ -343,6 +370,9 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			if (auto_register_agent)
 				agent_unregister(dbus_conn, NULL);
 		}
+	} else if (!strcmp(interface, "org.bluez.GattService1")) {
+		if (service_is_child(proxy))
+			gatt_remove_service(proxy);
 	}
 }
 
-- 
2.1.0

