Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 01/12] Add ATT connection callback registration
Date: Tue,  5 Jul 2011 10:55:57 -0300
Message-Id: <1309874168-32716-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function intends to be used by profiles to inform that a connection
is required and the callback that needs to be called when the it is
established. New header is required to avoid non GATT based profiles
including GAttrib header.
---
 Makefile.am  |    2 +-
 src/attio.h  |   29 +++++++++++++++++++++++++++++
 src/device.c |   30 +++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 src/attio.h

diff --git a/Makefile.am b/Makefile.am
index fab05eb..3b0dff9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -257,7 +257,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/error.h src/error.c \
 			src/manager.h src/manager.c \
 			src/adapter.h src/adapter.c \
-			src/device.h src/device.c \
+			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c \
 			src/oob.h src/oob.c src/eir.h src/eir.c
diff --git a/src/attio.h b/src/attio.h
new file mode 100644
index 0000000..fad8516
--- /dev/null
+++ b/src/attio.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+typedef void (*attio_connect_cb) (GAttrib *attrib, gpointer user_data);
+
+guint btd_device_add_attio_callback(struct btd_device *device,
+						attio_connect_cb func,
+						gpointer user_data);
diff --git a/src/device.c b/src/device.c
index 82759a4..b0d9c30 100644
--- a/src/device.c
+++ b/src/device.c
@@ -49,12 +49,13 @@
 #include "att.h"
 #include "hcid.h"
 #include "adapter.h"
+#include "gattrib.h"
+#include "attio.h"
 #include "device.h"
 #include "dbus-common.h"
 #include "event.h"
 #include "error.h"
 #include "glib-helper.h"
-#include "gattrib.h"
 #include "gatt.h"
 #include "agent.h"
 #include "sdp-xml.h"
@@ -104,6 +105,12 @@ struct browse_req {
 	guint listener_id;
 };
 
+struct attio_data {
+	guint id;
+	attio_connect_cb func;
+	gpointer user_data;
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	device_type_t	type;
@@ -124,6 +131,7 @@ struct btd_device {
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
 	GSList		*disconnects;		/* disconnects message */
+	GSList		*attios;
 
 	gboolean	connected;
 
@@ -200,6 +208,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->services, g_free);
 	g_slist_free_full(device->uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
+	g_slist_free_full(device->attios, g_free);
 
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
@@ -2441,3 +2450,22 @@ void device_set_class(struct btd_device *device, uint32_t value)
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
 				DBUS_TYPE_UINT32, &value);
 }
+
+guint btd_device_add_attio_callback(struct btd_device *device,
+						attio_connect_cb func,
+						gpointer user_data)
+{
+	struct attio_data *attio;
+	static guint attio_id = 0;
+
+	DBG("%p registered ATT connection callback", device);
+
+	attio = g_new0(struct attio_data, 1);
+	attio->id = ++attio_id;
+	attio->func = func;
+	attio->user_data = user_data;
+
+	device->attios = g_slist_append(device->attios, attio);
+
+	return attio->id;
+}
-- 
1.7.6

