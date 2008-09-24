Return-Path: <cyrus@holtmann.org>
Subject: First pass at HAL device class plugin
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-TB2AbL6OIb4c0EQY0La7"
Date: Tue, 23 Sep 2008 17:06:25 -0700
Message-Id: <1222214785.10497.127.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-TB2AbL6OIb4c0EQY0La7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Probably doesn't work, and it's missing some exported functionality to
set the device class on the actual adapter (and have it written).

--=-TB2AbL6OIb4c0EQY0La7
Content-Disposition: attachment; filename="0001-First-pass-at-a-HAL-plugin-to-set-the-device-class.patch"
Content-Type: text/x-patch; name="0001-First-pass-at-a-HAL-plugin-to-set-the-device-class.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From bb925e0a397dbbec2a60f39e65ff19c3d5e58d0b Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 23 Sep 2008 17:03:06 -0700
Subject: [PATCH] First pass at a HAL plugin to set the device class

---
 plugins/hal-adapter-class.c |  126 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 plugins/hal-adapter-class.c

diff --git a/plugins/hal-adapter-class.c b/plugins/hal-adapter-class.c
new file mode 100644
index 0000000..c5dae5c
--- /dev/null
+++ b/plugins/hal-adapter-class.c
@@ -0,0 +1,126 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2008  Marcel Holtmann <marcel@holtmann.org>
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
+#include <errno.h>
+#include <unistd.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+#include <hal/libhal.h>
+#include <gdbus.h>
+
+#include "plugin.h"
+#include "adapter.h"
+#include "logging.h"
+
+static guint32 get_form_factor(LibHalContext *ctx)
+{
+	char *formfactor;
+	guint32 ret;
+
+	ret = 1 << 8; /* Computer major class */
+	formfactor = libhal_device_get_property_string(ctx,
+				"/org/freedesktop/Hal/devices/computer",
+						"system.formfactor", NULL);
+
+	if (formfactor == NULL)
+		return ret;
+
+	if (g_str_equal(formfactor, "laptop"))
+		ret += (1 << 2) + (1 << 3);
+	else if (g_str_equal(formfactor, "desktop"))
+		ret += 1 << 2;
+	else if (g_str_equal(formfactor, "server"))
+		ret += 1 << 3;
+	else if (g_str_equal(formfactor, "handheld"))
+		ret += 1 << 4;
+
+	g_free (formfactor);
+
+	return ret;
+}
+
+static int hal_adapter_class_probe(struct btd_adapter *adapter)
+{
+	DBusConnection *conn;
+	LibHalContext *ctx = NULL;
+	guint32 class;
+
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	ctx = libhal_ctx_new();
+	if (libhal_ctx_set_dbus_connection(ctx, conn) == FALSE) {
+		libhal_ctx_free(ctx);
+		dbus_connection_unref(conn);
+		return -EIO;
+	}
+
+	if (libhal_ctx_init(ctx, NULL) == FALSE) {
+		g_warning("Unable to init HAL context");
+		libhal_ctx_free(ctx);
+		dbus_connection_unref(conn);
+		return -EIO;
+	}
+
+	class = get_form_factor (ctx);
+	debug ("0: 0x%X", class);
+#if 0
+	adapter_set_class (adapter, class);
+	dbus_g_proxy_call(object, "SetMajorClass", NULL,
+		G_TYPE_STRING, "computer", G_TYPE_INVALID, G_TYPE_INVALID);
+	dbus_g_proxy_call(object, "SetMinorClass", NULL,
+		G_TYPE_STRING, formfactor, G_TYPE_INVALID, G_TYPE_INVALID);
+	g_free (formfactor);
+#endif
+	libhal_ctx_free(ctx);
+	dbus_connection_unref(conn);
+
+	return 0;
+}
+
+static struct btd_adapter_driver hal_adapter_class = {
+	.name	= "hal-adapter-class",
+	.probe	= hal_adapter_class_probe,
+	.remove	= NULL,
+};
+
+static int hal_adapter_class_init(void)
+{
+	debug("Setup HAL Adapter Class plugin");
+
+	return btd_register_adapter_driver(&hal_adapter_class);
+}
+
+static void hal_adapter_class_exit(void)
+{
+	debug("Cleanup HAL Adapter Class plugin");
+
+	btd_unregister_adapter_driver(&hal_adapter_class);
+}
+
+BLUETOOTH_PLUGIN_DEFINE("hal", hal_adapter_class_init, hal_adapter_class_exit)
-- 
1.6.0.1


--=-TB2AbL6OIb4c0EQY0La7--

