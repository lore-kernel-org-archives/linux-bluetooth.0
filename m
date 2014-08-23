Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 04/13] shared/gatt-client: Added initial skeleton and simple functions.
Date: Fri, 22 Aug 2014 17:47:38 -0700
Message-Id: <1408754867-13313-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces shared/gatt-client, which provides a central/client side
implementation of the Generic Attribute Profile. An instance of bt_gatt_client
will provide a central database of all GATT services, characteristics, and
descriptors that have been discovered on a peripheral and will provide API
functions to obtain information about discovered attributes, registering
handlers for "Service Changed" indications, as well as providing
reference-counted access to "Client Characteristic Configuration" descriptors.
---
 Makefile.am              |  3 +-
 src/shared/gatt-client.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h | 42 +++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/gatt-client.c
 create mode 100644 src/shared/gatt-client.h

diff --git a/Makefile.am b/Makefile.am
index 88fcb49..6aed8e2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -158,7 +158,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/shared/util.h src/shared/util.c \
 			src/shared/mgmt.h src/shared/mgmt.c \
 			src/shared/att-types.h src/shared/att.h src/shared/att.c \
-			src/shared/gatt-helpers.h src/shared/gatt-helpers.c
+			src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
+			src/shared/gatt-client.h src/shared/gatt-client.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
new file mode 100644
index 0000000..8d5c126
--- /dev/null
+++ b/src/shared/gatt-client.c
@@ -0,0 +1,79 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/util.h"
+
+struct bt_gatt_client {
+	struct bt_att *att;
+	int ref_count;
+};
+
+struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
+{
+	struct bt_gatt_client *client;
+
+	if (!att)
+		return NULL;
+
+	client = new0(struct bt_gatt_client, 1);
+	if (!client)
+		return NULL;
+
+	client->att = bt_att_ref(att);
+
+	// TODO: Initiate MTU exchange and service discovery.
+
+	return bt_gatt_client_ref(client);
+}
+
+struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
+{
+	if (!client)
+		return NULL;
+
+	__sync_fetch_and_add(&client->ref_count, 1);
+
+	return client;
+}
+
+void bt_gatt_client_unref(struct bt_gatt_client *client)
+{
+	if (!client)
+		return;
+
+	if (__sync_sub_and_fetch(&client->ref_count, 1))
+		return;
+
+	bt_att_unref(client->att);
+	free(client);
+}
+
+bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	// TODO
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
new file mode 100644
index 0000000..757db65
--- /dev/null
+++ b/src/shared/gatt-client.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+struct bt_gatt_client;
+
+struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
+
+struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
+void bt_gatt_client_unref(struct bt_gatt_client *client);
+
+typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
+typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
+							void *user_data);
+
+bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
+
-- 
2.1.0.rc2.206.gedb03e5

