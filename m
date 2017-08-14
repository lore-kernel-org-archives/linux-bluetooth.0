Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH 4/5] mesh: Baseline Mesh implementation
Date: Mon, 14 Aug 2017 12:01:18 -0700
Message-Id: <20170814190119.8684-5-brian.gix@intel.com>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
References: <20170814190119.8684-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/agent.c         |  276 ++++++
 mesh/config-client.c |  667 +++++++++++++++
 mesh/config-server.c |  165 ++++
 mesh/crypto.c        | 1168 ++++++++++++++++++++++++++
 mesh/gatt.c          |  609 ++++++++++++++
 mesh/main.c          | 2269 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/net.c           | 2184 ++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/node.c          |  879 +++++++++++++++++++
 mesh/onoff-model.c   |  306 +++++++
 mesh/prov-db.c       | 1599 +++++++++++++++++++++++++++++++++++
 mesh/prov.c          |  664 +++++++++++++++
 mesh/util.c          |  369 ++++++++
 12 files changed, 11155 insertions(+)
 create mode 100644 mesh/agent.c
 create mode 100644 mesh/config-client.c
 create mode 100644 mesh/config-server.c
 create mode 100644 mesh/crypto.c
 create mode 100644 mesh/gatt.c
 create mode 100644 mesh/main.c
 create mode 100644 mesh/net.c
 create mode 100644 mesh/node.c
 create mode 100644 mesh/onoff-model.c
 create mode 100644 mesh/prov-db.c
 create mode 100644 mesh/prov.c
 create mode 100644 mesh/util.c

