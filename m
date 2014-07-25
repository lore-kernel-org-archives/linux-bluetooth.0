Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
Date: Fri, 25 Jul 2014 15:08:33 -0700
Message-Id: <1406326123-10564-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1406326123-10564-1-git-send-email-armansito@chromium.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the skeleton for src/shared/gatt-helpers, which defines
helper functions for over-the-air GATT client-side procedures that will be
frequently used by clients. Most of these functions require several sequential
ATT protocol requests and it is useful to abstract these details away from the
upper layer.
---
 Makefile.am               |   3 +-
 src/shared/gatt-helpers.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h | 127 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/gatt-helpers.c
 create mode 100644 src/shared/gatt-helpers.h

diff --git a/Makefile.am b/Makefile.am
index c73e23a..88fcb49 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -157,7 +157,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/shared/queue.h src/shared/queue.c \
 			src/shared/util.h src/shared/util.c \
 			src/shared/mgmt.h src/shared/mgmt.c \
-			src/shared/att-types.h src/shared/att.h src/shared/att.c
+			src/shared/att-types.h src/shared/att.h src/shared/att.c \
+			src/shared/gatt-helpers.h src/shared/gatt-helpers.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
new file mode 100644
index 0000000..a119de6
--- /dev/null
+++ b/src/shared/gatt-helpers.c
@@ -0,0 +1,141 @@
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
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "lib/uuid.h"
+#include "src/shared/gatt-helpers.h"
+
+bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
+					bt_gatt_result_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_discover_primary_services(struct bt_att *att,
+					bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_discover_included_services(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_discover_characteristics(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_discover_descriptors(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
+					bt_gatt_read_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_read_long_value(struct bt_att *att,
+					uint16_t value_handle, uint16_t offset,
+					bt_gatt_read_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_write_without_response(struct bt_att *att,
+					uint16_t value_handle,
+                                        bool signed_write,
+					uint8_t *value, uint16_t length)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
+					uint8_t *value, uint16_t length,
+					bt_gatt_result_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
+					uint16_t value_handle, uint16_t offset,
+					uint8_t *value, uint16_t length,
+					bt_gatt_write_long_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
+
+unsigned int bt_gatt_register(struct bt_att *att, bool indications,
+					bt_gatt_notify_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	/* TODO */
+	return false;
+}
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
new file mode 100644
index 0000000..d3a95ae
--- /dev/null
+++ b/src/shared/gatt-helpers.h
@@ -0,0 +1,127 @@
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
+/* This file defines helpers for performing client-side procedures defined by
+ * the Generic Attribute Profile.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+struct bt_gatt_service {
+	uint16_t start;
+	uint16_t end;
+	uint8_t uuid[16];
+};
+
+struct bt_gatt_characteristic {
+	uint16_t start;
+	uint16_t end;
+	uint16_t value;
+	uint8_t properties;
+	uint8_t uuid[16];
+};
+
+struct bt_gatt_descriptor {
+	uint16_t handle;
+	uint8_t uuid[16];
+};
+
+struct bt_gatt_list;
+
+struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *l);
+void *bt_gatt_list_get_data(struct bt_gatt_list *l);
+
+typedef void (*bt_gatt_destroy_func_t)(void *user_data);
+
+typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
+							void *user_data);
+typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
+						struct bt_gatt_list *results,
+						void *user_data);
+typedef void (*bt_gatt_read_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
+typedef void (*bt_gatt_write_long_callback_t)(bool success, bool reliable_error,
+					uint8_t att_ecode, void *user_data);
+
+typedef void (*bt_gatt_notify_callback_t)(uint16_t value_handle,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
+
+bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
+					bt_gatt_result_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+
+bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_discover_included_services(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_discover_characteristics(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_discover_descriptors(struct bt_att *att,
+					uint16_t start, uint16_t end,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+
+bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
+					bt_gatt_read_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_read_long_value(struct bt_att *att,
+					uint16_t value_handle, uint16_t offset,
+					bt_gatt_read_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+
+bool bt_gatt_write_without_response(struct bt_att *att, uint16_t value_handle,
+					bool signed_write,
+					uint8_t *value, uint16_t length);
+bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
+					uint8_t *value, uint16_t length,
+					bt_gatt_result_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
+					uint16_t value_handle, uint16_t offset,
+					uint8_t *value, uint16_t length,
+					bt_gatt_write_long_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
+
+unsigned int bt_gatt_register(struct bt_att *att, bool indications,
+					bt_gatt_notify_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
-- 
2.0.0.526.g5318336

