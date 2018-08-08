Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andri Yngvason <andri@yngvason.is>
To: linux-bluetooth@vger.kernel.org
Cc: Andri Yngvason <andri@yngvason.is>
Subject: [PATCH BlueZ] Mesh: Add basic sensor model
Date: Wed,  8 Aug 2018 21:26:10 +0000
Message-Id: <20180808212610.21144-1-andri@yngvason.is>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an incomplete implementation of the sensor model. Only "get" and
"status" are supported.
---
 Makefile.tools            |   3 +-
 tools/mesh/sensor-model.c | 252 ++++++++++++++++++++++++++++++++++++++
 tools/mesh/sensor-model.h |  37 ++++++
 tools/meshctl.c           |   4 +
 4 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh/sensor-model.c
 create mode 100644 tools/mesh/sensor-model.h

diff --git a/Makefile.tools b/Makefile.tools
index f81fd0a4c..76e37fc0d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -308,7 +308,8 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 				tools/mesh/prov-db.h tools/mesh/prov-db.c \
 				tools/mesh/config-model.h tools/mesh/config-client.c \
 				tools/mesh/config-server.c \
-				tools/mesh/onoff-model.h tools/mesh/onoff-model.c
+				tools/mesh/onoff-model.h tools/mesh/onoff-model.c \
+				tools/mesh/sensor-model.h tools/mesh/sensor-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
diff --git a/tools/mesh/sensor-model.c b/tools/mesh/sensor-model.c
new file mode 100644
index 000000000..cbc6c7806
--- /dev/null
+++ b/tools/mesh/sensor-model.c
@@ -0,0 +1,252 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018  Andri Yngvason <andri@yngvason.is>
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
+#include <stdio.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <glib.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/sensor-model.h"
+
+static uint16_t sensor_app_idx = APP_IDX_INVALID;
+
+static int client_bind(uint16_t app_idx, int action)
+{
+	if (action == ACTION_ADD) {
+		if (sensor_app_idx != APP_IDX_INVALID)
+			return MESH_STATUS_INSUFF_RESOURCES;
+
+		sensor_app_idx = app_idx;
+		bt_shell_printf("Sensor client model: new binding %4.4x\n",
+				app_idx);
+	} else {
+		if (sensor_app_idx == app_idx)
+			sensor_app_idx = APP_IDX_INVALID;
+	}
+
+	return MESH_STATUS_SUCCESS;
+}
+
+static ssize_t decode_tlv_head(uint16_t *property_id, size_t *value_index,
+			       const void *data, size_t max_size)
+{
+	ssize_t len;
+
+	if (max_size == 0)
+		return -1;
+
+	const uint8_t *b = data;
+
+	if (b[0] & 1) {
+		if (max_size < 3)
+			return -1;
+
+		len = b[0] >> 1;
+		*property_id = b[1] | b[2] << 8;
+		*value_index = 3;
+
+	} else {
+		if (max_size < 2)
+			return -1;
+
+		len = (b[0] >> 1) & 7;
+		*property_id = b[0] >> 4 | b[1];
+		*value_index = 2;
+	}
+
+	return len;
+}
+
+/* TODO: The sensor value size, signedness and multiplier should be based on the
+ * propery id.
+ */
+static int32_t convert_sensor_value(const void *data, size_t len)
+{
+	const uint8_t *b = data;
+
+	switch (len) {
+	case 1: return (int8_t)b[0];
+	case 2: return (int16_t)(b[0] | b[1] << 8);
+	case 4: return (int32_t)(b[0] | b[1] << 8 | b[2] << 16 | b[3] << 24);
+	}
+
+	return 0;
+}
+
+static void interpret_sensor_status(const void *data, size_t size)
+{
+	ssize_t len;
+	size_t i;
+	size_t value_index = 0;
+
+	const uint8_t *b = data;
+
+	for (i = 0; i < size; i += len + value_index) {
+		uint16_t property_id = 0;
+
+		len = decode_tlv_head(&property_id, &value_index, &b[i],
+				      size - i);
+		if (len < 0)
+			return;
+
+		const char *property_name = bt_uuid16_to_str(property_id);
+		int32_t value = convert_sensor_value(&b[i + value_index], len);
+
+		if (property_name)
+			bt_shell_printf("%s: %" PRIi32 "\n", property_name,
+					value);
+		else
+			bt_shell_printf("%x: %" PRIi32 "\n", property_id,
+					value);
+	}
+}
+
+static bool client_msg_received(uint16_t src, uint8_t *data, uint16_t len,
+				void *userdata)
+{
+	uint32_t opcode;
+	int n;
+
+	if (!mesh_opcode_get(data, len, &opcode, &n))
+		return false;
+
+	len -= n;
+	data += n;
+
+	bt_shell_printf("Sensor Model Message received (%d) opcode %x\n",
+			len, opcode);
+
+	print_byte_array("\t", data, len);
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+	case OP_SENSOR_STATUS:
+		bt_shell_printf("Node %4.4x:\n", src);
+		interpret_sensor_status(data, len);
+		break;
+	}
+
+	return true;
+}
+
+static uint32_t target;
+
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	uint8_t ttl;
+
+	if (!node)
+		return false;
+
+	ttl = node_get_default_ttl(node);
+
+	return net_access_layer_send(ttl, node_get_primary(node),
+				     target, sensor_app_idx, buf, len);
+}
+
+static void cmd_set_node(int argc, char *argv[])
+{
+	uint32_t dst;
+	char *end;
+
+	dst = strtol(argv[1], &end, 16);
+	if (end != (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: expected format 4 digit hex\n",
+				argv[1]);
+		target = UNASSIGNED_ADDRESS;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
+		bt_shell_printf("Controlling sensor for node %4.4x\n", dst);
+		target = dst;
+		set_menu_prompt("sensor", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+}
+
+/* TODO: Requesting a specific profile id is not supported.
+ */
+static void cmd_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	node = node_find_by_addr(target);
+
+	if (!node)
+		return;
+
+	n = mesh_opcode_set(OP_SENSOR_GET, msg);
+
+	if (!send_cmd(msg, n)) {
+		bt_shell_printf("Failed to send \"SENSOR GET\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu sensor_menu = {
+	.name = "sensor",
+	.desc = "Sensor Model Submenu",
+	.entries = {
+		{ "target", "<unicast>", cmd_set_node, "Set node to configure" },
+		{ "get", NULL, cmd_get, "Get sensor status" },
+		{ }
+	},
+};
+
+static struct mesh_model_ops client_cbs = {
+	client_msg_received,
+	client_bind,
+	NULL,
+	NULL,
+};
+
+bool sensor_client_init(uint8_t element)
+{
+	if (!node_local_model_register(element, SENSOR_CLIENT_MODEL_ID,
+				       &client_cbs, NULL))
+		return false;
+
+	bt_shell_add_submenu(&sensor_menu);
+
+	return true;
+}
diff --git a/tools/mesh/sensor-model.h b/tools/mesh/sensor-model.h
new file mode 100644
index 000000000..984dcdc43
--- /dev/null
+++ b/tools/mesh/sensor-model.h
@@ -0,0 +1,37 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Andri Yngvason <andri@yngvason.is>
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
+#define SENSOR_SERVER_MODEL_ID 0x1100
+#define SENSOR_CLIENT_MODEL_ID 0x1102
+
+#define OP_SENSOR_DESCRIPTOR_GET 0x8230
+#define OP_SENSOR_DESCRIPTOR_STATUS 0x51
+#define OP_SENSOR_GET 0x8231
+#define OP_SENSOR_STATUS 0x52
+#define OP_SENSOR_COLUMN_GET 0x8232
+#define OP_SENSOR_COLUMN_STATUS 0x53
+#define OP_SENSOR_SERIES_GET 0x8233
+#define OP_SENSOR_SERIES_STATUS 0x54
+
+void sensor_set_node(const char *args);
+bool sensor_client_init(uint8_t element);
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 3e1484f61..08bba9a13 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -58,6 +58,7 @@
 #include "mesh/prov-db.h"
 #include "mesh/config-model.h"
 #include "mesh/onoff-model.h"
+#include "mesh/sensor-model.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -1990,6 +1991,9 @@ int main(int argc, char *argv[])
 	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic On/Off client\n");
 
+	if (!sensor_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh sensor client\n");
+
 	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
-- 
2.18.0