diff --git a/mesh/agent.c b/mesh/agent.c
new file mode 100644
index 0000000..0944862
--- /dev/null
+++ b/mesh/agent.c
@@ -0,0 +1,276 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <readline/readline.h>
+
+#include <glib.h>
+
+#include <lib/bluetooth.h>
+#include "client/display.h"
+#include "util.h"
+#include "agent.h"
+
+#define AGENT_PROMPT	COLOR_RED "[agent]" COLOR_OFF " "
+
+static char *agent_saved_prompt = NULL;
+static int agent_saved_point = 0;
+
+struct input_request {
+	oob_type_t type;
+	uint16_t len;
+	agent_input_cb cb;
+	void *user_data;
+};
+
+static struct input_request pending_request = {NONE, 0, NULL, NULL};
+
+static void agent_prompt(const char *msg)
+{
+	char *prompt;
+
+	/* Normal use should not prompt for user input to the agent a second
+	 * time before it releases the prompt, but we take a safe action. */
+	if (agent_saved_prompt)
+		return;
+
+	agent_saved_point = rl_point;
+	agent_saved_prompt = g_strdup(rl_prompt);
+
+	rl_set_prompt("");
+	rl_redisplay();
+
+	prompt = g_strdup_printf(AGENT_PROMPT "%s", msg);
+	rl_set_prompt(prompt);
+	g_free(prompt);
+
+	rl_replace_line("", 0);
+	rl_redisplay();
+}
+
+static void agent_release_prompt(void)
+{
+	if (!agent_saved_prompt)
+		return;
+
+	/* This will cause rl_expand_prompt to re-run over the last prompt, but
+	 * our prompt doesn't expand anyway. */
+	rl_set_prompt(agent_saved_prompt);
+	rl_replace_line("", 0);
+	rl_point = agent_saved_point;
+	rl_redisplay();
+
+	g_free(agent_saved_prompt);
+	agent_saved_prompt = NULL;
+}
+
+bool agent_completion(void)
+{
+	if (pending_request.type == NONE)
+		return false;
+
+	return true;
+}
+
+static bool response_hexadecimal(const char *input)
+{
+	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
+
+	if (!str2hex(input, strlen(input), buf, pending_request.len) ) {
+		rl_printf("Incorrect input: expecting %d hex octets\n",
+			  pending_request.len);
+		return false;
+	}
+
+	if (pending_request.cb)
+		pending_request.cb(HEXADECIMAL, buf, pending_request.len,
+					pending_request.user_data);
+	return true;
+}
+
+static bool response_decimal(const char *input)
+{
+	uint8_t buf[DECIMAL_OOB_LEN];
+
+	if (strlen(input) > pending_request.len)
+		return false;
+
+	bt_put_be32(atoi(input), buf);
+
+	if (pending_request.cb)
+		pending_request.cb(DECIMAL, buf, DECIMAL_OOB_LEN,
+					pending_request.user_data);
+
+	return true;
+}
+
+static void response_ascii(const char *input)
+{
+	if (pending_request.cb)
+		pending_request.cb(ASCII, (uint8_t *) input, strlen(input),
+					pending_request.user_data);
+}
+
+bool agent_input(const char *input)
+{
+	bool repeat = false;
+
+	if (pending_request.type == NONE)
+		return false;
+
+	switch (pending_request.type) {
+	case HEXADECIMAL:
+		if (!response_hexadecimal(input))
+			repeat = true;
+		break;
+	case DECIMAL:
+		if (!response_decimal(input))
+			repeat = true;
+		break;
+	case ASCII:
+		response_ascii(input);
+		break;
+	case OUTPUT:
+		repeat = true;
+	case NONE:
+	default:
+		break;
+	};
+
+	if (!repeat) {
+		pending_request.type = NONE;
+		pending_request.len = 0;
+		pending_request.cb = NULL;
+		pending_request.user_data = NULL;
+
+		agent_release_prompt();
+	}
+
+	return true;
+}
+
+void agent_release(void)
+{
+	agent_release_prompt();
+}
+
+static bool request_hexadecimal(uint16_t len)
+{
+	if (len > MAX_HEXADECIMAL_OOB_LEN)
+		return false;
+
+	rl_printf("Request hexadecimal key (hex %d octets)\n", len);
+	agent_prompt("Enter key (hex number): ");
+
+	return true;
+}
+
+static uint32_t power_ten(uint8_t power)
+{
+	uint32_t ret = 1;
+
+	while (power--)
+		ret *= 10;
+
+	return ret;
+}
+
+static bool request_decimal(uint16_t len)
+{
+	rl_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
+	agent_prompt("Enter Numeric key: ");
+
+	return true;
+}
+
+static bool request_ascii(uint16_t len)
+{
+	if (len != MAX_ASCII_OOB_LEN)
+		return false;
+
+	rl_printf("Request ASCII key (max characters %d)\n", len);
+	agent_prompt("Enter key (ascii string): ");
+
+	return true;
+}
+
+bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
+				void *user_data)
+{
+	bool result;
+
+	if (pending_request.type != NONE)
+		return FALSE;
+
+	switch (type) {
+	case HEXADECIMAL:
+		result = request_hexadecimal(max_len);
+		break;
+	case DECIMAL:
+		result = request_decimal(max_len);
+		break;
+	case ASCII:
+		result = request_ascii(max_len);
+		break;
+	case NONE:
+	case OUTPUT:
+	default:
+		return false;
+	};
+
+	if (result) {
+		pending_request.type = type;
+		pending_request.len = max_len;
+		pending_request.cb = cb;
+		pending_request.user_data = user_data;
+
+		return true;
+	}
+
+	return false;
+}
+
+bool agent_output_request(const char* str)
+{
+	if (pending_request.type != NONE)
+		return false;
+
+	pending_request.type = OUTPUT;
+	agent_prompt(str);
+	return true;
+}
+
+void agent_output_request_cancel(void)
+{
+	if (pending_request.type != OUTPUT)
+		return;
+	pending_request.type = NONE;
+	agent_release_prompt();
+}
diff --git a/mesh/config-client.c b/mesh/config-client.c
new file mode 100644
index 0000000..a0f6eee
--- /dev/null
+++ b/mesh/config-client.c
@@ -0,0 +1,667 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "client/display.h"
+#include "mesh-net.h"
+#include "keys.h"
+#include "net.h"
+#include "node.h"
+#include "prov-db.h"
+#include "util.h"
+#include "config-model.h"
+
+#define MIN_COMPOSITION_LEN 16
+
+static bool client_msg_recvd(uint16_t src, uint8_t *data,
+				uint16_t len, void *user_data)
+{
+	uint32_t opcode;
+	struct mesh_node *node;
+	uint16_t app_idx, net_idx, addr;
+	uint32_t mod_id;
+	uint16_t primary;
+	uint16_t ele_addr;
+	uint8_t ele_idx;
+	struct mesh_publication pub;
+	int n;
+
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+
+	if (IS_UNICAST(src)) {
+		node = node_find_by_addr(src);
+	} else
+		node = NULL;
+
+	if (!node)
+		return false;
+
+	primary = node_get_primary(node);
+	if (primary != src)
+		return false;
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+	case OP_DEV_COMP_STATUS:
+		if (len < MIN_COMPOSITION_LEN || !node)
+			break;
+		if (node_parse_composition(node, data, len)) {
+			if (!prov_db_add_node_composition(node, data, len))
+				break;
+		}
+
+		if (node_get_composition(node))
+			prov_db_print_node_composition(node);
+		break;
+
+	case OP_APPKEY_STATUS:
+		if (len != 4)
+			break;
+
+		rl_printf("Node %4.4x AppKey Status %s\n", src,
+						mesh_status_str(data[0]));
+		net_idx = get_le16(data + 1) & 0xfff;
+		app_idx = get_le16(data + 2) >> 4;
+
+		rl_printf("\tNetKey %3.3x, AppKey %3.3x\n", net_idx, app_idx);
+
+		if (data[0] != MESH_STATUS_SUCCESS &&
+				data[0] != MESH_STATUS_IDX_ALREADY_STORED &&
+				node_app_key_delete(node, net_idx, app_idx))
+			prov_db_node_keys(node, node_get_app_keys(node),
+								"appKeys");
+		break;
+
+	case OP_NETKEY_STATUS:
+		if (len != 3)
+			break;
+
+		rl_printf("Node %4.4x NetKey Status %s\n", src,
+						mesh_status_str(data[0]));
+		net_idx = get_le16(data + 1) & 0xfff;
+
+		rl_printf("\tNetKey %3.3x\n", net_idx);
+
+		if (data[0] != MESH_STATUS_SUCCESS &&
+				data[0] != MESH_STATUS_IDX_ALREADY_STORED &&
+					node_net_key_delete(node, net_idx))
+			prov_db_node_keys(node, node_get_net_keys(node),
+								"netKeys");
+		break;
+
+	case OP_MODEL_APP_STATUS:
+		if (len != 7 && len != 9)
+			break;
+
+		rl_printf("Node %4.4x Model App Status %s\n", src,
+						mesh_status_str(data[0]));
+		addr = get_le16(data + 1);
+		app_idx = get_le16(data + 3);
+
+		rl_printf("\tElement %4.4x AppIdx %3.3x\n ", addr, app_idx);
+
+		if (len == 7) {
+			mod_id = get_le16(data + 5);
+			rl_printf("ModelId %4.4x\n", mod_id);
+			mod_id = 0xffff0000 | mod_id;
+		} else {
+			mod_id = get_le16(data + 7);
+			rl_printf("ModelId %4.4x %4.4x\n", get_le16(data + 5),
+									mod_id);
+			mod_id = get_le16(data + 5) << 16 | mod_id;
+		}
+
+		if (data[0] == MESH_STATUS_SUCCESS &&
+			node_add_binding(node, addr - src, mod_id, app_idx))
+			prov_db_add_binding(node, addr - src, mod_id, app_idx);
+		break;
+
+	case OP_CONFIG_DEFAULT_TTL_STATUS:
+		if (len != 1)
+			return true;
+		rl_printf("Node %4.4x Default TTL %d\n", src, data[0]);
+		if (node_set_default_ttl (node, data[0]))
+			prov_db_node_set_ttl(node, data[0]);
+		break;
+
+	case OP_CONFIG_MODEL_PUB_STATUS:
+		if (len != 12 && len != 14)
+			return true;
+
+		rl_printf("\nSet publication for node %4.4x status: %s\n", src,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		ele_addr = get_le16(data + 1);
+		mod_id = get_le16(data + 10);
+		if (len == 14)
+			mod_id = (mod_id << 16)  | get_le16(data + 12);
+		else
+			mod_id |= 0xffff0000;
+
+		pub.u.addr16 = get_le16(data + 3);
+		pub.app_idx = get_le16(data + 5);
+		pub.ttl = data[7];
+		pub.period = data[8];
+		n = (data[8] & 0x3f);
+		switch (data[8] >> 6) {
+		case 0:
+			rl_printf("Period: %d ms\n", n * 100);
+			break;
+		case 2:
+			n *= 10;
+			/* fall through */
+		case 1:
+			rl_printf("Period: %d sec\n", n);
+			break;
+		case 3:
+			rl_printf("Period: %d min\n", n * 10);
+			break;
+		}
+
+		pub.retransmit = data[9];
+		rl_printf("Retransmit count: %d\n", data[9] >> 5);
+		rl_printf("Retransmit Interval Steps: %d\n", data[9] & 0x1f);
+
+		ele_idx = ele_addr - node_get_primary(node);
+
+		/* Local configuration is saved by server */
+		if (node == node_get_local_node())
+			break;
+
+		if (node_model_pub_set(node, ele_idx, mod_id, &pub))
+			prov_db_node_set_model_pub(node, ele_idx, mod_id,
+				     node_model_pub_get(node, ele_idx, mod_id));
+		break;
+	}
+	return true;
+}
+
+static uint32_t target;
+static uint32_t parms[8];
+
+static uint32_t read_input_parameters(const char *args)
+{
+	uint32_t i;
+
+	if (!args)
+		return 0;
+
+	memset(parms, 0xff, sizeof(parms));
+
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]); i++) {
+		int n;
+
+		sscanf(args, "%x", &parms[i]);
+		if (parms[i] == 0xffffffff)
+			break;
+
+		n = strcspn(args, " \t");
+		args = args + n + strspn(args + n, " \t");
+	}
+
+	return i;
+}
+
+static void cmd_set_node(const char *args)
+{
+	uint32_t dst;
+	char *end;
+
+	dst = strtol(args, &end, 16);
+	if (end != (args + 4)) {
+		rl_printf("Bad unicast address %s: "
+					"expected format 4 digit hex\n", args);
+		target = UNASSIGNED_ADDRESS;
+	} else {
+		rl_printf("Configuring node %4.4x\n", dst);
+		target = dst;
+		set_menu_prompt("config", args);
+	}
+
+}
+
+static bool config_send(uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	uint16_t primary;
+
+	if(!node)
+		return false;
+
+	primary = node_get_primary(node);
+	if (target != primary)
+		return net_access_layer_send(DEFAULT_TTL, primary,
+						target, APP_IDX_DEV, buf, len);
+
+	node_local_data_handler(primary, target, node_get_iv_index(node),
+				node_get_sequence_number(node), APP_IDX_DEV,
+				buf, len);
+	return true;
+
+}
+
+static void cmd_get_composition(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	node = node_find_by_addr(target);
+
+	if (!node)
+		return;
+
+	n = mesh_opcode_set(OP_DEV_COMP_GET, msg);
+
+	/* By default, use page 0 */
+	msg[n++] = (read_input_parameters(args) == 1) ? parms[0] : 0;
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send \"GET NODE COMPOSITION\"\n");
+}
+
+static void cmd_net_key(const char *args, uint32_t opcode)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	uint16_t net_idx;
+	uint8_t *key;
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(opcode, msg);
+
+	if (read_input_parameters(args) != 1) {
+		rl_printf("Bad arguments %s\n", args);
+		return;
+	}
+
+	node = node_find_by_addr(target);
+	if (!node) {
+		rl_printf("Node %4.4x\n not found", target);
+		return;
+	}
+
+	net_idx = parms[0];
+
+	if (opcode != OP_NETKEY_DELETE) {
+
+		key = keys_net_key_get(net_idx, true);
+		if (!key) {
+			rl_printf("Network key with index %4.4x not found\n",
+								net_idx);
+			return;
+		}
+
+		put_le16(net_idx, &msg[n]);
+		n += 2;
+
+		memcpy(msg + n, key, 16);
+		n += 16;
+	}
+
+	if (!config_send(msg, n)) {
+		rl_printf("Failed to send \"%s NET KEY\"\n",
+				opcode == OP_NETKEY_ADD ? "ADD" : "DEL");
+		return;
+	}
+
+	if (opcode != OP_NETKEY_DELETE) {
+		if (node_net_key_add(node, net_idx))
+			prov_db_node_keys(node, node_get_net_keys(node),
+								"netKeys");
+	} else {
+		if (node_net_key_delete(node, net_idx))
+			prov_db_node_keys(node, node_get_net_keys(node),
+								"netKeys");
+	}
+
+}
+
+static void cmd_add_net_key(const char *args)
+{
+	cmd_net_key(args, OP_NETKEY_ADD);
+}
+
+static void cmd_del_net_key(const char *args)
+{
+	cmd_net_key(args, OP_NETKEY_DELETE);
+}
+
+static void cmd_app_key(const char *args, uint32_t opcode)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	uint16_t net_idx;
+	uint16_t app_idx;
+	uint8_t *key;
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	if (read_input_parameters(args) != 1) {
+		rl_printf("Bad arguments %s\n", args);
+		return;
+	}
+
+	node = node_find_by_addr(target);
+	if (!node) {
+		rl_printf("Node %4.4x\n not found", target);
+		return;
+	}
+
+	n = mesh_opcode_set(opcode, msg);
+
+	app_idx = parms[0];
+	net_idx = keys_app_key_get_bound(app_idx);
+	if (net_idx == NET_IDX_INVALID) {
+		rl_printf("App key with index %4.4x not found\n", app_idx);
+		return;
+	}
+
+	msg[n++] = net_idx & 0xf;
+	msg[n++] = ((net_idx >> 8) & 0xf) |
+		((app_idx << 4) & 0xf0);
+	msg[n++] = app_idx >> 4;
+
+	if (opcode != OP_APPKEY_DELETE) {
+		key = keys_app_key_get(app_idx, true);
+		if (!key) {
+			rl_printf("App key %4.4x not found\n", net_idx);
+			return;
+		}
+
+		memcpy(msg + n, key, 16);
+		n += 16;
+	}
+
+	if (!config_send(msg, n)) {
+		rl_printf("Failed to send \"ADD %s KEY\"\n",
+				opcode == OP_APPKEY_ADD ? "ADD" : "DEL");
+		return;
+	}
+
+	if (opcode != OP_APPKEY_DELETE) {
+		if (node_app_key_add(node, app_idx))
+			prov_db_node_keys(node, node_get_app_keys(node),
+								"appKeys");
+	} else {
+		if (node_app_key_delete(node, net_idx, app_idx))
+			prov_db_node_keys(node, node_get_app_keys(node),
+								"appKeys");
+	}
+}
+
+static void cmd_add_app_key(const char *args)
+{
+	cmd_app_key(args, OP_APPKEY_ADD);
+}
+
+static void cmd_del_app_key(const char *args)
+{
+	cmd_app_key(args, OP_APPKEY_DELETE);
+}
+
+static void cmd_bind(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	parm_cnt = read_input_parameters(args);
+	if (parm_cnt != 3 && parm_cnt != 4) {
+		rl_printf("Bad arguments %s\n", args);
+		return;
+	}
+
+	n = mesh_opcode_set(OP_MODEL_APP_BIND, msg);
+
+	put_le16(target + parms[0], msg + n);
+	n += 2;
+	put_le16(parms[1], msg + n);
+	n += 2;
+	if (parm_cnt == 4) {
+		put_le16(parms[3], msg + n);
+		put_le16(parms[2], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[2], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send \"MODEL APP BIND\"\n");
+}
+
+static void cmd_set_ttl(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+	uint8_t ttl;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_DEFAULT_TTL_SET, msg);
+
+	parm_cnt = read_input_parameters(args);
+	if (parm_cnt) {
+		ttl = parms[0] & TTL_MASK;
+	} else
+		ttl = node_get_default_ttl(node_get_local_node());
+
+	msg[n++] = ttl;
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send \"SET_DEFAULT TTL\"\n");
+}
+
+static void cmd_set_pub(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
+
+	parm_cnt = read_input_parameters(args);
+	if (parm_cnt != 5) {
+		rl_printf("Bad arguments: %s\n", args);
+		return;
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Publish address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* App key index + credential (set to 0) */
+	put_le16(parms[2], msg + n);
+	n += 2;
+	/* TTL */
+	msg[n++] = DEFAULT_TTL;
+	/* Publish period  step count and step resolution */
+	msg[n++] = parms[3];
+	/* Publish retransmit count & interval steps */
+	msg[n++] = (1 << 5) + 2;
+	/* Model Id */
+	if (parms[4] > 0xffff) {
+		put_le16(parms[4] >> 16, msg + n);
+		put_le16(parms[4], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[4], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
+}
+
+static void cmd_default(uint32_t opcode)
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(opcode, msg);
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send command (opcode 0x%x)\n", opcode);
+}
+
+static void cmd_get_ttl(const char *args)
+{
+	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
+}
+
+static void cmd_back(const char *args)
+{
+	cmd_menu_main(false);
+}
+
+static void cmd_help(const char *args);
+
+static const struct menu_entry cfg_menu[] = {
+	{"target",		"<unicast>",			cmd_set_node,
+						"Set target node to configure"},
+	{"get-composition",	"[<page_num>]",		cmd_get_composition,
+						"Get Composition Data"},
+	{"add-netkey",		"<net_idx>",			cmd_add_net_key,
+						"Add network key"},
+	{"del-netkey",		"<net_idx>",			cmd_del_net_key,
+						"Delete network key"},
+	{"add-appkey",		"<app_idx>",			cmd_add_app_key,
+						"Add application key"},
+	{"del-appkey",		"<app_idx>",			cmd_del_app_key,
+						"Delete application key"},
+	{"bind",		"<ele_idx> <app_idx> <mod_id> [cid]",
+				cmd_bind,	"Bind app key to a model"},
+	{"set-ttl",		"<ttl>",			cmd_set_ttl,
+						"Set default TTL"},
+	{"get-ttl",		NULL,			cmd_get_ttl,
+						"Get default TTL"},
+	{"set-pub", "<ele_addr> <pub_addr> <app_idx> "
+						"<period (step|res)> <model>",
+				cmd_set_pub,	"Set publication"},
+	{"back",		NULL,				cmd_back,
+						"Back to main menu"},
+	{"help",		NULL,				cmd_help,
+						"Config Commands"},
+	{}
+};
+
+static void cmd_help(const char *args)
+{
+	rl_printf("Client Configuration Menu\n");
+	print_cmd_menu(cfg_menu);
+}
+
+void config_set_node(const char *args)
+{
+	cmd_set_node(args);
+}
+
+void config_client_get_composition(uint32_t dst)
+{
+	uint32_t tmp = target;
+
+	target = dst;
+	cmd_get_composition("");
+	target = tmp;
+}
+
+static struct mesh_model_ops client_cbs = {
+	client_msg_recvd,
+		NULL,
+		NULL,
+		NULL
+};
+
+bool config_client_init(void)
+{
+	if (!node_local_model_register(PRIMARY_ELEMENT_IDX,
+						CONFIG_CLIENT_MODEL_ID,
+						&client_cbs, NULL))
+		return false;
+
+	add_cmd_menu("configure", cfg_menu);
+
+	return true;
+}
diff --git a/mesh/config-server.c b/mesh/config-server.c
new file mode 100644
index 0000000..14e5d7b
--- /dev/null
+++ b/mesh/config-server.c
@@ -0,0 +1,165 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "client/display.h"
+#include "mesh-net.h"
+#include "keys.h"
+#include "net.h"
+#include "node.h"
+#include "prov-db.h"
+#include "util.h"
+#include "config-model.h"
+
+static bool server_msg_recvd(uint16_t src, uint8_t *data,
+				uint16_t len, void *user_data)
+{
+	uint32_t opcode;
+	uint8_t msg[32];
+	struct mesh_node *node;
+	uint16_t primary;
+	uint32_t mod_id;
+	uint16_t ele_addr;
+	uint8_t ele_idx;
+	struct mesh_publication pub;
+
+	int n;
+
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+
+	node = node_get_local_node();
+
+	if (!node)
+		return true;
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+	case OP_CONFIG_DEFAULT_TTL_SET:
+		if (len != 1 || data[0] > TTL_MASK || data[0] == 1)
+			return true;
+
+		if (data[0] <= TTL_MASK) {
+			node_set_default_ttl(node, data[0]);
+			prov_db_node_set_ttl(node, data[0]);
+		}
+
+		/* Fall Through */
+
+	case OP_CONFIG_DEFAULT_TTL_GET:
+		n = mesh_opcode_set(OP_CONFIG_DEFAULT_TTL_STATUS, msg);
+		msg[n++] = node_get_default_ttl(node);
+		break;
+
+	case OP_CONFIG_MODEL_PUB_SET:
+		if (len != 11 && len != 13)
+			return true;
+
+		rl_printf("Set publication\n");
+
+		ele_addr = get_le16(data);
+		mod_id = get_le16(data + 9);
+		if (len == 14)
+			mod_id = (mod_id << 16)  | get_le16(data + 11);
+		else
+			mod_id |= 0xffff0000;
+
+		pub.u.addr16 = get_le16(data + 2);
+		pub.app_idx = get_le16(data + 4);
+		pub.ttl = data[6];
+		pub.period = data[7];
+		n = (data[7] & 0x3f);
+		switch (data[7] >> 6) {
+		case 0:
+			rl_printf("Period: %d ms\n", n * 100);
+			break;
+		case 2:
+			n *= 10;
+			/* fall through */
+		case 1:
+			rl_printf("Period: %d sec\n", n);
+			break;
+		case 3:
+			rl_printf("Period: %d min\n", n * 10);
+			break;
+		}
+
+		pub.retransmit = data[8];
+		rl_printf("Retransmit count: %d\n", data[8] >> 5);
+		rl_printf("Retransmit Interval Steps: %d\n", data[8] & 0x1f);
+
+		ele_idx = ele_addr - node_get_primary(node);
+
+		if (node_model_pub_set(node, ele_idx, mod_id, &pub)) {
+			prov_db_node_set_model_pub(node, ele_idx, mod_id,
+				     node_model_pub_get(node, ele_idx, mod_id));
+		}
+		break;
+	}
+
+	primary = node_get_primary(node);
+	if (src != primary)
+		net_access_layer_send(node_get_default_ttl(node), primary,
+					src, APP_IDX_DEV, msg, len);
+	return true;
+}
+
+
+static struct mesh_model_ops server_cbs = {
+	server_msg_recvd,
+		NULL,
+		NULL,
+		NULL
+};
+
+bool config_server_init(void)
+{
+	if (!node_local_model_register(PRIMARY_ELEMENT_IDX,
+						CONFIG_SERVER_MODEL_ID,
+						&server_cbs, NULL))
+		return false;
+
+	return true;
+}
diff --git a/mesh/crypto.c b/mesh/crypto.c
new file mode 100644
index 0000000..189624e
--- /dev/null
+++ b/mesh/crypto.c
@@ -0,0 +1,1168 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+
+#include <linux/if_alg.h>
+
+#include <glib.h>
+
+#ifndef SOL_ALG
+#define SOL_ALG		279
+#endif
+
+#ifndef ALG_SET_AEAD_AUTHSIZE
+#define ALG_SET_AEAD_AUTHSIZE	5
+#endif
+
+#include "src/shared/util.h"
+#include "mesh-net.h"
+#include "crypto.h"
+
+static int alg_new(int fd, const void *keyval, socklen_t keylen,
+		size_t mic_size)
+{
+	if (setsockopt(fd, SOL_ALG, ALG_SET_KEY, keyval, keylen) < 0) {
+		g_printerr("key");
+		return -1;
+	}
+
+	if (mic_size &&
+		setsockopt(fd, SOL_ALG,
+			ALG_SET_AEAD_AUTHSIZE, NULL, mic_size) < 0) {
+		g_printerr("taglen");
+		return -1;
+	}
+
+	/* FIXME: This should use accept4() with SOCK_CLOEXEC */
+	return accept(fd, NULL, 0);
+}
+
+static bool alg_encrypt(int fd, const void *inbuf, size_t inlen,
+						void *outbuf, size_t outlen)
+{
+	__u32 alg_op = ALG_OP_ENCRYPT;
+	char cbuf[CMSG_SPACE(sizeof(alg_op))];
+	struct cmsghdr *cmsg;
+	struct msghdr msg;
+	struct iovec iov;
+	ssize_t len;
+
+	memset(cbuf, 0, sizeof(cbuf));
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(alg_op));
+	memcpy(CMSG_DATA(cmsg), &alg_op, sizeof(alg_op));
+
+	iov.iov_base = (void *) inbuf;
+	iov.iov_len = inlen;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	len = sendmsg(fd, &msg, 0);
+	if (len < 0)
+		return false;
+
+	len = read(fd, outbuf, outlen);
+	if (len < 0)
+		return false;
+
+	return true;
+}
+
+static int aes_ecb_setup(const uint8_t key[16])
+{
+	struct sockaddr_alg salg;
+	int fd, nfd;
+
+	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	memset(&salg, 0, sizeof(salg));
+	salg.salg_family = AF_ALG;
+	strcpy((char *) salg.salg_type, "skcipher");
+	strcpy((char *) salg.salg_name, "ecb(aes)");
+
+	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	nfd = alg_new(fd, key, 16, 0);
+
+	close(fd);
+
+	return nfd;
+}
+
+static bool aes_ecb(int fd, const uint8_t plaintext[16], uint8_t encrypted[16])
+{
+	return alg_encrypt(fd, plaintext, 16, encrypted, 16);
+}
+
+static void aes_ecb_destroy(int fd)
+{
+	close(fd);
+}
+
+static bool aes_ecb_one(const uint8_t key[16],
+			const uint8_t plaintext[16], uint8_t encrypted[16])
+{
+	bool result;
+	int fd;
+
+	fd = aes_ecb_setup(key);
+	if (fd < 0)
+		return false;
+
+	result = aes_ecb(fd, plaintext, encrypted);
+
+	aes_ecb_destroy(fd);
+
+	return result;
+}
+
+/* Maximum message length that can be passed to aes_cmac */
+#define CMAC_MSG_MAX	(64 + 64 + 17)
+
+static int aes_cmac_setup(const uint8_t key[16])
+{
+	struct sockaddr_alg salg;
+	int fd, nfd;
+
+	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	memset(&salg, 0, sizeof(salg));
+	salg.salg_family = AF_ALG;
+	strcpy((char *) salg.salg_type, "hash");
+	strcpy((char *) salg.salg_name, "cmac(aes)");
+
+	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	nfd = alg_new(fd, key, 16, 0);
+
+	close(fd);
+
+	return nfd;
+}
+
+static bool aes_cmac(int fd, const uint8_t *msg,
+					size_t msg_len, uint8_t res[16])
+{
+	ssize_t len;
+
+	if (msg_len > CMAC_MSG_MAX)
+		return false;
+
+	len = send(fd, msg, msg_len, 0);
+	if (len < 0)
+		return false;
+
+	len = read(fd, res, 16);
+	if (len < 0)
+		return false;
+
+	return true;
+}
+
+static void aes_cmac_destroy(int fd)
+{
+	close(fd);
+}
+
+static int aes_cmac_N_start(const uint8_t N[16])
+{
+	int fd;
+
+	fd = aes_cmac_setup(N);
+	return fd;
+}
+
+static bool aes_cmac_one(const uint8_t key[16], const void *msg,
+					size_t msg_len, uint8_t res[16])
+{
+	bool result;
+	int fd;
+
+	fd = aes_cmac_setup(key);
+	if (fd < 0)
+		return false;
+
+	result = aes_cmac(fd, msg, msg_len, res);
+
+	aes_cmac_destroy(fd);
+
+	return result;
+}
+
+bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
+					size_t msg_len, uint8_t res[16])
+{
+	return aes_cmac_one(key, msg, msg_len, res);
+}
+
+bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
+					const uint8_t *aad, uint16_t aad_len,
+					const uint8_t *msg, uint16_t msg_len,
+					uint8_t *out_msg, void *out_mic,
+					size_t mic_size)
+{
+	uint8_t pmsg[16], cmic[16], cmsg[16];
+	uint8_t mic[16], Xn[16];
+	uint16_t blk_cnt, last_blk;
+	bool result;
+	size_t i, j;
+	int fd;
+
+	if (aad_len >= 0xff00) {
+		g_printerr("Unsupported AAD size");
+		return false;
+	}
+
+	fd = aes_ecb_setup(key);
+	if (fd < 0)
+		return false;
+
+	/* C_mic = e(AppKey, 0x01 || nonce || 0x0000) */
+	pmsg[0] = 0x01;
+	memcpy(pmsg + 1, nonce, 13);
+	put_be16(0x0000, pmsg + 14);
+
+	result = aes_ecb(fd, pmsg, cmic);
+	if (!result)
+		goto done;
+
+	/* X_0 = e(AppKey, 0x09 || nonce || length) */
+	if (mic_size == sizeof(uint64_t))
+		pmsg[0] = 0x19 | (aad_len ? 0x40 : 0x00);
+	else
+		pmsg[0] = 0x09 | (aad_len ? 0x40 : 0x00);
+
+	memcpy(pmsg + 1, nonce, 13);
+	put_be16(msg_len, pmsg + 14);
+
+	result = aes_ecb(fd, pmsg, Xn);
+	if (!result)
+		goto done;
+
+	/* If AAD is being used to authenticate, include it here */
+	if (aad_len) {
+		put_be16(aad_len, pmsg);
+
+		for (i = 0; i < sizeof(uint16_t); i++)
+			pmsg[i] = Xn[i] ^ pmsg[i];
+
+		j = 0;
+		aad_len += sizeof(uint16_t);
+		while (aad_len > 16) {
+			do {
+				pmsg[i] = Xn[i] ^ aad[j];
+				i++, j++;
+			} while (i < 16);
+
+			aad_len -= 16;
+			i = 0;
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+		}
+
+		for (i = 0; i < aad_len; i++, j++)
+			pmsg[i] = Xn[i] ^ aad[j];
+
+		for (i = aad_len; i < 16; i++)
+			pmsg[i] = Xn[i];
+
+		result = aes_ecb(fd, pmsg, Xn);
+		if (!result)
+			goto done;
+	}
+
+	last_blk = msg_len % 16;
+	blk_cnt = (msg_len + 15) / 16;
+	if (!last_blk)
+		last_blk = 16;
+
+	for (j = 0; j < blk_cnt; j++) {
+		if (j + 1 == blk_cnt) {
+			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
+			for (i = 0; i < last_blk; i++)
+				pmsg[i] = Xn[i] ^ msg[(j * 16) + i];
+			for (i = last_blk; i < 16; i++)
+				pmsg[i] = Xn[i] ^ 0x00;
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+
+			/* MIC = C_mic ^ X_1 */
+			for (i = 0; i < sizeof(mic); i++)
+				mic[i] = cmic[i] ^ Xn[i];
+
+			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
+			pmsg[0] = 0x01;
+			memcpy(pmsg + 1, nonce, 13);
+			put_be16(j + 1, pmsg + 14);
+
+			result = aes_ecb(fd, pmsg, cmsg);
+			if (!result)
+				goto done;
+
+			if (out_msg) {
+				/* Encrypted = Payload[0-15] ^ C_1 */
+				for (i = 0; i < last_blk; i++)
+					out_msg[(j * 16) + i] =
+						msg[(j * 16) + i] ^ cmsg[i];
+
+			}
+		} else {
+			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
+			for (i = 0; i < 16; i++)
+				pmsg[i] = Xn[i] ^ msg[(j * 16) + i];
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+
+			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
+			pmsg[0] = 0x01;
+			memcpy(pmsg + 1, nonce, 13);
+			put_be16(j + 1, pmsg + 14);
+
+			result = aes_ecb(fd, pmsg, cmsg);
+			if (!result)
+				goto done;
+
+			if (out_msg) {
+				/* Encrypted = Payload[0-15] ^ C_N */
+				for (i = 0; i < 16; i++)
+					out_msg[(j * 16) + i] =
+						msg[(j * 16) + i] ^ cmsg[i];
+			}
+
+		}
+	}
+
+	if (out_msg)
+		memcpy(out_msg + msg_len, mic, mic_size);
+
+	if (out_mic) {
+		switch (mic_size) {
+		case sizeof(uint32_t):
+			*(uint32_t *)out_mic = get_be32(mic);
+			break;
+		case sizeof(uint64_t):
+			*(uint64_t *)out_mic = get_be64(mic);
+			break;
+		default:
+			g_printerr("Unsupported MIC size");
+		}
+	}
+
+done:
+	aes_ecb_destroy(fd);
+
+	return result;
+}
+
+bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
+				const uint8_t *aad, uint16_t aad_len,
+				const uint8_t *enc_msg, uint16_t enc_msg_len,
+				uint8_t *out_msg, void *out_mic,
+				size_t mic_size)
+{
+	uint8_t msg[16], pmsg[16], cmic[16], cmsg[16], Xn[16];
+	uint8_t mic[16];
+	uint16_t msg_len = enc_msg_len - mic_size;
+	uint16_t last_blk, blk_cnt;
+	bool result;
+	size_t i, j;
+	int fd;
+
+	if (enc_msg_len < 5 || aad_len >= 0xff00)
+		return false;
+
+	fd = aes_ecb_setup(key);
+	if (fd < 0)
+		return false;
+
+	/* C_mic = e(AppKey, 0x01 || nonce || 0x0000) */
+	pmsg[0] = 0x01;
+	memcpy(pmsg + 1, nonce, 13);
+	put_be16(0x0000, pmsg + 14);
+
+	result = aes_ecb(fd, pmsg, cmic);
+	if (!result)
+		goto done;
+
+	/* X_0 = e(AppKey, 0x09 || nonce || length) */
+	if (mic_size == sizeof(uint64_t))
+		pmsg[0] = 0x19 | (aad_len ? 0x40 : 0x00);
+	else
+		pmsg[0] = 0x09 | (aad_len ? 0x40 : 0x00);
+
+	memcpy(pmsg + 1, nonce, 13);
+	put_be16(msg_len, pmsg + 14);
+
+	result = aes_ecb(fd, pmsg, Xn);
+	if (!result)
+		goto done;
+
+	/* If AAD is being used to authenticate, include it here */
+	if (aad_len) {
+		put_be16(aad_len, pmsg);
+
+		for (i = 0; i < sizeof(uint16_t); i++)
+			pmsg[i] = Xn[i] ^ pmsg[i];
+
+		j = 0;
+		aad_len += sizeof(uint16_t);
+		while (aad_len > 16) {
+			do {
+				pmsg[i] = Xn[i] ^ aad[j];
+				i++, j++;
+			} while (i < 16);
+
+			aad_len -= 16;
+			i = 0;
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+		}
+
+		for (i = 0; i < aad_len; i++, j++)
+			pmsg[i] = Xn[i] ^ aad[j];
+
+		for (i = aad_len; i < 16; i++)
+			pmsg[i] = Xn[i];
+
+		result = aes_ecb(fd, pmsg, Xn);
+		if (!result)
+			goto done;
+	}
+
+	last_blk = msg_len % 16;
+	blk_cnt = (msg_len + 15) / 16;
+	if (!last_blk)
+		last_blk = 16;
+
+	for (j = 0; j < blk_cnt; j++) {
+		if (j + 1 == blk_cnt) {
+			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
+			pmsg[0] = 0x01;
+			memcpy(pmsg + 1, nonce, 13);
+			put_be16(j + 1, pmsg + 14);
+
+			result = aes_ecb(fd, pmsg, cmsg);
+			if (!result)
+				goto done;
+
+			/* Encrypted = Payload[0-15] ^ C_1 */
+			for (i = 0; i < last_blk; i++)
+				msg[i] = enc_msg[(j * 16) + i] ^ cmsg[i];
+
+			if (out_msg)
+				memcpy(out_msg + (j * 16), msg, last_blk);
+
+			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
+			for (i = 0; i < last_blk; i++)
+				pmsg[i] = Xn[i] ^ msg[i];
+			for (i = last_blk; i < 16; i++)
+				pmsg[i] = Xn[i] ^ 0x00;
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+
+			/* MIC = C_mic ^ X_1 */
+			for (i = 0; i < sizeof(mic); i++)
+				mic[i] = cmic[i] ^ Xn[i];
+		} else {
+			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
+			pmsg[0] = 0x01;
+			memcpy(pmsg + 1, nonce, 13);
+			put_be16(j + 1, pmsg + 14);
+
+			result = aes_ecb(fd, pmsg, cmsg);
+			if (!result)
+				goto done;
+
+			/* Encrypted = Payload[0-15] ^ C_1 */
+			for (i = 0; i < 16; i++)
+				msg[i] = enc_msg[(j * 16) + i] ^ cmsg[i];
+
+			if (out_msg)
+				memcpy(out_msg + (j * 16), msg, 16);
+
+			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
+			for (i = 0; i < 16; i++)
+				pmsg[i] = Xn[i] ^ msg[i];
+
+			result = aes_ecb(fd, pmsg, Xn);
+			if (!result)
+				goto done;
+		}
+	}
+
+	switch (mic_size) {
+		case sizeof(uint32_t):
+			if (out_mic)
+				*(uint32_t *)out_mic = get_be32(mic);
+			else if (get_be32(enc_msg + enc_msg_len - mic_size) !=
+					get_be32(mic))
+				result = false;
+			break;
+
+		case sizeof(uint64_t):
+			if (out_mic)
+				*(uint64_t *)out_mic = get_be64(mic);
+			else if (get_be64(enc_msg + enc_msg_len - mic_size) !=
+					get_be64(mic))
+				result = false;
+			break;
+
+		default:
+			g_printerr("Unsupported MIC size");
+			result = false;
+	}
+
+done:
+	aes_ecb_destroy(fd);
+
+	return result;
+}
+
+bool mesh_crypto_k1(const uint8_t ikm[16], const uint8_t salt[16],
+		const void *info, size_t info_len, uint8_t okm[16])
+{
+	uint8_t res[16];
+
+	if (!aes_cmac_one(salt, ikm, 16, res))
+		return false;
+
+	return aes_cmac_one(res, info, info_len, okm);
+}
+
+bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
+							uint8_t net_id[1],
+							uint8_t enc_key[16],
+							uint8_t priv_key[16])
+{
+	int fd;
+	uint8_t output[16];
+	uint8_t t[16];
+	uint8_t *stage;
+	bool success = false;
+
+	stage = g_malloc(sizeof(output) + p_len + 1);
+	if (stage == NULL)
+		return false;
+
+	if (!mesh_crypto_s1("smk2", 4, stage))
+		goto fail;
+
+	if (!aes_cmac_one(stage, n, 16, t))
+		goto fail;
+
+	fd = aes_cmac_N_start(t);
+	if (fd < 0)
+		goto fail;
+
+	memcpy(stage, p, p_len);
+	stage[p_len] = 1;
+
+	if(!aes_cmac(fd, stage, p_len + 1, output))
+		goto done;
+
+	net_id[0] = output[15] & 0x7f;
+
+	memcpy(stage, output, 16);
+	memcpy(stage + 16, p, p_len);
+	stage[p_len + 16] = 2;
+
+	if(!aes_cmac(fd, stage, p_len + 16 + 1, output))
+		goto done;
+
+	memcpy(enc_key, output, 16);
+
+	memcpy(stage, output, 16);
+	memcpy(stage + 16, p, p_len);
+	stage[p_len + 16] = 3;
+
+	if(!aes_cmac(fd, stage, p_len + 16 + 1, output))
+		goto done;
+
+	memcpy(priv_key, output, 16);
+	success = true;
+
+done:
+	aes_cmac_destroy(fd);
+fail:
+	g_free(stage);
+
+	return success;
+}
+
+static bool crypto_128(const uint8_t n[16], const char *s, uint8_t out128[16])
+{
+	uint8_t id128[] = { 'i', 'd', '1', '2', '8', 0x01 };
+	uint8_t salt[16];
+
+	if (!mesh_crypto_s1(s, 4, salt))
+		return false;
+
+	return mesh_crypto_k1(n, salt, id128, sizeof(id128), out128);
+}
+
+bool mesh_crypto_nkik(const uint8_t n[16], uint8_t identity_key[16])
+{
+	return crypto_128(n, "nkik", identity_key);
+}
+
+static bool identity_calc(const uint8_t net_key[16], uint16_t addr,
+		bool check, uint8_t id[16])
+{
+	uint8_t id_key[16];
+	uint8_t tmp[16];
+
+	if (!mesh_crypto_nkik(net_key, id_key))
+		return false;
+
+	memset(tmp, 0, sizeof(tmp));
+	put_be16(addr, tmp + 14);
+
+	if (check) {
+		memcpy(tmp + 6, id + 8, 8);
+	} else {
+		mesh_get_random_bytes(tmp + 6, 8);
+		memcpy(id + 8, tmp + 6, 8);
+	}
+
+	if (!aes_ecb_one(id_key, tmp, tmp))
+		return false;
+
+	if (check)
+		return (memcmp(id, tmp + 8, 8) == 0);
+
+	memcpy(id, tmp + 8, 8);
+	return true;
+}
+
+bool mesh_crypto_identity(const uint8_t net_key[16], uint16_t addr,
+							uint8_t id[16])
+{
+	return identity_calc(net_key, addr, false, id);
+}
+
+bool mesh_crypto_identity_check(const uint8_t net_key[16], uint16_t addr,
+							uint8_t id[16])
+{
+	return identity_calc(net_key, addr, true, id);
+}
+
+bool mesh_crypto_nkbk(const uint8_t n[16], uint8_t beacon_key[16])
+{
+	return crypto_128(n, "nkbk", beacon_key);
+}
+
+bool mesh_crypto_k3(const uint8_t n[16], uint8_t out64[8])
+{
+	uint8_t tmp[16];
+	uint8_t t[16];
+	uint8_t id64[] = { 'i', 'd', '6', '4', 0x01 };
+
+	if (!mesh_crypto_s1("smk3", 4, tmp))
+		return false;
+
+	if (!aes_cmac_one(tmp, n, 16, t))
+		return false;
+
+	if (!aes_cmac_one(t, id64, sizeof(id64), tmp))
+		return false;
+
+	memcpy(out64, tmp + 8, 8);
+
+	return true;
+}
+
+bool mesh_crypto_k4(const uint8_t a[16], uint8_t out6[1])
+{
+	uint8_t tmp[16];
+	uint8_t t[16];
+	uint8_t id6[] = { 'i', 'd', '6', 0x01 };
+
+	if (!mesh_crypto_s1("smk4", 4, tmp))
+		return false;
+
+	if (!aes_cmac_one(tmp, a, 16, t))
+		return false;
+
+	if (!aes_cmac_one(t, id6, sizeof(id6), tmp))
+		return false;
+
+	out6[0] = tmp[15] & 0x3f;
+	return true;
+}
+
+bool mesh_crypto_beacon_cmac(const uint8_t encryption_key[16],
+				const uint8_t network_id[8],
+				uint32_t iv_index, bool kr, bool iu,
+				uint64_t *cmac)
+{
+	uint8_t msg[13], tmp[16];
+
+	if (!cmac)
+		return false;
+
+	msg[0] = kr ? 0x01 : 0x00;
+	msg[0] |= iu ? 0x02 : 0x00;
+	memcpy(msg + 1, network_id, 8);
+	put_be32(iv_index, msg + 9);
+
+	if (!aes_cmac_one(encryption_key, msg, 13, tmp))
+		return false;
+
+	*cmac = get_be64(tmp);
+
+	return true;
+}
+
+bool mesh_crypto_network_nonce(bool ctl, uint8_t ttl, uint32_t seq,
+				uint16_t src, uint32_t iv_index,
+				uint8_t nonce[13])
+{
+	nonce[0] = 0;
+	nonce[1] = (ttl & TTL_MASK) | (ctl ? CTL : 0x00);
+	nonce[2] = (seq >> 16) & 0xff;
+	nonce[3] = (seq >> 8) & 0xff;
+	nonce[4] = seq & 0xff;
+
+	/* SRC */
+	put_be16(src, nonce + 5);
+
+	put_be16(0, nonce + 7);
+
+	/* IV Index */
+	put_be32(iv_index, nonce + 9);
+
+	return true;
+}
+
+bool mesh_crypto_network_encrypt(bool ctl, uint8_t ttl,
+				uint32_t seq, uint16_t src,
+				uint32_t iv_index,
+				const uint8_t net_key[16],
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *net_mic)
+{
+	uint8_t nonce[13];
+
+	if (!mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce))
+		return false;
+
+	return mesh_crypto_aes_ccm_encrypt(nonce, net_key,
+				NULL, 0, enc_msg,
+				enc_msg_len, out,
+				net_mic,
+				ctl ? sizeof(uint64_t) : sizeof(uint32_t));
+}
+
+bool mesh_crypto_network_decrypt(bool ctl, uint8_t ttl,
+				uint32_t seq, uint16_t src,
+				uint32_t iv_index,
+				const uint8_t net_key[16],
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *net_mic, size_t mic_size)
+{
+	uint8_t nonce[13];
+
+	if (!mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce))
+		return false;
+
+	return mesh_crypto_aes_ccm_decrypt(nonce, net_key, NULL, 0,
+						enc_msg, enc_msg_len, out,
+						net_mic, mic_size);
+}
+
+bool mesh_crypto_application_nonce(uint32_t seq, uint16_t src,
+					uint16_t dst, uint32_t iv_index,
+					bool aszmic, uint8_t nonce[13])
+{
+	nonce[0] = 0x01;
+	nonce[1] = aszmic ? 0x80 : 0x00;
+	nonce[2] = (seq & 0x00ff0000) >> 16;
+	nonce[3] = (seq & 0x0000ff00) >> 8;
+	nonce[4] = (seq & 0x000000ff);
+	nonce[5] = (src & 0xff00) >> 8;
+	nonce[6] = (src & 0x00ff);
+	nonce[7] = (dst & 0xff00) >> 8;
+	nonce[8] = (dst & 0x00ff);
+	put_be32(iv_index, nonce + 9);
+
+	return true;
+}
+
+bool mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
+					uint16_t dst, uint32_t iv_index,
+					bool aszmic, uint8_t nonce[13])
+{
+	nonce[0] = 0x02;
+	nonce[1] = aszmic ? 0x80 : 0x00;
+	nonce[2] = (seq & 0x00ff0000) >> 16;
+	nonce[3] = (seq & 0x0000ff00) >> 8;
+	nonce[4] = (seq & 0x000000ff);
+	nonce[5] = (src & 0xff00) >> 8;
+	nonce[6] = (src & 0x00ff);
+	nonce[7] = (dst & 0xff00) >> 8;
+	nonce[8] = (dst & 0x00ff);
+	put_be32(iv_index, nonce + 9);
+
+	return true;
+}
+
+bool mesh_crypto_application_encrypt(uint8_t key_id, uint32_t seq, uint16_t src,
+					uint16_t dst, uint32_t iv_index,
+					const uint8_t app_key[16],
+					const uint8_t *aad, uint8_t aad_len,
+					const uint8_t *msg, uint8_t msg_len,
+					uint8_t *out, void *app_mic,
+					size_t mic_size)
+{
+	uint8_t nonce[13];
+	bool aszmic = (mic_size == sizeof(uint64_t)) ? true : false;
+
+	if (!key_id && !mesh_crypto_device_nonce(seq, src, dst,
+				iv_index, aszmic, nonce))
+		return false;
+
+	if (key_id && !mesh_crypto_application_nonce(seq, src, dst,
+				iv_index, aszmic, nonce))
+		return false;
+
+	return mesh_crypto_aes_ccm_encrypt(nonce, app_key, aad, aad_len,
+						msg, msg_len,
+						out, app_mic, mic_size);
+}
+
+bool mesh_crypto_application_decrypt(uint8_t key_id, uint32_t seq, uint16_t src,
+				uint16_t dst, uint32_t iv_index,
+				const uint8_t app_key[16],
+				const uint8_t *aad, uint8_t aad_len,
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *app_mic, size_t mic_size)
+{
+	uint8_t nonce[13];
+	bool aszmic = (mic_size == sizeof(uint64_t)) ? true : false;
+
+	if (!key_id && !mesh_crypto_device_nonce(seq, src, dst,
+				iv_index, aszmic, nonce))
+		return false;
+
+	if (key_id && !mesh_crypto_application_nonce(seq, src, dst,
+				iv_index, aszmic, nonce))
+		return false;
+
+	return mesh_crypto_aes_ccm_decrypt(nonce, app_key,
+						aad, aad_len, enc_msg,
+						enc_msg_len, out,
+						app_mic, mic_size);
+}
+
+bool mesh_crypto_session_key(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t session_key[16])
+{
+	const uint8_t prsk[4] = "prsk";
+
+	if (!aes_cmac_one(salt, secret, 32, session_key))
+		return false;
+
+	return aes_cmac_one(session_key, prsk, 4, session_key);
+}
+
+bool mesh_crypto_nonce(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t nonce[13])
+{
+	const uint8_t prsn[4] = "prsn";
+	uint8_t tmp[16];
+	bool result;
+
+	if (!aes_cmac_one(salt, secret, 32, tmp))
+		return false;
+
+	result =  aes_cmac_one(tmp, prsn, 4, tmp);
+
+	if (result)
+		memcpy(nonce, tmp + 3, 13);
+
+	return result;
+}
+
+bool mesh_crypto_s1(const void *info, size_t len, uint8_t salt[16])
+{
+	const uint8_t zero[16] = {0};
+
+	return aes_cmac_one(zero, info, len, salt);
+}
+
+bool mesh_crypto_prov_prov_salt(const uint8_t conf_salt[16],
+					const uint8_t prov_rand[16],
+					const uint8_t dev_rand[16],
+					uint8_t prov_salt[16])
+{
+	const uint8_t zero[16] = {0};
+	uint8_t tmp[16 * 3];
+
+	memcpy(tmp, conf_salt, 16);
+	memcpy(tmp + 16, prov_rand, 16);
+	memcpy(tmp + 32, dev_rand, 16);
+
+	return aes_cmac_one(zero, tmp, sizeof(tmp), prov_salt);
+}
+
+bool mesh_crypto_prov_conf_key(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t conf_key[16])
+{
+	const uint8_t prck[4] = "prck";
+
+	if (!aes_cmac_one(salt, secret, 32, conf_key))
+		return false;
+
+	return aes_cmac_one(conf_key, prck, 4, conf_key);
+}
+
+bool mesh_crypto_device_key(const uint8_t secret[32],
+						const uint8_t salt[16],
+						uint8_t device_key[16])
+{
+	const uint8_t prdk[4] = "prdk";
+
+	if (!aes_cmac_one(salt, secret, 32, device_key))
+		return false;
+
+	return aes_cmac_one(device_key, prdk, 4, device_key);
+}
+
+bool mesh_crypto_virtual_addr(const uint8_t virtual_label[16],
+						uint16_t *addr)
+{
+	uint8_t tmp[16];
+
+	if (!mesh_crypto_s1("vtad", 4, tmp))
+		return false;
+
+	if (!addr || !aes_cmac_one(tmp, virtual_label, 16, tmp))
+		return false;
+
+	*addr = (get_be16(tmp + 14) & 0x3fff) | 0x8000;
+
+	return true;
+}
+
+bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
+				const uint8_t network_key[16],
+				uint32_t iv_index,
+				const uint8_t privacy_key[16])
+{
+	uint8_t network_nonce[13] = { 0x00, 0x00 };
+	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
+	uint8_t tmp[16];
+	int i;
+
+	/* Detect Proxy packet by CTL == true && DST == 0x0000 */
+	if ((packet[1] & CTL) && get_be16(packet + 7) == 0)
+		network_nonce[0] = 0x03;
+	else
+		/* CTL + TTL */
+		network_nonce[1] = packet[1];
+
+	/* Seq Num */
+	network_nonce[2] = packet[2];
+	network_nonce[3] = packet[3];
+	network_nonce[4] = packet[4];
+
+	/* SRC */
+	network_nonce[5] = packet[5];
+	network_nonce[6] = packet[6];
+
+	/* DST not available */
+	network_nonce[7] = 0;
+	network_nonce[8] = 0;
+
+	/* IV Index */
+	put_be32(iv_index, network_nonce + 9);
+
+	/* Check for Long net-MIC */
+	if (packet[1] & CTL) {
+		if (!mesh_crypto_aes_ccm_encrypt(network_nonce, network_key,
+					NULL, 0,
+					packet + 7, packet_len - 7 - 8,
+					packet + 7, NULL, sizeof(uint64_t)))
+			return false;
+	} else {
+		if (!mesh_crypto_aes_ccm_encrypt(network_nonce, network_key,
+					NULL, 0,
+					packet + 7, packet_len - 7 - 4,
+					packet + 7, NULL, sizeof(uint32_t)))
+			return false;
+	}
+
+	put_be32(iv_index, privacy_counter + 5);
+	memcpy(privacy_counter + 9, packet + 7, 7);
+
+	if (!aes_ecb_one(privacy_key, privacy_counter, tmp))
+		return false;
+
+	for (i = 0; i < 6; i++)
+		packet[1 + i] ^= tmp[i];
+
+	return true;
+}
+
+bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
+				bool proxy, uint8_t *out, uint32_t iv_index,
+				const uint8_t network_key[16],
+				const uint8_t privacy_key[16])
+{
+	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
+	uint8_t network_nonce[13] = { 0x00, 0x00, };
+	uint8_t tmp[16];
+	uint16_t src;
+	int i;
+
+	if (packet_len < 14)
+		return false;
+
+	put_be32(iv_index, privacy_counter + 5);
+	memcpy(privacy_counter + 9, packet + 7, 7);
+
+	if (!aes_ecb_one(privacy_key, privacy_counter, tmp))
+		return false;
+
+	memcpy(out, packet, packet_len);
+	for (i = 0; i < 6; i++)
+		out[1 + i] ^= tmp[i];
+
+	src  = get_be16(out + 5);
+
+	/* Pre-check SRC address for illegal values */
+	if (!src || src >= 0x8000)
+		return false;
+
+	/* Detect Proxy packet by CTL == true && proxy == true */
+	if ((out[1] & CTL) && proxy)
+		network_nonce[0] = 0x03;
+	else
+		/* CTL + TTL */
+		network_nonce[1] = out[1];
+
+	/* Seq Num */
+	network_nonce[2] = out[2];
+	network_nonce[3] = out[3];
+	network_nonce[4] = out[4];
+
+	/* SRC */
+	network_nonce[5] = out[5];
+	network_nonce[6] = out[6];
+
+	/* DST not available */
+	network_nonce[7] = 0;
+	network_nonce[8] = 0;
+
+	/* IV Index */
+	put_be32(iv_index, network_nonce + 9);
+
+	/* Check for Long MIC */
+	if (out[1] & CTL) {
+		uint64_t mic;
+
+		if (!mesh_crypto_aes_ccm_decrypt(network_nonce, network_key,
+					NULL, 0, packet + 7, packet_len - 7,
+					out + 7, &mic, sizeof(mic)))
+			return false;
+
+		mic ^= get_be64(out + packet_len - 8);
+		put_be64(mic, out + packet_len - 8);
+
+		if (mic)
+			return false;
+	} else {
+		uint32_t mic;
+
+		if (!mesh_crypto_aes_ccm_decrypt(network_nonce, network_key,
+					NULL, 0, packet + 7, packet_len - 7,
+					out + 7, &mic, sizeof(mic)))
+			return false;
+
+		mic ^= get_be32(out + packet_len - 4);
+		put_be32(mic, out + packet_len - 4);
+
+		if (mic)
+			return false;
+	}
+
+	return true;
+}
+
+bool mesh_get_random_bytes(void *buf, size_t num_bytes)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	len = read(fd, buf, num_bytes);
+
+	close(fd);
+
+	if (len < 0)
+		return false;
+
+	return true;
+}
diff --git a/mesh/gatt.c b/mesh/gatt.c
new file mode 100644
index 0000000..b981054
--- /dev/null
+++ b/mesh/gatt.c
@@ -0,0 +1,609 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "src/shared/io.h"
+#include "gdbus/gdbus.h"
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "client/display.h"
+#include "node.h"
+#include "util.h"
+#include "gatt.h"
+#include "prov.h"
+#include "net.h"
+
+#define MESH_PROV_DATA_OUT_UUID_STR	"00002adc-0000-1000-8000-00805f9b34fb"
+#define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
+
+static struct io *write_io;
+static uint16_t write_mtu;
+
+static struct io *notify_io;
+static uint16_t notify_mtu;
+
+struct write_data {
+	GDBusProxy *proxy;
+	void *user_data;
+	struct iovec iov;
+	GDBusReturnFunction cb;
+	uint8_t *gatt_data;
+	uint8_t gatt_len;
+};
+
+struct notify_data {
+	GDBusProxy *proxy;
+	bool enable;
+	GDBusReturnFunction cb;
+	void *user_data;
+};
+
+bool mesh_gatt_is_child(GDBusProxy *proxy, GDBusProxy *parent,
+			const char *name)
+{
+	DBusMessageIter iter;
+	const char *parent_path;
+
+	if (!parent)
+		return FALSE;
+
+	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &parent_path);
+
+	if (!strcmp(parent_path, g_dbus_proxy_get_path(parent)))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+/* Refactor this once actual MTU is available */
+#define GATT_MTU	23
+
+static void write_data_free(void *user_data)
+{
+	struct write_data *data = user_data;
+
+	g_free(data->gatt_data);
+	free(data);
+}
+
+static void write_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct write_data *data = user_data;
+	struct iovec *iov = &data->iov;
+	DBusMessageIter array, dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&iov->iov_base, iov->iov_len);
+	dbus_message_iter_close_container(iter, &array);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+uint16_t mesh_gatt_sar(uint8_t **pkt, uint16_t size)
+{
+	const uint8_t *data = *pkt;
+	uint8_t gatt_hdr = *data++;
+	uint8_t type = gatt_hdr & GATT_TYPE_MASK;
+	static uint8_t gatt_size;
+	static uint8_t gatt_pkt[67];
+
+	print_byte_array("GATT-RX:\t", *pkt, size);
+	if (size < 1) {
+		gatt_pkt[0] = GATT_TYPE_INVALID;
+		/* TODO: Disconnect GATT per last paragraph sec 6.6 */
+		return 0;
+	}
+
+	size--;
+
+	switch (gatt_hdr & GATT_SAR_MASK) {
+	case GATT_SAR_FIRST:
+		gatt_size = 1;
+		gatt_pkt[0] = type;
+		/* TODO: Start Proxy Timeout */
+		/* fall through */
+
+	case GATT_SAR_CONTINUE:
+		if (gatt_pkt[0] != type ||
+				gatt_size + size > MAX_GATT_SIZE) {
+
+			/* Invalidate packet and return failure */
+			gatt_pkt[0] = GATT_TYPE_INVALID;
+			/* TODO: Disconnect GATT per last paragraph sec 6.6 */
+			return 0;
+		}
+
+		memcpy(gatt_pkt + gatt_size, data, size);
+		gatt_size += size;
+
+		/* We are good to this point, but incomplete */
+		return 0;
+
+	default:
+	case GATT_SAR_COMPLETE:
+		gatt_size = 1;
+		gatt_pkt[0] = type;
+
+		/* fall through */
+
+	case GATT_SAR_LAST:
+		if (gatt_pkt[0] != type ||
+				gatt_size + size > MAX_GATT_SIZE) {
+
+			/* Invalidate packet and return failure */
+			gatt_pkt[0] = GATT_TYPE_INVALID;
+			/* Disconnect GATT per last paragraph sec 6.6 */
+			return 0;
+		}
+
+		memcpy(gatt_pkt + gatt_size, data, size);
+		gatt_size += size;
+		*pkt = gatt_pkt;
+		return gatt_size;
+	}
+}
+
+static bool pipe_write(struct io *io, void *user_data)
+{
+	struct write_data *data = user_data;
+	struct iovec iov[2];
+	uint8_t sar;
+	uint8_t max_len = write_mtu - 4;
+
+	if (data == NULL)
+		return true;
+
+	print_byte_array("GATT-TX:\t", data->gatt_data, data->gatt_len);
+
+	sar = data->gatt_data[0];
+
+	data->iov.iov_base = data->gatt_data + 1;
+	data->iov.iov_len--;
+
+	iov[0].iov_base = &sar;
+	iov[0].iov_len = sizeof(sar);
+
+	while (1) {
+		int err;
+
+		iov[1] = data->iov;
+
+		err = io_send(io, iov, 2);
+		if (err < 0) {
+			rl_printf("Failed to write: %s\n", strerror(-err));
+			write_data_free(data);
+			return false;
+		}
+
+		switch (sar & GATT_SAR_MASK) {
+		case GATT_SAR_FIRST:
+		case GATT_SAR_CONTINUE:
+			data->gatt_len -= max_len;
+			data->iov.iov_base = data->iov.iov_base + max_len;
+
+			sar &= GATT_TYPE_MASK;
+			if (max_len < data->gatt_len) {
+				data->iov.iov_len = max_len;
+				sar |= GATT_SAR_CONTINUE;
+			} else {
+				data->iov.iov_len = data->gatt_len;
+				sar |= GATT_SAR_LAST;
+			}
+
+			break;
+
+		default:
+			if(data->cb)
+				data->cb(NULL, data->user_data);
+			write_data_free(data);
+			return true;
+		}
+	}
+}
+
+static void write_reply(DBusMessage *message, void *user_data)
+{
+	struct write_data *data = user_data;
+	struct write_data *tmp;
+	uint8_t *dptr = data->gatt_data;
+	uint8_t max_len = GATT_MTU - 3;
+	uint8_t max_seg = GATT_MTU - 4;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to write: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	if (data == NULL)
+		return;
+
+	switch (data->gatt_data[0] & GATT_SAR_MASK) {
+		case GATT_SAR_FIRST:
+		case GATT_SAR_CONTINUE:
+			tmp = g_new0(struct write_data, 1);
+			if (!data)
+				return;
+
+			*tmp = *data;
+			tmp->gatt_data = g_malloc(data->gatt_len);
+
+			if (!tmp->gatt_data) {
+				g_free(tmp);
+				return;
+			}
+
+			tmp->gatt_data[0] = dptr[0];
+			data = tmp;
+			memcpy(data->gatt_data + 1, dptr + max_len,
+					data->gatt_len - max_seg);
+			data->gatt_len -= max_seg;
+			data->gatt_data[0] &= GATT_TYPE_MASK;
+			data->iov.iov_base = data->gatt_data;
+			if (max_len < data->gatt_len) {
+				data->iov.iov_len = max_len;
+				data->gatt_data[0] |= GATT_SAR_CONTINUE;
+			} else {
+				data->iov.iov_len = data->gatt_len;
+				data->gatt_data[0] |= GATT_SAR_LAST;
+			}
+
+			break;
+
+		default:
+			if(data->cb)
+				data->cb(message, data->user_data);
+			return;
+	}
+
+	if (g_dbus_proxy_method_call(data->proxy, "WriteValue", write_setup,
+				write_reply, data, write_data_free) == FALSE) {
+		rl_printf("Failed to write\n");
+		write_data_free(data);
+		return;
+	}
+
+}
+
+static void write_io_destroy(void)
+{
+	io_destroy(write_io);
+	write_io = NULL;
+	write_mtu = 0;
+}
+
+static void notify_io_destroy(void)
+{
+	io_destroy(notify_io);
+	notify_io = NULL;
+	notify_mtu = 0;
+}
+
+static bool pipe_hup(struct io *io, void *user_data)
+{
+	rl_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
+
+	if (io == notify_io)
+		notify_io_destroy();
+	else
+		write_io_destroy();
+
+	return false;
+}
+
+static struct io *pipe_io_new(int fd)
+{
+	struct io *io;
+
+	io = io_new(fd);
+
+	io_set_close_on_destroy(io, true);
+
+	io_set_disconnect_handler(io, pipe_hup, NULL, NULL);
+
+	return io;
+}
+
+static void acquire_write_reply(DBusMessage *message, void *user_data)
+{
+	struct write_data *data = user_data;
+	DBusError error;
+	int fd;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		dbus_error_free(&error);
+		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
+				write_setup, write_reply, data,
+				write_data_free) == FALSE) {
+			rl_printf("Failed to write\n");
+			write_data_free(data);
+		}
+		return;
+	}
+
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_UINT16, &write_mtu,
+					DBUS_TYPE_INVALID) == false)) {
+		rl_printf("Invalid AcquireWrite response\n");
+		return;
+	}
+
+	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
+
+	write_io = pipe_io_new(fd);
+
+	pipe_write(write_io, data);
+}
+
+bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
+			GDBusReturnFunction cb, void *user_data)
+{
+	struct write_data *data;
+	DBusMessageIter iter;
+	uint8_t max_len;
+
+	if (!buf || !len)
+		return false;
+
+	if (len > 69)
+		return false;
+
+	data = g_new0(struct write_data, 1);
+	if (!data)
+		return false;
+
+	max_len = write_mtu ? write_mtu - 3 : GATT_MTU - 3;
+
+	/* TODO: should keep in queue in case we need to cancel write? */
+
+	data->gatt_len = len;
+	data->gatt_data = g_memdup(buf, len);
+	data->gatt_data[0] &= GATT_TYPE_MASK;
+	if (max_len < len) {
+		len = max_len;
+		data->gatt_data[0] |= GATT_SAR_FIRST;
+	}
+	data->iov.iov_base = data->gatt_data;
+	data->iov.iov_len = len;
+	data->proxy = proxy;
+	data->user_data = user_data;
+	data->cb = cb;
+
+	if (write_io)
+		return pipe_write(write_io, data);
+
+	if (g_dbus_proxy_get_property(proxy, "WriteAcquired", &iter)) {
+		if (g_dbus_proxy_method_call(proxy, "AcquireWrite", NULL,
+				acquire_write_reply, data, NULL) == FALSE) {
+			rl_printf("Failed to AcquireWrite\n");
+			write_data_free(data);
+			return false;
+		}
+	} else {
+		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
+				write_setup, write_reply, data,
+				write_data_free) == FALSE) {
+			rl_printf("Failed to write\n");
+			write_data_free(data);
+			return false;
+		}
+		print_byte_array("GATT-TX: ", buf, len);
+		rl_printf("Attempting to write %s\n",
+						g_dbus_proxy_get_path(proxy));
+	}
+
+	return true;
+}
+
+static void notify_reply(DBusMessage *message, void *user_data)
+{
+	struct notify_data *data = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to %s notify: %s\n",
+				data->enable ? "start" : "stop", error.name);
+		dbus_error_free(&error);
+		goto done;
+	}
+
+	rl_printf("Notify %s\n", data->enable ? "started" : "stopped");
+
+done:
+	if (data->cb)
+		data->cb(message, data->user_data);
+
+	g_free(data);
+}
+
+static bool pipe_read(struct io *io, bool prov, void *user_data)
+{
+	struct mesh_node *node = user_data;
+	uint8_t buf[512];
+	uint8_t *res;
+	int fd = io_get_fd(io);
+	ssize_t len;
+
+	if (io != notify_io)
+		return true;
+
+	while ((len = read(fd, buf, sizeof(buf)))) {
+		if (len <= 0)
+			break;
+
+		res = buf;
+		mesh_gatt_sar(&res, len);
+
+		if (prov)
+			prov_data_ready(node, res, len);
+		else
+			net_data_ready(res, len);
+	}
+
+	return true;
+}
+
+static bool pipe_read_prov(struct io *io, void *user_data)
+{
+	return pipe_read(io, true, user_data);
+}
+
+static bool pipe_read_proxy(struct io *io, void *user_data)
+{
+	return pipe_read(io, false, user_data);
+}
+
+static void acquire_notify_reply(DBusMessage *message, void *user_data)
+{
+	struct notify_data *data = user_data;
+	DBusMessageIter iter;
+	DBusError error;
+	int fd;
+	const char *uuid;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		dbus_error_free(&error);
+		if (g_dbus_proxy_method_call(data->proxy, "StartNotify", NULL,
+					notify_reply, data, NULL) == FALSE) {
+			rl_printf("Failed to StartNotify\n");
+			g_free(data);
+		}
+		return;
+	}
+
+	if (notify_io) {
+		io_destroy(notify_io);
+		notify_io = NULL;
+	}
+
+	notify_mtu = 0;
+
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_UINT16, &notify_mtu,
+					DBUS_TYPE_INVALID) == false)) {
+		if (g_dbus_proxy_method_call(data->proxy, "StartNotify", NULL,
+					notify_reply, data, NULL) == FALSE) {
+			rl_printf("Failed to StartNotify\n");
+			g_free(data);
+		}
+		return;
+	}
+
+	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_mtu);
+
+	if (g_dbus_proxy_get_property(data->proxy, "UUID", &iter) == FALSE)
+		goto done;
+
+	notify_io = pipe_io_new(fd);
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (!bt_uuid_strcmp(uuid, MESH_PROV_DATA_OUT_UUID_STR))
+		io_set_read_handler(notify_io, pipe_read_prov, data->user_data,
+									NULL);
+	else if (!bt_uuid_strcmp(uuid, MESH_PROXY_DATA_OUT_UUID_STR))
+		io_set_read_handler(notify_io, pipe_read_proxy, data->user_data,
+									NULL);
+
+done:
+	if (data->cb)
+		data->cb(message, data->user_data);
+
+	g_free(data);
+}
+
+bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
+			void *user_data)
+{
+	struct notify_data *data;
+	DBusMessageIter iter;
+	const char *method;
+
+	data = g_new0(struct notify_data, 1);
+	data->proxy = proxy;
+	data->enable = enable;
+	data->cb = cb;
+	data->user_data = user_data;
+
+	if (enable == TRUE) {
+		if (g_dbus_proxy_get_property(proxy, "NotifyAcquired", &iter)) {
+			method = "AcquireNotify";
+			cb = acquire_notify_reply;
+		} else {
+			method = "StartNotify";
+			cb = notify_reply;
+		}
+	} else {
+		if (notify_io) {
+			notify_io_destroy();
+			if (cb)
+				cb(NULL, user_data);
+			return true;
+		} else {
+			method = "StopNotify";
+			cb = notify_reply;
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, method, NULL, cb,
+					data, NULL) == FALSE) {
+		rl_printf("Failed to %s\n", method);
+		return false;
+	}
+	return true;
+}
diff --git a/mesh/main.c b/mesh/main.c
new file mode 100644
index 0000000..a347484
--- /dev/null
+++ b/mesh/main.c
@@ -0,0 +1,2269 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+#include <wordexp.h>
+
+#include <inttypes.h>
+#include <ctype.h>
+#include <sys/file.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include "bluetooth/bluetooth.h"
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "src/shared/util.h"
+#include "gdbus/gdbus.h"
+#include "monitor/uuid.h"
+#include "client/display.h"
+#include "mesh-net.h"
+#include "gatt.h"
+#include "crypto.h"
+#include "node.h"
+#include "net.h"
+#include "keys.h"
+#include "prov.h"
+#include "util.h"
+#include "agent.h"
+#include "prov-db.h"
+#include "config-model.h"
+#include "onoff-model.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+#define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
+
+#define PROMPT_ON	COLOR_BLUE "[meshctl]" COLOR_OFF "# "
+#define PROMPT_OFF	"Waiting to connect to bluetoothd..."
+
+#define MESH_PROV_DATA_IN_UUID_STR	"00002adb-0000-1000-8000-00805f9b34fb"
+#define MESH_PROV_DATA_OUT_UUID_STR	"00002adc-0000-1000-8000-00805f9b34fb"
+#define MESH_PROXY_DATA_IN_UUID_STR	"00002add-0000-1000-8000-00805f9b34fb"
+#define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
+
+static GMainLoop *main_loop;
+static DBusConnection *dbus_conn;
+
+struct adapter {
+GDBusProxy *proxy;
+	GList *mesh_devices;
+};
+
+struct mesh_device {
+	GDBusProxy *proxy;
+	uint8_t dev_uuid[16];
+	gboolean hide;
+};
+
+GList *service_list;
+GList *char_list;
+
+static GList *ctrl_list;
+static struct adapter *default_ctrl;
+
+static char *mesh_prov_db_filename;
+static char *mesh_local_config_filename;
+
+static bool discovering = false;
+static bool discover_mesh;
+static uint16_t prov_net_key_index = NET_IDX_PRIMARY;
+
+static guint input = 0;
+
+#define CONN_TYPE_NETWORK	0x00
+#define CONN_TYPE_IDENTITY	0x01
+#define CONN_TYPE_PROVISION	0x02
+#define CONN_TYPE_INVALID	0xff
+
+#define NET_IDX_INVALID		0xffff
+
+struct {
+	GDBusProxy *device;
+	GDBusProxy *service;
+	GDBusProxy *data_in;
+	GDBusProxy *data_out;
+	bool session_open;
+	uint16_t unicast;
+	uint16_t net_idx;
+	uint8_t dev_uuid[16];
+	uint8_t type;
+} connection;
+
+static bool service_is_mesh(GDBusProxy *proxy, const char *target_uuid)
+{
+	DBusMessageIter iter;
+	const char *uuid;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (target_uuid)
+		return (!bt_uuid_strcmp(uuid, target_uuid));
+	else if (bt_uuid_strcmp(uuid, MESH_PROV_SVC_UUID) ||
+				bt_uuid_strcmp(uuid, MESH_PROXY_SVC_UUID))
+		return true;
+	else
+		return false;
+}
+
+static bool char_is_mesh(GDBusProxy *proxy, const char *target_uuid)
+{
+	DBusMessageIter iter;
+	const char *uuid;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (target_uuid)
+		return (!bt_uuid_strcmp(uuid, target_uuid));
+
+	if (!bt_uuid_strcmp(uuid, MESH_PROV_DATA_IN_UUID_STR))
+		return true;
+
+	if (!bt_uuid_strcmp(uuid, MESH_PROV_DATA_OUT_UUID_STR))
+		return true;
+
+	if (!bt_uuid_strcmp(uuid, MESH_PROXY_DATA_IN_UUID_STR))
+		return true;
+
+	if (!bt_uuid_strcmp(uuid, MESH_PROXY_DATA_OUT_UUID_STR))
+		return true;
+
+	return false;
+}
+
+static gboolean check_default_ctrl(void)
+{
+	if (!default_ctrl) {
+		rl_printf("No default controller available\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void proxy_leak(gpointer data)
+{
+	rl_printf("Leaking proxy %p\n", data);
+}
+
+static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	if (condition & G_IO_IN) {
+		rl_callback_read_char();
+		return TRUE;
+	}
+
+	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		g_main_loop_quit(main_loop);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static guint setup_standard_input(void)
+{
+	GIOChannel *channel;
+	guint source;
+
+	channel = g_io_channel_unix_new(fileno(stdin));
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				input_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+static void connect_handler(DBusConnection *connection, void *user_data)
+{
+	rl_set_prompt(PROMPT_ON);
+	rl_printf("\r");
+	rl_on_new_line();
+	rl_redisplay();
+}
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	if (input > 0) {
+		g_source_remove(input);
+		input = 0;
+	}
+
+	rl_set_prompt(PROMPT_OFF);
+	rl_printf("\r");
+	rl_on_new_line();
+	rl_redisplay();
+
+	g_list_free_full(ctrl_list, proxy_leak);
+	ctrl_list = NULL;
+
+	default_ctrl = NULL;
+}
+
+static void print_adapter(GDBusProxy *proxy, const char *description)
+{
+	DBusMessageIter iter;
+	const char *address, *name;
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
+	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) == TRUE)
+		dbus_message_iter_get_basic(&iter, &name);
+	else
+		name = "<unknown>";
+
+	rl_printf("%s%s%sController %s %s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				address, name,
+				default_ctrl &&
+				default_ctrl->proxy == proxy ?
+				"[default]" : "");
+
+}
+
+static void print_device(GDBusProxy *proxy, const char *description)
+{
+	DBusMessageIter iter;
+	const char *address, *name;
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
+	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) == TRUE)
+		dbus_message_iter_get_basic(&iter, &name);
+	else
+		name = "<unknown>";
+
+	rl_printf("%s%s%sDevice %s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				address, name);
+}
+
+static void print_iter(const char *label, const char *name,
+						DBusMessageIter *iter)
+{
+	dbus_bool_t valbool;
+	dbus_uint32_t valu32;
+	dbus_uint16_t valu16;
+	dbus_int16_t vals16;
+	unsigned char byte;
+	const char *valstr;
+	DBusMessageIter subiter;
+	char *entry;
+
+	if (iter == NULL) {
+		rl_printf("%s%s is nil\n", label, name);
+		return;
+	}
+
+	switch (dbus_message_iter_get_arg_type(iter)) {
+	case DBUS_TYPE_INVALID:
+		rl_printf("%s%s is invalid\n", label, name);
+		break;
+	case DBUS_TYPE_STRING:
+	case DBUS_TYPE_OBJECT_PATH:
+		dbus_message_iter_get_basic(iter, &valstr);
+		rl_printf("%s%s: %s\n", label, name, valstr);
+		break;
+	case DBUS_TYPE_BOOLEAN:
+		dbus_message_iter_get_basic(iter, &valbool);
+		rl_printf("%s%s: %s\n", label, name,
+					valbool == TRUE ? "yes" : "no");
+		break;
+	case DBUS_TYPE_UINT32:
+		dbus_message_iter_get_basic(iter, &valu32);
+		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		break;
+	case DBUS_TYPE_UINT16:
+		dbus_message_iter_get_basic(iter, &valu16);
+		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		break;
+	case DBUS_TYPE_INT16:
+		dbus_message_iter_get_basic(iter, &vals16);
+		rl_printf("%s%s: %d\n", label, name, vals16);
+		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_basic(iter, &byte);
+		rl_printf("%s%s: 0x%02x\n", label, name, byte);
+		break;
+	case DBUS_TYPE_VARIANT:
+		dbus_message_iter_recurse(iter, &subiter);
+		print_iter(label, name, &subiter);
+		break;
+	case DBUS_TYPE_ARRAY:
+		dbus_message_iter_recurse(iter, &subiter);
+		while (dbus_message_iter_get_arg_type(&subiter) !=
+							DBUS_TYPE_INVALID) {
+			print_iter(label, name, &subiter);
+			dbus_message_iter_next(&subiter);
+		}
+		break;
+	case DBUS_TYPE_DICT_ENTRY:
+		dbus_message_iter_recurse(iter, &subiter);
+		entry = g_strconcat(name, "Key", NULL);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
+
+		entry = g_strconcat(name, " Value", NULL);
+		dbus_message_iter_next(&subiter);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
+		break;
+	default:
+		rl_printf("%s%s has unsupported type\n", label, name);
+		break;
+	}
+}
+
+static void print_property(GDBusProxy *proxy, const char *name)
+{
+	DBusMessageIter iter;
+
+	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
+		return;
+
+	print_iter("\t", name, &iter);
+}
+
+static void forget_mesh_devices()
+{
+	g_list_free_full(default_ctrl->mesh_devices, g_free);
+	default_ctrl->mesh_devices = NULL;
+}
+
+static struct mesh_device *find_device_by_uuid(GList *source, uint8_t uuid[16])
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct mesh_device *dev = list->data;
+
+		if (!memcmp(dev->dev_uuid, uuid, 16))
+			return dev;
+	}
+
+	return NULL;
+}
+
+static void print_prov_service(struct prov_svc_data *prov_data)
+{
+	const char *prefix = "\t\t";
+	char txt_uuid[16 * 2 + 1];
+	int i;
+
+	rl_printf("%sMesh Provisioning Service (%s)\n", prefix,
+							MESH_PROV_SVC_UUID);
+	for (i = 0; i < 16; ++i) {
+		sprintf(txt_uuid + (i * 2), "%2.2x", prov_data->dev_uuid[i]);
+	}
+
+	rl_printf("%s\tDevice UUID: %s\n", prefix, txt_uuid);
+	rl_printf("%s\tOOB: %4.4x\n", prefix, prov_data->oob);
+
+}
+
+static bool parse_prov_service_data(const char *uuid, uint8_t *data, int len,
+								void *data_out)
+{
+	struct prov_svc_data *prov_data = data_out;
+	int i;
+
+	if (len < 18)
+		return false;
+
+	for (i = 0; i < 16; ++i) {
+		prov_data->dev_uuid[i] = data[i];
+	}
+
+	prov_data->oob = get_be16(&data[16]);
+
+	return true;
+}
+
+static bool parse_mesh_service_data(const char *uuid, uint8_t *data, int len,
+								void *data_out)
+{
+	const char *prefix = "\t\t";
+
+	if (!(len == 9 && data[0] == 0x00) && !(len == 17 && data[0] == 0x01)) {
+		rl_printf("Unexpected mesh proxy service data length %d\n",
+									len);
+		return false;
+	}
+
+	if (data[0] != connection.type)
+		return false;
+
+	if (data[0] == CONN_TYPE_IDENTITY) {
+		uint8_t *key;
+
+		if (IS_UNASSIGNED(connection.unicast)) {
+			/* This would be a bug */
+			rl_printf("Error: Searching identity with "
+							"unicast 0000\n");
+			return false;
+		}
+
+		key = keys_net_key_get(prov_net_key_index, true);
+		if (!key)
+			return false;
+
+		if (!mesh_crypto_identity_check(key, connection.unicast,
+					       &data[1]))
+			return false;
+
+		if (discovering) {
+			rl_printf("\n%sMesh Proxy Service (%s)\n", prefix,
+									uuid);
+			rl_printf("%sIdentity for node %4.4x\n", prefix,
+							connection.unicast);
+		}
+
+	} else if (data[0] == CONN_TYPE_NETWORK) {
+		uint16_t net_idx = net_validate_proxy_beacon(data + 1);
+
+		if (net_idx == NET_IDX_INVALID || net_idx != connection.net_idx)
+			return false;
+
+		if (discovering) {
+			rl_printf("\n%sMesh Proxy Service (%s)\n", prefix,
+									uuid);
+			rl_printf("%sNetwork Beacon for net index %4.4x\n",
+							prefix, net_idx);
+		}
+	}
+
+	return true;
+}
+
+static bool parse_service_data(GDBusProxy *proxy, const char *target_uuid,
+					void *data_out)
+{
+	DBusMessageIter iter, entries;
+	bool mesh_prov = false;
+	bool mesh_proxy = false;
+
+	if (target_uuid) {
+		mesh_prov = !strcmp(target_uuid, MESH_PROV_SVC_UUID);
+		mesh_proxy = !strcmp(target_uuid, MESH_PROXY_SVC_UUID);
+	}
+
+	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &entries);
+
+	while (dbus_message_iter_get_arg_type(&entries)
+						== DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry, array;
+		const char *uuid_str;
+		bt_uuid_t uuid;
+		uint8_t *service_data;
+		int len;
+
+		dbus_message_iter_recurse(&entries, &entry);
+		dbus_message_iter_get_basic(&entry, &uuid_str);
+
+		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
+			goto fail;
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto fail;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&value, &array);
+
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_fixed_array(&array, &service_data, &len);
+
+		if (mesh_prov && !strcmp(uuid_str, MESH_PROV_SVC_UUID)) {
+			return parse_prov_service_data(uuid_str, service_data,
+								len, data_out);
+		} else if (mesh_proxy &&
+				!strcmp(uuid_str, MESH_PROXY_SVC_UUID)) {
+			return parse_mesh_service_data(uuid_str, service_data,
+								len, data_out);
+		}
+
+		dbus_message_iter_next(&entries);
+	}
+
+	if (!target_uuid)
+		return true;
+fail:
+	return false;
+}
+
+static void print_uuids(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, value;
+
+	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_recurse(&iter, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) == DBUS_TYPE_STRING) {
+		const char *uuid, *text;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		text = uuidstr_to_str(uuid);
+		if (text) {
+			char str[26];
+			unsigned int n;
+
+			str[sizeof(str) - 1] = '\0';
+
+			n = snprintf(str, sizeof(str), "%s", text);
+			if (n > sizeof(str) - 1) {
+				str[sizeof(str) - 2] = '.';
+				str[sizeof(str) - 3] = '.';
+				if (str[sizeof(str) - 4] == ' ')
+					str[sizeof(str) - 4] = '.';
+
+				n = sizeof(str) - 1;
+			}
+
+			rl_printf("\tUUID: %s%*c(%s)\n",
+						str, 26 - n, ' ', uuid);
+		} else
+			rl_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
+{
+	DBusMessageIter iter;
+	const char *adapter, *path;
+
+	if (!master)
+		return FALSE;
+
+	if (g_dbus_proxy_get_property(device, "Adapter", &iter) == FALSE)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &adapter);
+	path = g_dbus_proxy_get_path(master);
+
+	if (!strcmp(path, adapter))
+		return TRUE;
+
+	return FALSE;
+}
+
+static struct adapter *find_parent(GDBusProxy *device)
+{
+	GList *list;
+
+	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+
+		if (device_is_child(device, adapter->proxy) == TRUE)
+			return adapter;
+	}
+	return NULL;
+}
+
+static void set_connected_device(GDBusProxy *proxy)
+{
+	char *desc = NULL;
+	DBusMessageIter iter;
+	char buf[10];
+	bool mesh;
+
+	connection.device = proxy;
+
+	if (proxy == NULL) {
+		memset(&connection, 0, sizeof(connection));
+		connection.type = CONN_TYPE_INVALID;
+		goto done;
+	}
+
+	if (connection.type == CONN_TYPE_IDENTITY) {
+		mesh = true;
+		snprintf(buf, 10, "Node-%4.4x", connection.unicast);
+	} else if (connection.type == CONN_TYPE_NETWORK) {
+		mesh = true;
+		snprintf(buf, 9, "Net-%4.4x", connection.net_idx);
+	} else {
+		mesh = false;
+	}
+
+	if (!g_dbus_proxy_get_property(proxy, "Alias", &iter) && !mesh)
+			goto done;
+
+	dbus_message_iter_get_basic(&iter, &desc);
+	desc = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", desc,
+			       (desc && mesh) ? "-" : "",
+				mesh ? buf : "");
+
+done:
+	rl_set_prompt(desc ? desc : PROMPT_ON);
+	rl_printf("\r");
+	rl_on_new_line();
+	g_free(desc);
+
+	/* If disconnected, return to main menu */
+	if (proxy == NULL)
+		cmd_menu_main(true);
+}
+
+static void connect_reply(DBusMessage *message, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to connect: %s\n", error.name);
+		dbus_error_free(&error);
+		set_connected_device(NULL);
+		return;
+	}
+
+	rl_printf("Connection successful\n");
+
+	set_connected_device(proxy);
+}
+
+static void update_device_info(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+	DBusMessageIter iter;
+	struct prov_svc_data prov_data;
+
+	if (!adapter) {
+		/* TODO: Error */
+		return;
+	}
+
+	if (adapter != default_ctrl)
+		return;
+
+	if (!g_dbus_proxy_get_property(proxy, "Address", &iter))
+		return;
+
+	if (parse_service_data(proxy, MESH_PROV_SVC_UUID, &prov_data)) {
+		struct mesh_device *dev;
+
+		dev = find_device_by_uuid(adapter->mesh_devices,
+							prov_data.dev_uuid);
+
+		/* Display provisioning service once per sicovery session */
+		if (discovering && (!dev || !dev->hide))
+						print_prov_service(&prov_data);
+
+		if (dev) {
+			dev->proxy = proxy;
+			dev->hide = discovering;
+			return;
+		}
+
+		dev = g_malloc0(sizeof(struct mesh_device));
+		if (!dev)
+			return;
+
+		dev->proxy = proxy;
+		dev->hide = discovering;
+
+		memcpy(dev->dev_uuid, prov_data.dev_uuid, 16);
+
+		adapter->mesh_devices = g_list_append(adapter->mesh_devices,
+							dev);
+		print_device(proxy, COLORED_NEW);
+
+		node_create_new(&prov_data);
+
+	} else if (parse_service_data(proxy, MESH_PROXY_SVC_UUID, NULL) &&
+								discover_mesh) {
+		bool res;
+
+		g_dbus_proxy_method_call(default_ctrl->proxy, "StopDiscovery",
+						NULL, NULL, NULL, NULL);
+		discover_mesh = false;
+
+		forget_mesh_devices();
+
+		res = g_dbus_proxy_method_call(proxy, "Connect", NULL,
+						connect_reply, proxy, NULL);
+
+		if (!res)
+			rl_printf("Failed to connect to mesh\n");
+
+		else
+			rl_printf("Trying to connect to mesh\n");
+
+	}
+}
+
+static void adapter_added(GDBusProxy *proxy)
+{
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	adapter->proxy = proxy;
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
+	print_adapter(proxy, COLORED_NEW);
+}
+
+static void data_out_notify(GDBusProxy *proxy, bool enable,
+				GDBusReturnFunction cb)
+{
+	struct mesh_node *node;
+
+	node = node_find_by_uuid(connection.dev_uuid);
+
+	if (!mesh_gatt_notify(proxy, enable, cb, node))
+		rl_printf("Failed to %s notification on %s\n", enable ?
+				"start" : "stop", g_dbus_proxy_get_path(proxy));
+	else
+		rl_printf("%s notification on %s\n", enable ?
+			  "Start" : "Stop", g_dbus_proxy_get_path(proxy));
+}
+
+struct disconnect_data {
+	GDBusReturnFunction cb;
+	void *data;
+};
+
+static void disconnect(GDBusReturnFunction cb, void *user_data)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *addr;
+
+	proxy = connection.device;
+	if (!proxy)
+		return;
+
+	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, cb, user_data,
+							NULL) == FALSE) {
+		rl_printf("Failed to disconnect\n");
+		return;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
+			dbus_message_iter_get_basic(&iter, &addr);
+
+	rl_printf("Attempting to disconnect from %s\n", addr);
+}
+
+static void disc_notify_cb(DBusMessage *message, void *user_data)
+{
+	struct disconnect_data *disc_data = user_data;
+
+	disconnect(disc_data->cb, disc_data->data);
+
+	g_free(user_data);
+}
+
+static void disconnect_device(GDBusReturnFunction cb, void *user_data)
+{
+	DBusMessageIter iter;
+
+	net_session_close(connection.data_in);
+
+	/* Stop notificiation on prov_out or proxy out characteristics */
+	if (connection.data_out) {
+		if (g_dbus_proxy_get_property(connection.data_out, "Notifying",
+							&iter) == TRUE) {
+			struct disconnect_data *disc_data;
+			disc_data = g_malloc(sizeof(struct disconnect_data));
+			disc_data->cb = cb;
+			disc_data->data = user_data;
+
+			if (mesh_gatt_notify(connection.data_out, false,
+						disc_notify_cb, disc_data))
+				return;
+		}
+	}
+
+	disconnect(cb, user_data);
+}
+
+static void mesh_prov_done(void *user_data, int status);
+
+static void notify_prov_out_cb(DBusMessage *message, void *user_data)
+{
+	struct mesh_node *node = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to start notify: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Notify for Mesh Provisioning Out Data started\n");
+
+	if (connection.type != CONN_TYPE_PROVISION) {
+		rl_printf("Error: wrong connection type %d (expected %d)\n",
+			connection.type, CONN_TYPE_PROVISION);
+		return;
+	}
+
+	if (!connection.data_in) {
+		rl_printf("Error: don't have mesh provisioning data in\n");
+		return;
+	}
+
+	if (!node) {
+		rl_printf("Error: provisioning node not present\n");
+		return;
+	}
+
+	if(!prov_open(node, connection.data_in, prov_net_key_index,
+			mesh_prov_done, node))
+	{
+		rl_printf("Failed to start provisioning\n");
+		node_free(node);
+		disconnect_device(NULL, NULL);
+	} else
+		rl_printf("Initiated provisioning\n");
+
+}
+
+static void session_open_cb (int status)
+{
+	if (status) {
+		rl_printf("Failed to open Mesh session\n");
+		disconnect_device(NULL, NULL);
+		return;
+	}
+
+	rl_printf("Mesh session is open\n");
+
+	/* Get composition data for a newly provisioned node */
+	if (connection.type == CONN_TYPE_IDENTITY)
+		config_client_get_composition(connection.unicast);
+}
+
+static void notify_proxy_out_cb(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to start notify: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Notify for Mesh Proxy Out Data started\n");
+
+	if (connection.type != CONN_TYPE_IDENTITY &&
+			connection.type != CONN_TYPE_NETWORK) {
+		rl_printf("Error: wrong connection type %d "
+				"(expected %d or %d)\n", connection.type,
+				CONN_TYPE_IDENTITY, CONN_TYPE_NETWORK);
+		return;
+	}
+
+	if (!connection.data_in) {
+		rl_printf("Error: don't have mesh proxy data in\n");
+		return;
+	}
+
+	rl_printf("Trying to open mesh session\n");
+	net_session_open(connection.data_in, true, session_open_cb);
+	connection.session_open = true;
+}
+
+static GDBusProxy *get_characteristic(GDBusProxy *device, const char *char_uuid)
+{
+	GList *l;
+	GDBusProxy *service;
+	const char *svc_uuid;
+
+	if (connection.type == CONN_TYPE_PROVISION) {
+		svc_uuid = MESH_PROV_SVC_UUID;
+	} else {
+		svc_uuid = MESH_PROXY_SVC_UUID;
+	}
+	for (l = service_list; l; l = l->next) {
+		if (mesh_gatt_is_child(l->data, device, "Device") &&
+					service_is_mesh(l->data, svc_uuid))
+			break;
+	}
+
+	if (l)
+		service = l->data;
+	else {
+		rl_printf("Mesh service not found\n");
+		return	NULL;
+	}
+
+	for (l = char_list; l; l = l->next) {
+		if (mesh_gatt_is_child(l->data, service, "Service") &&
+					char_is_mesh(l->data, char_uuid)) {
+			rl_printf("Found matching char: path %s, uuid %s\n",
+				g_dbus_proxy_get_path(l->data), char_uuid);
+			return l->data;
+		}
+	}
+	return NULL;
+}
+
+static void mesh_session_setup(GDBusProxy *proxy)
+{
+	if (connection.type == CONN_TYPE_PROVISION) {
+		connection.data_in = get_characteristic(proxy,
+						MESH_PROV_DATA_IN_UUID_STR);
+		if (!connection.data_in)
+			goto fail;
+
+		connection.data_out = get_characteristic(proxy,
+						MESH_PROV_DATA_OUT_UUID_STR);
+		if (!connection.data_out)
+			goto fail;
+
+		data_out_notify(connection.data_out, true, notify_prov_out_cb);
+
+	} else if (connection.type != CONN_TYPE_INVALID){
+
+		connection.data_in = get_characteristic(proxy,
+						MESH_PROXY_DATA_IN_UUID_STR);
+		if (!connection.data_in)
+			goto fail;
+
+		connection.data_out = get_characteristic(proxy,
+						MESH_PROXY_DATA_OUT_UUID_STR);
+		if (!connection.data_out)
+			goto fail;
+
+		data_out_notify(connection.data_out, true, notify_proxy_out_cb);
+	}
+
+	return;
+
+fail:
+
+	rl_printf("Services resolved, mesh characteristics not found\n");
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.Device1")) {
+		update_device_info(proxy);
+
+	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
+
+		adapter_added(proxy);
+
+	} else if (!strcmp(interface, "org.bluez.GattService1") &&
+						service_is_mesh(proxy, NULL)) {
+
+		rl_printf("Service added %s\n", g_dbus_proxy_get_path(proxy));
+		service_list = g_list_append(service_list, proxy);
+
+	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1") &&
+						char_is_mesh(proxy, NULL)) {
+
+		rl_printf("Char added %s:\n", g_dbus_proxy_get_path(proxy));
+
+		char_list = g_list_append(char_list, proxy);
+	}
+}
+
+static void start_discovery_reply(DBusMessage *message, void *user_data)
+{
+	dbus_bool_t enable = GPOINTER_TO_UINT(user_data);
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to %s discovery: %s\n",
+				enable == TRUE ? "start" : "stop", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
+}
+
+static struct mesh_device *find_device_by_proxy(GList *source,
+							GDBusProxy *proxy)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct mesh_device *dev = list->data;
+		GDBusProxy *proxy = dev->proxy;
+
+		if (dev->proxy == proxy)
+			return dev;
+	}
+
+	return NULL;
+}
+
+static void device_removed(GDBusProxy *proxy)
+{
+	struct adapter *adapter = find_parent(proxy);
+	struct mesh_device *dev;
+
+	if (!adapter) {
+		/* TODO: Error */
+		return;
+	}
+
+	dev = find_device_by_proxy(adapter->mesh_devices, proxy);
+	if (dev)
+		adapter->mesh_devices = g_list_remove(adapter->mesh_devices,
+									dev);
+
+	print_device(proxy, COLORED_DEL);
+
+	if (connection.device == proxy)
+		set_connected_device(NULL);
+
+}
+
+static void adapter_removed(GDBusProxy *proxy)
+{
+	GList *ll;
+	for (ll = g_list_first(ctrl_list); ll; ll = g_list_next(ll)) {
+		struct adapter *adapter = ll->data;
+
+		if (adapter->proxy == proxy) {
+			print_adapter(proxy, COLORED_DEL);
+
+			if (default_ctrl && default_ctrl->proxy == proxy) {
+				default_ctrl = NULL;
+				set_connected_device(NULL);
+			}
+
+			ctrl_list = g_list_remove_link(ctrl_list, ll);
+
+			g_list_free_full(adapter->mesh_devices, g_free);
+			g_free(adapter);
+			g_list_free(ll);
+			return;
+		}
+	}
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.Device1")) {
+		device_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
+		adapter_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattService1")) {
+		if (proxy == connection.service) {
+			if (service_is_mesh(proxy, MESH_PROXY_SVC_UUID)) {
+				data_out_notify(connection.data_out,
+								false, NULL);
+				net_session_close(connection.data_in);
+			}
+			connection.service = NULL;
+			connection.data_in = NULL;
+			connection.data_out = NULL;
+		}
+
+		service_list = g_list_remove(service_list, proxy);
+
+	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		char_list = g_list_remove(char_list, proxy);
+	}
+}
+
+static int get_characteristic_value(DBusMessageIter *value, uint8_t *buf)
+{
+	DBusMessageIter array;
+	uint8_t *data;
+	int len;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
+		return 0;
+
+	dbus_message_iter_recurse(value, &array);
+
+	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+		return 0;
+
+	dbus_message_iter_get_fixed_array(&array, &data, &len);
+	memcpy(buf, data, len);
+
+	return len;
+}
+
+static bool process_mesh_characteristic(GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+	const char *uuid;
+	uint8_t *res;
+	uint8_t buf[256];
+	bool is_prov;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (g_dbus_proxy_get_property(proxy, "Value", &iter) == FALSE)
+		return false;
+
+	is_prov = !bt_uuid_strcmp(uuid, MESH_PROV_DATA_OUT_UUID_STR);
+
+	if (is_prov || !bt_uuid_strcmp(uuid, MESH_PROXY_DATA_OUT_UUID_STR))
+	{
+		struct mesh_node *node;
+		uint16_t len;
+
+		len = get_characteristic_value(&iter, buf);
+
+		if (!len || len > 69)
+			return false;
+
+		res = buf;
+		len = mesh_gatt_sar(&res, len);
+
+		if (!len)
+			return false;
+
+		if (is_prov) {
+			node = node_find_by_uuid(connection.dev_uuid);
+
+			if (!node) {
+				rl_printf("Node not found?\n");
+				return false;
+			}
+
+			return prov_data_ready(node, res, len);
+		}
+
+		return net_data_ready(res, len);
+	}
+
+	return false;
+}
+
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.Device1")) {
+
+		if (default_ctrl && device_is_child(proxy,
+					default_ctrl->proxy) == TRUE) {
+
+			if (strcmp(name, "Connected") == 0) {
+				dbus_bool_t connected;
+				dbus_message_iter_get_basic(iter, &connected);
+
+				if (connected && connection.device == NULL)
+					set_connected_device(proxy);
+				else if (!connected &&
+						connection.device == proxy)
+					set_connected_device(NULL);
+			} else if ((strcmp(name, "Alias") == 0) &&
+						connection.device == proxy) {
+				/* Re-generate prompt */
+				set_connected_device(proxy);
+			} else if (!strcmp(name, "ServiceData")) {
+				update_device_info(proxy);
+			} else if (!strcmp(name, "ServicesResolved")) {
+				gboolean resolved;
+
+				dbus_message_iter_get_basic(iter, &resolved);
+
+				rl_printf("Services resolved %s\n", resolved ?
+								"yes" : "no");
+
+				if (resolved)
+					mesh_session_setup(connection.device);
+			}
+
+		}
+	} else if (!strcmp(interface, "org.bluez.Adapter1")) {
+		DBusMessageIter addr_iter;
+		char *str;
+
+		rl_printf("Adapter property changed \n");
+		if (g_dbus_proxy_get_property(proxy, "Address",
+						&addr_iter) == TRUE) {
+			const char *address;
+
+			dbus_message_iter_get_basic(&addr_iter, &address);
+			str = g_strdup_printf("[" COLORED_CHG
+						"] Controller %s ", address);
+		} else
+			str = g_strdup("");
+
+		if (strcmp(name, "Discovering") == 0) {
+			int temp;
+
+			dbus_message_iter_get_basic(iter, &temp);
+			discovering = !!temp;
+		}
+
+		print_iter(str, name, iter);
+		g_free(str);
+	} else if (!strcmp(interface, "org.bluez.GattService1")) {
+		rl_printf("Service property changed %s\n",
+						g_dbus_proxy_get_path(proxy));
+	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		rl_printf("Characteristic property changed %s\n",
+						g_dbus_proxy_get_path(proxy));
+
+		if ((connection.type == CONN_TYPE_PROVISION) ||
+							connection.session_open)
+			process_mesh_characteristic(proxy);
+	}
+}
+
+static void message_handler(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	rl_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
+					dbus_message_get_member(message));
+}
+
+static struct adapter *find_ctrl_by_address(GList *source, const char *address)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+		DBusMessageIter iter;
+		const char *str;
+
+		if (g_dbus_proxy_get_property(adapter->proxy,
+					"Address", &iter) == FALSE)
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (!strcmp(str, address))
+			return adapter;
+	}
+
+	return NULL;
+}
+
+static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
+{
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing on/off argument\n");
+		return FALSE;
+	}
+
+	if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
+		*value = TRUE;
+		return TRUE;
+	}
+
+	if (!strcmp(arg, "off") || !strcmp(arg, "no")) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	rl_printf("Invalid argument %s\n", arg);
+	return FALSE;
+}
+
+static void cmd_list(const char *arg)
+{
+	GList *list;
+
+	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+		print_adapter(adapter->proxy, NULL);
+	}
+}
+
+static void cmd_show(const char *arg)
+{
+	struct adapter *adapter;
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *address;
+
+
+	if (!arg || !strlen(arg)) {
+		if (check_default_ctrl() == FALSE)
+			return;
+
+		proxy = default_ctrl->proxy;
+	} else {
+		adapter = find_ctrl_by_address(ctrl_list, arg);
+		if (!adapter) {
+			rl_printf("Controller %s not available\n", arg);
+			return;
+		}
+		proxy = adapter->proxy;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+	rl_printf("Controller %s\n", address);
+
+	print_property(proxy, "Name");
+	print_property(proxy, "Alias");
+	print_property(proxy, "Class");
+	print_property(proxy, "Powered");
+	print_property(proxy, "Discoverable");
+	print_uuids(proxy);
+	print_property(proxy, "Modalias");
+	print_property(proxy, "Discovering");
+}
+
+static void cmd_select(const char *arg)
+{
+	struct adapter *adapter;
+
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing controller address argument\n");
+		return;
+	}
+
+	adapter = find_ctrl_by_address(ctrl_list, arg);
+	if (!adapter) {
+		rl_printf("Controller %s not available\n", arg);
+		return;
+	}
+
+	if (default_ctrl && default_ctrl->proxy == adapter->proxy)
+		return;
+
+	forget_mesh_devices();
+
+	default_ctrl = adapter;
+	print_adapter(adapter->proxy, NULL);
+}
+
+static void generic_callback(const DBusError *error, void *user_data)
+{
+	char *str = user_data;
+
+	if (dbus_error_is_set(error))
+		rl_printf("Failed to set %s: %s\n", str, error->name);
+	else
+		rl_printf("Changing %s succeeded\n", str);
+}
+
+static void cmd_power(const char *arg)
+{
+	dbus_bool_t powered;
+	char *str;
+
+	if (parse_argument_on_off(arg, &powered) == FALSE)
+		return;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	str = g_strdup_printf("power %s", powered == TRUE ? "on" : "off");
+
+	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Powered",
+					DBUS_TYPE_BOOLEAN, &powered,
+					generic_callback, str, g_free) == TRUE)
+		return;
+
+	g_free(str);
+}
+
+static void cmd_scan(const char *arg)
+{
+	dbus_bool_t enable;
+	const char *method;
+
+	if (parse_argument_on_off(arg, &enable) == FALSE)
+		return;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (enable == TRUE) {
+		method = "StartDiscovery";
+	} else {
+		method = "StopDiscovery";
+	}
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
+				NULL, start_discovery_reply,
+				GUINT_TO_POINTER(enable), NULL) == FALSE) {
+		rl_printf("Failed to %s discovery\n",
+					enable == TRUE ? "start" : "stop");
+		return;
+	}
+}
+
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void append_array_variant(DBusMessageIter *iter, int type, void *val,
+							int n_elements)
+{
+	DBusMessageIter variant, array;
+	char type_sig[2] = { type, '\0' };
+	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						array_sig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						type_sig, &array);
+
+	if (dbus_type_is_fixed(type) == TRUE) {
+		dbus_message_iter_append_fixed_array(&array, type, val,
+							n_elements);
+	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		const char ***str_array = val;
+		int i;
+
+		for (i = 0; i < n_elements; i++)
+			dbus_message_iter_append_basic(&array, type,
+							&((*str_array)[i]));
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void dict_append_entry(DBusMessageIter *dict, const char *key,
+							int type, void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, key_type, key);
+
+	append_array_variant(&entry, type, val, n_elements);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
+						void *val, int n_elements)
+{
+	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
+								n_elements);
+}
+
+#define	DISTANCE_VAL_INVALID	0x7FFF
+
+struct set_discovery_filter_args {
+	char *transport;
+	dbus_uint16_t rssi;
+	dbus_int16_t pathloss;
+	char **uuids;
+	size_t uuids_len;
+	dbus_bool_t reset;
+};
+
+static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct set_discovery_filter_args *args = user_data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &args->uuids,
+							args->uuids_len);
+
+	if (args->pathloss != DISTANCE_VAL_INVALID)
+		dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
+						&args->pathloss);
+
+	if (args->rssi != DISTANCE_VAL_INVALID)
+		dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16, &args->rssi);
+
+	if (args->transport != NULL)
+		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
+						&args->transport);
+	if (args->reset)
+		dict_append_entry(&dict, "ResetData", DBUS_TYPE_BOOLEAN,
+						&args->reset);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+
+static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("SetDiscoveryFilter failed: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("SetDiscoveryFilter success\n");
+}
+
+static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
+static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+static char **filtered_scan_uuids;
+static size_t filtered_scan_uuids_len;
+static char *filtered_scan_transport = "le";
+
+static void set_scan_filter_commit(void)
+{
+	struct set_discovery_filter_args args;
+
+	args.pathloss = filtered_scan_pathloss;
+	args.rssi = filtered_scan_rssi;
+	args.transport = filtered_scan_transport;
+	args.uuids = filtered_scan_uuids;
+	args.uuids_len = filtered_scan_uuids_len;
+	args.reset = TRUE;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
+		set_discovery_filter_setup, set_discovery_filter_reply,
+		&args, NULL) == FALSE) {
+		rl_printf("Failed to set discovery filter\n");
+		return;
+	}
+}
+
+static void set_scan_filter_uuids(const char *arg)
+{
+	g_strfreev(filtered_scan_uuids);
+	filtered_scan_uuids = NULL;
+	filtered_scan_uuids_len = 0;
+
+	if (!arg || !strlen(arg))
+		goto commit;
+
+	rl_printf("set_scan_filter_uuids %s\n", arg);
+	filtered_scan_uuids = g_strsplit(arg, " ", -1);
+	if (!filtered_scan_uuids) {
+		rl_printf("Failed to parse input\n");
+		return;
+	}
+
+	filtered_scan_uuids_len = g_strv_length(filtered_scan_uuids);
+
+commit:
+	set_scan_filter_commit();
+}
+
+static void cmd_scan_unprovisioned_devices(const char *arg)
+{
+	dbus_bool_t enable;
+
+	if (parse_argument_on_off(arg, &enable) == FALSE)
+		return;
+
+	if (enable == TRUE) {
+		discover_mesh = false;
+		set_scan_filter_uuids(MESH_PROV_SVC_UUID);
+	}
+	cmd_scan(arg);
+}
+
+static void cmd_info(const char *arg)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *address;
+
+	proxy = connection.device;
+	if (!proxy)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+	rl_printf("Device %s\n", address);
+
+	print_property(proxy, "Name");
+	print_property(proxy, "Alias");
+	print_property(proxy, "Class");
+	print_property(proxy, "Appearance");
+	print_property(proxy, "Icon");
+	print_property(proxy, "Trusted");
+	print_property(proxy, "Blocked");
+	print_property(proxy, "Connected");
+	print_uuids(proxy);
+	print_property(proxy, "Modalias");
+	print_property(proxy, "ManufacturerData");
+	print_property(proxy, "ServiceData");
+	print_property(proxy, "RSSI");
+	print_property(proxy, "TxPower");
+}
+
+static void cmd_connect(const char *arg)
+{
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	memset(&connection, 0, sizeof(connection));
+
+	if (!arg || !strlen(arg)) {
+		connection.net_idx = NET_IDX_PRIMARY;
+	} else {
+		char *end;
+		connection.net_idx = strtol(arg, &end, 16);
+		if (end == arg) {
+			connection.net_idx = NET_IDX_INVALID;
+			rl_printf("Invalid network index %s\n", arg);
+			return;
+		}
+	}
+
+	if (discovering)
+		g_dbus_proxy_method_call(default_ctrl->proxy, "StopDiscovery",
+						NULL, NULL, NULL, NULL);
+
+	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
+	discover_mesh = true;
+
+	connection.type = CONN_TYPE_NETWORK;
+
+
+	rl_printf("Looking for mesh network with net index %4.4x\n",
+							connection.net_idx);
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy,
+			"StartDiscovery", NULL, start_discovery_reply,
+				GUINT_TO_POINTER(TRUE), NULL) == FALSE)
+		rl_printf("Failed to start mesh proxy discovery\n");
+
+	g_dbus_proxy_method_call(default_ctrl->proxy, "StartDiscovery",
+						NULL, NULL, NULL, NULL);
+
+}
+
+static void prov_disconn_reply(DBusMessage *message, void *user_data)
+{
+	struct mesh_node *node = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to disconnect: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	set_connected_device(NULL);
+
+	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
+	discover_mesh = true;
+
+	connection.type = CONN_TYPE_IDENTITY;
+	connection.data_in = NULL;
+	connection.data_out = NULL;
+	connection.unicast = node_get_primary(node);
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy,
+			"StartDiscovery", NULL, start_discovery_reply,
+				GUINT_TO_POINTER(TRUE), NULL) == FALSE)
+		rl_printf("Failed to start mesh proxy discovery\n");
+
+}
+
+static void disconn_reply(DBusMessage *message, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to disconnect: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Successfully disconnected\n");
+
+	if (proxy != connection.device)
+		return;
+
+	set_connected_device(NULL);
+}
+
+static void cmd_disconn(const char *arg)
+{
+	if (connection.type == CONN_TYPE_PROVISION) {
+		struct mesh_node *node = node_find_by_uuid(connection.dev_uuid);
+		if (node)
+			node_free(node);
+	}
+
+	disconnect_device(disconn_reply, connection.device);
+}
+
+static void mesh_prov_done(void *user_data, int status)
+{
+	struct mesh_node *node = user_data;
+
+	if (status){
+		rl_printf("Provisioning failed\n");
+		node_free(node);
+		disconnect_device(NULL, NULL);
+		return;
+	}
+
+	rl_printf("Provision success. Assigned Primary Unicast %4.4x\n",
+						node_get_primary(node));
+
+	if (!prov_db_add_new_node(node))
+		rl_printf("Failed to add node to provisioning DB\n");
+
+	disconnect_device(prov_disconn_reply, node);
+}
+
+static void cmd_start_prov(const char *arg)
+{
+	GDBusProxy *proxy;
+	struct mesh_device *dev;
+	struct mesh_node *node;
+	int len;
+
+	if (!arg) {
+		rl_printf("Mesh Device UUID is required\n");
+		return;
+	}
+
+	len = strlen(arg);
+	if ( len > 32 || len % 2) {
+		rl_printf("Incorrect UUID size %d\n", len);
+	}
+
+	disconnect_device(NULL, NULL);
+
+	memset(connection.dev_uuid, 0, 16);
+	str2hex(arg, len, connection.dev_uuid, len/2);
+
+	node = node_find_by_uuid(connection.dev_uuid);
+	if (!node) {
+		rl_printf("Device with UUID %s not found.\n", arg);
+		rl_printf("Stale services? Remove device and re-discover\n");
+		return;
+	}
+
+	/* TODO: add command to remove a node from mesh, i.e., "unprovision" */
+	if (node_is_provisioned(node)) {
+		rl_printf("Already provisioned with unicast %4.4x\n",
+				node_get_primary(node));
+		return;
+	}
+
+	dev = find_device_by_uuid(default_ctrl->mesh_devices,
+				  connection.dev_uuid);
+	if (!dev || !dev->proxy) {
+		rl_printf("Could not find device proxy\n");
+		memset(connection.dev_uuid, 0, 16);
+		return;
+	}
+
+	proxy = dev->proxy;
+	if (discovering)
+		g_dbus_proxy_method_call(default_ctrl->proxy, "StopDiscovery",
+						NULL, NULL, NULL, NULL);
+	forget_mesh_devices();
+
+	connection.type = CONN_TYPE_PROVISION;
+
+	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
+							proxy, NULL) == FALSE) {
+		rl_printf("Failed to connect ");
+		print_device(proxy, NULL);
+		return;
+	} else {
+		rl_printf("Trying to connect ");
+		print_device(proxy, NULL);
+	}
+
+}
+
+static void cmd_config(const char *arg)
+{
+	rl_printf("Switching to Mesh Client configuration menu\n");
+
+	if (!switch_cmd_menu("configure"))
+		return;
+
+	set_menu_prompt("config", NULL);
+
+	if (arg && strlen(arg))
+		config_set_node(arg);
+}
+
+static void cmd_onoff_cli(const char *arg)
+{
+	rl_printf("Switching to Mesh Generic ON OFF Client menu\n");
+
+	if (!switch_cmd_menu("onoff"))
+		return;
+
+	set_menu_prompt("on/off", NULL);
+
+	if (arg && strlen(arg))
+		onoff_set_node(arg);
+}
+
+static void cmd_print_mesh(const char *arg)
+{
+	if (!prov_db_show(mesh_prov_db_filename))
+		rl_printf("Unavailable\n");
+
+}
+
+ static void cmd_print_local(const char *arg)
+{
+	if (!prov_db_show(mesh_local_config_filename))
+		rl_printf("Unavailable\n");
+}
+
+static void disc_quit_cb(DBusMessage *message, void *user_data)
+{
+	g_main_loop_quit(main_loop);
+}
+
+static void cmd_quit(const char *arg)
+{
+	if (connection.device) {
+		disconnect_device(disc_quit_cb, NULL);
+		return;
+	}
+
+	g_main_loop_quit(main_loop);
+}
+
+static const struct menu_entry meshctl_cmd_table[] = {
+	{ "list",         NULL,       cmd_list, "List available controllers"},
+	{ "show",         "[ctrl]",   cmd_show, "Controller information"},
+	{ "select",       "<ctrl>",   cmd_select, "Select default controller"},
+	{ "info",         "[dev]",    cmd_info, "Device information"},
+	{ "connect",      "[net_idx]",cmd_connect, "Connect to mesh network"},
+	{ "discover-unprovisioned", "<on/off>", cmd_scan_unprovisioned_devices,
+					"Look for devices to provision" },
+	{ "provision",    "<uuid>",   cmd_start_prov, "Initiate provisioning"},
+	{ "power",        "<on/off>", cmd_power, "Set controller power" },
+	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device"},
+	{ "mesh-info",    NULL,       cmd_print_mesh,
+					"Mesh networkinfo (provisioner)" },
+	{ "local-info",    NULL,      cmd_print_local, "Local mesh node info" },
+	{ "configure",    "[dst]",    cmd_config, "Config client model menu"},
+	{ "onoff",        "[dst]",    cmd_onoff_cli,
+						"Generic On/Off model menu"},
+	{ "quit",         NULL,       cmd_quit, "Quit program" },
+	{ "exit",         NULL,       cmd_quit },
+	{ "help" },
+	{ }
+};
+
+static void rl_handler(char *input)
+{
+	char *cmd, *arg;
+
+	if (!input) {
+		rl_insert_text("quit");
+		rl_redisplay();
+		rl_crlf();
+		g_main_loop_quit(main_loop);
+		return;
+	}
+
+	if (!strlen(input))
+		goto done;
+	else if (!strcmp(input, "q") || !strcmp(input, "quit")
+						|| !strcmp(input, "exit")) {
+		cmd_quit(NULL);
+		goto done;
+	}
+
+	if (agent_input(input) == TRUE)
+		goto done;
+
+	add_history(input);
+
+	cmd = strtok_r(input, " \t\r\n", &arg);
+	if (!cmd)
+		goto done;
+
+	process_menu_cmd(cmd, arg);
+
+done:
+	free(input);
+}
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	static bool terminated = false;
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_main_loop_quit(main_loop);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+		if (input) {
+			rl_replace_line("", 0);
+			rl_crlf();
+			rl_on_new_line();
+			rl_redisplay();
+			break;
+		}
+
+		/*
+		 * If input was not yet setup up that means signal was received
+		 * while daemon was not yet running. Since user is not able
+		 * to terminate client by CTRL-D or typing exit treat this as
+		 * exit and fall through.
+		 */
+
+		/* fall through */
+	case SIGTERM:
+		if (!terminated) {
+			rl_replace_line("", 0);
+			rl_crlf();
+			g_main_loop_quit(main_loop);
+		}
+
+		terminated = true;
+		break;
+	}
+
+	return TRUE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Failed to set signal mask");
+		return 0;
+	}
+
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
+	}
+
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+static gboolean option_version = FALSE;
+static const char *mesh_config_dir;
+
+static GOptionEntry options[] = {
+	{ "config", 'c', 0, G_OPTION_ARG_STRING, &mesh_config_dir,
+			"Read local mesh config JSON files from <directory>" },
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit" },
+	{ NULL },
+};
+
+static void client_ready(GDBusClient *client, void *user_data)
+{
+	if (!input)
+		input = setup_standard_input();
+}
+
+int main(int argc, char *argv[])
+{
+	GOptionContext *context;
+	GError *error = NULL;
+	GDBusClient *client;
+	guint signal;
+	int len;
+	int extra;
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
+		if (error != NULL) {
+			g_printerr("%s\n", error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+		exit(1);
+	}
+
+	g_option_context_free(context);
+
+	if (option_version == TRUE) {
+		rl_printf("%s\n", VERSION);
+		exit(0);
+	}
+
+	if (!mesh_config_dir) {
+		rl_printf("Local config directory not provided.\n");
+		mesh_config_dir = "";
+	} else {
+		rl_printf("Reading prov_db.json and local_node.json from %s\n",
+							mesh_config_dir);
+	}
+
+	len = strlen(mesh_config_dir);
+	if (len && mesh_config_dir[len - 1] != '/') {
+		extra = 1;
+		rl_printf("mesh_config_dir[%d] %s\n", len,
+						&mesh_config_dir[len - 1]);
+	} else {
+		extra = 0;
+	}
+	mesh_local_config_filename = g_malloc(len + strlen("local_node.json")
+									+ 2);
+	if (!mesh_local_config_filename)
+		exit(1);
+
+	mesh_prov_db_filename = g_malloc(len + strlen("prov_db.json") + 2);
+	if (!mesh_prov_db_filename) {
+		exit(1);
+	}
+
+	sprintf(mesh_local_config_filename, "%s", mesh_config_dir);
+
+	if (extra)
+		sprintf(mesh_local_config_filename + len , "%c", '/');
+
+	sprintf(mesh_local_config_filename + len + extra, "%s",
+							"local_node.json");
+	len = len + extra + strlen("local_node.json");
+	sprintf(mesh_local_config_filename + len, "%c", '\0');
+
+	if (!prov_db_read_local_node(mesh_local_config_filename, true)) {
+		g_printerr("Failed to parse local node configuration file %s\n",
+			mesh_local_config_filename);
+		exit(1);
+	}
+
+	sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
+	len = strlen(mesh_config_dir);
+	if (extra)
+		sprintf(mesh_prov_db_filename + len , "%c", '/');
+
+	sprintf(mesh_prov_db_filename + len + extra, "%s", "prov_db.json");
+	sprintf(mesh_prov_db_filename + len + extra + strlen("prov_db.json"),
+								"%c", '\0');
+
+	if (!prov_db_read(mesh_prov_db_filename)) {
+		g_printerr("Failed to parse provisioning database file %s\n",
+			mesh_prov_db_filename);
+		exit(1);
+	}
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+
+	setlinebuf(stdout);
+
+	rl_erase_empty_line = 1;
+	rl_callback_handler_install(NULL, rl_handler);
+
+	rl_set_prompt(PROMPT_OFF);
+	rl_redisplay();
+
+	signal = setup_signalfd();
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+	g_dbus_client_set_signal_watch(client, message_handler, NULL);
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							property_changed, NULL);
+
+	g_dbus_client_set_ready_watch(client, client_ready, NULL);
+
+	cmd_menu_init(meshctl_cmd_table);
+
+	if (!config_client_init())
+		g_printerr("Failed to initialize mesh configuration client\n");
+
+	if (!config_server_init())
+		g_printerr("Failed to initialize mesh configuration server\n");
+
+	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic On/Off client\n");
+
+	g_main_loop_run(main_loop);
+
+	g_dbus_client_unref(client);
+	g_source_remove(signal);
+	if (input > 0)
+		g_source_remove(input);
+
+	rl_message("");
+	rl_callback_handler_remove();
+
+	dbus_connection_unref(dbus_conn);
+	g_main_loop_unref(main_loop);
+
+	node_cleanup();
+
+	g_list_free(char_list);
+	g_list_free(service_list);
+	g_list_free_full(ctrl_list, proxy_leak);
+
+	agent_release();
+
+	return 0;
+}
diff --git a/mesh/net.c b/mesh/net.c
new file mode 100644
index 0000000..fb2d200
--- /dev/null
+++ b/mesh/net.c
@@ -0,0 +1,2184 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <inttypes.h>
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "client/display.h"
+
+#include "crypto.h"
+#include "gatt.h"
+#include "mesh-net.h"
+#include "util.h"
+#include "keys.h"
+#include "node.h"
+#include "prov-db.h"
+#include "net.h"
+
+struct address_range
+{
+	uint16_t min;
+	uint16_t max;
+};
+
+struct mesh_net {
+	uint32_t iv_index;
+	uint32_t seq_num;
+	uint32_t seq_num_reserved;
+	uint16_t primary_addr;
+	uint8_t iv_upd_state;
+	uint8_t num_elements;
+	uint8_t default_ttl;
+	bool iv_update;
+	bool provisioner;
+	bool blacklist;
+	guint iv_update_timeout;
+	GDBusProxy *proxy_in;
+	GList *address_pool;
+	GList *dest;	/* List of valid local destinations for Whitelist */
+	GList *sar_in;	/* Incoming segmented messages in progress */
+	GList *msg_out;	/* Pre-Network encoded, might be multi-segment */
+	GList *pkt_out; /* Fully encoded packets awaiting Tx in order */
+	net_mesh_session_open_callback open_cb;
+};
+
+struct generic_key {
+	uint16_t	idx;
+};
+
+struct net_key_parts {
+	uint8_t nid;
+	uint8_t enc_key[16];
+	uint8_t privacy_key[16];
+	uint8_t	net_key[16];
+	uint8_t	beacon_key[16];
+	uint8_t	net_id[8];
+};
+
+struct mesh_net_key {
+	struct generic_key	generic;
+	uint8_t			phase;
+	struct net_key_parts	current;
+	struct net_key_parts	new;
+};
+
+struct app_key_parts {
+	uint8_t key[16];
+	uint8_t akf_aid;
+};
+
+struct mesh_app_key {
+	struct generic_key	generic;
+	uint16_t		net_idx;
+	struct app_key_parts	current;
+	struct app_key_parts	new;
+};
+
+struct mesh_virt_addr {
+	uint16_t	va16;
+	uint32_t	va32;
+	uint8_t		va128[16];
+};
+
+struct mesh_pkt {
+	uint8_t		data[30];
+	uint8_t		len;
+};
+
+struct mesh_sar_msg {
+	guint		ack_to;
+	guint		msg_to;
+	uint32_t	iv_index;
+	uint32_t	seqAuth;
+	uint32_t	ack;
+	uint32_t	dst;
+	uint16_t	src;
+	uint16_t	net_idx;
+	uint16_t	len;
+	uint8_t		akf_aid;
+	uint8_t		ttl;
+	uint8_t		segN;
+	uint8_t		activity_cnt;
+	bool		ctl;
+	bool		segmented;
+	bool		szmic;
+	bool		proxy;
+	uint8_t		data[20]; /* Open ended, min 20 */
+};
+
+struct mesh_destination {
+	uint16_t	cnt;
+	uint16_t	dst;
+};
+
+/* Network Packet Layer based Offsets */
+#define AKF_BIT			0x40
+
+#define PKT_IVI(p)		!!((p)[0] & 0x80)
+#define SET_PKT_IVI(p,v)	do {(p)[0] &= 0x7f; \
+					(p)[0] |= ((v) ? 0x80 : 0);} while(0)
+#define PKT_NID(p)		((p)[0] & 0x7f)
+#define SET_PKT_NID(p,v)	do {(p)[0] &= 0x80; (p)[0] |= (v);} while(0)
+#define PKT_CTL(p)		(!!((p)[1] & 0x80))
+#define SET_PKT_CTL(p,v)	do {(p)[1] &= 0x7f; \
+					(p)[1] |= ((v) ? 0x80 : 0);} while(0)
+#define PKT_TTL(p)		((p)[1] & 0x7f)
+#define SET_PKT_TTL(p,v)	do {(p)[1] &= 0x80; (p)[1] |= (v);} while(0)
+#define PKT_SEQ(p)		(get_be32((p) + 1) & 0xffffff)
+#define SET_PKT_SEQ(p,v)	put_be32(((p)[1] << 24) + ((v) & 0xffffff), \
+									(p) + 1)
+#define PKT_SRC(p)		get_be16((p) + 5)
+#define SET_PKT_SRC(p,v)	put_be16(v, (p) + 5)
+#define PKT_DST(p)		get_be16((p) + 7)
+#define SET_PKT_DST(p,v)	put_be16(v, (p) + 7)
+#define PKT_TRANS(p)		((p) + 9)
+#define PKT_TRANS_LEN(l)	((l) - 9)
+
+#define PKT_SEGMENTED(p)	(!!((p)[9] & 0x80))
+#define SET_PKT_SEGMENTED(p,v)	do {(p)[9] &= 0x7f; \
+					(p)[9] |= ((v) ? 0x80 : 0);} while(0)
+#define PKT_AKF_AID(p)		((p)[9] & 0x7f)
+#define SET_PKT_AKF_AID(p,v)	do {(p)[9] &= 0x80; (p)[9] |= (v);} while(0)
+#define PKT_OPCODE(p)		((p)[9] & 0x7f)
+#define SET_PKT_OPCODE(p,v)	do {(p)[9] &= 0x80; (p)[9] |= (v);} while(0)
+#define PKT_OBO(p)		(!!((p)[10] & 0x80))
+#define PKT_SZMIC(p)		(!!(PKT_SEGMENTED(p) ? ((p)[10] & 0x40) : 0))
+#define SET_PKT_SZMIC(p,v)	do {(p)[10] &= 0x7f; \
+					(p)[10] |= ((v) ? 0x80 : 0);} while(0)
+#define PKT_SEQ0(p)		((get_be16((p) + 10) >> 2) & 0x1fff)
+#define SET_PKT_SEQ0(p,v)	do {put_be16((get_be16((p) + 10) & 0x8003) \
+					| (((v) & 0x1fff) << 2), \
+					(p) + 10);} while(0)
+#define SET_PKT_SEGO(p,v)	do {put_be16((get_be16( \
+					(p) + 11) & 0xfc1f) | ((v) << 5), \
+					(p) + 11);} while(0)
+#define SET_PKT_SEGN(p,v)	do {(p)[12] = ((p)[12] & 0xe0) | (v);} while(0)
+#define PKT_ACK(p)		(get_be32((p) + 12))
+#define SET_PKT_ACK(p,v)	(put_be32((v)(p) + 12))
+
+/* Transport Layer based offsets */
+#define TRANS_SEGMENTED(t)	(!!((t)[0] & 0x80))
+#define SET_TRANS_SEGMENTD(t,v)	do {(t)[0] &= 0x7f; \
+					(t)[0] |= ((v) ? 0x80 : 0);} while(0)
+#define TRANS_OPCODE(t)		((t)[0] & 0x7f)
+#define SET_TRANS_OPCODE(t,v)	do {(t)[0] &= 0x80; (t)[0] |= (v);} while(0)
+#define TRANS_AKF_AID(t)		((t)[0] & 0x7f)
+#define SET_TRANS_AKF_AID(t,v)	do {(t)[0] &= 0xc0; (t)[0] |= (v);} while(0)
+#define TRANS_AKF(t)		(!!((t)[0] & AKF_BIT))
+#define TRANS_SZMIC(t)		(!!(TRANS_SEGMENTED(t) ? ((t)[1] & 0x80) : 0))
+#define TRANS_SEQ0(t)		((get_be16((t) + 1) >> 2) & 0x1fff)
+#define SET_TRANS_SEQ0(t,v)	do {put_be16((get_be16((t) + 1) & 0x8003) \
+					| (((v) & 0x1fff) << 2), \
+					(t) + 1);} while(0)
+#define SET_TRANS_ACK(t,v)	put_be32((v), (t) + 3)
+#define TRANS_SEGO(t)		((get_be16((t) + 2) >> 5) & 0x1f)
+#define TRANS_SEGN(t)		((t)[3] & 0x1f)
+
+#define TRANS_PAYLOAD(t)	((t) + (TRANS_SEGMENTED(t) ? 4 : 1))
+#define TRANS_LEN(t,l)		((l) -(TRANS_SEGMENTED(t) ? 4 : 1))
+
+/* Proxy Config Opcodes */
+#define FILTER_SETUP		0x00
+#define FILTER_ADD		0x01
+#define FILTER_DEL		0x02
+#define FILTER_STATUS		0x03
+
+/* Proxy Filter Types */
+#define WHITELIST_FILTER	0x00
+#define BLACKLIST_FILTER	0x01
+
+/* IV Updating states for timing enforcement */
+#define IV_UPD_INIT 		0
+#define IV_UPD_NORMAL		1
+#define IV_UPD_UPDATING		2
+#define IV_UPD_NORMAL_HOLD	3
+
+#define IV_IDX_DIFF_RANGE	42
+
+static struct mesh_net net;
+static GList *virt_addrs = NULL;
+static GList *net_keys = NULL;
+static GList *app_keys = NULL;
+
+/* Forward static declarations */
+static void resend_segs(struct mesh_sar_msg *sar);
+
+static int match_net_id(const void *a, const void *net_id)
+{
+	const struct mesh_net_key *net_key = a;
+
+	if (net_key->current.nid != 0xff &&
+			!memcmp(net_key->current.net_id, net_id, 8))
+		return 0;
+
+	if (net_key->new.nid != 0xff &&
+			!memcmp(net_key->new.net_id, net_id, 8))
+		return 0;
+
+	return -1;
+}
+
+static struct mesh_net_key *find_net_key_by_id(const uint8_t *net_id)
+{
+	GList *l;
+
+	l = g_list_find_custom(net_keys, net_id, match_net_id);
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+uint16_t net_validate_proxy_beacon(const uint8_t *proxy_beacon)
+{
+	struct mesh_net_key *net_key = find_net_key_by_id(proxy_beacon);
+
+	if (net_key == NULL)
+		return NET_IDX_INVALID;
+
+	return net_key->generic.idx;
+}
+
+static int match_sar_dst(const void *a, const void *b)
+{
+	const struct mesh_sar_msg *sar = a;
+	uint16_t dst = GPOINTER_TO_UINT(b);
+
+	return (sar->dst == dst) ? 0 : -1;
+}
+
+static struct mesh_sar_msg *find_sar_out_by_dst(uint16_t dst)
+{
+	GList *l;
+
+	l = g_list_find_custom(net.msg_out, GUINT_TO_POINTER(dst),
+			match_sar_dst);
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static int match_sar_src(const void *a, const void *b)
+{
+	const struct mesh_sar_msg *sar = a;
+	uint16_t src = GPOINTER_TO_UINT(b);
+
+	return (sar->src == src) ? 0 : -1;
+}
+
+static struct mesh_sar_msg *find_sar_in_by_src(uint16_t src)
+{
+	GList *l;
+
+	l = g_list_find_custom(net.sar_in, GUINT_TO_POINTER(src),
+			match_sar_src);
+
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static int match_key_index(const void *a, const void *b)
+{
+	const struct generic_key *generic = a;
+	uint16_t index = GPOINTER_TO_UINT(b);
+
+	return (generic->idx == index) ? 0 : -1;
+}
+
+static bool delete_key(GList **list, uint16_t index)
+{
+	GList *l;
+
+	l = g_list_find_custom(*list, GUINT_TO_POINTER(index),
+				match_key_index);
+
+	if (!l)
+		return false;
+
+	*list = g_list_delete_link(*list, l);
+
+	return true;
+
+}
+
+static uint8_t *get_key(GList *list, uint16_t index)
+{
+	GList *l;
+	struct mesh_app_key *app_key;
+	struct mesh_net_key *net_key;
+
+	l = g_list_find_custom(list, GUINT_TO_POINTER(index),
+				match_key_index);
+
+	if (!l) return NULL;
+
+	if (list == app_keys) {
+		app_key = l->data;
+
+		/* All App Keys must belong to a valid Net Key */
+		l = g_list_find_custom(net_keys,
+				GUINT_TO_POINTER(app_key->net_idx),
+				match_key_index);
+
+		if (!l) return NULL;
+
+		net_key = l->data;
+
+		if (net_key->phase == 2 && app_key->new.akf_aid != 0xff)
+			return app_key->new.key;
+
+		if (app_key->current.akf_aid != 0xff)
+			return app_key->current.key;
+
+		return NULL;
+	}
+
+	net_key = l->data;
+
+	if (net_key->phase == 2 && net_key->new.nid != 0xff)
+		return net_key->new.net_key;
+
+	if (net_key->current.nid != 0xff)
+		return net_key->current.net_key;
+
+	return NULL;
+}
+
+bool keys_app_key_add(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
+			bool update)
+{
+	struct mesh_app_key *app_key = NULL;
+	uint8_t akf_aid;
+	GList *l = g_list_find_custom(app_keys, GUINT_TO_POINTER(app_idx),
+				match_key_index);
+
+	if (!mesh_crypto_k4(key, &akf_aid))
+		return false;
+
+	akf_aid |= AKF_BIT;
+
+	if (l && update) {
+
+		app_key = l->data;
+
+		if (app_key->net_idx != net_idx)
+			return false;
+
+		memcpy(app_key->new.key, key, 16);
+		app_key->new.akf_aid = akf_aid;
+
+	} else if (l) {
+
+		app_key = l->data;
+
+		if (memcmp(app_key->current.key, key, 16) ||
+				app_key->net_idx != net_idx)
+			return false;
+
+	} else {
+
+		app_key = g_new(struct mesh_app_key, 1);
+		memcpy(app_key->current.key, key, 16);
+		app_key->net_idx = net_idx;
+		app_key->generic.idx = app_idx;
+		app_key->current.akf_aid = akf_aid;
+
+		/* Invalidate "New" version */
+		app_key->new.akf_aid = 0xff;
+
+		app_keys = g_list_append(app_keys, app_key);
+
+	}
+
+	return true;
+}
+
+bool keys_net_key_add(uint16_t net_idx, uint8_t *key, bool update)
+{
+	struct mesh_net_key *net_key = NULL;
+	uint8_t p = 0;
+	GList *l = g_list_find_custom(net_keys, GUINT_TO_POINTER(net_idx),
+				match_key_index);
+
+	if (l && update) {
+		bool result;
+
+		net_key = l->data;
+
+		memcpy(net_key->new.net_key, key, 16);
+
+		/* Calculate the many component parts */
+		result = mesh_crypto_nkbk(key, net_key->new.beacon_key);
+		if (!result)
+			return false;
+
+		result = mesh_crypto_k3(key, net_key->new.net_id);
+		if (!result)
+			return false;
+
+		result = mesh_crypto_k2(key, &p, 1,
+				&net_key->new.nid,
+				net_key->new.enc_key,
+				net_key->new.privacy_key);
+		if (!result)
+			net_key->new.nid = 0xff;
+
+		return result;
+
+	} else if (l) {
+		net_key = l->data;
+
+		if (memcmp(net_key->current.net_key, key, 16))
+			return false;
+	} else {
+		bool result;
+
+		net_key = g_new(struct mesh_net_key, 1);
+		memcpy(net_key->current.net_key, key, 16);
+		net_key->generic.idx = net_idx;
+
+		/* Invalidate "New" version */
+		net_key->new.nid = 0xff;
+
+		/* Calculate the many component parts */
+		result = mesh_crypto_nkbk(key, net_key->current.beacon_key);
+		if (!result) {
+			g_free(net_key);
+			return false;
+		}
+
+		result = mesh_crypto_k3(key, net_key->current.net_id);
+		if (!result) {
+			g_free(net_key);
+			return false;
+		}
+
+		result = mesh_crypto_k2(key, &p, 1,
+				&net_key->current.nid,
+				net_key->current.enc_key,
+				net_key->current.privacy_key);
+
+		if (!result) {
+			g_free(net_key);
+			return false;
+		}
+
+		net_keys = g_list_append(net_keys, net_key);
+	}
+
+	return true;
+}
+
+static struct mesh_app_key *find_app_key_by_idx(uint16_t app_idx)
+{
+	GList *l;
+
+	l = g_list_find_custom(app_keys, GUINT_TO_POINTER(app_idx),
+				match_key_index);
+
+	if (!l) return NULL;
+
+	return l->data;
+}
+
+static struct mesh_net_key *find_net_key_by_idx(uint16_t net_idx)
+{
+	GList *l;
+
+	l = g_list_find_custom(net_keys, GUINT_TO_POINTER(net_idx),
+				match_key_index);
+
+	if (!l) return NULL;
+
+	return l->data;
+}
+
+static int match_virt_dst(const void *a, const void *b)
+{
+	const struct mesh_virt_addr *virt = a;
+	uint32_t dst = GPOINTER_TO_UINT(b);
+
+	if (dst < 0x10000 && dst == virt->va16)
+		return 0;
+
+	if (dst == virt->va32)
+		return 0;
+
+	return -1;
+}
+
+static struct mesh_virt_addr *find_virt_by_dst(uint32_t dst)
+{
+	GList *l;
+
+	l = g_list_find_custom(virt_addrs, GUINT_TO_POINTER(dst),
+				match_virt_dst);
+
+	if (!l) return NULL;
+
+	return l->data;
+}
+
+uint8_t *keys_net_key_get(uint16_t net_idx, bool current)
+{
+	GList *l;
+
+
+	l = g_list_find_custom(net_keys, GUINT_TO_POINTER(net_idx),
+				match_key_index);
+	if (!l) {
+		return NULL;
+	} else {
+		struct mesh_net_key *key = l->data;
+		if (current)
+			return key->current.net_key;
+		else
+			return key->new.net_key;
+	}
+}
+
+bool keys_app_key_delete(uint16_t app_idx)
+{
+	/* TODO: remove all associated bindings */
+	return delete_key(&app_keys, app_idx);
+}
+
+bool keys_net_key_delete(uint16_t net_idx)
+{
+	/* TODO: remove all associated app keys and bindings */
+	return delete_key(&net_keys, net_idx);
+}
+
+uint8_t keys_get_kr_phase(uint16_t net_idx)
+{
+	GList *l;
+	struct mesh_net_key *key;
+
+	l = g_list_find_custom(net_keys, GUINT_TO_POINTER(net_idx),
+				match_key_index);
+
+	if (!l)
+		return KR_PHASE_INVALID;
+
+	key = l->data;
+
+	return key->phase;
+}
+
+bool keys_set_kr_phase(uint16_t index, uint8_t phase)
+{
+	GList *l;
+	struct mesh_net_key *net_key;
+
+	l = g_list_find_custom(net_keys, GUINT_TO_POINTER(index),
+				match_key_index);
+
+	if (!l)
+		return false;
+
+	net_key = l->data;
+	net_key->phase = phase;
+
+	return true;
+}
+
+uint16_t keys_app_key_get_bound(uint16_t app_idx)
+{
+	GList *l;
+
+	l = g_list_find_custom(app_keys, GUINT_TO_POINTER(app_idx),
+				match_key_index);
+	if (!l)
+		return NET_IDX_INVALID;
+	else {
+		struct mesh_app_key *key = l->data;
+		return key->net_idx;
+	}
+}
+
+uint8_t *keys_app_key_get(uint16_t app_idx, bool current)
+{
+	GList *l;
+
+
+	l = g_list_find_custom(app_keys, GUINT_TO_POINTER(app_idx),
+				match_key_index);
+	if (!l) {
+		return NULL;
+	} else {
+		struct mesh_app_key *key = l->data;
+		if (current)
+			return key->current.key;
+		else
+			return key->new.key;
+	}
+}
+
+void keys_cleanup_all(void)
+{
+	g_list_free_full(app_keys, g_free);
+	g_list_free_full(net_keys, g_free);
+	app_keys = net_keys = NULL;
+}
+
+bool net_get_key(uint16_t net_idx, uint8_t *key)
+{
+	uint8_t *buf;
+
+	buf = get_key(net_keys, net_idx);
+
+	if (!buf)
+		return false;
+
+	memcpy(key, buf, 16);
+	return true;
+}
+
+bool net_get_flags(uint16_t net_idx, uint8_t *out_flags)
+{
+	uint8_t phase;
+
+	phase = keys_get_kr_phase(net_idx);
+
+	if (phase == KR_PHASE_INVALID || !out_flags)
+		return false;
+
+	if (phase != KR_PHASE_NONE)
+		*out_flags = 0x01;
+	else
+		*out_flags = 0x00;
+
+	if (net.iv_update)
+		*out_flags |= 0x02;
+
+	return true;
+}
+
+uint32_t net_get_iv_index(bool *update)
+{
+	if (update)
+		*update = net.iv_update;
+
+	return net.iv_index;
+}
+
+void net_set_iv_index(uint32_t iv_index, bool update)
+{
+	net.iv_index = iv_index;
+	net.iv_update = update;
+}
+
+void set_sequence_number(uint32_t seq_num)
+{
+	net.seq_num = seq_num;
+}
+
+uint32_t get_sequence_number(void)
+{
+	return net.seq_num;
+}
+
+bool net_add_address_pool(uint16_t min, uint16_t max)
+{
+	uint32_t range;
+	if (max < min)
+		return false;
+	range = min + (max << 16);
+	net.address_pool = g_list_append(net.address_pool,
+						GUINT_TO_POINTER(range));
+	return true;
+}
+
+static int match_address_range(const void *a, const void *b)
+{
+	uint32_t range = GPOINTER_TO_UINT(a);
+	uint8_t num_elements = (uint8_t) (GPOINTER_TO_UINT(b));
+	uint16_t max = range >> 16;
+	uint16_t min = range & 0xffff;
+
+	return ((max - min) >= (num_elements - 1)) ? 0 : -1;
+
+}
+
+uint16_t net_obtain_address(uint8_t num_eles)
+{
+	uint16_t addr;
+	GList *l;
+
+	l = g_list_find_custom(net.address_pool, GUINT_TO_POINTER(num_eles),
+				match_address_range);
+	if (l) {
+		uint32_t range = GPOINTER_TO_UINT(l->data);
+		uint16_t max = range >> 16;
+		uint16_t min = range & 0xffff;
+
+		addr = min;
+		min += num_eles;
+
+		if (min > max)
+			net.address_pool = g_list_delete_link(net.address_pool,
+								l);
+		else {
+			range = min + (max << 16);
+			l->data = GUINT_TO_POINTER(range);
+		}
+		return addr;
+	}
+
+	return UNASSIGNED_ADDRESS;
+}
+
+static int range_cmp(const void *a, const void *b)
+{
+	uint32_t range1 = GPOINTER_TO_UINT(a);
+	uint32_t range2 = GPOINTER_TO_UINT(b);
+
+	return range2 - range1;
+}
+
+void net_release_address(uint16_t addr, uint8_t num_elements)
+{
+	GList *l;
+	uint32_t range;
+
+	for (l = net.address_pool; l != NULL; l = l->next)
+	{
+		uint16_t max;
+		uint16_t min;
+
+		range = GPOINTER_TO_UINT(l->data);
+
+		max = range >> 16;
+		min = range & 0xffff;
+
+		if (min == (addr + num_elements + 1))
+			min  = addr;
+		else if (addr && max == (addr - 1))
+			max = addr + num_elements + 1;
+		else
+			continue;
+
+		range = min + (max << 16);
+		l->data = GUINT_TO_POINTER(range);
+		return;
+	}
+
+	range = addr + ((addr + num_elements - 1) << 16);
+	net.address_pool = g_list_insert_sorted(net.address_pool,
+						GUINT_TO_POINTER(range),
+						range_cmp);
+}
+
+bool net_reserve_address_range(uint16_t base, uint8_t num_elements)
+{
+	GList *l;
+	uint32_t range;
+	uint16_t max;
+	uint16_t min;
+	bool shrink;
+
+	for (l = net.address_pool; l != NULL; l = l->next) {
+
+		range = GPOINTER_TO_UINT(l->data);
+
+		max = range >> 16;
+		min = range & 0xffff;
+
+		if (base >= min && (base + num_elements - 1) <= max)
+			break;
+	}
+
+	if (!l)
+		return false;
+
+	net.address_pool = g_list_delete_link(net.address_pool, l);
+
+	shrink = false;
+
+	if (base == min) {
+		shrink = true;
+		min = base + num_elements;
+	}
+
+	if (max == base + num_elements - 1) {
+		shrink = true;
+		max -= num_elements;
+	}
+
+	if (min > max)
+		return true;
+
+	if (shrink)
+		range = min + (max << 16);
+	else
+		range = min + ((base - 1) << 16);
+
+	net.address_pool = g_list_insert_sorted(net.address_pool,
+						GUINT_TO_POINTER(range),
+						range_cmp);
+
+	if (shrink)
+		return true;
+
+	range = (base + num_elements) + (max << 16);
+	net.address_pool = g_list_insert_sorted(net.address_pool,
+						GUINT_TO_POINTER(range),
+						range_cmp);
+
+	return true;
+}
+
+static int match_destination(const void *a, const void *b)
+{
+	const struct mesh_destination *dest = a;
+	uint16_t dst = GPOINTER_TO_UINT(b);
+
+	return (dest->dst == dst) ? 0 : -1;
+}
+
+void net_dest_ref(uint16_t dst)
+{
+	struct mesh_destination *dest;
+	GList *l;
+
+	if (!dst) return;
+
+	l = g_list_find_custom(net.dest, GUINT_TO_POINTER(dst),
+			match_destination);
+
+	if (l) {
+		dest = l->data;
+		dest->cnt++;
+		return;
+	}
+
+	dest = g_new0(struct mesh_destination, 1);
+	dest->dst = dst;
+	dest->cnt++;
+	net.dest = g_list_append(net.dest, dest);
+}
+
+void net_dest_unref(uint16_t dst)
+{
+	struct mesh_destination *dest;
+	GList *l;
+
+	l = g_list_find_custom(net.dest, GUINT_TO_POINTER(dst),
+			match_destination);
+
+	if (!l)
+		return;
+
+	dest = l->data;
+	dest->cnt--;
+
+	if (dest->cnt == 0) {
+		net.dest = g_list_remove(net.dest, dest);
+		g_free(dest);
+	}
+}
+
+struct build_whitelist {
+	uint8_t len;
+	uint8_t data[12];
+};
+
+static void whitefilter_add(gpointer data, gpointer user_data)
+{
+	struct mesh_destination	*dest = data;
+	struct build_whitelist *white = user_data;
+
+	if (white->len == 0)
+		white->data[white->len++] = FILTER_ADD;
+
+	put_be16(dest->dst, white->data + white->len);
+	white->len += 2;
+
+	if (white->len > (sizeof(white->data) - sizeof(uint16_t))) {
+		net_ctl_msg_send(0, 0, 0, white->data, white->len);
+		white->len = 0;
+	}
+}
+
+static void setup_whitelist()
+{
+	struct build_whitelist white;
+
+	white.len = 0;
+
+	/* Enable (and Clear) Proxy Whitelist */
+	white.data[white.len++] = FILTER_SETUP;
+	white.data[white.len++] = WHITELIST_FILTER;
+
+	net_ctl_msg_send(0, 0, 0, white.data, white.len);
+
+	white.len = 0;
+	g_list_foreach(net.dest, whitefilter_add, &white);
+
+	if (white.len)
+		net_ctl_msg_send(0, 0, 0, white.data, white.len);
+}
+
+static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
+{
+
+	/* Enforcement of 96 hour and 192 hour IVU time windows */
+	if (iv_update && !net.iv_update) {
+		rl_printf("iv_upd_state = IV_UPD_UPDATING\n");
+		net.iv_upd_state = IV_UPD_UPDATING;
+		/* TODO: Start timer to enforce IV Update parameters */
+	} else if (first) {
+		if (iv_update)
+			net.iv_upd_state = IV_UPD_UPDATING;
+		else
+			net.iv_upd_state = IV_UPD_NORMAL;
+
+		rl_printf("iv_upd_state = IV_UPD_%s\n",
+				iv_update ? "UPDATING" : "NORMAL");
+
+	} else if (iv_update && iv_index != net.iv_index) {
+		rl_printf("IV Update too soon -- Rejecting\n");
+		return;
+	}
+
+	if (iv_index > net.iv_index ||
+			iv_update != net.iv_update) {
+
+		/* Don't reset our seq_num unless
+		 * we start using new iv_index */
+		if (!(iv_update && (net.iv_index + 1 == iv_index))) {
+			net.seq_num = 0;
+			net.seq_num_reserved = 100;
+		}
+	}
+
+	if (!net.seq_num || net.iv_index != iv_index ||
+			net.iv_update != iv_update) {
+
+		if (net.seq_num_reserved <= net.seq_num)
+			net.seq_num_reserved = net.seq_num + 100;
+
+		prov_db_local_set_iv_index(iv_index, iv_update,
+				net.provisioner);
+		prov_db_local_set_seq_num(net.seq_num_reserved);
+	}
+
+	net.iv_index = iv_index;
+	net.iv_update = iv_update;
+
+	if (first) {
+		/* Must be done once per Proxy Connection after Beacon RXed */
+		setup_whitelist();
+		if (net.open_cb)
+			net.open_cb(0);
+	}
+}
+
+static bool process_beacon(uint8_t *data, uint8_t size)
+{
+	struct mesh_net_key *net_key;
+	struct net_key_parts *key_part;
+	bool rxed_iv_update, rxed_key_refresh, iv_update;
+	bool  my_krf;
+	uint32_t rxed_iv_index, iv_index;
+	uint64_t cmac;
+
+	if (size != 22)
+		return false;
+
+	rxed_key_refresh = (data[1] & 0x01) == 0x01;
+	iv_update = rxed_iv_update = (data[1] & 0x02) == 0x02;
+	iv_index = rxed_iv_index = get_be32(data + 10);
+
+	/* Inhibit recognizing iv_update true-->false
+	 * if we have outbound SAR messages in flight */
+	if (net.msg_out != NULL) {
+		if (net.iv_update && !rxed_iv_update)
+			iv_update = true;
+	}
+
+	/* Don't bother going further if nothing has changed */
+	if (iv_index == net.iv_index && iv_update == net.iv_update &&
+			net.iv_upd_state != IV_UPD_INIT)
+		return true;
+
+	/* Find key we are using for SNBs */
+	net_key = find_net_key_by_id(data + 2);
+
+	if (net_key == NULL)
+		return false;
+
+	/* We are Provisioner, and control the key_refresh flag */
+	if (rxed_key_refresh != !!(net_key->phase == 2))
+		return false;
+
+	if (net_key->phase != 2) {
+		my_krf = false;
+		key_part = &net_key->current;
+	} else {
+		my_krf = true;
+		key_part = &net_key->new;
+	}
+
+	/* Ignore for incorrect KR state */
+	if (memcmp(key_part->net_id, data + 2, 8))
+		return false;
+
+	if ((net.iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
+			(iv_index < net.iv_index)) {
+		rl_printf("iv index outside range\n");
+		return false;
+	}
+
+	/* Any behavioral changes must pass CMAC test */
+	if (!mesh_crypto_beacon_cmac(key_part->beacon_key, key_part->net_id,
+				rxed_iv_index, my_krf,
+				rxed_iv_update, &cmac)) {
+		return false;
+	}
+
+	if (cmac != get_be64(data + 14))
+		return false;
+
+	if (iv_update && (net.iv_upd_state > IV_UPD_UPDATING)) {
+		if (iv_index != net.iv_index) {
+			rl_printf("Update too soon -- Rejecting\n");
+		}
+		/* Silently ignore old beacons */
+		return true;
+	}
+
+	beacon_update(net.iv_upd_state == IV_UPD_INIT, iv_update, iv_index);
+
+	return true;
+}
+
+struct decode_params {
+	struct mesh_net_key	*net_key;
+	uint8_t			*packet;
+	uint32_t		iv_index;
+	uint8_t			size;
+	bool			proxy;
+};
+
+static void try_decode(gpointer data, gpointer user_data)
+{
+	struct mesh_net_key *net_key = data;
+	struct decode_params *decode = user_data;
+	uint8_t nid = decode->packet[0] & 0x7f;
+	uint8_t tmp[29];
+	bool status = false;
+
+	if (decode->net_key)
+		return;
+
+	if (net_key->current.nid == nid)
+		status = mesh_crypto_packet_decode(decode->packet,
+				decode->size, decode->proxy, tmp,
+				decode->iv_index,
+				net_key->current.enc_key,
+				net_key->current.privacy_key);
+
+	if (!status && net_key->new.nid == nid)
+		status = mesh_crypto_packet_decode(decode->packet,
+				decode->size, decode->proxy, tmp,
+				decode->iv_index,
+				net_key->new.enc_key,
+				net_key->new.privacy_key);
+
+	if (status) {
+		decode->net_key = net_key;
+		memcpy(decode->packet, tmp, decode->size);
+		return;
+	}
+}
+
+static struct mesh_net_key *net_packet_decode(bool proxy, uint32_t iv_index,
+				uint8_t *packet, uint8_t size)
+{
+	struct decode_params decode = {
+		.proxy = proxy,
+		.iv_index = iv_index,
+		.packet = packet,
+		.size = size,
+		.net_key = NULL,
+	};
+
+	g_list_foreach(net_keys, try_decode, &decode);
+
+	return decode.net_key;
+}
+
+static void flush_sar(GList **list, struct mesh_sar_msg *sar)
+{
+	*list = g_list_remove(*list, sar);
+
+	if (sar->msg_to)
+		g_source_remove(sar->msg_to);
+
+	if (sar->ack_to)
+		g_source_remove(sar->ack_to);
+
+	g_free(sar);
+}
+
+static void flush_sar_list(GList **list)
+{
+	struct mesh_sar_msg *sar;
+	GList *l = g_list_first(*list);
+
+	while (l) {
+		sar = l->data;
+		flush_sar(list, sar);
+		l = g_list_first(*list);
+	}
+}
+
+static void flush_pkt_list(GList **list)
+{
+	struct mesh_pkt *pkt;
+	GList *l = g_list_first(*list);
+
+	while (l) {
+		pkt = l->data;
+		*list = g_list_remove(*list, pkt);
+		g_free(pkt);
+	}
+}
+
+static void resend_unacked_segs(gpointer data, gpointer user_data)
+{
+	struct mesh_sar_msg *sar = data;
+
+	if (sar->activity_cnt)
+		resend_segs(sar);
+}
+
+static void send_pkt_cmplt(DBusMessage *message, void *user_data)
+{
+	struct mesh_pkt *pkt = user_data;
+	GList *l = g_list_first(net.pkt_out);
+
+	if (l && user_data == l->data) {
+		net.pkt_out = g_list_delete_link(net.pkt_out, l);
+		g_free(pkt);
+	} else {
+		/* This is a serious error, and probable memory leak */
+		rl_printf("ERR: send_pkt_cmplt %p not head of queue\n", pkt);
+	}
+
+	l = g_list_first(net.pkt_out);
+
+	if (l == NULL) {
+		/* If queue is newly empty, resend all SAR outbound packets */
+		g_list_foreach(net.msg_out, resend_unacked_segs, NULL);
+		return;
+	}
+
+	pkt = l->data;
+
+	mesh_gatt_write(net.proxy_in, pkt->data, pkt->len,
+			send_pkt_cmplt, pkt);
+}
+
+static void send_mesh_pkt(struct mesh_pkt *pkt)
+{
+	bool queued = !!(net.pkt_out);
+
+	net.pkt_out = g_list_append(net.pkt_out, pkt);
+
+	if (queued)
+		return;
+
+	mesh_gatt_write(net.proxy_in, pkt->data, pkt->len,
+			send_pkt_cmplt, pkt);
+}
+
+static uint32_t get_next_seq()
+{
+	uint32_t this_seq = net.seq_num++;
+
+	if (net.seq_num + 32 >= net.seq_num_reserved) {
+		net.seq_num_reserved = net.seq_num + 100;
+		prov_db_local_set_seq_num(net.seq_num_reserved);
+	}
+
+	return this_seq;
+}
+
+static void send_seg(struct mesh_sar_msg *sar, uint8_t seg)
+{
+	struct mesh_net_key *net_key;
+	struct net_key_parts *part;
+	struct mesh_pkt *pkt;
+	uint8_t *data;
+
+	net_key = find_net_key_by_idx(sar->net_idx);
+
+	if (net_key == NULL)
+		return;
+
+	/* Choose which components to use to secure pkt */
+	if (net_key->phase == 2 && net_key->new.nid != 0xff)
+		part = &net_key->new;
+	else
+		part = &net_key->current;
+
+	pkt = g_new0(struct mesh_pkt, 1);
+
+	if (pkt == NULL)
+		return;
+
+	/* leave extra byte at start for GATT Proxy type */
+	data = pkt->data + 1;
+
+	SET_PKT_NID(data, part->nid);
+	SET_PKT_IVI(data, sar->iv_index & 1);
+	SET_PKT_CTL(data, sar->ctl);
+	SET_PKT_TTL(data, sar->ttl);
+	SET_PKT_SEQ(data, get_next_seq());
+	SET_PKT_SRC(data, sar->src);
+	SET_PKT_DST(data, sar->dst);
+	SET_PKT_SEGMENTED(data, sar->segmented);
+
+	if (sar->ctl)
+		SET_PKT_OPCODE(data, sar->data[0]);
+	else
+		SET_PKT_AKF_AID(data, sar->akf_aid);
+
+	if (sar->segmented) {
+
+		if (!sar->ctl)
+			SET_PKT_SZMIC(data, sar->szmic);
+
+		SET_PKT_SEQ0(data, sar->seqAuth);
+		SET_PKT_SEGO(data, seg);
+		SET_PKT_SEGN(data, sar->segN);
+
+		memcpy(PKT_TRANS(data) + 4,
+				sar->data + sar->ctl + (seg * 12), 12);
+
+		pkt->len = 9 + 4;
+
+		if (sar->segN == seg)
+			pkt->len += (sar->len - sar->ctl) % 12;
+
+		if (pkt->len == (9 + 4))
+			pkt->len += 12;
+
+	} else {
+		memcpy(PKT_TRANS(data) + 1,
+				sar->data + sar->ctl, 15);
+
+		pkt->len = 9 + 1 + sar->len - sar->ctl;
+	}
+
+	pkt->len += (sar->ctl ? 8 : 4);
+	mesh_crypto_packet_encode(data, pkt->len,
+			part->enc_key,
+			sar->iv_index,
+			part->privacy_key);
+
+
+	/* Prepend GATT_Proxy packet type */
+	if (sar->proxy)
+		pkt->data[0] = PROXY_CONFIG_PDU;
+	else
+		pkt->data[0] = PROXY_NETWORK_PDU;
+
+	pkt->len++;
+
+	send_mesh_pkt(pkt);
+}
+
+static void resend_segs(struct mesh_sar_msg *sar)
+{
+	uint32_t ack = 1;
+	uint8_t i;
+
+	sar->activity_cnt = 0;
+
+	for (i = 0; i <= sar->segN; i++, ack <<= 1) {
+		if (!(ack & sar->ack))
+			send_seg(sar, i);
+	}
+}
+
+static bool ack_rxed(bool to, uint16_t src, uint16_t dst, bool obo,
+				uint16_t seq0, uint32_t ack_flags)
+{
+	struct mesh_sar_msg *sar = find_sar_out_by_dst(src);
+	uint32_t full_ack;
+
+	/* Silently ignore unknown (stale?) ACKs */
+	if (sar == NULL)
+		return true;
+
+	full_ack = 0xffffffff >> (31 - sar->segN);
+
+	sar->ack |= (ack_flags & full_ack);
+
+	if (sar->ack == full_ack) {
+		/* Outbound message 100% received by remote node */
+		flush_sar(&net.msg_out, sar);
+		return true;
+	}
+
+	/* Because we are GATT, and slow, only resend PKTs if it is
+	 * time *and* our outbound PKT queue is empty.  */
+	sar->activity_cnt++;
+
+	if (net.pkt_out == NULL)
+		resend_segs(sar);
+
+	return true;
+}
+
+static bool proxy_ctl_rxed(uint16_t net_idx, uint32_t iv_index,
+		uint8_t ttl, uint32_t seq_num, uint16_t src, uint16_t dst,
+		uint8_t *trans, uint16_t len)
+{
+	if (len < 1)
+		return false;
+
+	switch(trans[0]) {
+		case FILTER_STATUS:
+			if (len != 4)
+				return false;
+
+			net.blacklist = !!(trans[1] == BLACKLIST_FILTER);
+			rl_printf("Proxy %slist filter length: %d\n",
+					net.blacklist ? "Black" : "White",
+					get_be16(trans + 2));
+
+			return true;
+
+		default:
+			return false;
+	}
+
+	return false;
+}
+
+static bool ctl_rxed(uint16_t net_idx, uint32_t iv_index,
+		uint8_t ttl, uint32_t seq_num, uint16_t src, uint16_t dst,
+		uint8_t *trans, uint16_t len)
+{
+	/* TODO: Handle control messages */
+	return false;
+}
+
+struct decrypt_params {
+	uint8_t		*nonce;
+	uint8_t		*aad;
+	uint8_t		*out_msg;
+	uint8_t		*trans;
+	uint32_t	iv_index;
+	uint32_t	seq_num;
+	uint16_t	src;
+	uint16_t	dst;
+	uint16_t	len;
+	uint16_t	net_idx;
+	uint16_t	app_idx;
+	uint8_t		akf_aid;
+	bool		szmic;
+};
+
+
+static void try_decrypt(gpointer data, gpointer user_data)
+{
+	struct mesh_app_key *app_key = data;
+	struct decrypt_params *decrypt = user_data;
+	size_t mic_size = decrypt->szmic ? sizeof(uint64_t) : sizeof(uint32_t);
+	bool status = false;
+
+	/* Already done... Nothing to do */
+	if (decrypt->app_idx != APP_IDX_INVALID)
+		return;
+
+	/* Don't decrypt on Appkeys not owned by this NetKey */
+	if (app_key->net_idx != decrypt->net_idx)
+		return;
+
+	/* Test and decrypt against current key copy */
+	if (app_key->current.akf_aid == decrypt->akf_aid)
+		status = mesh_crypto_aes_ccm_decrypt(decrypt->nonce,
+				app_key->current.key,
+				decrypt->aad, decrypt->aad ? 16 : 0,
+				decrypt->trans, decrypt->len,
+				decrypt->out_msg, NULL, mic_size);
+
+	/* Test and decrypt against new key copy */
+	if (!status && app_key->new.akf_aid == decrypt->akf_aid)
+		status = mesh_crypto_aes_ccm_decrypt(decrypt->nonce,
+				app_key->new.key,
+				decrypt->aad, decrypt->aad ? 16 : 0,
+				decrypt->trans, decrypt->len,
+				decrypt->out_msg, NULL, mic_size);
+
+	/* If successful, terminate with successful App IDX */
+	if (status)
+		decrypt->app_idx = app_key->generic.idx;
+}
+
+static uint16_t access_pkt_decrypt(uint8_t *nonce, uint8_t *aad,
+		uint16_t net_idx, uint8_t akf_aid, bool szmic,
+		uint8_t *trans, uint16_t len)
+{
+	uint8_t *out_msg;
+	struct decrypt_params decrypt = {
+		.nonce = nonce,
+		.aad = aad,
+		.net_idx = net_idx,
+		.akf_aid = akf_aid,
+		.szmic = szmic,
+		.trans = trans,
+		.len = len,
+		.app_idx = APP_IDX_INVALID,
+	};
+
+	out_msg = g_malloc(len);
+
+	if (out_msg == NULL)
+		return false;
+
+	decrypt.out_msg = out_msg;
+
+	g_list_foreach(app_keys, try_decrypt, &decrypt);
+
+	if (decrypt.app_idx != APP_IDX_INVALID)
+		memcpy(trans, out_msg, len);
+
+	g_free(out_msg);
+
+	return decrypt.app_idx;
+}
+
+static bool access_rxed(uint8_t *nonce, uint16_t net_idx,
+		uint32_t iv_index, uint32_t seq_num,
+		uint16_t src, uint16_t dst,
+		uint8_t akf_aid, bool szmic, uint8_t *trans, uint16_t len)
+{
+	uint16_t app_idx = access_pkt_decrypt(nonce, NULL,
+			net_idx, akf_aid, szmic, trans, len);
+
+	if (app_idx != APP_IDX_INVALID) {
+		len -= szmic ? sizeof(uint64_t) : sizeof(uint32_t);
+
+		node_local_data_handler(src, dst, iv_index, seq_num,
+				app_idx, trans, len);
+		return true;
+	}
+
+	return false;
+}
+
+static void try_virt_decrypt(gpointer data, gpointer user_data)
+{
+	struct mesh_virt_addr *virt = data;
+	struct decrypt_params *decrypt = user_data;
+
+	if (decrypt->app_idx != APP_IDX_INVALID || decrypt->dst != virt->va16)
+		return;
+
+	decrypt->app_idx = access_pkt_decrypt(decrypt->nonce,
+			virt->va128,
+			decrypt->net_idx, decrypt->akf_aid,
+			decrypt->szmic, decrypt->trans, decrypt->len);
+
+	if (decrypt->app_idx != APP_IDX_INVALID) {
+		uint16_t len = decrypt->len;
+
+		len -= decrypt->szmic ? sizeof(uint64_t) : sizeof(uint32_t);
+
+		node_local_data_handler(decrypt->src, virt->va32,
+				decrypt->iv_index, decrypt->seq_num,
+				decrypt->app_idx, decrypt->trans, len);
+	}
+}
+
+static bool virtual_rxed(uint8_t *nonce, uint16_t net_idx,
+		uint32_t iv_index, uint32_t seq_num,
+		uint16_t src, uint16_t dst,
+		uint8_t akf_aid, bool szmic, uint8_t *trans, uint16_t len)
+{
+	struct decrypt_params decrypt = {
+		.nonce = nonce,
+		.net_idx = net_idx,
+		.iv_index = iv_index,
+		.seq_num = seq_num,
+		.src = dst,
+		.dst = dst,
+		.akf_aid = akf_aid,
+		.szmic = szmic,
+		.trans = trans,
+		.len = len,
+		.app_idx = APP_IDX_INVALID,
+	};
+
+	/* Cycle through known virtual addresses */
+	g_list_foreach(virt_addrs, try_virt_decrypt, &decrypt);
+
+	if (decrypt.app_idx != APP_IDX_INVALID)
+		return true;
+
+	return false;
+}
+
+static bool msg_rxed(uint16_t net_idx, uint32_t iv_index, bool szmic,
+		uint8_t ttl, uint32_t seq_num, uint32_t seq_auth,
+		uint16_t src, uint16_t dst,
+		uint8_t *trans, uint16_t len)
+{
+	uint8_t akf_aid = TRANS_AKF_AID(trans);
+	bool result;
+	size_t mic_size = szmic ? sizeof(uint64_t) : sizeof(uint32_t);
+	uint8_t nonce[13];
+	uint8_t *dev_key;
+	uint8_t *out = NULL;
+
+	if (!TRANS_AKF(trans)) {
+		/* Compose Nonce */
+		result = mesh_crypto_device_nonce(seq_auth, src, dst,
+				iv_index, szmic, nonce);
+
+		if (!result) return false;
+
+		out = g_malloc0(TRANS_LEN(trans, len));
+		if (out == NULL) return false;
+
+		/* If we are provisioner, we probably RXed on remote Dev Key */
+		if (net.provisioner) {
+			dev_key = node_get_device_key(node_find_by_addr(src));
+
+			if (dev_key == NULL)
+				goto local_dev_key;
+		} else
+			goto local_dev_key;
+
+		result = mesh_crypto_aes_ccm_decrypt(nonce, dev_key,
+				NULL, 0,
+				TRANS_PAYLOAD(trans), TRANS_LEN(trans, len),
+				out, NULL, mic_size);
+
+		if (result) {
+			node_local_data_handler(src, dst,
+					iv_index, seq_num, APP_IDX_DEV,
+					out, TRANS_LEN(trans, len) - mic_size);
+			goto done;
+		}
+
+local_dev_key:
+		/* Always fallback to the local Dev Key */
+		dev_key = node_get_device_key(node_get_local_node());
+
+		if (dev_key == NULL)
+			goto done;
+
+		result = mesh_crypto_aes_ccm_decrypt(nonce, dev_key,
+				NULL, 0,
+				TRANS_PAYLOAD(trans), TRANS_LEN(trans, len),
+				out, NULL, mic_size);
+
+		if (result) {
+			node_local_data_handler(src, dst,
+					iv_index, seq_num, APP_IDX_DEV,
+					out, TRANS_LEN(trans, len) - mic_size);
+			goto done;
+		}
+
+		goto done;
+	}
+
+	result = mesh_crypto_application_nonce(seq_auth, src, dst,
+			iv_index, szmic, nonce);
+
+	if (!result) goto done;
+
+	/* If Virtual destination wrap the Access decoder with Virtual */
+	if (IS_VIRTUAL(dst)) {
+		result = virtual_rxed(nonce, net_idx, iv_index, seq_num,
+				src, dst, akf_aid, szmic,
+				TRANS_PAYLOAD(trans), TRANS_LEN(trans, len));
+		goto done;
+	}
+
+	/* Try all matching App Keys until success or exhaustion */
+	result = access_rxed(nonce, net_idx, iv_index, seq_num,
+			src, dst, akf_aid, szmic,
+			TRANS_PAYLOAD(trans), TRANS_LEN(trans, len));
+
+done:
+	if (out != NULL)
+		g_free(out);
+
+	return result;
+}
+
+static void send_sar_ack(struct mesh_sar_msg *sar)
+{
+	uint8_t ack[7];
+
+	sar->activity_cnt = 0;
+
+	memset(ack, 0, sizeof(ack));
+	SET_TRANS_OPCODE(ack, NET_OP_SEG_ACKNOWLEDGE);
+	SET_TRANS_SEQ0(ack, sar->seqAuth);
+	SET_TRANS_ACK(ack, sar->ack);
+
+	net_ctl_msg_send(0xff, sar->dst, sar->src, ack, sizeof(ack));
+}
+
+static gboolean sar_out_ack_timeout(void *user_data)
+{
+	struct mesh_sar_msg *sar = user_data;
+
+	sar->activity_cnt++;
+
+	/* Because we are GATT, and slow, only resend PKTs if it is
+	 * time *and* our outbound PKT queue is empty.  */
+	if (net.pkt_out == NULL)
+		resend_segs(sar);
+
+	/* Only add resent SAR pkts to empty queue */
+	return true;
+}
+
+static gboolean sar_out_msg_timeout(void *user_data)
+{
+	struct mesh_sar_msg *sar = user_data;
+
+	/* msg_to will expire when we return false */
+	sar->msg_to = 0;
+
+	flush_sar(&net.msg_out, sar);
+
+	return false;
+}
+
+static gboolean sar_in_ack_timeout(void *user_data)
+{
+	struct mesh_sar_msg *sar = user_data;
+	uint32_t full_ack = 0xffffffff >> (31 - sar->segN);
+
+	if (sar->activity_cnt || sar->ack != full_ack)
+		send_sar_ack(sar);
+
+	return true;
+}
+
+static gboolean sar_in_msg_timeout(void *user_data)
+{
+	struct mesh_sar_msg *sar = user_data;
+
+	/* msg_to will expire when we return false */
+	sar->msg_to = 0;
+
+	flush_sar(&net.sar_in, sar);
+
+	return false;
+}
+
+static uint32_t calc_seqAuth(uint32_t seq_num, uint8_t *trans)
+{
+	uint32_t seqAuth = seq_num & ~0x1fff;
+
+	seqAuth |= TRANS_SEQ0(trans);
+
+	return seqAuth;
+}
+
+static bool seg_rxed(uint16_t net_idx, uint32_t iv_index, bool ctl,
+		uint8_t ttl, uint32_t seq_num, uint16_t src, uint16_t dst,
+		uint8_t *trans, uint16_t len)
+{
+	struct mesh_sar_msg *sar;
+	uint32_t seqAuth = calc_seqAuth(seq_num, trans);
+	uint8_t segN, segO;
+	uint32_t old_ack, full_ack, last_ack_mask;
+	bool send_ack, result = false;
+
+	segN = TRANS_SEGN(trans);
+	segO = TRANS_SEGO(trans);
+
+	/* Only support single incoming SAR'd message per SRC */
+	sar = find_sar_in_by_src(src);
+
+	/* Reuse existing SAR structure if appropriate */
+	if (sar) {
+		uint64_t iv_seqAuth = (uint64_t)iv_index << 32 | seqAuth;
+		uint64_t old_iv_seqAuth = (uint64_t)sar->iv_index << 32 |
+			sar->seqAuth;
+		if (old_iv_seqAuth < iv_seqAuth) {
+
+			flush_sar(&net.sar_in, sar);
+			sar = NULL;
+
+		} else if (old_iv_seqAuth > iv_seqAuth) {
+
+			/* New segment is Stale. Silently ignore */
+			return false;
+
+		} else if (segN != sar->segN) {
+
+			/* Remote side sent conflicting data: abandon */
+			flush_sar(&net.sar_in, sar);
+			sar = NULL;
+
+		}
+	}
+
+	if (sar == NULL) {
+		sar = g_malloc0(sizeof(*sar) + (12 * segN));
+
+		if (sar == NULL)
+			return false;
+
+		sar->net_idx = net_idx;
+		sar->iv_index = iv_index;
+		sar->ctl = ctl;
+		sar->ttl = ttl;
+		sar->seqAuth = seqAuth;
+		sar->src = src;
+		sar->dst = dst;
+		sar->segmented = true;
+		sar->szmic = TRANS_SZMIC(trans);
+		sar->segN = segN;
+
+		/* In all cases, the reassembled packet should begin with the
+		 * same first octet of all segments, minus the SEGMENTED flag */
+		sar->data[0] = trans[0] & 0x7f;
+
+		net.sar_in = g_list_append(net.sar_in, sar);
+
+		/* Setup expiration timers */
+		if (IS_UNICAST(dst))
+			sar->ack_to = g_timeout_add(5000,
+					sar_in_ack_timeout, sar);
+
+		sar->msg_to = g_timeout_add(60000, sar_in_msg_timeout, sar);
+	}
+
+	/* If last segment, calculate full msg size */
+	if (segN == segO)
+		sar->len = (segN * 12) + len - 3;
+
+	/* Copy to correct offset */
+	memcpy(sar->data + 1 + (12 * segO), trans + 4, 12);
+
+	full_ack = 0xffffffff >> (31 - segN);
+	last_ack_mask = 0xffffffff << segO;
+	old_ack = sar->ack;
+	sar->ack |= 1 << segO;
+	send_ack = false;
+
+	/* Determine if we should forward message */
+	if (sar->ack == full_ack && old_ack != full_ack) {
+
+		/* First time we have seen this complete message */
+		send_ack = true;
+
+		if (ctl)
+			result = ctl_rxed(sar->net_idx, sar->iv_index,
+					sar->ttl, sar->seqAuth, sar->src,
+					sar->dst, sar->data, sar->len);
+		else
+			result = msg_rxed(sar->net_idx, sar->iv_index,
+					sar->szmic, sar->ttl,
+					seq_num, sar->seqAuth, sar->src,
+					sar->dst, sar->data, sar->len);
+	}
+
+	/* Never Ack Group addressed SAR messages */
+	if (!IS_UNICAST(dst))
+		return result;
+
+	/* Tickle the ACK system so it knows we are still RXing segments */
+	sar->activity_cnt++;
+
+	/* Determine if we should ACK */
+	if (old_ack == sar->ack)
+		/* Let the timer generate repeat ACKs as needed */
+		send_ack = false;
+	else if ((last_ack_mask & sar->ack) == (last_ack_mask & full_ack))
+		/* If this was largest segO outstanding segment, we ACK */
+		send_ack = true;
+
+	if (send_ack)
+		send_sar_ack(sar);
+
+	return result;
+}
+
+bool net_data_ready(uint8_t *msg, uint8_t len)
+{
+	uint8_t type = *msg++;
+	uint32_t iv_index = net.iv_index;
+	struct mesh_net_key *net_key;
+
+	if (len-- < 10) return false;
+
+	if (type == PROXY_MESH_BEACON)
+		return process_beacon(msg, len);
+	else if (type > PROXY_CONFIG_PDU)
+		return false;
+
+	/* RXed iv_index must be equal or 1 less than local iv_index */
+	/* With the clue being high-order bit of first octet */
+	if (!!(iv_index & 0x01) != !!(msg[0] & 0x80)) {
+		if (iv_index)
+			iv_index--;
+		else
+			return false;
+	}
+
+	net_key = net_packet_decode(type == PROXY_CONFIG_PDU,
+			iv_index, msg, len);
+
+	if (net_key == NULL)
+		return false;
+
+	/* CTL packets have 64 bit network MIC, otherwise 32 bit MIC */
+	len -= PKT_CTL(msg) ? sizeof(uint64_t) : sizeof(uint32_t);
+
+	if (type == PROXY_CONFIG_PDU) {
+
+		/* Proxy Configuration DST messages must be 0x0000 */
+		if (PKT_DST(msg))
+			return false;
+
+		return proxy_ctl_rxed(net_key->generic.idx,
+				iv_index, PKT_TTL(msg), PKT_SEQ(msg),
+				PKT_SRC(msg), PKT_DST(msg),
+				PKT_TRANS(msg), PKT_TRANS_LEN(len));
+
+	} if (PKT_CTL(msg) && PKT_OPCODE(msg) == NET_OP_SEG_ACKNOWLEDGE) {
+
+		return ack_rxed(false, PKT_SRC(msg), PKT_DST(msg),
+				PKT_OBO(msg), PKT_SEQ0(msg), PKT_ACK(msg));
+
+	} else if (PKT_SEGMENTED(msg)) {
+
+		return seg_rxed(net_key->generic.idx, iv_index, PKT_CTL(msg),
+				PKT_TTL(msg), PKT_SEQ(msg),
+				PKT_SRC(msg), PKT_DST(msg),
+				PKT_TRANS(msg), PKT_TRANS_LEN(len));
+
+	} else if (!PKT_CTL(msg)){
+
+		return msg_rxed(net_key->generic.idx,
+				iv_index, false, PKT_TTL(msg), PKT_SEQ(msg),
+				PKT_SEQ(msg), PKT_SRC(msg), PKT_DST(msg),
+				PKT_TRANS(msg), PKT_TRANS_LEN(len));
+	} else {
+
+		return ctl_rxed(net_key->generic.idx,
+				iv_index, PKT_TTL(msg), PKT_SEQ(msg),
+				PKT_SRC(msg), PKT_DST(msg),
+				PKT_TRANS(msg), PKT_TRANS_LEN(len));
+
+	}
+
+	return false;
+}
+
+bool net_session_open(GDBusProxy *data_in, bool provisioner,
+					net_mesh_session_open_callback cb)
+{
+	if (net.proxy_in)
+		return false;
+
+	net.proxy_in = data_in;
+	net.iv_upd_state = IV_UPD_INIT;
+	net.blacklist = false;
+	net.provisioner = provisioner;
+	net.open_cb = cb;
+	flush_pkt_list(&net.pkt_out);
+	return true;
+}
+
+void net_session_close(GDBusProxy *data_in)
+{
+	if (net.proxy_in == data_in)
+		net.proxy_in = NULL;
+
+	flush_sar_list(&net.sar_in);
+	flush_sar_list(&net.msg_out);
+	flush_pkt_list(&net.pkt_out);
+}
+
+bool net_register_unicast(uint16_t unicast, uint8_t count)
+{
+	/* TODO */
+	return true;
+}
+
+bool net_register_group(uint16_t group_addr)
+{
+	/* TODO */
+	return true;
+}
+
+uint32_t net_register_virtual(uint8_t buf[16])
+{
+	/* TODO */
+	return 0;
+}
+
+static bool get_enc_keys(uint16_t app_idx, uint16_t dst,
+		uint8_t *akf_aid, uint8_t **app_enc_key,
+		uint16_t *net_idx)
+{
+	if (app_idx == APP_IDX_DEV) {
+		struct mesh_node *node;
+		uint8_t *enc_key = NULL;
+
+		if (net.provisioner) {
+			/* Default to Remote Device Key when Provisioner */
+			node = node_find_by_addr(dst);
+			enc_key = node_get_device_key(node);
+		}
+
+		if (enc_key == NULL) {
+			/* Use Local node Device Key */
+			node = node_get_local_node();
+			enc_key = node_get_device_key(node);
+		}
+
+		if (enc_key == NULL || node == NULL)
+			return false;
+
+		if (akf_aid) *akf_aid = 0;
+		if (app_enc_key) *app_enc_key = enc_key;
+		if (net_idx) *net_idx = node_get_primary_net_idx(node);
+
+	} else {
+		struct mesh_app_key *app_key = find_app_key_by_idx(app_idx);
+		struct mesh_net_key *net_key;
+		bool phase_two;
+
+
+		if (app_key == NULL)
+			return false;
+
+		net_key = find_net_key_by_idx(app_key->net_idx);
+
+		if (net_key == NULL)
+			return false;
+
+		if (net_idx) *net_idx = app_key->net_idx;
+
+		phase_two = !!(net_key->phase == 2);
+
+		if (phase_two && app_key->new.akf_aid != 0xff) {
+			if (app_enc_key) *app_enc_key = app_key->new.key;
+			if (akf_aid) *akf_aid = app_key->new.akf_aid;
+		} else {
+			if (app_enc_key) *app_enc_key = app_key->current.key;
+			if (akf_aid) *akf_aid = app_key->current.akf_aid;
+		}
+	}
+
+	return true;
+}
+
+bool net_ctl_msg_send(uint8_t ttl, uint16_t src, uint16_t dst,
+					uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	struct mesh_sar_msg sar_ctl;
+
+	/* For simplicity, we will reject segmented OB CTL messages */
+	if (len > 12 || node == NULL || buf == NULL || buf[0] & 0x80)
+		return false;
+
+	if (!src) {
+		src = node_get_primary(node);
+
+		if (!src)
+			return false;
+	}
+
+	if (ttl == 0xff)
+		ttl = net.default_ttl;
+
+	memset(&sar_ctl, 0, sizeof(sar_ctl));
+
+	if (!dst)
+		sar_ctl.proxy = true;
+
+	/* Get the default net_idx for remote device (or local) */
+	get_enc_keys(APP_IDX_DEV, dst, NULL, NULL, &sar_ctl.net_idx);
+	sar_ctl.ctl = true;
+	sar_ctl.iv_index = net.iv_index - net.iv_update;
+	sar_ctl.ttl = ttl;
+	sar_ctl.src = src;
+	sar_ctl.dst = dst;
+	sar_ctl.len = len;
+	memcpy(sar_ctl.data, buf, len);
+	send_seg(&sar_ctl, 0);
+
+	return true;
+}
+
+bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
+				uint16_t app_idx, uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	struct mesh_sar_msg *sar;
+	uint8_t *app_enc_key = NULL;
+	uint8_t *aad = NULL;
+	uint32_t mic32;
+	uint8_t aad_len = 0;
+	uint8_t i, j, ackless_retries = 0;
+	uint8_t segN, akf_aid;
+	uint16_t net_idx;
+	bool result;
+
+	if (len > 384 || node == NULL)
+		return false;
+
+	if (!src)
+		src = node_get_primary(node);
+
+	if (!src || !dst)
+		return false;
+
+	if (ttl == 0xff)
+		ttl = net.default_ttl;
+
+	if (IS_VIRTUAL(dst)) {
+		struct mesh_virt_addr *virt = find_virt_by_dst(dst);
+
+		if (virt == NULL)
+			return false;
+
+		dst = virt->va16;
+		aad = virt->va128;
+		aad_len = sizeof(virt->va128);
+	}
+
+	result = get_enc_keys(app_idx, dst,
+			&akf_aid, &app_enc_key, &net_idx);
+
+	if (!result)
+		return false;
+
+	segN = SEG_MAX(len);
+
+	/* Only one ACK required SAR message per destination at a time */
+	if (segN && IS_UNICAST(dst)) {
+		sar = find_sar_out_by_dst(dst);
+
+		if (sar)
+			flush_sar(&net.msg_out, sar);
+	}
+
+	sar = g_malloc0(sizeof(struct mesh_sar_msg) + (segN * 12));
+
+	if (sar == NULL)
+		return false;
+
+	if (segN)
+		sar->segmented = true;
+
+	sar->ttl = ttl;
+	sar->segN = segN;
+	sar->seqAuth = net.seq_num;
+	sar->iv_index = net.iv_index - net.iv_update;
+	sar->net_idx = net_idx;
+	sar->src = src;
+	sar->dst = dst;
+	sar->akf_aid = akf_aid;
+	sar->len = len + sizeof(uint32_t);
+
+	mesh_crypto_application_encrypt(akf_aid,
+			sar->seqAuth, src,
+			dst, sar->iv_index,
+			app_enc_key,
+			aad, aad_len,
+			buf, len,
+			sar->data, &mic32,
+			sizeof(uint32_t));
+
+	/* If sending as a segmented message to a non-Unicast (thus non-ACKing)
+	 * destination, send each segments multiple times. */
+	if (!IS_UNICAST(dst) && segN)
+		ackless_retries = 4;
+
+	for (j = 0; j <= ackless_retries; j++) {
+		for (i = 0; i <= segN; i++)
+			send_seg(sar, i);
+	}
+
+	if (IS_UNICAST(dst) && segN) {
+		net.msg_out = g_list_append(net.msg_out, sar);
+		sar->ack_to = g_timeout_add(2000, sar_out_ack_timeout, sar);
+		sar->msg_to = g_timeout_add(60000, sar_out_msg_timeout, sar);
+	} else
+		g_free(sar);
+
+	return true;
+}
+
+bool net_set_default_ttl(uint8_t ttl)
+{
+	if (ttl > 0x7f)
+		return false;
+
+	net.default_ttl = ttl;
+	return true;
+}
+
+uint8_t net_get_default_ttl()
+{
+	return net.default_ttl;
+}
+
+bool net_set_seq_num(uint32_t seq_num)
+{
+	if (seq_num > 0xffffff)
+		return false;
+
+	net.seq_num = seq_num;
+	return true;
+}
+
+uint32_t net_get_seq_num()
+{
+	return net.seq_num;
+}
diff --git a/mesh/node.c b/mesh/node.c
new file mode 100644
index 0000000..ba8d4b6
--- /dev/null
+++ b/mesh/node.c
@@ -0,0 +1,879 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "client/display.h"
+#include "src/shared/util.h"
+#include "gdbus/gdbus.h"
+#include "monitor/uuid.h"
+#include "mesh-net.h"
+#include "config-model.h"
+#include "node.h"
+#include "keys.h"
+#include "gatt.h"
+#include "net.h"
+#include "prov-db.h"
+#include "util.h"
+
+struct mesh_model {
+	struct mesh_model_ops cbs;
+	void *user_data;
+	GList *bindings;
+	GList *subscriptions;
+	uint32_t id;
+	struct mesh_publication *pub;
+};
+
+struct mesh_element {
+	GList *models;
+	uint16_t loc;
+	uint8_t index;
+};
+
+struct mesh_node {
+	const char *name;
+	GList *net_keys;
+	GList *app_keys;
+	void *prov;
+	GList *elements;
+	uint32_t iv_index;
+	uint32_t seq_number;
+	uint16_t primary_net_idx;
+	uint16_t primary;
+	uint16_t oob;
+	uint16_t features;
+	uint8_t gatt_pkt[MAX_GATT_SIZE];
+	uint8_t dev_uuid[16];
+	uint8_t dev_key[16];
+	uint8_t num_ele;
+	uint8_t ttl;
+	uint8_t gatt_size;
+	bool provisioner;
+	struct mesh_node_composition *comp;
+};
+
+static GList *nodes;
+
+static struct mesh_node *local_node;
+
+static int match_node_unicast(const void *a, const void *b)
+{
+	const struct mesh_node *node = a;
+	uint16_t dst = GPOINTER_TO_UINT(b);
+
+	if (dst >= node->primary &&
+				dst <= (node->primary + node->num_ele - 1))
+		return 0;
+
+	return -1;
+}
+
+static int match_device_uuid(const void *a, const void *b)
+{
+	const struct mesh_node *node = a;
+	const uint8_t *uuid = b;
+
+	return memcmp(node->dev_uuid, uuid, 16);
+}
+
+static int match_element_idx(const void *a, const void *b)
+{
+	const struct mesh_element *element = a;
+	uint32_t index = GPOINTER_TO_UINT(b);
+
+	return (element->index == index) ? 0 : -1;
+}
+
+static int match_model_id(const void *a, const void *b)
+{
+	const struct mesh_model *model = a;
+	uint32_t id = GPOINTER_TO_UINT(b);
+
+	return (model->id == id) ? 0 : -1;
+}
+
+struct mesh_node *node_find_by_addr(uint16_t addr)
+{
+	GList *l;
+
+	if (!IS_UNICAST(addr))
+		return NULL;
+
+	l = g_list_find_custom(nodes, GUINT_TO_POINTER(addr),
+			match_node_unicast);
+
+	if (l)
+		return l->data;
+	else
+		return NULL;
+}
+
+struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
+{
+	GList *l;
+
+	l = g_list_find_custom(nodes, uuid, match_device_uuid);
+
+	if (l)
+		return l->data;
+	else
+		return NULL;
+}
+
+struct mesh_node *node_create_new(struct prov_svc_data *prov)
+{
+	struct mesh_node *node;
+
+	if (node_find_by_uuid(prov->dev_uuid))
+		return NULL;
+
+	node = g_malloc0(sizeof(struct mesh_node));
+	if (!node)
+		return NULL;
+
+	memcpy(node->dev_uuid, prov->dev_uuid, 16);
+	node->oob = prov->oob;
+	nodes = g_list_append(nodes, node);
+
+	return node;
+}
+
+struct mesh_node *node_new(void)
+{
+	struct mesh_node *node;
+
+	node = g_malloc0(sizeof(struct mesh_node));
+	if (!node)
+		return NULL;
+
+	nodes = g_list_append(nodes, node);
+
+	return node;
+}
+
+static void model_free(void *data)
+{
+	struct mesh_model *model = data;
+
+	g_list_free(model->bindings);
+	g_list_free(model->subscriptions);
+	g_free(model->pub);
+	g_free(model);
+}
+
+static void element_free(void *data)
+{
+	struct mesh_element *element = data;
+
+	g_list_free_full(element->models, model_free);
+	g_free(element);
+}
+
+static void free_node_resources(void *data)
+{
+	struct mesh_node *node = data;
+	g_list_free(node->net_keys);
+	g_list_free(node->app_keys);
+
+	g_list_free_full(node->elements, element_free);
+
+	if(node->comp)
+		g_free(node->comp);
+
+	g_free(node);
+}
+
+void node_free(struct mesh_node *node)
+{
+	if (!node)
+		return;
+	nodes = g_list_remove(nodes, node);
+	free_node_resources(node);
+}
+
+void node_cleanup(void)
+{
+	g_list_free_full(nodes, free_node_resources);
+	local_node = NULL;
+}
+
+bool node_is_provisioned(struct mesh_node *node)
+{
+	return (!IS_UNASSIGNED(node->primary));
+}
+
+void *node_get_prov(struct mesh_node *node)
+{
+	return node->prov;
+}
+
+void node_set_prov(struct mesh_node *node, void *prov)
+{
+	node->prov = prov;
+}
+
+bool node_app_key_add(struct mesh_node *node, uint16_t idx)
+{
+	uint32_t index;
+	uint16_t net_idx;
+
+	if (!node)
+		return false;
+
+	net_idx = keys_app_key_get_bound(idx);
+	if (net_idx == NET_IDX_INVALID)
+		return false;
+
+	if (!g_list_find(node->net_keys, GUINT_TO_POINTER(net_idx)))
+		return false;
+
+	index = (net_idx << 16) + idx;
+
+	if (g_list_find(node->app_keys, GUINT_TO_POINTER(index)))
+		return false;
+
+	node->app_keys = g_list_append(node->app_keys, GUINT_TO_POINTER(index));
+
+	return true;
+}
+
+bool node_net_key_add(struct mesh_node *node, uint16_t index)
+{
+	if(!node)
+		return false;
+
+	if (g_list_find(node->net_keys, GUINT_TO_POINTER(index)))
+		return false;
+
+	node->net_keys = g_list_append(node->net_keys, GUINT_TO_POINTER(index));
+	return true;
+}
+
+bool node_net_key_delete(struct mesh_node *node, uint16_t index)
+{
+	GList *l;
+
+	if(!node)
+		return false;
+
+	l = g_list_find(node->net_keys, GUINT_TO_POINTER(index));
+	if (!l)
+		return false;
+
+	node->net_keys = g_list_remove(node->net_keys,
+						GUINT_TO_POINTER(index));
+	/* TODO: remove all associated app keys and bindings */
+	return true;
+}
+
+bool node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
+				uint16_t idx)
+{
+	GList *l;
+	uint32_t index;
+
+	if(!node)
+		return false;
+
+	index = (net_idx << 16) + idx;
+
+	l = g_list_find(node->app_keys, GUINT_TO_POINTER(index));
+	if (!l)
+		return false;
+
+	node->app_keys = g_list_remove(node->app_keys,
+					GUINT_TO_POINTER(index));
+	/* TODO: remove all associated bindings */
+	return true;
+}
+
+void node_set_primary(struct mesh_node *node, uint16_t unicast)
+{
+	node->primary = unicast;
+}
+
+uint16_t node_get_primary(struct mesh_node *node)
+{
+	if (!node)
+		return UNASSIGNED_ADDRESS;
+	else
+		return node->primary;
+}
+
+void node_set_device_key(struct mesh_node *node, uint8_t *key)
+
+{
+	if (!node || !key)
+		return;
+
+	memcpy(node->dev_key, key, 16);
+}
+
+uint8_t *node_get_device_key(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->dev_key;
+}
+
+void node_set_num_elements(struct mesh_node *node, uint8_t num_ele)
+{
+	node->num_ele = num_ele;
+}
+
+uint8_t node_get_num_elements(struct mesh_node *node)
+{
+	return node->num_ele;
+}
+
+GList *node_get_net_keys(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->net_keys;
+}
+
+GList *node_get_app_keys(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->app_keys;
+}
+
+bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
+{
+	struct mesh_node_composition *comp;
+	uint16_t features;
+	int i;
+
+	comp = g_malloc0(sizeof(struct mesh_node_composition));
+	if (!comp)
+		return false;
+
+	/* skip page -- We only support Page Zero */
+	data++;
+	len--;
+
+	comp->cid = get_le16(&data[0]);
+	comp->pid = get_le16(&data[2]);
+	comp->vid = get_le16(&data[4]);
+	comp->crpl = get_le16(&data[6]);
+	features = get_le16(&data[8]);
+	data += 10;
+	len -= 10;
+
+	comp->relay = !!(features & MESH_FEATURE_RELAY);
+	comp->proxy = !!(features & MESH_FEATURE_PROXY);
+	comp->friend = !!(features & MESH_FEATURE_FRIEND);
+	comp->lpn =  !!(features & MESH_FEATURE_LPN);
+
+	for (i = 0;  i< node->num_ele; i++) {
+		uint8_t m, v;
+		uint32_t mod_id;
+		uint16_t vendor_id;
+		struct mesh_element *ele;
+		ele = g_malloc0(sizeof(struct mesh_element));
+		if (!ele)
+			return false;
+
+		ele->index = i;
+		ele->loc = get_le16(data);
+		data += 2;
+		node->elements = g_list_append(node->elements, ele);
+
+		m = *data++;
+		v = *data++;
+		len -= 4;
+
+		while (len >= 2 && m--) {
+			mod_id = get_le16(data);
+			/* initialize uppper 16 bits to 0xffff for SIG models */
+			mod_id |= 0xffff0000;
+			if (!node_set_model(node, ele->index, mod_id))
+				return false;
+			data += 2;
+			len -= 2;
+		}
+		while (len >= 4 && v--) {
+			mod_id = get_le16(data);
+			vendor_id = get_le16(data);
+			mod_id |= (vendor_id << 16);
+			if (!node_set_model(node, ele->index, mod_id))
+				return false;
+			data += 4;
+			len -= 4;
+		}
+
+	}
+
+	node->comp = comp;
+	return true;
+}
+
+bool node_set_local_node(struct mesh_node *node)
+{
+	if (local_node) {
+		rl_printf("Local node already registered\n");
+		return false;
+	}
+	net_register_unicast(node->primary, node->num_ele);
+
+	local_node = node;
+	local_node->provisioner = true;
+
+	return true;
+}
+
+struct mesh_node *node_get_local_node()
+{
+	return local_node;
+}
+
+uint16_t node_get_primary_net_idx(struct mesh_node *node)
+{
+	if (node == NULL)
+		return NET_IDX_INVALID;
+
+	return node->primary_net_idx;
+}
+
+static bool deliver_model_data(struct mesh_element* element, uint16_t src,
+				uint16_t app_idx, uint8_t *data, uint16_t len)
+{
+	GList *l;
+
+	for(l = element->models; l; l = l->next) {
+		struct mesh_model *model = l->data;
+
+		if (!g_list_find(model->bindings, GUINT_TO_POINTER(app_idx)))
+			continue;
+
+		if (model->cbs.recv &&
+			model->cbs.recv(src, data, len, model->user_data))
+			return true;
+	}
+
+	return false;
+}
+
+void node_local_data_handler(uint16_t src, uint32_t dst,
+		uint32_t iv_index, uint32_t seq_num,
+		uint16_t app_idx, uint8_t *data, uint16_t len)
+{
+	GList *l;
+	bool res;
+	uint64_t iv_seq;
+	uint64_t iv_seq_remote;
+	uint8_t ele_idx;
+	struct mesh_element *element;
+	struct mesh_node *remote;
+	bool loopback;
+
+	if (!local_node || seq_num > 0xffffff)
+		return;
+
+	iv_seq = iv_index << 24;
+	iv_seq |= seq_num;
+
+	remote = node_find_by_addr(src);
+
+	if (!remote) {
+		if (local_node->provisioner) {
+			rl_printf("Remote node unknown (%4.4x)\n", src);
+			return;
+		}
+
+		remote = g_new0(struct mesh_node, 1);
+		if (!remote)
+			return;
+
+		/* Not Provisioner; Assume all SRC elements stand alone */
+		remote->primary = src;
+		remote->num_ele = 1;
+		nodes = g_list_append(nodes, remote);
+	}
+
+	loopback = (src < (local_node->primary + local_node->num_ele) &&
+						src >= local_node->primary);
+
+	if (!loopback) {
+		iv_seq_remote = remote->iv_index << 24;
+		iv_seq |= remote->seq_number;
+
+		if (iv_seq_remote >= iv_seq) {
+			rl_printf("Replayed message detected "
+							"(%14lx >= %14lx)\n",
+							iv_seq_remote, iv_seq);
+			return;
+		}
+	}
+
+	if (IS_GROUP(dst) || IS_VIRTUAL(dst)) {
+		/* TODO: if subscription address, deliver to subscribers */
+		return;
+	}
+
+	if (IS_ALL_NODES(dst)) {
+		ele_idx = 0;
+	} else {
+		if (dst >= (local_node->primary + local_node->num_ele) ||
+			dst < local_node->primary)
+				return;
+
+		ele_idx = dst - local_node->primary;
+	}
+
+	l = g_list_find_custom(local_node->elements,
+				GUINT_TO_POINTER(ele_idx), match_element_idx);
+
+	/* This should not happen */
+	if (!l)
+		return;
+
+	element = l->data;
+	res = deliver_model_data(element, src, app_idx, data, len);
+
+	if (res && !loopback) {
+		/* TODO: Save remote in Replay Protection db */
+		remote->iv_index = iv_index;
+		remote->seq_number = seq_num;
+		prov_db_node_set_iv_seq(remote, iv_index, seq_num);
+	}
+}
+
+static gboolean restore_model_state(gpointer data)
+{
+	struct mesh_model *model = data;
+	GList *l;
+	struct mesh_model_ops *ops;
+
+	ops = &model->cbs;
+
+	if (model->bindings && ops->bind) {
+		for (l = model->bindings; l; l = l->next) {
+			if (ops->bind(GPOINTER_TO_UINT(l->data), ACTION_ADD) !=
+				MESH_STATUS_SUCCESS)
+				break;
+		}
+	}
+
+	if (model->pub && ops->pub)
+		ops->pub(model->pub);
+
+	g_idle_remove_by_data(data);
+
+	return true;
+
+}
+
+bool node_local_model_register(uint8_t ele_idx, uint16_t model_id,
+				struct mesh_model_ops *ops, void *user_data)
+{
+	uint32_t id = 0xffff0000 | model_id;
+
+	return node_local_vendor_model_register(ele_idx, id, ops, user_data);
+}
+
+bool node_local_vendor_model_register(uint8_t ele_idx, uint32_t model_id,
+				struct mesh_model_ops *ops, void *user_data)
+{
+	struct mesh_element *ele;
+	struct mesh_model *model;
+	GList *l;
+
+	if (!local_node)
+		return false;
+
+	l = g_list_find_custom(local_node->elements, GUINT_TO_POINTER(ele_idx),
+				match_element_idx);
+	if (!l)
+		return false;
+
+	ele = l->data;
+
+	l = g_list_find_custom(ele->models, GUINT_TO_POINTER(model_id),
+				match_model_id);
+	if (!l)
+		return false;
+
+	model = l->data;
+	model->cbs = *ops;
+	model->user_data = user_data;
+
+	if (model_id >= 0xffff0000)
+		model_id = model_id & 0xffff;
+
+	/* Silently assign device key binding to configuration models */
+	if (model_id == CONFIG_SERVER_MODEL_ID ||
+					model_id == CONFIG_CLIENT_MODEL_ID) {
+		model->bindings = g_list_append(model->bindings,
+						GUINT_TO_POINTER(APP_IDX_DEV));
+	} else {
+		g_idle_add(restore_model_state, model);
+	}
+
+	return true;
+}
+
+bool node_set_element(struct mesh_node *node, uint8_t ele_idx)
+{
+	struct mesh_element *ele;
+	GList *l;
+
+	if (!node)
+		return false;
+
+	l = g_list_find_custom(node->elements, GUINT_TO_POINTER(ele_idx),
+				match_element_idx);
+	if (l)
+		return false;
+
+	ele = g_malloc0(sizeof(struct mesh_element));
+	if (!ele)
+		return false;
+
+	ele->index = ele_idx;
+	node->elements = g_list_append(node->elements, ele);
+
+	return true;
+}
+
+bool node_set_model(struct mesh_node *node, uint8_t ele_idx, uint32_t id)
+{
+	struct mesh_element *ele;
+	struct mesh_model *model;
+	GList *l;
+
+	if (!node)
+		return false;
+
+	l = g_list_find_custom(node->elements, GUINT_TO_POINTER(ele_idx),
+				match_element_idx);
+	if (!l)
+		return false;
+
+	ele = l->data;
+
+	l = g_list_find_custom(ele->models, GUINT_TO_POINTER(id),
+				match_model_id);
+	if (l)
+		return false;
+
+	model = g_malloc0(sizeof(struct mesh_model));
+	if (!model)
+		return false;
+
+	model->id = id;
+	ele->models = g_list_append(ele->models, model);
+
+	return true;
+}
+
+bool node_set_composition(struct mesh_node *node,
+				struct mesh_node_composition *comp)
+{
+	if (!node || !comp || node->comp)
+		return false;
+
+	node->comp = g_malloc0(sizeof(struct mesh_node_composition));
+	if (!node->comp)
+		return false;
+
+	*(node->comp) = *comp;
+	return true;
+}
+
+struct mesh_node_composition *node_get_composition(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+
+	return node->comp;
+}
+
+static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
+							uint32_t model_id)
+{
+	struct mesh_element *ele;
+	GList *l;
+
+	if (!node)
+		return NULL;
+
+	l = g_list_find_custom(node->elements, GUINT_TO_POINTER(ele_idx),
+				match_element_idx);
+	if (!l)
+		return NULL;
+
+	ele = l->data;
+
+	l = g_list_find_custom(ele->models, GUINT_TO_POINTER(model_id),
+				match_model_id);
+	if (!l)
+		return NULL;
+
+	return l->data;
+
+}
+
+bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx)
+{
+	struct mesh_model *model;
+	GList *l;
+
+	model = get_model(node, ele_idx, model_id);
+	if(!model)
+		return false;
+
+	l = g_list_find(model->bindings, GUINT_TO_POINTER(app_idx));
+	if (l)
+		return false;
+
+	if ((node == local_node) && model->cbs.bind) {
+		if (!model->cbs.bind(app_idx, ACTION_ADD))
+			return false;
+	}
+
+	model->bindings = g_list_append(model->bindings,
+					GUINT_TO_POINTER(app_idx));
+
+	return true;
+}
+
+uint8_t node_get_default_ttl(struct mesh_node *node)
+{
+	if (!node)
+		return DEFAULT_TTL;
+	else if (node == local_node)
+		return net_get_default_ttl();
+	else
+		return node->ttl;
+}
+
+bool node_set_default_ttl(struct mesh_node *node, uint8_t ttl)
+{
+	if (!node)
+		return false;
+
+	node->ttl = ttl;
+
+	if (node == local_node || local_node == NULL)
+		return net_set_default_ttl(ttl);
+
+	return true;
+}
+
+bool node_set_sequence_number(struct mesh_node *node, uint32_t seq)
+{
+	if (!node)
+		return false;
+
+	node->seq_number = seq;
+
+	if (node == local_node || local_node == NULL)
+		return net_set_seq_num(seq);
+
+	return true;
+}
+
+uint32_t node_get_sequence_number(struct mesh_node *node)
+{
+	if (!node)
+		return 0xffffffff;
+	else if (node == local_node)
+		return net_get_seq_num();
+
+	return node->seq_number;
+}
+
+bool node_set_iv_index(struct mesh_node *node, uint32_t iv_index)
+{
+	if (!node)
+		return false;
+
+	node->iv_index = iv_index;
+	return true;
+}
+
+uint32_t node_get_iv_index(struct mesh_node *node)
+{
+	bool update;
+
+	if (!node)
+		return 0xffffffff;
+	else if (node == local_node)
+		return net_get_iv_index(&update);
+	return node->iv_index;
+}
+
+bool node_model_pub_set(struct mesh_node *node, uint8_t ele, uint32_t model_id,
+						struct mesh_publication *pub)
+{
+	struct mesh_model *model;
+
+	model = get_model(node, ele, model_id);
+	if(!model)
+		return false;
+
+	if (!model->pub)
+		model->pub = g_malloc0(sizeof(struct mesh_publication));
+	if (!model)
+		return false;
+
+	memcpy(model->pub, pub, (sizeof(struct mesh_publication)));
+
+	if((node == local_node) && model->cbs.pub)
+		model->cbs.pub(pub);
+	return true;
+}
+
+struct mesh_publication *node_model_pub_get(struct mesh_node *node, uint8_t ele,
+							uint32_t model_id)
+{
+	struct mesh_model *model;
+
+	model = get_model(node, ele, model_id);
+	if(!model)
+		return NULL;
+	else
+		return model->pub;
+}
diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
new file mode 100644
index 0000000..61c6ed6
--- /dev/null
+++ b/mesh/onoff-model.c
@@ -0,0 +1,306 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "client/display.h"
+#include "src/shared/util.h"
+#include "mesh-net.h"
+#include "keys.h"
+#include "net.h"
+#include "node.h"
+#include "prov-db.h"
+#include "util.h"
+#include "onoff-model.h"
+
+static uint8_t trans_id;
+static uint16_t onoff_app_idx = APP_IDX_INVALID;
+
+static int client_bind(uint16_t app_idx, int action)
+{
+	if (action == ACTION_ADD) {
+		if (onoff_app_idx != APP_IDX_INVALID) {
+			return MESH_STATUS_INSUFF_RESOURCES;
+		} else {
+			onoff_app_idx = app_idx;
+			rl_printf("On/Off client model: new binding %4.4x\n",
+								app_idx);
+		}
+	} else {
+		if (onoff_app_idx == app_idx)
+			onoff_app_idx = APP_IDX_INVALID;
+	}
+	return MESH_STATUS_SUCCESS;
+}
+
+static void print_remaining_time(uint8_t remaining_time)
+{
+	uint8_t step = (remaining_time & 0xc0) >> 6;
+	uint8_t count = remaining_time & 0x3f;
+	int secs = 0, msecs = 0, minutes = 0, hours = 0;
+
+	switch (step) {
+	case 0:
+		msecs = 100 * count;
+		secs = msecs / 60;
+		msecs -= (secs * 60);
+		break;
+	case 1:
+		secs = 1 * count;
+		minutes = secs / 60;
+		secs -= (minutes * 60);
+		break;
+
+	case 2:
+		secs = 10 * count;
+		minutes = secs / 60;
+		secs -= (minutes * 60);
+		break;
+	case 3:
+		minutes = 10 * count;
+		hours = minutes / 60;
+		minutes -= (hours * 60);
+		break;
+
+	default:
+		break;
+	}
+
+	rl_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d msecs\n",
+						hours, minutes, secs, msecs);
+
+}
+
+static bool client_msg_recvd(uint16_t src, uint8_t *data,
+				uint16_t len, void *user_data)
+{
+	uint32_t opcode;
+	int n;
+
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+
+	rl_printf("On Off Model Message received (%d) opcode %x\n",
+								len, opcode);
+	print_byte_array("\t",data, len);
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+	case OP_GENERIC_ONOFF_STATUS:
+		if (len != 1 && len != 3)
+			break;
+
+		rl_printf("Node %4.4x: Off Status present = %s",
+						src, data[0] ? "ON" : "OFF");
+
+		if (len == 3) {
+			rl_printf(", target = %s", data[1] ? "ON" : "OFF");
+			print_remaining_time(data[2]);
+		} else
+			rl_printf("\n");
+		break;
+	}
+
+	return true;
+}
+
+
+static uint32_t target;
+static uint32_t parms[8];
+
+static uint32_t read_input_parameters(const char *args)
+{
+	uint32_t i;
+
+	if (!args)
+		return 0;
+
+	memset(parms, 0xff, sizeof(parms));
+
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]); i++) {
+		int n;
+
+		sscanf(args, "%x", &parms[i]);
+		if (parms[i] == 0xffffffff)
+			break;
+
+		n = strcspn(args, " \t");
+		args = args + n + strspn(args + n, " \t");
+	}
+
+	return i;
+}
+
+static void cmd_set_node(const char *args)
+{
+	uint32_t dst;
+	char *end;
+
+	dst = strtol(args, &end, 16);
+	if (end != (args + 4)) {
+		rl_printf("Bad unicast address %s: "
+						"expected format 4 digit hex\n",
+			args);
+		target = UNASSIGNED_ADDRESS;
+	} else {
+		rl_printf("Controlling ON/OFF for node %4.4x\n", dst);
+		target = dst;
+		set_menu_prompt("on/off", args);
+	}
+}
+
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	uint8_t ttl;
+
+	if(!node)
+		return false;
+
+	ttl = node_get_default_ttl(node);
+
+	return net_access_layer_send(ttl, node_get_primary(node),
+					target, onoff_app_idx, buf, len);
+}
+
+static void cmd_get_status(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	node = node_find_by_addr(target);
+
+	if (!node)
+		return;
+
+	n = mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
+
+	if (!send_cmd(msg, n))
+		rl_printf("Failed to send \"GENERIC ON/OFF GET\"\n");
+}
+
+static void cmd_set(const char *args)
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		rl_printf("Destination not set\n");
+		return;
+	}
+
+	node = node_find_by_addr(target);
+
+	if (!node)
+		return;
+
+	if ((read_input_parameters(args) != 1) &&
+					parms[0] != 0 && parms[0] != 1) {
+		rl_printf("Bad arguments %s. Expecting \"0\" or \"1\"\n", args);
+		return;
+	}
+
+	n = mesh_opcode_set(OP_GENERIC_ONOFF_SET, msg);
+	msg[n++] = parms[0];
+	msg[n++] = trans_id++;
+
+	if (!send_cmd(msg, n))
+		rl_printf("Failed to send \"GENERIC ON/OFF SET\"\n");
+
+}
+
+static void cmd_back(const char *args)
+{
+	cmd_menu_main(false);
+}
+
+static void cmd_help(const char *args);
+
+static const struct menu_entry cfg_menu[] = {
+	{"target",		"<unicast>",			cmd_set_node,
+						"Set node to configure"},
+	{"get",			NULL,				cmd_get_status,
+						"Get ON/OFF status"},
+	{"onoff",		"<0/1>",			cmd_set,
+						"Send \"SET ON/OFF\" command"},
+	{"back",		NULL,				cmd_back,
+						"Back to main menu"},
+	{"help",		NULL,				cmd_help,
+						"Config Commands"},
+	{}
+};
+
+static void cmd_help(const char *args)
+{
+	rl_printf("Client Configuration Menu\n");
+	print_cmd_menu(cfg_menu);
+}
+
+void onoff_set_node(const char *args) {
+	cmd_set_node(args);
+}
+
+static struct mesh_model_ops client_cbs = {
+	client_msg_recvd,
+	client_bind,
+	NULL,
+	NULL
+};
+
+bool onoff_client_init(uint8_t ele)
+{
+	if (!node_local_model_register(ele, GENERIC_ONOFF_CLIENT_MODEL_ID,
+					&client_cbs, NULL))
+		return false;
+
+	add_cmd_menu("onoff", cfg_menu);
+
+	return true;
+}
diff --git a/mesh/prov-db.c b/mesh/prov-db.c
new file mode 100644
index 0000000..aad6145
--- /dev/null
+++ b/mesh/prov-db.c
@@ -0,0 +1,1599 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <fcntl.h>
+#include <glib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <json-c/json.h>
+#include <sys/stat.h>
+
+#include <readline/readline.h>
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "client/display.h"
+
+#include "mesh-net.h"
+#include "crypto.h"
+#include "keys.h"
+#include "net.h"
+#include "node.h"
+#include "util.h"
+#include "prov-db.h"
+
+#define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
+
+static const char *prov_filename;
+static const char *local_filename;
+
+static char* prov_file_read(const char *filename)
+{
+	int fd;
+	char *str;
+	struct stat st;
+	ssize_t sz;
+
+	if (!filename)
+		return NULL;
+
+	fd = open(filename,O_RDONLY);
+	if (!fd)
+		return NULL;
+
+	if (fstat(fd, &st) == -1) {
+		close(fd);
+		return NULL;
+	}
+
+	str = (char *) g_malloc0(st.st_size + 1);
+	if (!str) {
+		close(fd);
+		return NULL;
+	}
+
+	sz = read(fd, str, st.st_size);
+	if (sz != st.st_size)
+		rl_printf("Incomplete read: %d vs %d\n", (int)sz,
+							(int)(st.st_size));
+
+	close(fd);
+
+	return str;
+}
+
+static void prov_file_write(json_object *jmain, bool local)
+{
+	FILE *outfile;
+	const char *out_str;
+	const char *out_filename;
+
+	if (local)
+		out_filename = local_filename;
+	else
+		out_filename = prov_filename;
+
+	outfile = fopen(out_filename, "wr");
+	if (!outfile) {
+		rl_printf("Failed to open file %s for writing\n", out_filename);
+		return;
+	}
+
+	out_str = json_object_to_json_string_ext(jmain,
+						JSON_C_TO_STRING_PRETTY);
+
+	fwrite(out_str, sizeof(char), strlen(out_str), outfile);
+	fclose(outfile);
+}
+
+static void put_uint16(json_object *jobject, const char *desc, uint16_t value)
+{
+	json_object *jstring;
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", value);
+	jstring = json_object_new_string(buf);
+	json_object_object_add(jobject, desc, jstring);
+}
+
+static void put_uint32(json_object *jobject, const char *desc, uint32_t value)
+{
+	json_object *jstring;
+	char buf[9];
+
+	snprintf(buf, 9, "%8.8x", value);
+	jstring = json_object_new_string(buf);
+	json_object_object_add(jobject, desc, jstring);
+}
+
+static void put_uint16_array_entry(json_object *jarray, uint16_t value)
+{
+	json_object *jstring;
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", value);
+	jstring = json_object_new_string(buf);
+	json_object_array_add(jarray, jstring);
+}
+
+static void put_uint32_array_entry(json_object *jarray, uint32_t value)
+{
+	json_object *jstring;
+	char buf[9];
+
+	snprintf(buf, 9, "%8.8x", value);
+	jstring = json_object_new_string(buf);
+	json_object_array_add(jarray, jstring);
+}
+
+static void put_uint16_list(json_object *jarray, GList *list)
+{
+	GList *l;
+
+	if (!list)
+		return;
+
+	for (l = list; l; l = l->next) {
+		uint32_t ivalue = GPOINTER_TO_UINT(l->data);
+		put_uint16_array_entry(jarray, ivalue);
+	}
+}
+
+static void add_node_idxs(json_object *jnode, const char *desc,
+				GList *idxs)
+{
+	json_object *jarray;
+
+	jarray = json_object_new_array();
+
+	put_uint16_list(jarray, idxs);
+
+	json_object_object_add(jnode, desc, jarray);
+}
+
+static bool parse_unicast_range(json_object *jobject)
+{
+	int cnt;
+	int i;
+
+	cnt = json_object_array_length(jobject);
+
+	for (i = 0; i < cnt; ++i) {
+		json_object *jrange;
+		json_object *jvalue;
+		uint16_t low, high;
+		char *str;
+
+		jrange = json_object_array_get_idx(jobject, i);
+		json_object_object_get_ex(jrange, "lowAddress", &jvalue);
+		str = (char *)json_object_get_string(jvalue);
+		if (sscanf(str, "%04hx", &low) != 1)
+			return false;
+
+		json_object_object_get_ex(jrange, "highAddress", &jvalue);
+		str = (char *)json_object_get_string(jvalue);
+		if (sscanf(str, "%04hx", &high) != 1)
+			return false;
+
+		if(high < low)
+			return false;
+
+		net_add_address_pool(low, high);
+	}
+	return true;
+}
+
+static int parse_node_keys(struct mesh_node *node, json_object *jidxs,
+				bool is_app_key)
+{
+	int idx_cnt;
+	int i;
+
+	idx_cnt = json_object_array_length(jidxs);
+	for (i = 0; i < idx_cnt; ++i) {
+		int idx;
+		json_object *jvalue;
+
+		jvalue = json_object_array_get_idx(jidxs, i);
+		if (!jvalue)
+			break;
+		idx = json_object_get_int(jvalue);
+		if (!CHECK_KEY_IDX_RANGE(idx))
+			break;
+
+		if (is_app_key)
+			node_app_key_add(node, idx);
+		else
+			node_net_key_add(node, idx);
+	}
+
+	return i;
+}
+
+static bool parse_composition_models(struct mesh_node *node, int index,
+					json_object *jmodels)
+{
+	int model_cnt;
+	int i;
+
+	model_cnt = json_object_array_length(jmodels);
+
+	for (i = 0; i < model_cnt; ++i) {
+		json_object *jmodel;
+		char *str;
+		uint32_t model_id;
+		int len;
+
+		jmodel = json_object_array_get_idx(jmodels, i);
+		str = (char *)json_object_get_string(jmodel);
+		len = strlen(str);
+
+		if (len != 4 && len != 8)
+			return false;
+
+		if (sscanf(str, "%08x", &model_id) != 1)
+			return false;
+		if (len == 4)
+			model_id += 0xffff0000;
+
+		node_set_model(node, index, model_id);
+	}
+
+	return true;
+}
+
+static bool parse_composition_elements(struct mesh_node *node,
+					json_object *jelements)
+{
+	int el_cnt;
+	int i;
+
+	el_cnt = json_object_array_length(jelements);
+	node_set_num_elements(node, el_cnt);
+
+	for (i = 0; i < el_cnt; ++i) {
+		json_object *jelement;
+		json_object *jmodels;
+		json_object *jvalue;
+		int index;
+
+		jelement = json_object_array_get_idx(jelements, i);
+		json_object_object_get_ex(jelement, "elementIndex", &jvalue);
+		if (jvalue) {
+			index = json_object_get_int(jvalue);
+			if (index >= el_cnt) {
+				return false;
+			}
+		} else
+			return false;
+
+		if (!node_set_element(node, index))
+			return false;
+
+		json_object_object_get_ex(jelement, "models", &jmodels);
+		if (!jmodels)
+			continue;
+
+		if(!parse_composition_models(node, index, jmodels))
+			return false;
+	}
+	return true;
+}
+
+static bool parse_model_pub(struct mesh_node *node, int ele_idx,
+				uint32_t model_id, json_object *jpub)
+{
+	json_object *jvalue;
+	struct mesh_publication pub;
+	char *str;
+
+	memset(&pub, 0, sizeof(struct mesh_publication));
+
+	/* Read only required fields */
+	json_object_object_get_ex(jpub, "address", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &pub.u.addr16) != 1)
+		return false;
+
+	json_object_object_get_ex(jpub, "index", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &pub.app_idx) != 1)
+		return false;
+
+
+	json_object_object_get_ex(jpub, "ttl", &jvalue);
+	pub.ttl = json_object_get_int(jvalue);
+
+	if (!node_model_pub_set(node, ele_idx, model_id, &pub))
+			return false;
+
+	return true;
+}
+
+static bool parse_bindings(struct mesh_node *node, int ele_idx,
+				uint32_t model_id, json_object *jbindings)
+{
+	int cnt;
+	int i;
+
+	cnt = json_object_array_length(jbindings);
+
+	for (i = 0; i < cnt; ++i) {
+		int key_idx;
+		json_object *jvalue;
+
+		jvalue = json_object_array_get_idx(jbindings, i);
+		if (!jvalue)
+			return true;
+
+		key_idx = json_object_get_int(jvalue);
+		if (!CHECK_KEY_IDX_RANGE(key_idx))
+			return false;
+
+		if (!node_add_binding(node, ele_idx, model_id, key_idx))
+			return false;
+	}
+
+	return true;
+}
+
+static bool parse_configuration_models(struct mesh_node *node, int ele_idx,
+		json_object *jmodels, uint32_t target_id, json_object **jtarget)
+{
+	int model_cnt;
+	int i;
+
+	if (jtarget)
+		*jtarget = NULL;
+
+	model_cnt = json_object_array_length(jmodels);
+
+	for (i = 0; i < model_cnt; ++i) {
+		json_object *jmodel;
+		json_object *jvalue;
+		json_object *jarray;
+		char *str;
+		int len;
+		uint32_t model_id;
+
+		jmodel = json_object_array_get_idx(jmodels, i);
+
+		json_object_object_get_ex(jmodel, "modelId", &jvalue);
+		str = (char *)json_object_get_string(jvalue);
+
+		len = strlen(str);
+
+		if (len != 4 && len != 8)
+			return false;
+
+		if (sscanf(str, "%08x", &model_id) != 1)
+			return false;
+		if (len == 4)
+			model_id += 0xffff0000;
+
+		if (jtarget && model_id == target_id) {
+			*jtarget = jmodel;
+			return true;
+		}
+
+		json_object_object_get_ex(jmodel, "bind", &jarray);
+		if (jarray && !parse_bindings(node, ele_idx, model_id, jarray))
+			return false;
+
+		json_object_object_get_ex(jmodel, "publish", &jvalue);
+
+		if (jvalue && !parse_model_pub(node, ele_idx, model_id, jvalue))
+			return false;
+	}
+
+	return true;
+}
+
+static bool parse_configuration_elements(struct mesh_node *node,
+				json_object *jelements, bool local)
+{
+	int el_cnt;
+	int i;
+
+	el_cnt = json_object_array_length(jelements);
+	node_set_num_elements(node, el_cnt);
+
+	for (i = 0; i < el_cnt; ++i) {
+		json_object *jelement;
+		json_object *jmodels;
+		json_object *jvalue;
+		int index;
+		uint16_t addr;
+
+		jelement = json_object_array_get_idx(jelements, i);
+		json_object_object_get_ex(jelement, "elementIndex", &jvalue);
+		if (jvalue) {
+			index = json_object_get_int(jvalue);
+			if (index >= el_cnt) {
+				return false;
+			}
+		} else
+			return false;
+
+		if (index == 0) {
+			char *str;
+
+			json_object_object_get_ex(jelement, "unicastAddress",
+							&jvalue);
+			str = (char *)json_object_get_string(jvalue);
+			if (sscanf(str, "%04hx", &addr) != 1)
+				return false;
+
+			if (!local && !net_reserve_address_range(addr, el_cnt))
+				return false;
+
+			node_set_primary(node, addr);
+		}
+
+		json_object_object_get_ex(jelement, "models", &jmodels);
+		if (!jmodels)
+			continue;
+
+		if(!parse_configuration_models(node, index, jmodels, 0, NULL))
+			return false;
+	}
+	return true;
+}
+
+static void add_key(json_object *jobject, const char *desc, uint8_t* key)
+{
+	json_object *jstring;
+	char hexstr[33];
+
+	hex2str(key, 16, hexstr, 33);
+	jstring = json_object_new_string(hexstr);
+	json_object_object_add(jobject, desc, jstring);
+}
+
+static json_object *find_node_by_primary(json_object *jmain, uint16_t primary)
+{
+	json_object *jarray;
+	int i, len;
+
+	json_object_object_get_ex(jmain, "nodes", &jarray);
+
+	if (!jarray)
+		return NULL;
+	len = json_object_array_length(jarray);
+
+	for (i = 0; i < len; ++i) {
+		json_object *jnode;
+		json_object *jconfig;
+		json_object *jelements;
+		json_object *jelement;
+		json_object *jvalue;
+		char *str;
+		uint16_t addr;
+
+		jnode = json_object_array_get_idx(jarray, i);
+		if (!jnode)
+			return NULL;
+
+		json_object_object_get_ex(jnode, "configuration", &jconfig);
+		if (!jconfig)
+			return NULL;
+
+		json_object_object_get_ex(jconfig, "elements", &jelements);
+		if (!jelements)
+			return NULL;
+
+		jelement = json_object_array_get_idx(jelements, 0);
+		if (!jelement)
+			return NULL;
+
+		json_object_object_get_ex(jelement, "unicastAddress",
+								&jvalue);
+		str = (char *)json_object_get_string(jvalue);
+		if (sscanf(str, "%04hx", &addr) != 1)
+				return NULL;
+
+		if (addr == primary)
+			return jnode;
+	}
+
+	return NULL;
+
+}
+
+void prov_db_print_node_composition(struct mesh_node *node)
+{
+	char *in_str;
+	const char *comp_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jcomp;
+	uint16_t primary = node_get_primary(node);
+	const char *filename;
+	bool res = false;
+
+	if (!node || !node_get_composition(node))
+		return;
+
+	if (node == node_get_local_node())
+		filename = local_filename;
+	else
+		filename = prov_filename;
+
+	in_str = prov_file_read(filename);
+	if (!in_str)
+		return;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	jnode = find_node_by_primary(jmain, primary);
+	if (!jnode)
+		goto done;
+
+	json_object_object_get_ex(jnode, "composition", &jcomp);
+	if (!jcomp)
+		goto done;
+
+	comp_str = json_object_to_json_string_ext(jcomp,
+						JSON_C_TO_STRING_PRETTY);
+
+	res = true;
+
+done:
+	if (res)
+		rl_printf("\tComposition data for node %4.4x %s\n",
+							primary, comp_str);
+	else
+		rl_printf("\tComposition data for node %4.4x not present\n",
+								primary);
+	g_free(in_str);
+
+	if (jmain)
+		json_object_put(jmain);
+}
+
+bool prov_db_add_node_composition(struct mesh_node *node, uint8_t *data,
+								uint16_t len)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jcomp;
+	json_object *jbool;
+	json_object *jfeatures;
+	json_object *jelements;
+	struct mesh_node_composition *comp;
+	uint8_t num_ele;
+	int i;
+	uint16_t primary = node_get_primary(node);
+	bool res = NULL;
+
+	comp = node_get_composition(node);
+	if (!comp)
+		return false;
+
+	in_str = prov_file_read(prov_filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	jnode = find_node_by_primary(jmain, primary);
+	if (!jnode)
+		goto done;
+
+	jcomp = json_object_new_object();
+
+	put_uint16(jcomp, "cid", comp->cid);
+	put_uint16(jcomp, "pid", comp->pid);
+	put_uint16(jcomp, "vid", comp->pid);
+	put_uint16(jcomp, "crpl", comp->crpl);
+
+	jfeatures = json_object_new_object();
+	jbool = json_object_new_boolean(comp->relay);
+	json_object_object_add(jfeatures, "relay", jbool);
+	jbool = json_object_new_boolean(comp->proxy);
+	json_object_object_add(jfeatures, "proxy", jbool);
+	jbool = json_object_new_boolean(comp->friend);
+	json_object_object_add(jfeatures, "friend", jbool);
+	jbool = json_object_new_boolean(comp->lpn);
+	json_object_object_add(jfeatures, "lpn", jbool);
+	json_object_object_add(jcomp, "features", jfeatures);
+
+	data += 11;
+	len -= 11;
+
+	num_ele =  node_get_num_elements(node);
+
+	jelements = json_object_new_array();
+
+	for (i = 0; i < num_ele; ++i) {
+		json_object *jelement;
+		json_object *jmodels;
+		json_object *jint;
+		uint32_t mod_id;
+		uint16_t vendor_id;
+		uint8_t m, v;
+
+		jelement = json_object_new_object();
+
+		/* Element Index */
+		jint = json_object_new_int(i);
+		json_object_object_add(jelement, "elementIndex", jint);
+
+		/* Location */
+		put_uint16(jelement, "location", get_le16(data));
+		data += 2;
+		m = *data++;
+		v = *data++;
+		len -= 4;
+
+		/* Models */
+		jmodels = json_object_new_array();
+		while (len >= 2 && m--) {
+			mod_id = get_le16(data);
+			data += 2;
+			len -= 2;
+			put_uint16_array_entry(jmodels, (uint16_t) mod_id);
+		}
+
+		while (len >= 4 && v--) {
+			mod_id = get_le16(data);
+			vendor_id = get_le16(data);
+			mod_id |= (vendor_id << 16);
+			data += 4;
+			len -= 4;
+			put_uint32_array_entry(jmodels, mod_id);
+		}
+
+		json_object_object_add(jelement, "models", jmodels);
+		json_object_array_add(jelements, jelement);
+	}
+
+	json_object_object_add(jcomp, "elements", jelements);
+
+	json_object_object_add(jnode, "composition", jcomp);
+
+	prov_file_write(jmain, false);
+
+	res = true;;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+}
+
+bool prov_db_node_set_ttl(struct mesh_node *node, uint8_t ttl)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jconfig;
+	json_object *jvalue;
+	uint16_t primary = node_get_primary(node);
+	const char *filename;
+	bool local = node == node_get_local_node();
+	bool res = false;
+
+	if (local)
+		filename = local_filename;
+	else
+		filename = prov_filename;
+
+	in_str = prov_file_read(filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	if (local)
+		json_object_object_get_ex(jmain, "node", &jnode);
+	else
+		jnode = find_node_by_primary(jmain, primary);
+
+	if (!jnode)
+		goto done;
+
+	json_object_object_get_ex(jnode, "configuration", &jconfig);
+	if (!jconfig)
+		goto done;
+
+	json_object_object_del(jconfig, "defaultTTL");
+
+	jvalue = json_object_new_int(ttl);
+	json_object_object_add(jconfig, "defaultTTL", jvalue);
+
+	prov_file_write(jmain, local);
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+
+}
+
+static void set_local_iv_index(json_object *jobj, uint32_t idx, bool update)
+{
+	json_object *jvalue;
+
+	json_object_object_del(jobj, "IVindex");
+	jvalue = json_object_new_int(idx);
+	json_object_object_add(jobj, "IVindex", jvalue);
+
+	json_object_object_del(jobj, "IVupdate");
+	jvalue = json_object_new_int((update) ? 1 : 0);
+	json_object_object_add(jobj, "IVupdate", jvalue);
+
+}
+
+bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	bool res = false;
+
+	in_str = prov_file_read(local_filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	json_object_object_get_ex(jmain, "node", &jnode);
+	set_local_iv_index(jnode, iv_index, update);
+	prov_file_write(jmain, true);
+
+	g_free(in_str);
+	json_object_put(jmain);
+
+	/* If provisioner, save to global DB as well */
+	if (prov) {
+		in_str = prov_file_read(prov_filename);
+		if (!in_str)
+			return false;
+
+		jmain = json_tokener_parse(in_str);
+		if (!jmain)
+			goto done;
+
+		set_local_iv_index(jmain, iv_index, update);
+		prov_file_write(jmain, false);
+	}
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+
+}
+
+bool prov_db_local_set_seq_num(uint32_t seq_num)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jvalue;
+	bool res = false;
+
+	in_str = prov_file_read(local_filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	json_object_object_get_ex(jmain, "node", &jnode);
+
+	json_object_object_del(jnode, "sequenceNumber");
+	jvalue = json_object_new_int(seq_num);
+	json_object_object_add(jnode, "sequenceNumber", jvalue);
+
+	prov_file_write(jmain, true);
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+}
+
+bool prov_db_node_set_iv_seq(struct mesh_node *node, uint32_t iv, uint32_t seq)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jvalue;
+	uint16_t primary = node_get_primary(node);
+	bool res = false;
+
+	in_str = prov_file_read(prov_filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	jnode = find_node_by_primary(jmain, primary);
+	if (!jnode)
+		goto done;
+
+	json_object_object_del(jnode, "IVindex");
+
+	jvalue = json_object_new_int(iv);
+	json_object_object_add(jnode, "IVindex", jvalue);
+
+	json_object_object_del(jnode, "sequenceNumber");
+
+	jvalue = json_object_new_int(seq);
+	json_object_object_add(jnode, "sequenceNumber", jvalue);
+
+	prov_file_write(jmain, false);
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+
+}
+
+bool prov_db_node_keys(struct mesh_node *node, GList *idxs, const char *desc)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jnode;
+	json_object *jconfig;
+	json_object *jidxs;
+	uint16_t primary = node_get_primary(node);
+	const char *filename;
+	bool local = (node == node_get_local_node());
+	bool res = false;
+
+	if (local)
+		filename = local_filename;
+	else
+		filename = prov_filename;
+
+	in_str = prov_file_read(filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+
+	jnode = find_node_by_primary(jmain, primary);
+	if (!jnode)
+		goto done;
+
+	json_object_object_get_ex(jnode, "configuration", &jconfig);
+	if (!jconfig)
+		goto done;
+
+	json_object_object_del(jconfig, desc);
+
+	if (idxs) {
+		jidxs = json_object_new_array();
+		put_uint16_list(jidxs, idxs);
+		json_object_object_add(jconfig, desc, jidxs);
+	}
+
+	prov_file_write(jmain, local);
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if(jmain)
+		json_object_put(jmain);
+
+	return res;
+
+}
+
+static json_object *get_jmodel_obj(struct mesh_node *node, uint8_t ele_idx,
+					uint32_t model_id, json_object **jmain)
+{
+	char *in_str;
+	json_object *jnode;
+	json_object *jconfig;
+	json_object *jelements, *jelement;
+	json_object *jmodels, *jmodel = NULL;
+	uint16_t primary = node_get_primary(node);
+	const char *filename;
+	bool local = (node == node_get_local_node());
+
+	if (local)
+		filename = local_filename;
+	else
+		filename = prov_filename;
+
+	in_str = prov_file_read(filename);
+	if (!in_str)
+		return NULL;
+
+	*jmain = json_tokener_parse(in_str);
+	if (!(*jmain))
+		goto done;
+
+	if (local)
+		json_object_object_get_ex(*jmain, "node", &jnode);
+	else
+		jnode = find_node_by_primary(*jmain, primary);
+
+	if (!jnode)
+		goto done;
+
+	/* Configuration is mandatory for nodes in provisioning database */
+	json_object_object_get_ex(jnode, "configuration", &jconfig);
+	if (!jconfig)
+		goto done;
+
+	json_object_object_get_ex(jconfig, "elements", &jelements);
+	if (!jelements) {
+		goto done;
+	}
+
+	jelement = json_object_array_get_idx(jelements, ele_idx);
+	if (!jelement) {
+		goto done;
+	}
+
+	json_object_object_get_ex(jelement, "models", &jmodels);
+
+	if (!jmodels)  {
+		jmodels = json_object_new_array();
+		json_object_object_add(jelement, "models", jmodels);
+	} else {
+		parse_configuration_models(node, ele_idx, jmodels,
+							model_id, &jmodel);
+	}
+
+	if (!jmodel) {
+		jmodel = json_object_new_object();
+
+		if ((model_id & 0xffff0000) == 0xffff0000)
+			put_uint16(jmodel, "modelId", model_id & 0xffff);
+		else
+			put_uint32(jmodel, "modelId", model_id);
+
+		json_object_array_add(jmodels, jmodel);
+	}
+
+done:
+
+	g_free(in_str);
+
+	if(!jmodel && *jmain)
+		json_object_put(*jmain);
+
+	return jmodel;
+
+}
+
+bool prov_db_add_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx)
+{
+	json_object *jmain;
+	json_object *jmodel;
+	json_object *jvalue;
+	json_object *jbindings = NULL;
+	bool local = (node == node_get_local_node());
+
+	jmodel = get_jmodel_obj(node, ele_idx, model_id, &jmain);
+
+	if (!jmodel)
+		return false;
+
+	json_object_object_get_ex(jmodel, "bind", &jbindings);
+
+	if (!jbindings) {
+		jbindings = json_object_new_array();
+		json_object_object_add(jmodel, "bind", jbindings);
+	}
+
+	jvalue = json_object_new_int(app_idx);
+	json_object_array_add(jbindings, jvalue);
+
+	prov_file_write(jmain, local);
+
+	json_object_put(jmain);
+
+	return true;
+}
+
+bool prov_db_node_set_model_pub(struct mesh_node *node, uint8_t ele_idx,
+							uint32_t model_id,
+						struct mesh_publication *pub)
+{
+	json_object *jmain;
+	json_object *jmodel;
+	json_object *jpub;
+	json_object *jvalue;
+	bool local = (node == node_get_local_node());
+
+	jmodel = get_jmodel_obj(node, ele_idx, model_id, &jmain);
+
+	if (!jmodel)
+		return false;
+
+	json_object_object_del(jmodel, "publish");
+	if (!pub)
+		goto done;
+
+	jpub = json_object_new_object();
+
+	/* Save only required fields */
+	put_uint16(jpub, "address", pub->u.addr16);
+	put_uint16(jpub, "index", pub->app_idx);
+	jvalue = json_object_new_int(pub->ttl);
+	json_object_object_add(jpub, "ttl", jvalue);
+
+	json_object_object_add(jmodel, "publish", jpub);
+
+done:
+	prov_file_write(jmain, local);
+
+	json_object_put(jmain);
+
+	return true;
+}
+
+bool prov_db_add_new_node(struct mesh_node *node)
+{
+	char *in_str;
+	json_object *jmain;
+	json_object *jarray;
+	json_object *jnode;
+	json_object *jconfig;
+	json_object *jelements;
+	uint8_t num_ele;
+	uint16_t primary;
+	int i;
+	bool first_node;
+	bool res = false;
+
+	in_str = prov_file_read(prov_filename);
+	if (!in_str)
+		return false;
+
+	jmain = json_tokener_parse(in_str);
+	if (!jmain)
+		goto done;
+	json_object_object_get_ex(jmain, "nodes", &jarray);
+
+	if (!jarray) {
+		jarray = json_object_new_array();
+		first_node = true;
+	} else
+		first_node = false;
+
+	jnode = json_object_new_object();
+
+	/* Device key */
+	add_key(jnode, "deviceKey", node_get_device_key(node));
+
+	/* Net key */
+	jconfig = json_object_new_object();
+	add_node_idxs(jconfig, "netKeys", node_get_net_keys(node));
+
+	num_ele = node_get_num_elements(node);
+	if (num_ele == 0)
+		goto done;
+
+	jelements = json_object_new_array();
+
+	primary = node_get_primary(node);
+	if (IS_UNASSIGNED(primary))
+		goto done;
+
+	for (i = 0; i < num_ele; ++i) {
+		json_object *jelement;
+		json_object *jint;
+
+		jelement = json_object_new_object();
+
+		/* Element Index */
+		jint = json_object_new_int(i);
+		json_object_object_add(jelement, "elementIndex", jint);
+
+		/* Unicast */
+		put_uint16(jelement, "unicastAddress", primary + i);
+
+		json_object_array_add(jelements, jelement);
+	}
+
+	json_object_object_add(jconfig, "elements", jelements);
+
+	json_object_object_add(jnode, "configuration", jconfig);
+
+	json_object_array_add(jarray, jnode);
+
+	if (first_node)
+		json_object_object_add(jmain, "nodes", jarray);
+
+	prov_file_write(jmain, false);
+
+	res = true;
+done:
+
+	g_free(in_str);
+
+	if (jmain)
+		json_object_put(jmain);
+
+	return res;
+}
+
+static bool parse_node_composition(struct mesh_node *node, json_object *jcomp)
+{
+	json_object *jvalue;
+	json_object *jelements;
+	json_bool enable;
+	char *str;
+	struct mesh_node_composition comp;
+
+	json_object_object_get_ex(jcomp, "cid", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", &comp.cid) != 1)
+		return false;
+
+	json_object_object_get_ex(jcomp, "pid", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", &comp.vid) != 1)
+		return false;
+
+	json_object_object_get_ex(jcomp, "vid", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", &comp.vid) != 1)
+		return false;
+
+	json_object_object_get_ex(jcomp, "crpl", &jvalue);
+	if (!jvalue)
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", &comp.crpl) != 1)
+		return false;
+
+	/* Extract features */
+	json_object_object_get_ex(jcomp, "relay", &jvalue);
+	enable = json_object_get_boolean(jvalue);
+	comp.relay = (enable) ? true : false;
+
+	json_object_object_get_ex(jcomp, "proxy", &jvalue);
+	enable = json_object_get_boolean(jvalue);
+	comp.proxy = (enable) ? true : false;
+
+	json_object_object_get_ex(jcomp, "friend", &jvalue);
+	enable = json_object_get_boolean(jvalue);
+	comp.friend = (enable) ? true : false;
+
+	json_object_object_get_ex(jcomp, "lowPower", &jvalue);
+	enable = json_object_get_boolean(jvalue);
+	comp.lpn = (enable) ? true : false;
+
+	if (!node_set_composition(node, &comp))
+		return false;
+
+	json_object_object_get_ex(jcomp, "elements", &jelements);
+	if (!jelements)
+		return false;
+
+	return parse_composition_elements(node, jelements);
+}
+
+static bool parse_node(json_object *jnode, bool local)
+{
+	json_object *jconfig;
+	json_object *jelements;
+	json_object *jidxs;
+	json_object *jvalue;
+	json_object *jint;
+	uint8_t key[16];
+	char *value_str;
+	uint32_t idx;
+	struct mesh_node *node;
+
+	/* Device key */
+	if (!json_object_object_get_ex(jnode, "deviceKey", &jvalue) ||
+								!jvalue) {
+		if (!mesh_get_random_bytes(key, 16))
+			return false;
+
+		add_key(jnode, "deviceKey", key);
+	} else {
+		value_str = (char *)json_object_get_string(jvalue);
+		if (!str2hex(value_str, strlen(value_str), key, 16))
+			return false;;
+	}
+
+	node = node_new();
+
+	if (!node)
+		return false;
+
+	node_set_device_key(node, key);
+
+	json_object_object_get_ex(jnode, "IVindex", &jint);
+	if (jint)
+		idx = json_object_get_int(jint);
+	else
+		idx = 0;
+
+	node_set_iv_index(node, idx);
+	if (local) {
+		bool update = false;
+		json_object_object_get_ex(jnode, "IVupdate", &jint);
+		if (jint)
+			update = json_object_get_int(jint) ? true : false;
+		net_set_iv_index(idx, update);
+	}
+
+	if (json_object_object_get_ex(jnode, "sequenceNumber", &jint) &&
+									jint) {
+		int seq = json_object_get_int(jint);
+		node_set_sequence_number(node, seq);
+	}
+
+	/* Composition is mandatory for local node */
+	json_object_object_get_ex(jnode, "composition", &jconfig);
+	if ((jconfig && !parse_node_composition(node, jconfig)) ||
+							(!jconfig && local)) {
+		node_free(node);
+		return false;
+	}
+
+	/* Configuration is mandatory for nodes in provisioning database */
+	json_object_object_get_ex(jnode, "configuration", &jconfig);
+	if (!jconfig) {
+		if (local) {
+			/* This is an unprovisioned local device */
+			goto done;
+		} else {
+			node_free(node);
+			return false;
+		}
+	}
+
+	json_object_object_get_ex(jconfig, "elements", &jelements);
+	if (!jelements) {
+		node_free(node);
+		return false;
+	}
+
+	if (!parse_configuration_elements(node, jelements, local)) {
+		node_free(node);
+		return false;;
+	}
+
+	json_object_object_get_ex(jconfig, "netKeys", &jidxs);
+	if (!jidxs || (parse_node_keys(node, jidxs, false) == 0)) {
+		node_free(node);
+		return false;
+	}
+
+	json_object_object_get_ex(jconfig, "appKeys", &jidxs);
+	if (jidxs)
+		parse_node_keys(node, jidxs, true);
+
+	json_object_object_get_ex(jconfig, "defaultTTL", &jvalue);
+	if (jvalue) {
+		int ttl = json_object_get_int(jvalue);
+		node_set_default_ttl(node, ttl &TTL_MASK);
+	}
+
+done:
+	if (local && !node_set_local_node(node)) {
+		node_free(node);
+		return false;
+	}
+
+	return true;
+}
+
+bool prov_db_show(const char *filename)
+{
+	char *str;
+
+	str = prov_file_read(filename);
+	if (!str)
+		return false;
+
+	rl_printf("%s\n", str);
+	g_free(str);
+	return true;
+}
+
+static bool read_json_db(const char *filename, bool provisioner, bool local)
+{
+	char *str;
+	json_object *jmain;
+	json_object *jarray;
+	json_object *jprov;
+	json_object *jvalue;
+	json_object *jtemp;
+	uint8_t key[16];
+	int value_int;
+	char *value_str;
+	int len;
+	int i;
+	uint32_t index;
+	bool refresh = false;
+	bool res = false;
+
+	str = prov_file_read(filename);
+	if (!str) return false;
+
+	jmain = json_tokener_parse(str);
+	if (!jmain)
+		goto done;
+
+	if (local) {
+		json_object *jnode;
+		bool result;
+
+		json_object_object_get_ex(jmain, "node", &jnode);
+		if (!jnode) {
+			rl_printf("Cannot find \"node\" object");
+			goto done;
+		} else
+			result = parse_node(jnode, true);
+
+		/*
+		* If local node is provisioner, the rest of mesh settings
+		* are read from provisioning database.
+		*/
+		if (provisioner) {
+			res = result;
+			goto done;
+		}
+	}
+
+	/* IV index */
+	json_object_object_get_ex(jmain, "IVindex", &jvalue);
+	if (!jvalue)
+		goto done;
+
+	index = json_object_get_int(jvalue);
+
+	json_object_object_get_ex(jmain, "IVupdate", &jvalue);
+	if (!jvalue)
+		goto done;
+
+	value_int = json_object_get_int(jvalue);
+
+	net_set_iv_index(index, value_int);
+
+	/* Network key(s) */
+	json_object_object_get_ex(jmain, "netKeys", &jarray);
+	if (!jarray)
+		goto done;
+
+	len = json_object_array_length(jarray);
+	rl_printf("# netkeys = %d\n", len);
+
+	for (i = 0; i < len; ++i) {
+		uint32_t idx;
+
+		jtemp = json_object_array_get_idx(jarray, i);
+		json_object_object_get_ex(jtemp, "index", &jvalue);
+		if (!jvalue)
+			goto done;
+		idx = json_object_get_int(jvalue);
+
+		json_object_object_get_ex(jtemp, "key", &jvalue);
+		if (!jvalue) {
+			if (!mesh_get_random_bytes(key, 16))
+				goto done;
+			add_key(jtemp, "key", key);
+			refresh = true;
+		} else {
+			value_str = (char *)json_object_get_string(jvalue);
+			if (!str2hex(value_str, strlen(value_str), key, 16)) {
+				goto done;
+			}
+		}
+
+		if (!keys_net_key_add(idx, key, false))
+			goto done;
+
+		json_object_object_get_ex(jtemp, "keyRefresh", &jvalue);
+		if (!jvalue)
+			goto done;
+
+		keys_set_kr_phase(idx, (uint8_t) json_object_get_int(jvalue));
+	}
+
+	/* App keys */
+	json_object_object_get_ex(jmain, "appKeys", &jarray);
+	if (jarray) {
+		len = json_object_array_length(jarray);
+		rl_printf("# appkeys = %d\n", len);
+
+		for (i = 0; i < len; ++i) {
+			int app_idx;
+			int net_idx;
+
+			jtemp = json_object_array_get_idx(jarray, i);
+			json_object_object_get_ex(jtemp, "index",
+						&jvalue);
+			if (!jvalue)
+				goto done;
+
+			app_idx = json_object_get_int(jvalue);
+			if (!CHECK_KEY_IDX_RANGE(app_idx))
+				goto done;
+
+			json_object_object_get_ex(jtemp, "key", &jvalue);
+			if (!jvalue) {
+				if (!mesh_get_random_bytes(key, 16))
+					goto done;
+				add_key(jtemp, "key", key);
+				refresh = true;
+			} else {
+				value_str =
+					(char *)json_object_get_string(jvalue);
+				str2hex(value_str, strlen(value_str), key, 16);
+			}
+
+			json_object_object_get_ex(jtemp, "boundNetKey",
+							&jvalue);
+			if (!jvalue)
+				goto done;
+
+			net_idx = json_object_get_int(jvalue);
+			if (!CHECK_KEY_IDX_RANGE(net_idx))
+				goto done;
+
+			keys_app_key_add(net_idx, app_idx, key, false);
+		}
+	}
+
+	/* Provisioner info */
+	json_object_object_get_ex(jmain, "provisioners", &jarray);
+	if (!jarray)
+		goto done;
+
+	len = json_object_array_length(jarray);
+	rl_printf("# provisioners = %d\n", len);
+
+	for (i = 0; i < len; ++i) {
+
+		jprov = json_object_array_get_idx(jarray, i);
+
+		/* Allocated unicast range */
+		json_object_object_get_ex(jprov, "allocatedUnicastRange",
+						&jtemp);
+		if (!jtemp) {
+			goto done;
+		}
+
+		if (!parse_unicast_range(jtemp)) {
+			rl_printf("Doneed to parse unicast range\n");
+			goto done;
+		}
+	}
+
+	json_object_object_get_ex(jmain, "nodes", &jarray);
+	if (!jarray) {
+		res = true;
+		goto done;
+	}
+
+	len = json_object_array_length(jarray);
+
+	rl_printf("# provisioned nodes = %d\n", len);
+	for (i = 0; i < len; ++i) {
+		json_object *jnode;
+		jnode = json_object_array_get_idx(jarray, i);
+
+		if (!jnode || !parse_node(jnode, false))
+			goto done;
+	}
+
+	res = true;
+done:
+
+	g_free(str);
+
+	if (res && refresh)
+		prov_file_write(jmain, false);
+
+	if (jmain)
+		json_object_put(jmain);
+
+	return res;
+}
+
+bool prov_db_read(const char *filename)
+{
+	prov_filename = filename;
+	return read_json_db(filename, true, false);
+}
+
+bool prov_db_read_local_node(const char *filename, bool provisioner)
+{
+	local_filename = filename;
+	return read_json_db(filename, provisioner, true);
+}
diff --git a/mesh/prov.c b/mesh/prov.c
new file mode 100644
index 0000000..89fc884
--- /dev/null
+++ b/mesh/prov.c
@@ -0,0 +1,664 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/shared/ecc.h"
+
+#include "gdbus/gdbus.h"
+#include "monitor/uuid.h"
+#include "client/display.h"
+#include "node.h"
+#include "gatt.h"
+#include "crypto.h"
+#include "mesh-net.h"
+#include "util.h"
+#include "agent.h"
+#include "prov.h"
+#include "net.h"
+
+/* Provisioning Security Levels */
+#define MESH_PROV_SEC_HIGH	2
+#define MESH_PROV_SEC_MED	1
+#define MESH_PROV_SEC_LOW	0
+
+/* For Deployment, Security levels below HIGH are *not* recomended */
+#define mesh_gatt_prov_security()	MESH_PROV_SEC_MED
+
+#define PROV_INVITE	0x00
+#define PROV_CAPS	0x01
+#define PROV_START	0x02
+#define PROV_PUB_KEY	0x03
+#define PROV_INP_CMPLT	0x04
+#define PROV_CONFIRM	0x05
+#define PROV_RANDOM	0x06
+#define PROV_DATA	0x07
+#define PROV_COMPLETE	0x08
+#define PROV_FAILED	0x09
+
+#define PROV_NO_OOB	0
+#define PROV_STATIC_OOB	1
+#define PROV_OUTPUT_OOB	2
+#define PROV_INPUT_OOB	3
+
+#define PROV_ERR_INVALID_PDU		0x01
+#define PROV_ERR_INVALID_FORMAT		0x02
+#define PROV_ERR_UNEXPECTED_PDU		0x03
+#define PROV_ERR_CONFIRM_FAILED		0x04
+#define PROV_ERR_INSUF_RESOURCE		0x05
+#define PROV_ERR_DECRYPT_FAILED		0x06
+#define PROV_ERR_UNEXPECTED_ERR		0x07
+#define PROV_ERR_CANT_ASSIGN_ADDR	0x08
+
+/* Expected Provisioning PDU sizes */
+static const uint16_t expected_pdu_size[] = {
+	1 + 1,					/* PROV_INVITE */
+	1 + 1 + 2 + 1 + 1 + 1 + 2 + 1 + 2,	/* PROV_CAPS */
+	1 + 1 + 1 + 1 + 1 + 1,			/* PROV_START */
+	1 + 64,					/* PROV_PUB_KEY */
+	1,					/* PROV_INP_CMPLT */
+	1 + 16,					/* PROV_CONFIRM */
+	1 + 16,					/* PROV_RANDOM */
+	1 + 16 + 2 + 1 + 4 + 2 + 8,		/* PROV_DATA */
+	1,					/* PROV_COMPLETE */
+	1 + 1,					/* PROV_FAILED */
+};
+
+typedef struct __packed {
+	uint8_t attention;
+} __attribute__ ((packed))	prov_invite;
+
+typedef struct {
+	uint8_t  num_ele;
+	uint16_t algorithms;
+	uint8_t  pub_type;
+	uint8_t  static_type;
+	uint8_t  output_size;
+	uint16_t output_action;
+	uint8_t  input_size;
+	uint16_t input_action;
+} __attribute__ ((packed))	prov_caps;
+
+typedef struct {
+	uint8_t algorithm;
+	uint8_t pub_key;
+	uint8_t auth_method;
+	uint8_t auth_action;
+	uint8_t auth_size;
+} __attribute__ ((packed))	prov_start;
+
+typedef struct {
+	prov_invite	invite;
+	prov_caps	caps;
+	prov_start	start;
+	uint8_t prv_pub_key[64];
+	uint8_t dev_pub_key[64];
+} __attribute__ ((packed))	conf_input;
+
+struct prov_data {
+	GDBusProxy		*prov_in;
+	provision_done_cb	prov_done;
+	void			*user_data;
+	uint16_t		net_idx;
+	uint16_t		new_addr;
+	uint8_t			state;
+	uint8_t			eph_priv_key[32];
+	uint8_t			ecdh_secret[32];
+	conf_input		conf_in;
+	uint8_t			rand_auth[32];
+	uint8_t			salt[16];
+	uint8_t			conf_key[16];
+	uint8_t			mesh_conf[16];
+	uint8_t			dev_key[16];
+};
+
+static uint8_t u16_highest_bit(uint16_t mask)
+{
+	uint8_t cnt = 0;
+
+	if (!mask) return 0xff;
+
+	while (mask & 0xfffe) {
+		cnt++;
+		mask >>= 1;
+	}
+
+	return cnt;
+}
+
+bool prov_open(struct mesh_node *node, GDBusProxy *prov_in, uint16_t net_idx,
+		provision_done_cb cb, void *user_data)
+{
+	uint8_t invite[] = { PROXY_PROVISIONING_PDU, PROV_INVITE, 0x10 };
+	struct prov_data *prov = node_get_prov(node);
+
+	if (prov) return false;
+
+	prov = g_new0(struct prov_data, 1);
+	prov->prov_in = prov_in;
+	prov->net_idx = net_idx;
+	prov->prov_done = cb;
+	prov->user_data = user_data;
+	node_set_prov(node, prov);
+	prov->conf_in.invite.attention = invite[2];
+	prov->state = PROV_INVITE;
+
+	rl_printf("Open-Node: %p\n", node);
+	rl_printf("Open-Prov: %p\n", prov);
+	rl_printf("Open-Prov: proxy %p\n", prov_in);
+
+	return mesh_gatt_write(prov_in, invite, sizeof(invite), NULL, node);
+}
+
+static bool prov_send_prov_data(void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+	uint8_t out[35] = { PROXY_PROVISIONING_PDU, PROV_DATA };
+	uint8_t key[16];
+	uint8_t nonce[13];
+	uint64_t mic;
+
+	if (prov == NULL) return false;
+
+	mesh_crypto_session_key(prov->ecdh_secret, prov->salt, key);
+	mesh_crypto_nonce(prov->ecdh_secret, prov->salt, nonce);
+	mesh_crypto_device_key(prov->ecdh_secret, prov->salt, prov->dev_key);
+
+	print_byte_array("S-Key\t", key, sizeof(key));
+	print_byte_array("S-Nonce\t", nonce, sizeof(nonce));
+	print_byte_array("DevKey\t", prov->dev_key, sizeof(prov->dev_key));
+
+	if (!net_get_key(prov->net_idx, out + 2))
+		return false;
+
+	put_be16(prov->net_idx, out + 2 + 16);
+	net_get_flags(prov->net_idx, out + 2 + 16 + 2);
+	put_be32(net_get_iv_index(NULL), out + 2 + 16 + 2 + 1);
+	put_be16(prov->new_addr, out + 2 + 16 + 2 + 1 + 4);
+
+	print_byte_array("Data\t", out + 2, 16 + 2 + 1 + 4 + 2);
+
+	mesh_crypto_aes_ccm_encrypt(nonce, key,
+					NULL, 0,
+					out + 2,
+					sizeof(out) - 2 - sizeof(mic),
+					out + 2,
+					&mic, sizeof(mic));
+
+	print_byte_array("DataEncrypted + mic\t", out + 2, sizeof(out) - 2);
+
+	prov->state = PROV_DATA;
+	return mesh_gatt_write(prov->prov_in, out, sizeof(out), NULL, node);
+}
+
+static bool prov_send_confirm(void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+	uint8_t out[18] = { PROXY_PROVISIONING_PDU, PROV_CONFIRM };
+
+	if (prov == NULL) return false;
+
+	mesh_get_random_bytes(prov->rand_auth, 16);
+
+	mesh_crypto_aes_cmac(prov->conf_key, prov->rand_auth,
+				sizeof(prov->rand_auth), out + 2);
+
+	prov->state = PROV_CONFIRM;
+	return mesh_gatt_write(prov->prov_in, out, sizeof(out), NULL, node);
+}
+
+static void prov_out_oob_done(oob_type_t type, void *buf, uint16_t len,
+		void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+
+	if (prov == NULL) return;
+
+	switch (type) {
+		default:
+		case NONE:
+		case OUTPUT:
+			prov_complete(node, PROV_ERR_INVALID_PDU);
+			return;
+
+		case ASCII:
+		case HEXADECIMAL:
+			if (len > 16)
+				prov_complete(node, PROV_ERR_INVALID_PDU);
+
+			memcpy(prov->rand_auth + 16, buf, len);
+			break;
+
+		case DECIMAL:
+			if (len != 4)
+				prov_complete(node, PROV_ERR_INVALID_PDU);
+
+			memcpy(prov->rand_auth +
+					sizeof(prov->rand_auth) -
+					sizeof(uint32_t),
+					buf, len);
+			break;
+	}
+
+	prov_send_confirm(node);
+}
+
+static uint32_t power_ten(uint8_t power)
+{
+	uint32_t ret = 1;
+
+	while (power--)
+		ret *= 10;
+
+	return ret;
+}
+
+char *in_action[3] = {
+	"Push",
+	"Twist",
+	"Enter"
+};
+
+static void prov_calc_ecdh(DBusMessage *message, void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+	uint8_t action = prov->conf_in.start.auth_action;
+	uint8_t size = prov->conf_in.start.auth_size;
+	char in_oob_display[100];
+	uint8_t *tmp = (void *) in_oob_display;
+	uint32_t in_oob;
+
+	if (prov == NULL) return;
+
+	/* Convert to Mesh byte order */
+	memcpy(tmp, prov->conf_in.dev_pub_key, 64);
+	swap_u256_bytes(tmp);
+	swap_u256_bytes(tmp + 32);
+
+	ecdh_shared_secret(tmp, prov->eph_priv_key, prov->ecdh_secret);
+
+	/* Convert to Mesh byte order */
+	swap_u256_bytes(prov->ecdh_secret);
+
+	mesh_crypto_s1(&prov->conf_in,
+			sizeof(prov->conf_in), prov->salt);
+
+	mesh_crypto_prov_conf_key(prov->ecdh_secret,
+			prov->salt, prov->conf_key);
+
+	switch (prov->conf_in.start.auth_method) {
+		default:
+			prov_complete(node, PROV_ERR_INVALID_PDU);
+			break;
+
+		case 0: /* No OOB */
+			prov_send_confirm(node);
+			break;
+
+		case 1: /* Static OOB */
+			agent_input_request(HEXADECIMAL,
+					16,
+					prov_out_oob_done, node);
+			break;
+
+		case 2: /* Output OOB */
+			if (action <= 3)
+				agent_input_request(DECIMAL,
+						size,
+						prov_out_oob_done, node);
+			else
+				agent_input_request(ASCII,
+						size,
+						prov_out_oob_done, node);
+			break;
+
+		case 3: /* Input OOB */
+
+			if (action <= 2) {
+				mesh_get_random_bytes(&in_oob, sizeof(in_oob));
+				in_oob %= power_ten(size);
+				sprintf(in_oob_display, "%s %d on device\n",
+					in_action[action], in_oob);
+				put_be32(in_oob,
+						prov->rand_auth +
+						sizeof(prov->rand_auth) -
+						sizeof(uint32_t));
+			} else {
+				uint8_t in_ascii[9];
+				int i = size;
+
+				mesh_get_random_bytes(in_ascii, i);
+
+				while (i--) {
+					in_ascii[i] =
+						in_ascii[i] % ((26 * 2) + 10);
+					if (in_ascii[i] >= 10 + 26)
+						in_ascii[i] += 'a' - (10 + 26);
+					else if (in_ascii[i] >= 10)
+						in_ascii[i] += 'A' - 10;
+					else
+						in_ascii[i] += '0';
+				}
+				in_ascii[size] = '\0';
+				memcpy(prov->rand_auth + 16, in_ascii, size);
+				sprintf(in_oob_display,
+						"Enter %s on device\n",
+						in_ascii);
+			}
+			rl_printf("Agent String: %s\n", in_oob_display);
+			agent_output_request(in_oob_display);
+			break;
+	}
+}
+
+static void prov_send_pub_key(struct mesh_node *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+	uint8_t out[66] = { PROXY_PROVISIONING_PDU, PROV_PUB_KEY };
+	GDBusReturnFunction cb = NULL;
+
+	if (prov == NULL) return;
+
+	if (prov->conf_in.start.pub_key)
+		cb = prov_calc_ecdh;
+
+	memcpy(out + 2, prov->conf_in.prv_pub_key, 64);
+	prov->state = PROV_PUB_KEY;
+	mesh_gatt_write(prov->prov_in, out, 66, cb, node);
+}
+
+static void prov_oob_pub_key(oob_type_t type, void *buf, uint16_t len,
+		void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+
+	if (prov == NULL) return;
+
+	memcpy(prov->conf_in.dev_pub_key, buf, 64);
+	prov_send_pub_key(node);
+}
+
+static void prov_start_cmplt(DBusMessage *message, void *node)
+{
+	struct prov_data *prov = node_get_prov(node);
+
+	if (prov == NULL) return;
+
+	if (prov->conf_in.start.pub_key)
+		agent_input_request(HEXADECIMAL, 64, prov_oob_pub_key, node);
+	else
+		prov_send_pub_key(node);
+}
+
+bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
+{
+	struct prov_data *prov = node_get_prov(node);
+	uint8_t sec_level = MESH_PROV_SEC_HIGH;
+	uint8_t out[35] = { PROXY_PROVISIONING_PDU };
+
+	if (prov == NULL || len < 2) return false;
+
+	buf++;
+	len--;
+
+	rl_printf("Got provisioning data (%d bytes)\n", len);
+
+	if (buf[0] > PROV_FAILED || expected_pdu_size[buf[0]] != len)
+		return prov_complete(node, PROV_ERR_INVALID_PDU);
+
+	print_byte_array("\t", buf, len);
+
+	if (buf[0] == PROV_FAILED)
+		return prov_complete(node, buf[1]);
+
+	/* Check provisioning state */
+	switch (prov->state) {
+		default:
+			return prov_complete(node, PROV_ERR_INVALID_PDU);
+
+		case PROV_INVITE:
+
+			if (buf[0] != PROV_CAPS)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			/* Normalize to beginning of packed Param struct */
+			buf++;
+			len--;
+
+			/* Save Capability values */
+			memcpy(&prov->conf_in.caps, buf, len);
+
+			sec_level = mesh_gatt_prov_security();
+
+			if (sec_level == MESH_PROV_SEC_HIGH) {
+
+				/* Enforce High Security */
+				if (prov->conf_in.caps.pub_type != 1 &&
+					prov->conf_in.caps.static_type != 1)
+					return prov_complete(node,
+							PROV_ERR_INVALID_PDU);
+
+			} else if (sec_level == MESH_PROV_SEC_MED) {
+
+				/* Enforce Medium Security */
+				if (prov->conf_in.caps.pub_type != 1 &&
+					prov->conf_in.caps.static_type != 1 &&
+					prov->conf_in.caps.input_size == 0 &&
+					prov->conf_in.caps.output_size == 0)
+					return prov_complete(node,
+							PROV_ERR_INVALID_PDU);
+
+			}
+
+			/* Num Elements cannot be Zero */
+			if (prov->conf_in.caps.num_ele == 0)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			/* All nodes must support Algorithm 0x0001 */
+			if (!(get_be16(buf + 1) & 0x0001))
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			/* Pub Key and Static type may not be > 1 */
+			if (prov->conf_in.caps.pub_type > 0x01 ||
+					prov->conf_in.caps.static_type > 0x01)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			prov->new_addr =
+				net_obtain_address(prov->conf_in.caps.num_ele);
+
+			if (!prov->new_addr)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			out[1] = PROV_START;
+			prov->conf_in.start.algorithm = 0;
+			prov->conf_in.start.pub_key =
+				prov->conf_in.caps.pub_type;
+
+			/* Compose START based on most secure values */
+			if (prov->conf_in.caps.static_type) {
+
+				prov->conf_in.start.auth_method =
+					PROV_STATIC_OOB;
+
+			} else if (prov->conf_in.caps.output_size >
+					prov->conf_in.caps.input_size) {
+
+				prov->conf_in.start.auth_method =
+					PROV_OUTPUT_OOB;
+				prov->conf_in.start.auth_action =
+					u16_highest_bit(get_be16(buf + 6));
+				prov->conf_in.start.auth_size =
+					prov->conf_in.caps.output_size;
+
+			} else if (prov->conf_in.caps.input_size > 0) {
+
+				prov->conf_in.start.auth_method =
+					PROV_INPUT_OOB;
+				prov->conf_in.start.auth_action =
+					u16_highest_bit(get_be16(buf + 9));
+				prov->conf_in.start.auth_size =
+					prov->conf_in.caps.input_size;
+			}
+
+			/* Range Check START values */
+			if (prov->conf_in.start.auth_size > 8)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			prov->state = PROV_START;
+
+			memcpy(out + 2, &prov->conf_in.start, 5);
+
+			ecc_make_key(prov->conf_in.prv_pub_key,
+					prov->eph_priv_key);
+
+			/* Swap public key to share into Mesh byte ordering */
+			swap_u256_bytes(prov->conf_in.prv_pub_key);
+			swap_u256_bytes(prov->conf_in.prv_pub_key + 32);
+
+			return mesh_gatt_write(prov->prov_in, out, 7,
+					prov_start_cmplt, node);
+
+
+		case PROV_PUB_KEY:
+			if (buf[0] == PROV_PUB_KEY &&
+					!prov->conf_in.start.pub_key) {
+
+				memcpy(prov->conf_in.dev_pub_key, buf + 1, 64);
+				prov_calc_ecdh(NULL, node);
+				return true;
+
+			} else if (buf[0] == PROV_INP_CMPLT) {
+				agent_output_request_cancel();
+				return prov_send_confirm(node);
+			} else
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+		case PROV_CONFIRM:
+			if (buf[0] != PROV_CONFIRM)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			memcpy(prov->mesh_conf, buf + 1, 16);
+
+			out[1] = PROV_RANDOM;
+			memcpy(out + 2, prov->rand_auth, 16);
+
+			prov->state = PROV_RANDOM;
+			return mesh_gatt_write(prov->prov_in, out, 18,
+					NULL, node);
+
+		case PROV_RANDOM:
+			if (buf[0] != PROV_RANDOM)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			/* Calculate New Salt while we still have
+			 * both random values */
+			mesh_crypto_prov_prov_salt(prov->salt,
+							prov->rand_auth,
+							buf + 1,
+							prov->salt);
+
+			/* Calculate meshs Conf Value */
+			memcpy(prov->rand_auth, buf + 1, 16);
+			mesh_crypto_aes_cmac(prov->conf_key, prov->rand_auth,
+				sizeof(prov->rand_auth), out + 1);
+
+			/* Validate Mesh confirmation */
+			if (memcmp(out + 1, prov->mesh_conf, 16) != 0)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			rl_printf("Confirmation Validated\n");
+
+			prov_send_prov_data(node);
+
+			return true;
+
+		case PROV_DATA:
+			if (buf[0] != PROV_COMPLETE)
+				return prov_complete(node,
+						PROV_ERR_INVALID_PDU);
+
+			return prov_complete(node, 0);
+	}
+
+
+
+	/* Compose appropriate reply for the prov state message */
+	/* Send reply via mesh_gatt_write() */
+	/* If done, call prov_done calllback and free prov housekeeping data */
+	rl_printf("Got provisioning data (%d bytes)\n", len);
+	print_byte_array("\t", buf, len);
+
+	return true;
+}
+
+bool prov_complete(struct mesh_node *node, uint8_t status)
+{
+	struct prov_data *prov = node_get_prov(node);
+	void *user_data;
+	provision_done_cb cb;
+
+	if (prov == NULL) return false;
+
+	if (status && prov->new_addr && prov->conf_in.caps.num_ele) {
+		net_release_address(prov->new_addr, prov->conf_in.caps.num_ele);
+	}
+
+	if (!status) {
+		node_set_num_elements(node, prov->conf_in.caps.num_ele);
+		node_set_primary(node, prov->new_addr);
+		node_set_device_key(node, prov->dev_key);
+		node_net_key_add(node, prov->net_idx);
+	}
+
+	user_data = prov->user_data;
+	cb = prov->prov_done;
+	g_free(prov);
+	node_set_prov(node, NULL);
+	if (cb) cb(user_data, status);
+
+	return true;
+}
diff --git a/mesh/util.c b/mesh/util.c
new file mode 100644
index 0000000..cb241b3
--- /dev/null
+++ b/mesh/util.c
@@ -0,0 +1,369 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <readline/readline.h>
+#include <glib.h>
+
+#include "client/display.h"
+#include "src/shared/util.h"
+#include "mesh-net.h"
+#include "util.h"
+
+struct cmd_menu {
+	const char *name;
+	const struct menu_entry *table;
+};
+
+static struct menu_entry *main_cmd_table;
+static struct menu_entry *current_cmd_table;
+static GList *menu_list;
+
+static char *main_menu_prompt;
+static int main_menu_point;
+
+static int match_menu_name(const void *a, const void *b)
+{
+	const struct cmd_menu *menu = a;
+	const char *name = b;
+
+	return strcasecmp(menu->name, name);
+}
+
+bool cmd_menu_init(const struct menu_entry *cmd_table)
+{
+	struct cmd_menu *menu;
+
+	if (main_cmd_table) {
+		rl_printf("Main menu already registered\n");
+		return false;
+	}
+
+	menu = g_malloc(sizeof(struct cmd_menu));
+	if (!menu)
+		return false;
+
+	menu->name = "meshctl";
+	menu->table = cmd_table;
+	menu_list = g_list_append(menu_list, menu);
+	main_cmd_table = (struct menu_entry *) cmd_table;
+	current_cmd_table = (struct menu_entry *) main_cmd_table;
+
+	return true;
+}
+
+void cmd_menu_main(bool forced)
+{
+	current_cmd_table = main_cmd_table;
+
+	if (!forced) {
+		rl_set_prompt(main_menu_prompt);
+		rl_replace_line("", 0);
+		rl_point = main_menu_point;
+		rl_redisplay();
+	}
+
+	g_free(main_menu_prompt);
+	main_menu_prompt = NULL;
+}
+
+bool add_cmd_menu(const char *name, const struct menu_entry *cmd_table)
+{
+	struct cmd_menu *menu;
+	GList *l;
+
+	l = g_list_find_custom(menu_list, name, match_menu_name);
+	if (l) {
+		menu = l->data;
+		rl_printf("menu \"%s\" already registered\n", menu->name);
+		return false;
+	}
+
+	menu = g_malloc(sizeof(struct cmd_menu));
+	if (!menu)
+		return false;
+
+	menu->name = name;
+	menu->table = cmd_table;
+	menu_list = g_list_append(menu_list, menu);
+
+	return true;
+}
+
+void set_menu_prompt(const char *name, const char *id)
+{
+	char *prompt;
+
+	prompt = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", name,
+					id ? ": Target = " : "", id ? id : "");
+	rl_set_prompt(prompt);
+	g_free(prompt);
+	rl_on_new_line();
+}
+
+bool switch_cmd_menu(const char *name)
+{
+	GList *l;
+	struct cmd_menu *menu;
+
+	l = g_list_find_custom(menu_list, name, match_menu_name);
+	if(!l)
+		return false;
+
+	menu = l->data;
+	current_cmd_table = (struct menu_entry *) menu->table;
+
+	main_menu_point = rl_point;
+	main_menu_prompt = g_strdup(rl_prompt);
+
+	return true;
+}
+
+void process_menu_cmd(const char *cmd, const char *arg)
+{
+	int i;
+	int len;
+	struct menu_entry *cmd_table = current_cmd_table;
+
+	if (!current_cmd_table)
+		return;
+
+	len = strlen(cmd);
+
+	for (i = 0; cmd_table[i].cmd; i++) {
+		if (strncmp(cmd, cmd_table[i].cmd, len))
+			continue;
+
+		if (cmd_table[i].func) {
+			cmd_table[i].func(arg);
+			return;
+		}
+	}
+
+	if (strncmp(cmd, "help", len)) {
+		rl_printf("Invalid command\n");
+		return;
+	}
+
+	print_cmd_menu(cmd_table);
+}
+
+void print_cmd_menu(const struct menu_entry *cmd_table)
+{
+	int i;
+
+	rl_printf("Available commands:\n");
+
+	for (i = 0; cmd_table[i].cmd; i++) {
+		if (cmd_table[i].desc)
+			rl_printf("  %s %-*s %s\n", cmd_table[i].cmd,
+					(int)(40 - strlen(cmd_table[i].cmd)),
+					cmd_table[i].arg ? : "",
+					cmd_table[i].desc ? : "");
+	}
+
+}
+
+void cmd_menu_cleanup(void)
+{
+	main_cmd_table = NULL;
+	current_cmd_table = NULL;
+
+	g_list_free_full(menu_list, g_free);
+}
+
+void print_byte_array(const char *prefix, const void *ptr, int len)
+{
+	const uint8_t *data = ptr;
+	char *line, *bytes;
+	int i;
+
+	line = g_malloc(strlen(prefix) + (16 * 3) + 2);
+	sprintf(line, "%s ", prefix);
+	bytes = line + strlen(prefix) + 1;
+
+	for (i = 0; i < len; ++i) {
+		sprintf(bytes, "%2.2x ", data[i]);
+		if ((i + 1) % 16) {
+			bytes += 3;
+		} else {
+			rl_printf("\r%s\n", line);
+			bytes = line + strlen(prefix) + 1;
+		}
+	}
+
+	if (i % 16)
+		rl_printf("\r%s\n", line);
+
+	g_free(line);
+}
+
+bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
+		uint16_t out_len)
+{
+	uint16_t i;
+
+	if (in_len < out_len * 2)
+		return false;
+
+	for (i = 0; i < out_len; i++) {
+		if (sscanf(&str[i * 2], "%02hhx", &out[i]) != 1)
+			return false;
+	}
+
+	return true;
+}
+
+size_t hex2str(uint8_t *in, size_t in_len, char *out,
+		size_t out_len)
+{
+	static const char hexdigits[] = "0123456789abcdef";
+	size_t i;
+
+	if(in_len * 2 > out_len - 1)
+		return 0;
+
+	for (i = 0; i < in_len; i++) {
+		out[i * 2] = hexdigits[in[i] >> 4];
+		out[i * 2 + 1] = hexdigits[in[i] & 0xf];
+	}
+
+	out[in_len * 2] = '\0';
+	return i;
+}
+
+uint16_t mesh_opcode_set(uint32_t opcode, uint8_t *buf)
+{
+	if (opcode <= 0x7e) {
+		buf[0] = opcode;
+		return 1;
+	} else if (opcode >= 0x8000 && opcode <= 0xbfff) {
+		put_be16(opcode, buf);
+		return 2;
+	} else if (opcode >= 0xc00000 && opcode <= 0xffffff) {
+		buf[0] = (opcode >> 16) & 0xff;
+		put_be16(opcode, buf + 1);
+		return 3;
+	} else {
+		rl_printf("Illegal Opcode %x", opcode);
+		return 0;
+	}
+}
+
+bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, uint32_t *opcode, int *n)
+{
+	if (!n || !opcode || sz < 1) return false;
+
+	switch (buf[0] & 0xc0) {
+	case 0x00:
+	case 0x40:
+		/* RFU */
+		if (buf[0] == 0x7f)
+			return false;
+
+		*n = 1;
+		*opcode = buf[0];
+		break;
+
+	case 0x80:
+		if (sz < 2)
+			return false;
+
+		*n = 2;
+		*opcode = get_be16(buf);
+		break;
+
+	case 0xc0:
+		if (sz < 3)
+			return false;
+
+		*n = 3;
+		*opcode = get_be16(buf + 1);
+		*opcode |= buf[0] << 16;
+		break;
+
+	default:
+		rl_printf("Bad Packet:\n");
+		print_byte_array("\t", (void *) buf, sz);
+		return false;
+	}
+
+	return true;
+}
+
+const char *mesh_status_str(uint8_t status)
+{
+	switch (status) {
+	case MESH_STATUS_SUCCESS: return "Success";
+	case MESH_STATUS_INVALID_ADDRESS: return "Invalid Address";
+	case MESH_STATUS_INVALID_MODEL: return "Invalid Model";
+	case MESH_STATUS_INVALID_APPKEY: return "Invalid AppKey";
+	case MESH_STATUS_INVALID_NETKEY: return "Invalid NetKey";
+	case MESH_STATUS_INSUFF_RESOURCES: return "Insufficient Resources";
+	case MESH_STATUS_IDX_ALREADY_STORED: return "Key Idx Already Stored";
+	case MESH_STATUS_INVALID_PUB_PARAM: return "Invalid Publish Parameters";
+	case MESH_STATUS_NOT_SUB_MOD: return "Not a Subscribe Model";
+	case MESH_STATUS_STORAGE_FAIL: return "Storage Failure";
+	case MESH_STATUS_FEAT_NOT_SUP: return "Feature Not Supported";
+	case MESH_STATUS_CANNOT_UPDATE: return "Cannot Update";
+	case MESH_STATUS_CANNOT_REMOVE: return "Cannot Remove";
+	case MESH_STATUS_CANNOT_BIND: return "Cannot bind";
+	case MESH_STATUS_UNABLE_CHANGE_STATE: return "Unable to change state";
+	case MESH_STATUS_CANNOT_SET: return "Cannot set";
+	case MESH_STATUS_UNSPECIFIED_ERROR: return "Unspecified error";
+	case MESH_STATUS_INVALID_BINDING: return "Invalid Binding";
+
+	default: return "Unknown";
+	}
+}
+
+void print_model_pub(uint16_t ele_addr, uint32_t mod_id,
+						struct mesh_publication *pub)
+{
+	rl_printf("\tElement: %4.4x\n", ele_addr);
+	rl_printf("\tPub Addr: %4.4x", pub->u.addr16);
+	if (mod_id > 0xffff0000)
+		rl_printf("\tModel: %8.8x \n", mod_id);
+	else
+		rl_printf("\tModel: %4.4x \n", (uint16_t) (mod_id & 0xffff));
+	rl_printf("\tApp Key Idx: %4.4x", pub->app_idx);
+	rl_printf("\tTTL: %2.2x", pub->ttl);
+}
+
+void swap_u256_bytes(uint8_t *u256)
+{
+	int i;
+
+	/* End-to-End byte reflection of 32 octet buffer */
+	for (i = 0; i < 16; i++) {
+		u256[i] ^= u256[31 - i];
+		u256[31 - i] ^= u256[i];
+		u256[i] ^= u256[31 - i];
+	}
+}
-- 
2.9.5
