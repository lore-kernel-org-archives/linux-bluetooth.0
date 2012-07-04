Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 18/28] deviceinfo: move to profiles folder
Date: Wed,  4 Jul 2012 10:17:37 +0200
Message-Id: <1341389867-30749-19-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                      |   11 ++-
 deviceinfo/deviceinfo.c          |  195 --------------------------------------
 deviceinfo/deviceinfo.h          |   24 -----
 deviceinfo/main.c                |   52 ----------
 deviceinfo/manager.c             |   80 ----------------
 deviceinfo/manager.h             |   24 -----
 profiles/deviceinfo/deviceinfo.c |  195 ++++++++++++++++++++++++++++++++++++++
 profiles/deviceinfo/deviceinfo.h |   24 +++++
 profiles/deviceinfo/main.c       |   52 ++++++++++
 profiles/deviceinfo/manager.c    |   80 ++++++++++++++++
 profiles/deviceinfo/manager.h    |   24 +++++
 11 files changed, 381 insertions(+), 380 deletions(-)
 delete mode 100644 deviceinfo/deviceinfo.c
 delete mode 100644 deviceinfo/deviceinfo.h
 delete mode 100644 deviceinfo/main.c
 delete mode 100644 deviceinfo/manager.c
 delete mode 100644 deviceinfo/manager.h
 create mode 100644 profiles/deviceinfo/deviceinfo.c
 create mode 100644 profiles/deviceinfo/deviceinfo.h
 create mode 100644 profiles/deviceinfo/main.c
 create mode 100644 profiles/deviceinfo/manager.c
 create mode 100644 profiles/deviceinfo/manager.h

diff --git a/Makefile.am b/Makefile.am
index e4874ac..d1bc65f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -216,8 +216,7 @@ builtin_sources += health/hdp_main.c health/hdp_types.h \
 endif
 
 if GATTMODULES
-builtin_modules += thermometer alert time gatt_example proximity \
-			deviceinfo
+builtin_modules += thermometer alert time gatt_example proximity deviceinfo
 builtin_sources += thermometer/main.c \
 			thermometer/manager.h thermometer/manager.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
@@ -230,9 +229,11 @@ builtin_sources += thermometer/main.c \
 			proximity/reporter.h proximity/reporter.c \
 			proximity/linkloss.h proximity/linkloss.c \
 			proximity/immalert.h proximity/immalert.c \
-			deviceinfo/main.c \
-			deviceinfo/manager.h deviceinfo/manager.c \
-			deviceinfo/deviceinfo.h deviceinfo/deviceinfo.c
+			profiles/deviceinfo/main.c \
+			profiles/deviceinfo/manager.h \
+			profiles/deviceinfo/manager.c \
+			profiles/deviceinfo/deviceinfo.h \
+			profiles/deviceinfo/deviceinfo.c
 endif
 
 
diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
deleted file mode 100644
index 4548553..0000000
--- a/deviceinfo/deviceinfo.c
+++ /dev/null
@@ -1,195 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <glib.h>
-#include <bluetooth/uuid.h>
-
-#include "adapter.h"
-#include "device.h"
-#include "gattrib.h"
-#include "attio.h"
-#include "att.h"
-#include "gattrib.h"
-#include "gatt.h"
-#include "log.h"
-#include "deviceinfo.h"
-
-#define PNP_ID_SIZE	7
-
-struct deviceinfo {
-	struct btd_device	*dev;		/* Device reference */
-	GAttrib			*attrib;	/* GATT connection */
-	guint			attioid;	/* Att watcher id */
-	struct att_range	*svc_range;	/* DeviceInfo range */
-	GSList			*chars;		/* Characteristics */
-};
-
-static GSList *servers = NULL;
-
-struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
-	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
-};
-
-static void deviceinfo_free(gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
-
-	if (d->attioid > 0)
-		btd_device_remove_attio_callback(d->dev, d->attioid);
-
-	if (d->attrib != NULL)
-		g_attrib_unref(d->attrib);
-
-	g_slist_free_full(d->chars, g_free);
-
-	btd_device_unref(d->dev);
-	g_free(d->svc_range);
-	g_free(d);
-}
-
-static gint cmp_device(gconstpointer a, gconstpointer b)
-{
-	const struct deviceinfo *d = a;
-	const struct btd_device *dev = b;
-
-	if (dev == d->dev)
-		return 0;
-
-	return -1;
-}
-
-static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct characteristic *ch = user_data;
-	uint8_t value[PNP_ID_SIZE];
-	ssize_t vlen;
-
-	if (status != 0) {
-		error("Error reading PNP_ID value: %s", att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, len, value, sizeof(value));
-	if (vlen < 0) {
-		error("Error reading PNP_ID: Protocol error");
-		return;
-	}
-
-	if (vlen < 7) {
-		error("Error reading PNP_ID: Invalid pdu length received");
-		return;
-	}
-
-	device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
-				att_get_u16(&value[3]), att_get_u16(&value[5]));
-}
-
-static void process_deviceinfo_char(struct characteristic *ch)
-{
-	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
-		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
-							read_pnpid_cb, ch);
-}
-
-static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
-	GSList *l;
-
-	if (status != 0) {
-		error("Discover deviceinfo characteristics: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	for (l = characteristics; l; l = l->next) {
-		struct gatt_char *c = l->data;
-		struct characteristic *ch;
-
-		ch = g_new0(struct characteristic, 1);
-		ch->attr.handle = c->handle;
-		ch->attr.properties = c->properties;
-		ch->attr.value_handle = c->value_handle;
-		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
-		ch->d = d;
-
-		d->chars = g_slist_append(d->chars, ch);
-
-		process_deviceinfo_char(ch);
-	}
-}
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
-
-	d->attrib = g_attrib_ref(attrib);
-
-	gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
-					NULL, configure_deviceinfo_cb, d);
-}
-
-static void attio_disconnected_cb(gpointer user_data)
-{
-	struct deviceinfo *d = user_data;
-
-	g_attrib_unref(d->attrib);
-	d->attrib = NULL;
-}
-
-int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim)
-{
-	struct deviceinfo *d;
-
-	d = g_new0(struct deviceinfo, 1);
-	d->dev = btd_device_ref(device);
-	d->svc_range = g_new0(struct att_range, 1);
-	d->svc_range->start = prim->range.start;
-	d->svc_range->end = prim->range.end;
-
-	servers = g_slist_prepend(servers, d);
-
-	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
-						attio_disconnected_cb, d);
-	return 0;
-}
-
-void deviceinfo_unregister(struct btd_device *device)
-{
-	struct deviceinfo *d;
-	GSList *l;
-
-	l = g_slist_find_custom(servers, device, cmp_device);
-	if (l == NULL)
-		return;
-
-	d = l->data;
-	servers = g_slist_remove(servers, d);
-
-	deviceinfo_free(d);
-}
diff --git a/deviceinfo/deviceinfo.h b/deviceinfo/deviceinfo.h
deleted file mode 100644
index 7a804a5..0000000
--- a/deviceinfo/deviceinfo.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim);
-void deviceinfo_unregister(struct btd_device *device);
diff --git a/deviceinfo/main.c b/deviceinfo/main.c
deleted file mode 100644
index 82ecc82..0000000
--- a/deviceinfo/main.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <glib.h>
-#include <errno.h>
-#include <stdint.h>
-
-#include "plugin.h"
-#include "manager.h"
-#include "hcid.h"
-#include "log.h"
-
-static int deviceinfo_init(void)
-{
-	if (!main_opts.gatt_enabled) {
-		error("DIS cannot start: GATT is disabled");
-		return -ENOTSUP;
-	}
-
-	return deviceinfo_manager_init();
-}
-
-static void deviceinfo_exit(void)
-{
-	deviceinfo_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(deviceinfo, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-					deviceinfo_init, deviceinfo_exit)
diff --git a/deviceinfo/manager.c b/deviceinfo/manager.c
deleted file mode 100644
index 1d59918..0000000
--- a/deviceinfo/manager.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <glib.h>
-#include <errno.h>
-#include <bluetooth/uuid.h>
-
-#include "adapter.h"
-#include "device.h"
-#include "att.h"
-#include "gattrib.h"
-#include "gatt.h"
-#include "deviceinfo.h"
-#include "manager.h"
-
-static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct gatt_primary *prim = a;
-	const char *uuid = b;
-
-	return g_strcmp0(prim->uuid, uuid);
-}
-
-static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
-{
-	struct gatt_primary *prim;
-	GSList *primaries, *l;
-
-	primaries = btd_device_get_primaries(device);
-
-	l = g_slist_find_custom(primaries, DEVICE_INFORMATION_UUID,
-							primary_uuid_cmp);
-	if (l == NULL)
-		return -EINVAL;
-
-	prim = l->data;
-
-	return deviceinfo_register(device, prim);
-}
-
-static void deviceinfo_driver_remove(struct btd_device *device)
-{
-	deviceinfo_unregister(device);
-}
-
-static struct btd_device_driver deviceinfo_device_driver = {
-	.name	= "deviceinfo-driver",
-	.uuids	= BTD_UUIDS(DEVICE_INFORMATION_UUID),
-	.probe	= deviceinfo_driver_probe,
-	.remove	= deviceinfo_driver_remove
-};
-
-int deviceinfo_manager_init(void)
-{
-	return btd_register_device_driver(&deviceinfo_device_driver);
-}
-
-void deviceinfo_manager_exit(void)
-{
-	btd_unregister_device_driver(&deviceinfo_device_driver);
-}
diff --git a/deviceinfo/manager.h b/deviceinfo/manager.h
deleted file mode 100644
index 0f742ca..0000000
--- a/deviceinfo/manager.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int deviceinfo_manager_init(void);
-void deviceinfo_manager_exit(void);
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
new file mode 100644
index 0000000..4548553
--- /dev/null
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -0,0 +1,195 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "gattrib.h"
+#include "attio.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "log.h"
+#include "deviceinfo.h"
+
+#define PNP_ID_SIZE	7
+
+struct deviceinfo {
+	struct btd_device	*dev;		/* Device reference */
+	GAttrib			*attrib;	/* GATT connection */
+	guint			attioid;	/* Att watcher id */
+	struct att_range	*svc_range;	/* DeviceInfo range */
+	GSList			*chars;		/* Characteristics */
+};
+
+static GSList *servers = NULL;
+
+struct characteristic {
+	struct gatt_char	attr;	/* Characteristic */
+	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
+};
+
+static void deviceinfo_free(gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	if (d->attioid > 0)
+		btd_device_remove_attio_callback(d->dev, d->attioid);
+
+	if (d->attrib != NULL)
+		g_attrib_unref(d->attrib);
+
+	g_slist_free_full(d->chars, g_free);
+
+	btd_device_unref(d->dev);
+	g_free(d->svc_range);
+	g_free(d);
+}
+
+static gint cmp_device(gconstpointer a, gconstpointer b)
+{
+	const struct deviceinfo *d = a;
+	const struct btd_device *dev = b;
+
+	if (dev == d->dev)
+		return 0;
+
+	return -1;
+}
+
+static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	uint8_t value[PNP_ID_SIZE];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Error reading PNP_ID value: %s", att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
+		error("Error reading PNP_ID: Protocol error");
+		return;
+	}
+
+	if (vlen < 7) {
+		error("Error reading PNP_ID: Invalid pdu length received");
+		return;
+	}
+
+	device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
+				att_get_u16(&value[3]), att_get_u16(&value[5]));
+}
+
+static void process_deviceinfo_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
+		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
+							read_pnpid_cb, ch);
+}
+
+static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
+							gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+	GSList *l;
+
+	if (status != 0) {
+		error("Discover deviceinfo characteristics: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for (l = characteristics; l; l = l->next) {
+		struct gatt_char *c = l->data;
+		struct characteristic *ch;
+
+		ch = g_new0(struct characteristic, 1);
+		ch->attr.handle = c->handle;
+		ch->attr.properties = c->properties;
+		ch->attr.value_handle = c->value_handle;
+		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
+		ch->d = d;
+
+		d->chars = g_slist_append(d->chars, ch);
+
+		process_deviceinfo_char(ch);
+	}
+}
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	d->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
+					NULL, configure_deviceinfo_cb, d);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct deviceinfo *d = user_data;
+
+	g_attrib_unref(d->attrib);
+	d->attrib = NULL;
+}
+
+int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim)
+{
+	struct deviceinfo *d;
+
+	d = g_new0(struct deviceinfo, 1);
+	d->dev = btd_device_ref(device);
+	d->svc_range = g_new0(struct att_range, 1);
+	d->svc_range->start = prim->range.start;
+	d->svc_range->end = prim->range.end;
+
+	servers = g_slist_prepend(servers, d);
+
+	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
+						attio_disconnected_cb, d);
+	return 0;
+}
+
+void deviceinfo_unregister(struct btd_device *device)
+{
+	struct deviceinfo *d;
+	GSList *l;
+
+	l = g_slist_find_custom(servers, device, cmp_device);
+	if (l == NULL)
+		return;
+
+	d = l->data;
+	servers = g_slist_remove(servers, d);
+
+	deviceinfo_free(d);
+}
diff --git a/profiles/deviceinfo/deviceinfo.h b/profiles/deviceinfo/deviceinfo.h
new file mode 100644
index 0000000..7a804a5
--- /dev/null
+++ b/profiles/deviceinfo/deviceinfo.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+int deviceinfo_register(struct btd_device *device, struct gatt_primary *prim);
+void deviceinfo_unregister(struct btd_device *device);
diff --git a/profiles/deviceinfo/main.c b/profiles/deviceinfo/main.c
new file mode 100644
index 0000000..82ecc82
--- /dev/null
+++ b/profiles/deviceinfo/main.c
@@ -0,0 +1,52 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <glib.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include "plugin.h"
+#include "manager.h"
+#include "hcid.h"
+#include "log.h"
+
+static int deviceinfo_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		error("DIS cannot start: GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return deviceinfo_manager_init();
+}
+
+static void deviceinfo_exit(void)
+{
+	deviceinfo_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(deviceinfo, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+					deviceinfo_init, deviceinfo_exit)
diff --git a/profiles/deviceinfo/manager.c b/profiles/deviceinfo/manager.c
new file mode 100644
index 0000000..1d59918
--- /dev/null
+++ b/profiles/deviceinfo/manager.c
@@ -0,0 +1,80 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+#include <glib.h>
+#include <errno.h>
+#include <bluetooth/uuid.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+#include "deviceinfo.h"
+#include "manager.h"
+
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
+static int deviceinfo_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	struct gatt_primary *prim;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
+
+	l = g_slist_find_custom(primaries, DEVICE_INFORMATION_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
+		return -EINVAL;
+
+	prim = l->data;
+
+	return deviceinfo_register(device, prim);
+}
+
+static void deviceinfo_driver_remove(struct btd_device *device)
+{
+	deviceinfo_unregister(device);
+}
+
+static struct btd_device_driver deviceinfo_device_driver = {
+	.name	= "deviceinfo-driver",
+	.uuids	= BTD_UUIDS(DEVICE_INFORMATION_UUID),
+	.probe	= deviceinfo_driver_probe,
+	.remove	= deviceinfo_driver_remove
+};
+
+int deviceinfo_manager_init(void)
+{
+	return btd_register_device_driver(&deviceinfo_device_driver);
+}
+
+void deviceinfo_manager_exit(void)
+{
+	btd_unregister_device_driver(&deviceinfo_device_driver);
+}
diff --git a/profiles/deviceinfo/manager.h b/profiles/deviceinfo/manager.h
new file mode 100644
index 0000000..0f742ca
--- /dev/null
+++ b/profiles/deviceinfo/manager.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments, Inc.
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
+int deviceinfo_manager_init(void);
+void deviceinfo_manager_exit(void);
-- 
1.7.10.2

