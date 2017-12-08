Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] mesh: Make meshctl use bt_shell helpers
Date: Fri,  8 Dec 2017 08:52:49 -0200
Message-Id: <20171208105256.18635-3-luiz.dentz@gmail.com>
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes meshctl use bt_shell to manage the menus and command
handling.
---
 Makefile.tools       |   1 -
 mesh/agent.c         |  22 +-
 mesh/config-client.c | 190 ++++++++---------
 mesh/config-model.h  |   1 -
 mesh/config-server.c |  17 +-
 mesh/gatt.c          |  36 ++--
 mesh/main.c          | 592 ++++++++++++++-------------------------------------
 mesh/net.c           |  16 +-
 mesh/node.c          |  10 +-
 mesh/onoff-model.c   |  91 +++-----
 mesh/prov-db.c       |  25 ++-
 mesh/prov.c          |  16 +-
 mesh/util.c          | 179 ++--------------
 mesh/util.h          |  16 +-
 14 files changed, 360 insertions(+), 852 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 561302fa1..ba717e6cf 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -30,7 +30,6 @@ mesh_meshctl_SOURCES = mesh/main.c \
 				mesh/config-model.h mesh/config-client.c \
 				mesh/config-server.c \
 				mesh/onoff-model.h mesh/onoff-model.c \
-				client/display.h client/display.c \
 				monitor/uuid.h monitor/uuid.c
 mesh_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
diff --git a/mesh/agent.c b/mesh/agent.c
index efb8937d9..b8a14f015 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -29,12 +29,12 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <inttypes.h>
-#include <readline/readline.h>
 
 #include <glib.h>
 
 #include <lib/bluetooth.h>
-#include "client/display.h"
+
+#include "src/shared/shell.h"
 #include "mesh/util.h"
 #include "mesh/agent.h"
 
@@ -68,7 +68,7 @@ static void response_hexadecimal(const char *input, void *user_data)
 	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
 
 	if (!str2hex(input, strlen(input), buf, pending_request.len) ) {
-		rl_printf("Incorrect input: expecting %d hex octets\n",
+		bt_shell_printf("Incorrect input: expecting %d hex octets\n",
 			  pending_request.len);
 		return;
 	}
@@ -110,8 +110,8 @@ static bool request_hexadecimal(uint16_t len)
 	if (len > MAX_HEXADECIMAL_OOB_LEN)
 		return false;
 
-	rl_printf("Request hexadecimal key (hex %d octets)\n", len);
-	rl_prompt_input("mesh", "Enter key (hex number):", response_hexadecimal,
+	bt_shell_printf("Request hexadecimal key (hex %d octets)\n", len);
+	bt_shell_prompt_input("mesh", "Enter key (hex number):", response_hexadecimal,
 								NULL);
 
 	return true;
@@ -129,8 +129,8 @@ static uint32_t power_ten(uint8_t power)
 
 static bool request_decimal(uint16_t len)
 {
-	rl_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
-	rl_prompt_input("mesh", "Enter Numeric key:", response_decimal, NULL);
+	bt_shell_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
+	bt_shell_prompt_input("mesh", "Enter Numeric key:", response_decimal, NULL);
 
 	return true;
 }
@@ -140,8 +140,8 @@ static bool request_ascii(uint16_t len)
 	if (len > MAX_ASCII_OOB_LEN)
 		return false;
 
-	rl_printf("Request ASCII key (max characters %d)\n", len);
-	rl_prompt_input("mesh", "Enter key (ascii string):", response_ascii,
+	bt_shell_printf("Request ASCII key (max characters %d)\n", len);
+	bt_shell_prompt_input("mesh", "Enter key (ascii string):", response_ascii,
 									NULL);
 
 	return true;
@@ -194,7 +194,7 @@ bool agent_output_request(const char* str)
 		return false;
 
 	pending_request.type = OUTPUT;
-	rl_prompt_input("mesh", str, response_output, NULL);
+	bt_shell_prompt_input("mesh", str, response_output, NULL);
 	return true;
 }
 
@@ -203,5 +203,5 @@ void agent_output_request_cancel(void)
 	if (pending_request.type != OUTPUT)
 		return;
 	pending_request.type = NONE;
-	rl_release_prompt("");
+	bt_shell_release_prompt("");
 }
diff --git a/mesh/config-client.c b/mesh/config-client.c
index 782781602..7aabe6ce7 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -34,12 +34,11 @@
 #include <stdbool.h>
 #include <sys/uio.h>
 #include <wordexp.h>
-#include <readline/readline.h>
-#include <readline/history.h>
+
 #include <glib.h>
 
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "client/display.h"
 #include "mesh/mesh-net.h"
 #include "mesh/keys.h"
 #include "mesh/net.h"
@@ -101,12 +100,12 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 4)
 			break;
 
-		rl_printf("Node %4.4x AppKey Status %s\n", src,
+		bt_shell_printf("Node %4.4x AppKey Status %s\n", src,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 		app_idx = get_le16(data + 2) >> 4;
 
-		rl_printf("\tNetKey %3.3x, AppKey %3.3x\n", net_idx, app_idx);
+		bt_shell_printf("\tNetKey %3.3x, AppKey %3.3x\n", net_idx, app_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS &&
 				data[0] != MESH_STATUS_IDX_ALREADY_STORED &&
@@ -119,11 +118,11 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 3)
 			break;
 
-		rl_printf("Node %4.4x NetKey Status %s\n", src,
+		bt_shell_printf("Node %4.4x NetKey Status %s\n", src,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 
-		rl_printf("\tNetKey %3.3x\n", net_idx);
+		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS &&
 				data[0] != MESH_STATUS_IDX_ALREADY_STORED &&
@@ -136,20 +135,20 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 7 && len != 9)
 			break;
 
-		rl_printf("Node %4.4x Model App Status %s\n", src,
+		bt_shell_printf("Node %4.4x Model App Status %s\n", src,
 						mesh_status_str(data[0]));
 		addr = get_le16(data + 1);
 		app_idx = get_le16(data + 3);
 
-		rl_printf("\tElement %4.4x AppIdx %3.3x\n ", addr, app_idx);
+		bt_shell_printf("\tElement %4.4x AppIdx %3.3x\n ", addr, app_idx);
 
 		if (len == 7) {
 			mod_id = get_le16(data + 5);
-			rl_printf("ModelId %4.4x\n", mod_id);
+			bt_shell_printf("ModelId %4.4x\n", mod_id);
 			mod_id = 0xffff0000 | mod_id;
 		} else {
 			mod_id = get_le16(data + 7);
-			rl_printf("ModelId %4.4x %4.4x\n", get_le16(data + 5),
+			bt_shell_printf("ModelId %4.4x %4.4x\n", get_le16(data + 5),
 									mod_id);
 			mod_id = get_le16(data + 5) << 16 | mod_id;
 		}
@@ -162,7 +161,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	case OP_CONFIG_DEFAULT_TTL_STATUS:
 		if (len != 1)
 			return true;
-		rl_printf("Node %4.4x Default TTL %d\n", src, data[0]);
+		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
 		if (node_set_default_ttl (node, data[0]))
 			prov_db_node_set_ttl(node, data[0]);
 		break;
@@ -171,7 +170,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 12 && len != 14)
 			return true;
 
-		rl_printf("\nSet publication for node %4.4x status: %s\n", src,
+		bt_shell_printf("\nSet publication for node %4.4x status: %s\n", src,
 				data[0] == MESH_STATUS_SUCCESS ? "Success" :
 						mesh_status_str(data[0]));
 
@@ -192,22 +191,22 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		n = (data[8] & 0x3f);
 		switch (data[8] >> 6) {
 		case 0:
-			rl_printf("Period: %d ms\n", n * 100);
+			bt_shell_printf("Period: %d ms\n", n * 100);
 			break;
 		case 2:
 			n *= 10;
 			/* fall through */
 		case 1:
-			rl_printf("Period: %d sec\n", n);
+			bt_shell_printf("Period: %d sec\n", n);
 			break;
 		case 3:
-			rl_printf("Period: %d min\n", n * 10);
+			bt_shell_printf("Period: %d min\n", n * 10);
 			break;
 		}
 
 		pub.retransmit = data[9];
-		rl_printf("Retransmit count: %d\n", data[9] >> 5);
-		rl_printf("Retransmit Interval Steps: %d\n", data[9] & 0x1f);
+		bt_shell_printf("Retransmit count: %d\n", data[9] >> 5);
+		bt_shell_printf("Retransmit Interval Steps: %d\n", data[9] & 0x1f);
 
 		ele_idx = ele_addr - node_get_primary(node);
 
@@ -226,45 +225,43 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 static uint32_t target;
 static uint32_t parms[8];
 
-static uint32_t read_input_parameters(const char *args)
+static uint32_t read_input_parameters(int argc, char *argv[])
 {
 	uint32_t i;
 
-	if (!args)
+	--argc;
+	++argv;
+
+	if (!argc || argv[1][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
 
-	for (i = 0; i < sizeof(parms)/sizeof(parms[0]); i++) {
-		int n;
-
-		sscanf(args, "%x", &parms[i]);
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;
+									i++) {
+		sscanf(argv[i], "%x", &parms[i]);
 		if (parms[i] == 0xffffffff)
 			break;
-
-		n = strcspn(args, " \t");
-		args = args + n + strspn(args + n, " \t");
 	}
 
 	return i;
 }
 
-static void cmd_set_node(const char *args)
+static void cmd_set_node(int argc, char *argv[])
 {
 	uint32_t dst;
 	char *end;
 
-	dst = strtol(args, &end, 16);
-	if (end != (args + 4)) {
-		rl_printf("Bad unicast address %s: "
-					"expected format 4 digit hex\n", args);
+	dst = strtol(argv[1], &end, 16);
+	if (end != (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: "
+				"expected format 4 digit hex\n", argv[1]);
 		target = UNASSIGNED_ADDRESS;
 	} else {
-		rl_printf("Configuring node %4.4x\n", dst);
+		bt_shell_printf("Configuring node %4.4x\n", dst);
 		target = dst;
-		set_menu_prompt("config", args);
+		set_menu_prompt("config", argv[1]);
 	}
-
 }
 
 static bool config_send(uint8_t *buf, uint16_t len)
@@ -287,14 +284,14 @@ static bool config_send(uint8_t *buf, uint16_t len)
 
 }
 
-static void cmd_get_composition(const char *args)
+static void cmd_get_composition(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
@@ -306,13 +303,13 @@ static void cmd_get_composition(const char *args)
 	n = mesh_opcode_set(OP_DEV_COMP_GET, msg);
 
 	/* By default, use page 0 */
-	msg[n++] = (read_input_parameters(args) == 1) ? parms[0] : 0;
+	msg[n++] = (read_input_parameters(argc, argv) == 1) ? parms[0] : 0;
 
 	if (!config_send(msg, n))
-		rl_printf("Failed to send \"GET NODE COMPOSITION\"\n");
+		bt_shell_printf("Failed to send \"GET NODE COMPOSITION\"\n");
 }
 
-static void cmd_net_key(const char *args, uint32_t opcode)
+static void cmd_net_key(int argc, char *argv[], uint32_t opcode)
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -321,20 +318,20 @@ static void cmd_net_key(const char *args, uint32_t opcode)
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
 	n = mesh_opcode_set(opcode, msg);
 
-	if (read_input_parameters(args) != 1) {
-		rl_printf("Bad arguments %s\n", args);
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
 		return;
 	}
 
 	node = node_find_by_addr(target);
 	if (!node) {
-		rl_printf("Node %4.4x\n not found", target);
+		bt_shell_printf("Node %4.4x\n not found", target);
 		return;
 	}
 
@@ -344,7 +341,7 @@ static void cmd_net_key(const char *args, uint32_t opcode)
 
 		key = keys_net_key_get(net_idx, true);
 		if (!key) {
-			rl_printf("Network key with index %4.4x not found\n",
+			bt_shell_printf("Network key with index %4.4x not found\n",
 								net_idx);
 			return;
 		}
@@ -357,7 +354,7 @@ static void cmd_net_key(const char *args, uint32_t opcode)
 	}
 
 	if (!config_send(msg, n)) {
-		rl_printf("Failed to send \"%s NET KEY\"\n",
+		bt_shell_printf("Failed to send \"%s NET KEY\"\n",
 				opcode == OP_NETKEY_ADD ? "ADD" : "DEL");
 		return;
 	}
@@ -374,17 +371,17 @@ static void cmd_net_key(const char *args, uint32_t opcode)
 
 }
 
-static void cmd_add_net_key(const char *args)
+static void cmd_add_net_key(int argc, char *argv[])
 {
-	cmd_net_key(args, OP_NETKEY_ADD);
+	cmd_net_key(argc, argv, OP_NETKEY_ADD);
 }
 
-static void cmd_del_net_key(const char *args)
+static void cmd_del_net_key(int argc, char *argv[])
 {
-	cmd_net_key(args, OP_NETKEY_DELETE);
+	cmd_net_key(argc, argv, OP_NETKEY_DELETE);
 }
 
-static void cmd_app_key(const char *args, uint32_t opcode)
+static void cmd_app_key(int argc, char *argv[], uint32_t opcode)
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -394,18 +391,18 @@ static void cmd_app_key(const char *args, uint32_t opcode)
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
-	if (read_input_parameters(args) != 1) {
-		rl_printf("Bad arguments %s\n", args);
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
 		return;
 	}
 
 	node = node_find_by_addr(target);
 	if (!node) {
-		rl_printf("Node %4.4x\n not found", target);
+		bt_shell_printf("Node %4.4x\n not found", target);
 		return;
 	}
 
@@ -414,7 +411,7 @@ static void cmd_app_key(const char *args, uint32_t opcode)
 	app_idx = parms[0];
 	net_idx = keys_app_key_get_bound(app_idx);
 	if (net_idx == NET_IDX_INVALID) {
-		rl_printf("App key with index %4.4x not found\n", app_idx);
+		bt_shell_printf("App key with index %4.4x not found\n", app_idx);
 		return;
 	}
 
@@ -426,7 +423,7 @@ static void cmd_app_key(const char *args, uint32_t opcode)
 	if (opcode != OP_APPKEY_DELETE) {
 		key = keys_app_key_get(app_idx, true);
 		if (!key) {
-			rl_printf("App key %4.4x not found\n", net_idx);
+			bt_shell_printf("App key %4.4x not found\n", net_idx);
 			return;
 		}
 
@@ -435,7 +432,7 @@ static void cmd_app_key(const char *args, uint32_t opcode)
 	}
 
 	if (!config_send(msg, n)) {
-		rl_printf("Failed to send \"ADD %s KEY\"\n",
+		bt_shell_printf("Failed to send \"ADD %s KEY\"\n",
 				opcode == OP_APPKEY_ADD ? "ADD" : "DEL");
 		return;
 	}
@@ -451,14 +448,14 @@ static void cmd_app_key(const char *args, uint32_t opcode)
 	}
 }
 
-static void cmd_add_app_key(const char *args)
+static void cmd_add_app_key(int argc, char *argv[])
 {
-	cmd_app_key(args, OP_APPKEY_ADD);
+	cmd_app_key(argc, argv, OP_APPKEY_ADD);
 }
 
-static void cmd_del_app_key(const char *args)
+static void cmd_del_app_key(int argc, char *argv[])
 {
-	cmd_app_key(args, OP_APPKEY_DELETE);
+	cmd_app_key(argc, argv, OP_APPKEY_DELETE);
 }
 
 static bool verify_config_target(uint32_t dst)
@@ -466,25 +463,25 @@ static bool verify_config_target(uint32_t dst)
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(dst)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return false;
 	}
 
 	node = node_find_by_addr(dst);
 	if (!node) {
-		rl_printf("Node with unicast address %4.4x unknown\n", dst);
+		bt_shell_printf("Node with unicast address %4.4x unknown\n", dst);
 		return false;
 	}
 
 	if (!node_get_composition(node)) {
-		rl_printf("Node composition for %4.4x unknown\n", dst);
+		bt_shell_printf("Node composition for %4.4x unknown\n", dst);
 		return false;
 	}
 
 	return true;
 }
 
-static void cmd_bind(const char *args)
+static void cmd_bind(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -493,9 +490,9 @@ static void cmd_bind(const char *args)
 	if (!verify_config_target(target))
 		return;
 
-	parm_cnt = read_input_parameters(args);
+	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt != 3 && parm_cnt != 4) {
-		rl_printf("Bad arguments %s\n", args);
+		bt_shell_printf("Bad arguments\n");
 		return;
 	}
 
@@ -515,10 +512,10 @@ static void cmd_bind(const char *args)
 	}
 
 	if (!config_send(msg, n))
-		rl_printf("Failed to send \"MODEL APP BIND\"\n");
+		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
 }
 
-static void cmd_set_ttl(const char *args)
+static void cmd_set_ttl(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -526,13 +523,13 @@ static void cmd_set_ttl(const char *args)
 	uint8_t ttl;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
 	n = mesh_opcode_set(OP_CONFIG_DEFAULT_TTL_SET, msg);
 
-	parm_cnt = read_input_parameters(args);
+	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt) {
 		ttl = parms[0] & TTL_MASK;
 	} else
@@ -541,10 +538,10 @@ static void cmd_set_ttl(const char *args)
 	msg[n++] = ttl;
 
 	if (!config_send(msg, n))
-		rl_printf("Failed to send \"SET_DEFAULT TTL\"\n");
+		bt_shell_printf("Failed to send \"SET_DEFAULT TTL\"\n");
 }
 
-static void cmd_set_pub(const char *args)
+static void cmd_set_pub(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -555,9 +552,9 @@ static void cmd_set_pub(const char *args)
 
 	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
 
-	parm_cnt = read_input_parameters(args);
+	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt != 5) {
-		rl_printf("Bad arguments: %s\n", args);
+		bt_shell_printf("Bad arguments\n");
 		return;
 	}
 
@@ -586,7 +583,7 @@ static void cmd_set_pub(const char *args)
 	}
 
 	if (!config_send(msg, n))
-		rl_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
+		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
 static void cmd_default(uint32_t opcode)
@@ -595,29 +592,25 @@ static void cmd_default(uint32_t opcode)
 	uint8_t msg[32];
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
 	n = mesh_opcode_set(opcode, msg);
 
 	if (!config_send(msg, n))
-		rl_printf("Failed to send command (opcode 0x%x)\n", opcode);
+		bt_shell_printf("Failed to send command (opcode 0x%x)\n",
+								opcode);
 }
 
-static void cmd_get_ttl(const char *args)
+static void cmd_get_ttl(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
 }
 
-static void cmd_back(const char *args)
-{
-	cmd_menu_main(false);
-}
-
-static void cmd_help(const char *args);
-
-static const struct menu_entry cfg_menu[] = {
+static const struct bt_shell_menu cfg_menu = {
+	.name = "config",
+	.entries = {
 	{"target",		"<unicast>",			cmd_set_node,
 						"Set target node to configure"},
 	{"get-composition",	"[<page_num>]",		cmd_get_composition,
@@ -639,30 +632,15 @@ static const struct menu_entry cfg_menu[] = {
 	{"set-pub", "<ele_addr> <pub_addr> <app_idx> "
 						"<period (step|res)> <model>",
 				cmd_set_pub,	"Set publication"},
-	{"back",		NULL,				cmd_back,
-						"Back to main menu"},
-	{"help",		NULL,				cmd_help,
-						"Config Commands"},
-	{}
+	{} },
 };
 
-static void cmd_help(const char *args)
-{
-	rl_printf("Client Configuration Menu\n");
-	print_cmd_menu(cfg_menu);
-}
-
-void config_set_node(const char *args)
-{
-	cmd_set_node(args);
-}
-
 void config_client_get_composition(uint32_t dst)
 {
 	uint32_t tmp = target;
 
 	target = dst;
-	cmd_get_composition("");
+	cmd_get_composition(0, NULL);
 	target = tmp;
 }
 
@@ -680,7 +658,7 @@ bool config_client_init(void)
 						&client_cbs, NULL))
 		return false;
 
-	add_cmd_menu("configure", cfg_menu);
+	bt_shell_add_submenu(&cfg_menu);
 
 	return true;
 }
diff --git a/mesh/config-model.h b/mesh/config-model.h
index d7ee5e61f..a5b811365 100644
--- a/mesh/config-model.h
+++ b/mesh/config-model.h
@@ -99,4 +99,3 @@
 bool config_server_init(void);
 bool config_client_init(void);
 void config_client_get_composition(uint32_t dst);
-void config_set_node(const char *args);
diff --git a/mesh/config-server.c b/mesh/config-server.c
index 938ec2275..10fead6e2 100644
--- a/mesh/config-server.c
+++ b/mesh/config-server.c
@@ -34,12 +34,11 @@
 #include <stdbool.h>
 #include <sys/uio.h>
 #include <wordexp.h>
-#include <readline/readline.h>
-#include <readline/history.h>
+
 #include <glib.h>
 
 #include "src/shared/util.h"
-#include "client/display.h"
+#include "src/shared/shell.h"
 #include "mesh/mesh-net.h"
 #include "mesh/keys.h"
 #include "mesh/net.h"
@@ -99,7 +98,7 @@ static bool server_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 11 && len != 13)
 			return true;
 
-		rl_printf("Set publication\n");
+		bt_shell_printf("Set publication\n");
 
 		ele_addr = get_le16(data);
 		mod_id = get_le16(data + 9);
@@ -115,22 +114,22 @@ static bool server_msg_recvd(uint16_t src, uint8_t *data,
 		m = (data[7] & 0x3f);
 		switch (data[7] >> 6) {
 		case 0:
-			rl_printf("Period: %d ms\n", m * 100);
+			bt_shell_printf("Period: %d ms\n", m * 100);
 			break;
 		case 2:
 			m *= 10;
 			/* fall through */
 		case 1:
-			rl_printf("Period: %d sec\n", m);
+			bt_shell_printf("Period: %d sec\n", m);
 			break;
 		case 3:
-			rl_printf("Period: %d min\n", m * 10);
+			bt_shell_printf("Period: %d min\n", m * 10);
 			break;
 		}
 
 		pub.retransmit = data[8];
-		rl_printf("Retransmit count: %d\n", data[8] >> 5);
-		rl_printf("Retransmit Interval Steps: %d\n", data[8] & 0x1f);
+		bt_shell_printf("Retransmit count: %d\n", data[8] >> 5);
+		bt_shell_printf("Retransmit Interval Steps: %d\n", data[8] & 0x1f);
 
 		ele_idx = ele_addr - node_get_primary(node);
 
diff --git a/mesh/gatt.c b/mesh/gatt.c
index 001eb17a8..197291e67 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -33,15 +33,13 @@
 #include <sys/uio.h>
 #include <wordexp.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
 #include "src/shared/io.h"
+#include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
-#include "client/display.h"
 #include "mesh/node.h"
 #include "mesh/util.h"
 #include "mesh/gatt.h"
@@ -216,7 +214,7 @@ static bool pipe_write(struct io *io, void *user_data)
 
 		err = io_send(io, iov, 2);
 		if (err < 0) {
-			rl_printf("Failed to write: %s\n", strerror(-err));
+			bt_shell_printf("Failed to write: %s\n", strerror(-err));
 			write_data_free(data);
 			return false;
 		}
@@ -259,7 +257,7 @@ static void write_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to write: %s\n", error.name);
+		bt_shell_printf("Failed to write: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -307,7 +305,7 @@ static void write_reply(DBusMessage *message, void *user_data)
 
 	if (g_dbus_proxy_method_call(data->proxy, "WriteValue", write_setup,
 				write_reply, data, write_data_free) == FALSE) {
-		rl_printf("Failed to write\n");
+		bt_shell_printf("Failed to write\n");
 		write_data_free(data);
 		return;
 	}
@@ -330,7 +328,7 @@ static void notify_io_destroy(void)
 
 static bool pipe_hup(struct io *io, void *user_data)
 {
-	rl_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
+	bt_shell_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
 
 	if (io == notify_io)
 		notify_io_destroy();
@@ -366,7 +364,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
 				write_setup, write_reply, data,
 				write_data_free) == FALSE) {
-			rl_printf("Failed to write\n");
+			bt_shell_printf("Failed to write\n");
 			write_data_free(data);
 		}
 		return;
@@ -375,11 +373,11 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
 					DBUS_TYPE_UINT16, &write_mtu,
 					DBUS_TYPE_INVALID) == false)) {
-		rl_printf("Invalid AcquireWrite response\n");
+		bt_shell_printf("Invalid AcquireWrite response\n");
 		return;
 	}
 
-	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
+	bt_shell_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
 
 	write_io = pipe_io_new(fd);
 
@@ -441,7 +439,7 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 		if (g_dbus_proxy_method_call(proxy, "AcquireWrite",
 					acquire_setup, acquire_write_reply,
 					data, NULL) == FALSE) {
-			rl_printf("Failed to AcquireWrite\n");
+			bt_shell_printf("Failed to AcquireWrite\n");
 			write_data_free(data);
 			return false;
 		}
@@ -449,12 +447,12 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
 				write_setup, write_reply, data,
 				write_data_free) == FALSE) {
-			rl_printf("Failed to write\n");
+			bt_shell_printf("Failed to write\n");
 			write_data_free(data);
 			return false;
 		}
 		print_byte_array("GATT-TX: ", buf, len);
-		rl_printf("Attempting to write %s\n",
+		bt_shell_printf("Attempting to write %s\n",
 						g_dbus_proxy_get_path(proxy));
 	}
 
@@ -469,13 +467,13 @@ static void notify_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to %s notify: %s\n",
+		bt_shell_printf("Failed to %s notify: %s\n",
 				data->enable ? "start" : "stop", error.name);
 		dbus_error_free(&error);
 		goto done;
 	}
 
-	rl_printf("Notify %s\n", data->enable ? "started" : "stopped");
+	bt_shell_printf("Notify %s\n", data->enable ? "started" : "stopped");
 
 done:
 	if (data->cb)
@@ -535,7 +533,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 		dbus_error_free(&error);
 		if (g_dbus_proxy_method_call(data->proxy, "StartNotify", NULL,
 					notify_reply, data, NULL) == FALSE) {
-			rl_printf("Failed to StartNotify\n");
+			bt_shell_printf("Failed to StartNotify\n");
 			g_free(data);
 		}
 		return;
@@ -553,13 +551,13 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 					DBUS_TYPE_INVALID) == false)) {
 		if (g_dbus_proxy_method_call(data->proxy, "StartNotify", NULL,
 					notify_reply, data, NULL) == FALSE) {
-			rl_printf("Failed to StartNotify\n");
+			bt_shell_printf("Failed to StartNotify\n");
 			g_free(data);
 		}
 		return;
 	}
 
-	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_mtu);
+	bt_shell_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_mtu);
 
 	if (g_dbus_proxy_get_property(data->proxy, "UUID", &iter) == FALSE)
 		goto done;
@@ -619,7 +617,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 
 	if (g_dbus_proxy_method_call(proxy, method, setup, cb,
 					data, NULL) == FALSE) {
-		rl_printf("Failed to %s\n", method);
+		bt_shell_printf("Failed to %s\n", method);
 		return false;
 	}
 	return true;
diff --git a/mesh/main.c b/mesh/main.c
index 1d444977a..05841363f 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -30,8 +30,6 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include <signal.h>
-#include <sys/signalfd.h>
 #include <wordexp.h>
 
 #include <inttypes.h>
@@ -41,16 +39,14 @@
 #include <sys/stat.h>
 #include "bluetooth/bluetooth.h"
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
-#include "client/display.h"
 #include "mesh/mesh-net.h"
 #include "mesh/gatt.h"
 #include "mesh/crypto.h"
@@ -77,7 +73,6 @@
 #define MESH_PROXY_DATA_IN_UUID_STR	"00002add-0000-1000-8000-00805f9b34fb"
 #define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
 
-static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 
 struct adapter {
@@ -103,8 +98,7 @@ static char *mesh_local_config_filename;
 static bool discovering = false;
 static bool discover_mesh;
 static uint16_t prov_net_key_index = NET_IDX_PRIMARY;
-
-static guint input = 0;
+static const struct bt_shell_menu main_menu;
 
 #define CONN_TYPE_NETWORK	0x00
 #define CONN_TYPE_IDENTITY	0x01
@@ -175,7 +169,7 @@ static bool char_is_mesh(GDBusProxy *proxy, const char *target_uuid)
 static gboolean check_default_ctrl(void)
 {
 	if (!default_ctrl) {
-		rl_printf("No default controller available\n");
+		bt_shell_printf("No default controller available\n");
 		return FALSE;
 	}
 
@@ -184,60 +178,19 @@ static gboolean check_default_ctrl(void)
 
 static void proxy_leak(gpointer data)
 {
-	rl_printf("Leaking proxy %p\n", data);
-}
-
-static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	if (condition & G_IO_IN) {
-		rl_callback_read_char();
-		return TRUE;
-	}
-
-	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
-static guint setup_standard_input(void)
-{
-	GIOChannel *channel;
-	guint source;
-
-	channel = g_io_channel_unix_new(fileno(stdin));
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				input_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
+	bt_shell_printf("Leaking proxy %p\n", data);
 }
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
-	rl_set_prompt(PROMPT_ON);
-	rl_printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_set_prompt(PROMPT_ON);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
-	if (input > 0) {
-		g_source_remove(input);
-		input = 0;
-	}
+	bt_shell_detach();
 
-	rl_set_prompt(PROMPT_OFF);
-	rl_printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_set_prompt(PROMPT_OFF);
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	ctrl_list = NULL;
@@ -260,7 +213,7 @@ static void print_adapter(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sController %s %s %s\n",
+	bt_shell_printf("%s%s%sController %s %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -286,7 +239,7 @@ static void print_device(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sDevice %s %s\n",
+	bt_shell_printf("%s%s%sDevice %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -306,39 +259,39 @@ static void print_iter(const char *label, const char *name,
 	char *entry;
 
 	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
+		bt_shell_printf("%s%s is nil\n", label, name);
 		return;
 	}
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
+		bt_shell_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
+		bt_shell_printf("%s%s: %s\n", label, name, valstr);
 		break;
 	case DBUS_TYPE_BOOLEAN:
 		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
+		bt_shell_printf("%s%s: %s\n", label, name,
 					valbool == TRUE ? "yes" : "no");
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		bt_shell_printf("%s%s: 0x%06x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
+		bt_shell_printf("%s%s: %d\n", label, name, vals16);
 		break;
 	case DBUS_TYPE_BYTE:
 		dbus_message_iter_get_basic(iter, &byte);
-		rl_printf("%s%s: 0x%02x\n", label, name, byte);
+		bt_shell_printf("%s%s: 0x%02x\n", label, name, byte);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -364,7 +317,7 @@ static void print_iter(const char *label, const char *name,
 		g_free(entry);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		bt_shell_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -405,14 +358,14 @@ static void print_prov_service(struct prov_svc_data *prov_data)
 	char txt_uuid[16 * 2 + 1];
 	int i;
 
-	rl_printf("%sMesh Provisioning Service (%s)\n", prefix,
+	bt_shell_printf("%sMesh Provisioning Service (%s)\n", prefix,
 							MESH_PROV_SVC_UUID);
 	for (i = 0; i < 16; ++i) {
 		sprintf(txt_uuid + (i * 2), "%2.2x", prov_data->dev_uuid[i]);
 	}
 
-	rl_printf("%s\tDevice UUID: %s\n", prefix, txt_uuid);
-	rl_printf("%s\tOOB: %4.4x\n", prefix, prov_data->oob);
+	bt_shell_printf("%s\tDevice UUID: %s\n", prefix, txt_uuid);
+	bt_shell_printf("%s\tOOB: %4.4x\n", prefix, prov_data->oob);
 
 }
 
@@ -440,7 +393,7 @@ static bool parse_mesh_service_data(const char *uuid, uint8_t *data, int len,
 	const char *prefix = "\t\t";
 
 	if (!(len == 9 && data[0] == 0x00) && !(len == 17 && data[0] == 0x01)) {
-		rl_printf("Unexpected mesh proxy service data length %d\n",
+		bt_shell_printf("Unexpected mesh proxy service data length %d\n",
 									len);
 		return false;
 	}
@@ -453,7 +406,7 @@ static bool parse_mesh_service_data(const char *uuid, uint8_t *data, int len,
 
 		if (IS_UNASSIGNED(connection.unicast)) {
 			/* This would be a bug */
-			rl_printf("Error: Searching identity with "
+			bt_shell_printf("Error: Searching identity with "
 							"unicast 0000\n");
 			return false;
 		}
@@ -467,9 +420,9 @@ static bool parse_mesh_service_data(const char *uuid, uint8_t *data, int len,
 			return false;
 
 		if (discovering) {
-			rl_printf("\n%sMesh Proxy Service (%s)\n", prefix,
+			bt_shell_printf("\n%sMesh Proxy Service (%s)\n", prefix,
 									uuid);
-			rl_printf("%sIdentity for node %4.4x\n", prefix,
+			bt_shell_printf("%sIdentity for node %4.4x\n", prefix,
 							connection.unicast);
 		}
 
@@ -480,9 +433,9 @@ static bool parse_mesh_service_data(const char *uuid, uint8_t *data, int len,
 			return false;
 
 		if (discovering) {
-			rl_printf("\n%sMesh Proxy Service (%s)\n", prefix,
+			bt_shell_printf("\n%sMesh Proxy Service (%s)\n", prefix,
 									uuid);
-			rl_printf("%sNetwork Beacon for net index %4.4x\n",
+			bt_shell_printf("%sNetwork Beacon for net index %4.4x\n",
 							prefix, net_idx);
 		}
 	}
@@ -590,10 +543,10 @@ static void print_uuids(GDBusProxy *proxy)
 				n = sizeof(str) - 1;
 			}
 
-			rl_printf("\tUUID: %s%*c(%s)\n",
+			bt_shell_printf("\tUUID: %s%*c(%s)\n",
 						str, 26 - n, ' ', uuid);
 		} else
-			rl_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+			bt_shell_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -666,14 +619,12 @@ static void set_connected_device(GDBusProxy *proxy)
 				mesh ? buf : "");
 
 done:
-	rl_set_prompt(desc ? desc : PROMPT_ON);
-	rl_printf("\r");
-	rl_on_new_line();
+	bt_shell_set_prompt(desc ? desc : PROMPT_ON);
 	g_free(desc);
 
 	/* If disconnected, return to main menu */
 	if (proxy == NULL)
-		cmd_menu_main(true);
+		bt_shell_set_menu(&main_menu);
 }
 
 static void connect_reply(DBusMessage *message, void *user_data)
@@ -684,13 +635,13 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to connect: %s\n", error.name);
+		bt_shell_printf("Failed to connect: %s\n", error.name);
 		dbus_error_free(&error);
 		set_connected_device(NULL);
 		return;
 	}
 
-	rl_printf("Connection successful\n");
+	bt_shell_printf("Connection successful\n");
 
 	set_connected_device(proxy);
 }
@@ -757,10 +708,10 @@ static void update_device_info(GDBusProxy *proxy)
 						connect_reply, proxy, NULL);
 
 		if (!res)
-			rl_printf("Failed to connect to mesh\n");
+			bt_shell_printf("Failed to connect to mesh\n");
 
 		else
-			rl_printf("Trying to connect to mesh\n");
+			bt_shell_printf("Trying to connect to mesh\n");
 
 	}
 }
@@ -786,10 +737,10 @@ static void data_out_notify(GDBusProxy *proxy, bool enable,
 	node = node_find_by_uuid(connection.dev_uuid);
 
 	if (!mesh_gatt_notify(proxy, enable, cb, node))
-		rl_printf("Failed to %s notification on %s\n", enable ?
+		bt_shell_printf("Failed to %s notification on %s\n", enable ?
 				"start" : "stop", g_dbus_proxy_get_path(proxy));
 	else
-		rl_printf("%s notification on %s\n", enable ?
+		bt_shell_printf("%s notification on %s\n", enable ?
 			  "Start" : "Stop", g_dbus_proxy_get_path(proxy));
 }
 
@@ -810,14 +761,14 @@ static void disconnect(GDBusReturnFunction cb, void *user_data)
 
 	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, cb, user_data,
 							NULL) == FALSE) {
-		rl_printf("Failed to disconnect\n");
+		bt_shell_printf("Failed to disconnect\n");
 		return;
 	}
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
 			dbus_message_iter_get_basic(&iter, &addr);
 
-	rl_printf("Attempting to disconnect from %s\n", addr);
+	bt_shell_printf("Attempting to disconnect from %s\n", addr);
 }
 
 static void disc_notify_cb(DBusMessage *message, void *user_data)
@@ -863,49 +814,49 @@ static void notify_prov_out_cb(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to start notify: %s\n", error.name);
+		bt_shell_printf("Failed to start notify: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Notify for Mesh Provisioning Out Data started\n");
+	bt_shell_printf("Notify for Mesh Provisioning Out Data started\n");
 
 	if (connection.type != CONN_TYPE_PROVISION) {
-		rl_printf("Error: wrong connection type %d (expected %d)\n",
+		bt_shell_printf("Error: wrong connection type %d (expected %d)\n",
 			connection.type, CONN_TYPE_PROVISION);
 		return;
 	}
 
 	if (!connection.data_in) {
-		rl_printf("Error: don't have mesh provisioning data in\n");
+		bt_shell_printf("Error: don't have mesh provisioning data in\n");
 		return;
 	}
 
 	if (!node) {
-		rl_printf("Error: provisioning node not present\n");
+		bt_shell_printf("Error: provisioning node not present\n");
 		return;
 	}
 
 	if(!prov_open(node, connection.data_in, prov_net_key_index,
 			mesh_prov_done, node))
 	{
-		rl_printf("Failed to start provisioning\n");
+		bt_shell_printf("Failed to start provisioning\n");
 		node_free(node);
 		disconnect_device(NULL, NULL);
 	} else
-		rl_printf("Initiated provisioning\n");
+		bt_shell_printf("Initiated provisioning\n");
 
 }
 
 static void session_open_cb (int status)
 {
 	if (status) {
-		rl_printf("Failed to open Mesh session\n");
+		bt_shell_printf("Failed to open Mesh session\n");
 		disconnect_device(NULL, NULL);
 		return;
 	}
 
-	rl_printf("Mesh session is open\n");
+	bt_shell_printf("Mesh session is open\n");
 
 	/* Get composition data for a newly provisioned node */
 	if (connection.type == CONN_TYPE_IDENTITY)
@@ -919,27 +870,27 @@ static void notify_proxy_out_cb(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to start notify: %s\n", error.name);
+		bt_shell_printf("Failed to start notify: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Notify for Mesh Proxy Out Data started\n");
+	bt_shell_printf("Notify for Mesh Proxy Out Data started\n");
 
 	if (connection.type != CONN_TYPE_IDENTITY &&
 			connection.type != CONN_TYPE_NETWORK) {
-		rl_printf("Error: wrong connection type %d "
+		bt_shell_printf("Error: wrong connection type %d "
 				"(expected %d or %d)\n", connection.type,
 				CONN_TYPE_IDENTITY, CONN_TYPE_NETWORK);
 		return;
 	}
 
 	if (!connection.data_in) {
-		rl_printf("Error: don't have mesh proxy data in\n");
+		bt_shell_printf("Error: don't have mesh proxy data in\n");
 		return;
 	}
 
-	rl_printf("Trying to open mesh session\n");
+	bt_shell_printf("Trying to open mesh session\n");
 	net_session_open(connection.data_in, true, session_open_cb);
 	connection.session_open = true;
 }
@@ -964,14 +915,14 @@ static GDBusProxy *get_characteristic(GDBusProxy *device, const char *char_uuid)
 	if (l)
 		service = l->data;
 	else {
-		rl_printf("Mesh service not found\n");
+		bt_shell_printf("Mesh service not found\n");
 		return	NULL;
 	}
 
 	for (l = char_list; l; l = l->next) {
 		if (mesh_gatt_is_child(l->data, service, "Service") &&
 					char_is_mesh(l->data, char_uuid)) {
-			rl_printf("Found matching char: path %s, uuid %s\n",
+			bt_shell_printf("Found matching char: path %s, uuid %s\n",
 				g_dbus_proxy_get_path(l->data), char_uuid);
 			return l->data;
 		}
@@ -1013,7 +964,7 @@ static void mesh_session_setup(GDBusProxy *proxy)
 
 fail:
 
-	rl_printf("Services resolved, mesh characteristics not found\n");
+	bt_shell_printf("Services resolved, mesh characteristics not found\n");
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -1032,13 +983,13 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattService1") &&
 						service_is_mesh(proxy, NULL)) {
 
-		rl_printf("Service added %s\n", g_dbus_proxy_get_path(proxy));
+		bt_shell_printf("Service added %s\n", g_dbus_proxy_get_path(proxy));
 		service_list = g_list_append(service_list, proxy);
 
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1") &&
 						char_is_mesh(proxy, NULL)) {
 
-		rl_printf("Char added %s:\n", g_dbus_proxy_get_path(proxy));
+		bt_shell_printf("Char added %s:\n", g_dbus_proxy_get_path(proxy));
 
 		char_list = g_list_append(char_list, proxy);
 	}
@@ -1052,13 +1003,13 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to %s discovery: %s\n",
+		bt_shell_printf("Failed to %s discovery: %s\n",
 				enable == TRUE ? "start" : "stop", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
+	bt_shell_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
 }
 
 static struct mesh_device *find_device_by_proxy(GList *source,
@@ -1210,7 +1161,7 @@ static bool process_mesh_characteristic(GDBusProxy *proxy)
 			node = node_find_by_uuid(connection.dev_uuid);
 
 			if (!node) {
-				rl_printf("Node not found?\n");
+				bt_shell_printf("Node not found?\n");
 				return false;
 			}
 
@@ -1256,7 +1207,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 				dbus_message_iter_get_basic(iter, &resolved);
 
-				rl_printf("Services resolved %s\n", resolved ?
+				bt_shell_printf("Services resolved %s\n", resolved ?
 								"yes" : "no");
 
 				if (resolved)
@@ -1268,7 +1219,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		DBusMessageIter addr_iter;
 		char *str;
 
-		rl_printf("Adapter property changed \n");
+		bt_shell_printf("Adapter property changed \n");
 		if (g_dbus_proxy_get_property(proxy, "Address",
 						&addr_iter) == TRUE) {
 			const char *address;
@@ -1289,10 +1240,10 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		print_iter(str, name, iter);
 		g_free(str);
 	} else if (!strcmp(interface, "org.bluez.GattService1")) {
-		rl_printf("Service property changed %s\n",
+		bt_shell_printf("Service property changed %s\n",
 						g_dbus_proxy_get_path(proxy));
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
-		rl_printf("Characteristic property changed %s\n",
+		bt_shell_printf("Characteristic property changed %s\n",
 						g_dbus_proxy_get_path(proxy));
 
 		if ((strcmp(name, "Value") == 0) &&
@@ -1305,7 +1256,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	rl_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
+	bt_shell_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
 					dbus_message_get_member(message));
 }
 
@@ -1331,28 +1282,24 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
-static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
+static gboolean parse_argument_on_off(int argc, char *argv[],
+					dbus_bool_t *value)
 {
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing on/off argument\n");
-		return FALSE;
-	}
-
-	if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
 		*value = TRUE;
 		return TRUE;
 	}
 
-	if (!strcmp(arg, "off") || !strcmp(arg, "no")) {
+	if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no")) {
 		*value = FALSE;
 		return TRUE;
 	}
 
-	rl_printf("Invalid argument %s\n", arg);
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
 	return FALSE;
 }
 
-static void cmd_list(const char *arg)
+static void cmd_list(int argc, char *argv[])
 {
 	GList *list;
 
@@ -1362,7 +1309,7 @@ static void cmd_list(const char *arg)
 	}
 }
 
-static void cmd_show(const char *arg)
+static void cmd_show(int argc, char *argv[])
 {
 	struct adapter *adapter;
 	GDBusProxy *proxy;
@@ -1370,15 +1317,16 @@ static void cmd_show(const char *arg)
 	const char *address;
 
 
-	if (!arg || !strlen(arg)) {
+	if (argc < 2 || !strlen(argv[1])) {
 		if (check_default_ctrl() == FALSE)
 			return;
 
 		proxy = default_ctrl->proxy;
 	} else {
-		adapter = find_ctrl_by_address(ctrl_list, arg);
+		adapter = find_ctrl_by_address(ctrl_list, argv[1]);
 		if (!adapter) {
-			rl_printf("Controller %s not available\n", arg);
+			bt_shell_printf("Controller %s not available\n",
+								argv[1]);
 			return;
 		}
 		proxy = adapter->proxy;
@@ -1388,7 +1336,7 @@ static void cmd_show(const char *arg)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	rl_printf("Controller %s\n", address);
+	bt_shell_printf("Controller %s\n", address);
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
@@ -1400,18 +1348,13 @@ static void cmd_show(const char *arg)
 	print_property(proxy, "Discovering");
 }
 
-static void cmd_select(const char *arg)
+static void cmd_select(int argc, char *argv[])
 {
 	struct adapter *adapter;
 
-	if (!arg || !strlen(arg)) {
-		rl_printf("Missing controller address argument\n");
-		return;
-	}
-
-	adapter = find_ctrl_by_address(ctrl_list, arg);
+	adapter = find_ctrl_by_address(ctrl_list, argv[1]);
 	if (!adapter) {
-		rl_printf("Controller %s not available\n", arg);
+		bt_shell_printf("Controller %s not available\n", argv[1]);
 		return;
 	}
 
@@ -1429,17 +1372,17 @@ static void generic_callback(const DBusError *error, void *user_data)
 	char *str = user_data;
 
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set %s: %s\n", str, error->name);
+		bt_shell_printf("Failed to set %s: %s\n", str, error->name);
 	else
-		rl_printf("Changing %s succeeded\n", str);
+		bt_shell_printf("Changing %s succeeded\n", str);
 }
 
-static void cmd_power(const char *arg)
+static void cmd_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
 	char *str;
 
-	if (parse_argument_on_off(arg, &powered) == FALSE)
+	if (parse_argument_on_off(argc, argv, &powered) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -1455,12 +1398,12 @@ static void cmd_power(const char *arg)
 	g_free(str);
 }
 
-static void cmd_scan(const char *arg)
+static void cmd_scan(int argc, char *argv[])
 {
 	dbus_bool_t enable;
 	const char *method;
 
-	if (parse_argument_on_off(arg, &enable) == FALSE)
+	if (parse_argument_on_off(argc, argv, &enable) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -1475,7 +1418,7 @@ static void cmd_scan(const char *arg)
 	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
 				NULL, start_discovery_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
-		rl_printf("Failed to %s discovery\n",
+		bt_shell_printf("Failed to %s discovery\n",
 					enable == TRUE ? "start" : "stop");
 		return;
 	}
@@ -1617,12 +1560,12 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
 
 	dbus_error_init(&error);
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("SetDiscoveryFilter failed: %s\n", error.name);
+		bt_shell_printf("SetDiscoveryFilter failed: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("SetDiscoveryFilter success\n");
+	bt_shell_printf("SetDiscoveryFilter success\n");
 }
 
 static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
@@ -1648,24 +1591,23 @@ static void set_scan_filter_commit(void)
 	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
 		set_discovery_filter_setup, set_discovery_filter_reply,
 		&args, NULL) == FALSE) {
-		rl_printf("Failed to set discovery filter\n");
+		bt_shell_printf("Failed to set discovery filter\n");
 		return;
 	}
 }
 
-static void set_scan_filter_uuids(const char *arg)
+static void set_scan_filter_uuids(int argc, char *argv[])
 {
 	g_strfreev(filtered_scan_uuids);
 	filtered_scan_uuids = NULL;
 	filtered_scan_uuids_len = 0;
 
-	if (!arg || !strlen(arg))
+	if (!argc || !strlen(argv[0]))
 		goto commit;
 
-	rl_printf("set_scan_filter_uuids %s\n", arg);
-	filtered_scan_uuids = g_strsplit(arg, " ", -1);
+	filtered_scan_uuids = g_strdupv(argv);
 	if (!filtered_scan_uuids) {
-		rl_printf("Failed to parse input\n");
+		bt_shell_printf("Failed to parse input\n");
 		return;
 	}
 
@@ -1675,21 +1617,22 @@ commit:
 	set_scan_filter_commit();
 }
 
-static void cmd_scan_unprovisioned_devices(const char *arg)
+static void cmd_scan_unprovisioned_devices(int argc, char *argv[])
 {
 	dbus_bool_t enable;
+	char *filters[] = { MESH_PROV_SVC_UUID, NULL };
 
-	if (parse_argument_on_off(arg, &enable) == FALSE)
+	if (parse_argument_on_off(argc, argv, &enable) == FALSE)
 		return;
 
 	if (enable == TRUE) {
 		discover_mesh = false;
-		set_scan_filter_uuids(MESH_PROV_SVC_UUID);
+		set_scan_filter_uuids(1, filters);
 	}
-	cmd_scan(arg);
+	cmd_scan(argc, argv);
 }
 
-static void cmd_info(const char *arg)
+static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	DBusMessageIter iter;
@@ -1703,7 +1646,7 @@ static void cmd_info(const char *arg)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	rl_printf("Device %s\n", address);
+	bt_shell_printf("Device %s\n", address);
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
@@ -1735,71 +1678,67 @@ static const char *security2str(uint8_t level)
 	}
 }
 
-static void cmd_security(const char *arg)
+static void cmd_security(int argc, char *argv[])
 {
 	uint8_t level;
 	char *end;
 
-	if (!arg || arg[0] == '\0') {
-		level = prov_get_sec_level();
-		goto done;
-	}
-
-	level = strtol(arg, &end, 10);
-	if (end == arg || !prov_set_sec_level(level)) {
-		rl_printf("Invalid security level %s\n", arg);
+	level = strtol(argv[1], &end, 10);
+	if (end == argv[1] || !prov_set_sec_level(level)) {
+		bt_shell_printf("Invalid security level %s\n", argv[1]);
 		return;
 	}
 
-done:
-	rl_printf("Provision Security Level set to %u (%s)\n", level,
+	bt_shell_printf("Provision Security Level set to %u (%s)\n", level,
 						security2str(level));
 }
 
-static void cmd_connect(const char *arg)
+static void cmd_connect(int argc, char *argv[])
 {
+	char *filters[] = { MESH_PROXY_SVC_UUID, NULL };
+
 	if (check_default_ctrl() == FALSE)
 		return;
 
 	memset(&connection, 0, sizeof(connection));
 
-	if (!arg || !strlen(arg)) {
+	if (argc < 2 || !strlen(argv[1])) {
 		connection.net_idx = NET_IDX_PRIMARY;
 	} else {
 		char *end;
-		connection.net_idx = strtol(arg, &end, 16);
-		if (end == arg) {
+		connection.net_idx = strtol(argv[1], &end, 16);
+		if (end == argv[1]) {
 			connection.net_idx = NET_IDX_INVALID;
-			rl_printf("Invalid network index %s\n", arg);
+			bt_shell_printf("Invalid network index %s\n", argv[1]);
 			return;
 		}
 
-		connection.unicast = strtol(end, NULL, 16);
+		if (argc > 2)
+			connection.unicast = strtol(argv[2], NULL, 16);
 	}
 
 	if (discovering)
 		g_dbus_proxy_method_call(default_ctrl->proxy, "StopDiscovery",
 						NULL, NULL, NULL, NULL);
 
-	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
+	set_scan_filter_uuids(1, filters);
 	discover_mesh = true;
 
 	if (connection.unicast == UNASSIGNED_ADDRESS) {
 		connection.type = CONN_TYPE_NETWORK;
-		rl_printf("Looking for mesh network with net index %4.4x\n",
-				connection.net_idx);
+		bt_shell_printf("Looking for mesh network with net index "
+				"%4.4x\n", connection.net_idx);
 	} else {
 		connection.type = CONN_TYPE_IDENTITY;
-		rl_printf("Looking for node id %4.4x"
+		bt_shell_printf("Looking for node id %4.4x"
 				" on network with net index %4.4x\n",
 				connection.unicast, connection.net_idx);
 	}
 
-
 	if (g_dbus_proxy_method_call(default_ctrl->proxy,
 			"StartDiscovery", NULL, start_discovery_reply,
 				GUINT_TO_POINTER(TRUE), NULL) == FALSE)
-		rl_printf("Failed to start mesh proxy discovery\n");
+		bt_shell_printf("Failed to start mesh proxy discovery\n");
 
 	g_dbus_proxy_method_call(default_ctrl->proxy, "StartDiscovery",
 						NULL, NULL, NULL, NULL);
@@ -1809,19 +1748,20 @@ static void cmd_connect(const char *arg)
 static void prov_disconn_reply(DBusMessage *message, void *user_data)
 {
 	struct mesh_node *node = user_data;
+	char *filters[] = { MESH_PROXY_SVC_UUID, NULL };
 	DBusError error;
 
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to disconnect: %s\n", error.name);
+		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 	set_connected_device(NULL);
 
-	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
+	set_scan_filter_uuids(1, filters);
 	discover_mesh = true;
 
 	connection.type = CONN_TYPE_IDENTITY;
@@ -1832,7 +1772,7 @@ static void prov_disconn_reply(DBusMessage *message, void *user_data)
 	if (g_dbus_proxy_method_call(default_ctrl->proxy,
 			"StartDiscovery", NULL, start_discovery_reply,
 				GUINT_TO_POINTER(TRUE), NULL) == FALSE)
-		rl_printf("Failed to start mesh proxy discovery\n");
+		bt_shell_printf("Failed to start mesh proxy discovery\n");
 
 }
 
@@ -1844,12 +1784,12 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to disconnect: %s\n", error.name);
+		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Successfully disconnected\n");
+	bt_shell_printf("Successfully disconnected\n");
 
 	if (proxy != connection.device)
 		return;
@@ -1857,7 +1797,7 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	set_connected_device(NULL);
 }
 
-static void cmd_disconn(const char *arg)
+static void cmd_disconn(int argc, char *argv[])
 {
 	if (connection.type == CONN_TYPE_PROVISION) {
 		struct mesh_node *node = node_find_by_uuid(connection.dev_uuid);
@@ -1873,53 +1813,49 @@ static void mesh_prov_done(void *user_data, int status)
 	struct mesh_node *node = user_data;
 
 	if (status){
-		rl_printf("Provisioning failed\n");
+		bt_shell_printf("Provisioning failed\n");
 		node_free(node);
 		disconnect_device(NULL, NULL);
 		return;
 	}
 
-	rl_printf("Provision success. Assigned Primary Unicast %4.4x\n",
+	bt_shell_printf("Provision success. Assigned Primary Unicast %4.4x\n",
 						node_get_primary(node));
 
 	if (!prov_db_add_new_node(node))
-		rl_printf("Failed to add node to provisioning DB\n");
+		bt_shell_printf("Failed to add node to provisioning DB\n");
 
 	disconnect_device(prov_disconn_reply, node);
 }
 
-static void cmd_start_prov(const char *arg)
+static void cmd_start_prov(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	struct mesh_device *dev;
 	struct mesh_node *node;
 	int len;
 
-	if (!arg) {
-		rl_printf("Mesh Device UUID is required\n");
-		return;
-	}
-
-	len = strlen(arg);
+	len = strlen(argv[1]);
 	if ( len > 32 || len % 2) {
-		rl_printf("Incorrect UUID size %d\n", len);
+		bt_shell_printf("Incorrect UUID size %d\n", len);
 	}
 
 	disconnect_device(NULL, NULL);
 
 	memset(connection.dev_uuid, 0, 16);
-	str2hex(arg, len, connection.dev_uuid, len/2);
+	str2hex(argv[1], len, connection.dev_uuid, len/2);
 
 	node = node_find_by_uuid(connection.dev_uuid);
 	if (!node) {
-		rl_printf("Device with UUID %s not found.\n", arg);
-		rl_printf("Stale services? Remove device and re-discover\n");
+		bt_shell_printf("Device with UUID %s not found.\n", argv[1]);
+		bt_shell_printf("Stale services? Remove device and "
+						"re-discover\n");
 		return;
 	}
 
 	/* TODO: add command to remove a node from mesh, i.e., "unprovision" */
 	if (node_is_provisioned(node)) {
-		rl_printf("Already provisioned with unicast %4.4x\n",
+		bt_shell_printf("Already provisioned with unicast %4.4x\n",
 				node_get_primary(node));
 		return;
 	}
@@ -1927,7 +1863,7 @@ static void cmd_start_prov(const char *arg)
 	dev = find_device_by_uuid(default_ctrl->mesh_devices,
 				  connection.dev_uuid);
 	if (!dev || !dev->proxy) {
-		rl_printf("Could not find device proxy\n");
+		bt_shell_printf("Could not find device proxy\n");
 		memset(connection.dev_uuid, 0, 16);
 		return;
 	}
@@ -1942,71 +1878,32 @@ static void cmd_start_prov(const char *arg)
 
 	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
 							proxy, NULL) == FALSE) {
-		rl_printf("Failed to connect ");
+		bt_shell_printf("Failed to connect ");
 		print_device(proxy, NULL);
 		return;
 	} else {
-		rl_printf("Trying to connect ");
+		bt_shell_printf("Trying to connect ");
 		print_device(proxy, NULL);
 	}
 
 }
 
-static void cmd_config(const char *arg)
-{
-	rl_printf("Switching to Mesh Client configuration menu\n");
-
-	if (!switch_cmd_menu("configure"))
-		return;
-
-	set_menu_prompt("config", NULL);
-
-	if (arg && strlen(arg))
-		config_set_node(arg);
-}
-
-static void cmd_onoff_cli(const char *arg)
-{
-	rl_printf("Switching to Mesh Generic ON OFF Client menu\n");
-
-	if (!switch_cmd_menu("onoff"))
-		return;
-
-	set_menu_prompt("on/off", NULL);
-
-	if (arg && strlen(arg))
-		onoff_set_node(arg);
-}
-
-static void cmd_print_mesh(const char *arg)
+static void cmd_print_mesh(int argc, char *argv[])
 {
 	if (!prov_db_show(mesh_prov_db_filename))
-		rl_printf("Unavailable\n");
+		bt_shell_printf("Unavailable\n");
 
 }
 
- static void cmd_print_local(const char *arg)
+ static void cmd_print_local(int argc, char *argv[])
 {
 	if (!prov_db_show(mesh_local_config_filename))
-		rl_printf("Unavailable\n");
-}
-
-static void disc_quit_cb(DBusMessage *message, void *user_data)
-{
-	g_main_loop_quit(main_loop);
+		bt_shell_printf("Unavailable\n");
 }
 
-static void cmd_quit(const char *arg)
-{
-	if (connection.device) {
-		disconnect_device(disc_quit_cb, NULL);
-		return;
-	}
-
-	g_main_loop_quit(main_loop);
-}
-
-static const struct menu_entry meshctl_cmd_table[] = {
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
 	{ "list",         NULL,       cmd_list, "List available controllers"},
 	{ "show",         "[ctrl]",   cmd_show, "Controller information"},
 	{ "select",       "<ctrl>",   cmd_select, "Select default controller"},
@@ -2023,195 +1920,44 @@ static const struct menu_entry meshctl_cmd_table[] = {
 	{ "mesh-info",    NULL,       cmd_print_mesh,
 					"Mesh networkinfo (provisioner)" },
 	{ "local-info",    NULL,      cmd_print_local, "Local mesh node info" },
-	{ "configure",    "[dst]",    cmd_config, "Config client model menu"},
-	{ "onoff",        "[dst]",    cmd_onoff_cli,
-						"Generic On/Off model menu"},
-	{ "quit",         NULL,       cmd_quit, "Quit program" },
-	{ "exit",         NULL,       cmd_quit },
-	{ "help" },
-	{ }
+	{ } },
 };
 
-static void rl_handler(char *input)
-{
-	char *cmd, *arg;
-
-	if (!input) {
-		rl_insert_text("quit");
-		rl_redisplay();
-		rl_crlf();
-		g_main_loop_quit(main_loop);
-		return;
-	}
-
-	if (!strlen(input))
-		goto done;
-	else if (!strcmp(input, "q") || !strcmp(input, "quit")
-						|| !strcmp(input, "exit")) {
-		cmd_quit(NULL);
-		goto done;
-	}
-
-	if (!rl_release_prompt(input))
-		goto done;
-
-	add_history(input);
-
-	cmd = strtok_r(input, " \t\r\n", &arg);
-	if (!cmd)
-		goto done;
-
-	process_menu_cmd(cmd, arg);
-
-done:
-	free(input);
-}
-
-static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	static bool terminated = false;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
-
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return FALSE;
-
-	switch (si.ssi_signo) {
-	case SIGINT:
-		if (input) {
-			rl_replace_line("", 0);
-			rl_crlf();
-			rl_on_new_line();
-			rl_redisplay();
-			break;
-		}
-
-		/*
-		 * If input was not yet setup up that means signal was received
-		 * while daemon was not yet running. Since user is not able
-		 * to terminate client by CTRL-D or typing exit treat this as
-		 * exit and fall through.
-		 */
-
-		/* fall through */
-	case SIGTERM:
-		if (!terminated) {
-			rl_replace_line("", 0);
-			rl_crlf();
-			g_main_loop_quit(main_loop);
-		}
-
-		terminated = true;
-		break;
-	}
-
-	return TRUE;
-}
-
-static guint setup_signalfd(void)
-{
-	GIOChannel *channel;
-	guint source;
-	sigset_t mask;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		perror("Failed to set signal mask");
-		return 0;
-	}
-
-	fd = signalfd(-1, &mask, 0);
-	if (fd < 0) {
-		perror("Failed to create signal descriptor");
-		return 0;
-	}
-
-	channel = g_io_channel_unix_new(fd);
-
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				signal_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
-static gboolean option_version = FALSE;
 static const char *mesh_config_dir;
 
 static GOptionEntry options[] = {
 	{ "config", 'c', 0, G_OPTION_ARG_STRING, &mesh_config_dir,
 			"Read local mesh config JSON files from <directory>" },
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
 	{ NULL },
 };
 
 static void client_ready(GDBusClient *client, void *user_data)
 {
-	if (!input)
-		input = setup_standard_input();
+	bt_shell_attach(fileno(stdin));
 }
 
 int main(int argc, char *argv[])
 {
-	GOptionContext *context;
-	GError *error = NULL;
 	GDBusClient *client;
-	guint signal;
 	int len;
 	int extra;
 
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, options, NULL);
-
-	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
-	}
-
-	g_option_context_free(context);
-
-	if (option_version == TRUE) {
-		rl_printf("%s\n", VERSION);
-		exit(0);
-	}
+	bt_shell_init(&argc, &argv, options);
+	bt_shell_set_menu(&main_menu);
+	bt_shell_set_prompt(PROMPT_OFF);
 
 	if (!mesh_config_dir) {
-		rl_printf("Local config directory not provided.\n");
+		bt_shell_printf("Local config directory not provided.\n");
 		mesh_config_dir = "";
 	} else {
-		rl_printf("Reading prov_db.json and local_node.json from %s\n",
+		bt_shell_printf("Reading prov_db.json and local_node.json from %s\n",
 							mesh_config_dir);
 	}
 
 	len = strlen(mesh_config_dir);
 	if (len && mesh_config_dir[len - 1] != '/') {
 		extra = 1;
-		rl_printf("mesh_config_dir[%d] %s\n", len,
+		bt_shell_printf("mesh_config_dir[%d] %s\n", len,
 						&mesh_config_dir[len - 1]);
 	} else {
 		extra = 0;
@@ -2257,18 +2003,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	main_loop = g_main_loop_new(NULL, FALSE);
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-
-	setlinebuf(stdout);
-
-	rl_erase_empty_line = 1;
-	rl_callback_handler_install(NULL, rl_handler);
-
-	rl_set_prompt(PROMPT_OFF);
-	rl_redisplay();
-
-	signal = setup_signalfd();
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
@@ -2280,8 +2015,6 @@ int main(int argc, char *argv[])
 
 	g_dbus_client_set_ready_watch(client, client_ready, NULL);
 
-	cmd_menu_init(meshctl_cmd_table);
-
 	if (!config_client_init())
 		g_printerr("Failed to initialize mesh configuration client\n");
 
@@ -2291,18 +2024,11 @@ int main(int argc, char *argv[])
 	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic On/Off client\n");
 
-	g_main_loop_run(main_loop);
+	bt_shell_run();
 
 	g_dbus_client_unref(client);
-	g_source_remove(signal);
-	if (input > 0)
-		g_source_remove(input);
-
-	rl_message("");
-	rl_callback_handler_remove();
 
 	dbus_connection_unref(dbus_conn);
-	g_main_loop_unref(main_loop);
 
 	node_cleanup();
 
@@ -2310,7 +2036,5 @@ int main(int argc, char *argv[])
 	g_list_free(service_list);
 	g_list_free_full(ctrl_list, proxy_leak);
 
-	rl_release_prompt("");
-
 	return 0;
 }
diff --git a/mesh/net.c b/mesh/net.c
index 96e82fe1c..421dc6955 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -33,7 +33,7 @@
 #include <glib.h>
 
 #include "src/shared/util.h"
-#include "client/display.h"
+#include "src/shared/shell.h"
 
 #include "mesh/crypto.h"
 #include "mesh/gatt.h"
@@ -958,7 +958,7 @@ static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
 
 	/* Enforcement of 96 hour and 192 hour IVU time windows */
 	if (iv_update && !net.iv_update) {
-		rl_printf("iv_upd_state = IV_UPD_UPDATING\n");
+		bt_shell_printf("iv_upd_state = IV_UPD_UPDATING\n");
 		net.iv_upd_state = IV_UPD_UPDATING;
 		/* TODO: Start timer to enforce IV Update parameters */
 	} else if (first) {
@@ -967,11 +967,11 @@ static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
 		else
 			net.iv_upd_state = IV_UPD_NORMAL;
 
-		rl_printf("iv_upd_state = IV_UPD_%s\n",
+		bt_shell_printf("iv_upd_state = IV_UPD_%s\n",
 				iv_update ? "UPDATING" : "NORMAL");
 
 	} else if (iv_update && iv_index != net.iv_index) {
-		rl_printf("IV Update too soon -- Rejecting\n");
+		bt_shell_printf("IV Update too soon -- Rejecting\n");
 		return;
 	}
 
@@ -1060,7 +1060,7 @@ static bool process_beacon(uint8_t *data, uint8_t size)
 
 	if ((net.iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
 			(iv_index < net.iv_index)) {
-		rl_printf("iv index outside range\n");
+		bt_shell_printf("iv index outside range\n");
 		return false;
 	}
 
@@ -1076,7 +1076,7 @@ static bool process_beacon(uint8_t *data, uint8_t size)
 
 	if (iv_update && (net.iv_upd_state > IV_UPD_UPDATING)) {
 		if (iv_index != net.iv_index) {
-			rl_printf("Update too soon -- Rejecting\n");
+			bt_shell_printf("Update too soon -- Rejecting\n");
 		}
 		/* Silently ignore old beacons */
 		return true;
@@ -1198,7 +1198,7 @@ static void send_pkt_cmplt(DBusMessage *message, void *user_data)
 		g_free(pkt);
 	} else {
 		/* This is a serious error, and probable memory leak */
-		rl_printf("ERR: send_pkt_cmplt %p not head of queue\n", pkt);
+		bt_shell_printf("ERR: send_pkt_cmplt %p not head of queue\n", pkt);
 	}
 
 	l = g_list_first(net.pkt_out);
@@ -1381,7 +1381,7 @@ static bool proxy_ctl_rxed(uint16_t net_idx, uint32_t iv_index,
 				return false;
 
 			net.blacklist = !!(trans[1] == BLACKLIST_FILTER);
-			rl_printf("Proxy %slist filter length: %d\n",
+			bt_shell_printf("Proxy %slist filter length: %d\n",
 					net.blacklist ? "Black" : "White",
 					get_be16(trans + 2));
 
diff --git a/mesh/node.c b/mesh/node.c
index b906754ae..b682a35f7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -34,12 +34,10 @@
 #include <wordexp.h>
 #include <inttypes.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
-#include "client/display.h"
 #include "src/shared/util.h"
+#include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
 #include "mesh/mesh-net.h"
@@ -450,7 +448,7 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 bool node_set_local_node(struct mesh_node *node)
 {
 	if (local_node) {
-		rl_printf("Local node already registered\n");
+		bt_shell_printf("Local node already registered\n");
 		return false;
 	}
 	net_register_unicast(node->primary, node->num_ele);
@@ -516,7 +514,7 @@ void node_local_data_handler(uint16_t src, uint32_t dst,
 
 	if (!remote) {
 		if (local_node->provisioner) {
-			rl_printf("Remote node unknown (%4.4x)\n", src);
+			bt_shell_printf("Remote node unknown (%4.4x)\n", src);
 			return;
 		}
 
@@ -538,7 +536,7 @@ void node_local_data_handler(uint16_t src, uint32_t dst,
 		iv_seq |= remote->seq_number;
 
 		if (iv_seq_remote >= iv_seq) {
-			rl_printf("Replayed message detected "
+			bt_shell_printf("Replayed message detected "
 					"(%016" PRIx64 " >= %016" PRIx64 ")\n",
 							iv_seq_remote, iv_seq);
 			return;
diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
index 676c14c78..9c8869414 100644
--- a/mesh/onoff-model.c
+++ b/mesh/onoff-model.c
@@ -38,7 +38,7 @@
 #include <readline/history.h>
 #include <glib.h>
 
-#include "client/display.h"
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "mesh/mesh-net.h"
 #include "mesh/keys.h"
@@ -58,7 +58,7 @@ static int client_bind(uint16_t app_idx, int action)
 			return MESH_STATUS_INSUFF_RESOURCES;
 		} else {
 			onoff_app_idx = app_idx;
-			rl_printf("On/Off client model: new binding %4.4x\n",
+			bt_shell_printf("On/Off client model: new binding %4.4x\n",
 								app_idx);
 		}
 	} else {
@@ -101,7 +101,7 @@ static void print_remaining_time(uint8_t remaining_time)
 		break;
 	}
 
-	rl_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d msecs\n",
+	bt_shell_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d msecs\n",
 						hours, minutes, secs, msecs);
 
 }
@@ -118,7 +118,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	} else
 		return false;
 
-	rl_printf("On Off Model Message received (%d) opcode %x\n",
+	bt_shell_printf("On Off Model Message received (%d) opcode %x\n",
 								len, opcode);
 	print_byte_array("\t",data, len);
 
@@ -130,14 +130,14 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 1 && len != 3)
 			break;
 
-		rl_printf("Node %4.4x: Off Status present = %s",
+		bt_shell_printf("Node %4.4x: Off Status present = %s",
 						src, data[0] ? "ON" : "OFF");
 
 		if (len == 3) {
-			rl_printf(", target = %s", data[1] ? "ON" : "OFF");
+			bt_shell_printf(", target = %s", data[1] ? "ON" : "OFF");
 			print_remaining_time(data[2]);
 		} else
-			rl_printf("\n");
+			bt_shell_printf("\n");
 		break;
 	}
 
@@ -148,44 +148,42 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 static uint32_t target;
 static uint32_t parms[8];
 
-static uint32_t read_input_parameters(const char *args)
+static uint32_t read_input_parameters(int argc, char *argv[])
 {
 	uint32_t i;
 
-	if (!args)
+	--argc;
+	++argv;
+
+	if (!argc || argv[1][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
 
-	for (i = 0; i < sizeof(parms)/sizeof(parms[0]); i++) {
-		int n;
-
-		sscanf(args, "%x", &parms[i]);
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;
+									i++) {
+		sscanf(argv[i], "%x", &parms[i]);
 		if (parms[i] == 0xffffffff)
 			break;
-
-		n = strcspn(args, " \t");
-		args = args + n + strspn(args + n, " \t");
 	}
 
 	return i;
 }
 
-static void cmd_set_node(const char *args)
+static void cmd_set_node(int argc, char *argv[])
 {
 	uint32_t dst;
 	char *end;
 
-	dst = strtol(args, &end, 16);
-	if (end != (args + 4)) {
-		rl_printf("Bad unicast address %s: "
-						"expected format 4 digit hex\n",
-			args);
+	dst = strtol(argv[1], &end, 16);
+	if (end != (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: "
+				"expected format 4 digit hex\n", argv[1]);
 		target = UNASSIGNED_ADDRESS;
 	} else {
-		rl_printf("Controlling ON/OFF for node %4.4x\n", dst);
+		bt_shell_printf("Controlling ON/OFF for node %4.4x\n", dst);
 		target = dst;
-		set_menu_prompt("on/off", args);
+		set_menu_prompt("on/off", argv[1]);
 	}
 }
 
@@ -203,14 +201,14 @@ static bool send_cmd(uint8_t *buf, uint16_t len)
 					target, onoff_app_idx, buf, len);
 }
 
-static void cmd_get_status(const char *args)
+static void cmd_get_status(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
@@ -222,17 +220,17 @@ static void cmd_get_status(const char *args)
 	n = mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
 
 	if (!send_cmd(msg, n))
-		rl_printf("Failed to send \"GENERIC ON/OFF GET\"\n");
+		bt_shell_printf("Failed to send \"GENERIC ON/OFF GET\"\n");
 }
 
-static void cmd_set(const char *args)
+static void cmd_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
 	struct mesh_node *node;
 
 	if (IS_UNASSIGNED(target)) {
-		rl_printf("Destination not set\n");
+		bt_shell_printf("Destination not set\n");
 		return;
 	}
 
@@ -241,9 +239,9 @@ static void cmd_set(const char *args)
 	if (!node)
 		return;
 
-	if ((read_input_parameters(args) != 1) &&
+	if ((read_input_parameters(argc, argv) != 1) &&
 					parms[0] != 0 && parms[0] != 1) {
-		rl_printf("Bad arguments %s. Expecting \"0\" or \"1\"\n", args);
+		bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\"\n");
 		return;
 	}
 
@@ -252,41 +250,22 @@ static void cmd_set(const char *args)
 	msg[n++] = trans_id++;
 
 	if (!send_cmd(msg, n))
-		rl_printf("Failed to send \"GENERIC ON/OFF SET\"\n");
+		bt_shell_printf("Failed to send \"GENERIC ON/OFF SET\"\n");
 
 }
 
-static void cmd_back(const char *args)
-{
-	cmd_menu_main(false);
-}
-
-static void cmd_help(const char *args);
-
-static const struct menu_entry cfg_menu[] = {
+static const struct bt_shell_menu onoff_menu = {
+	.name = "onoff",
+	.entries = {
 	{"target",		"<unicast>",			cmd_set_node,
 						"Set node to configure"},
 	{"get",			NULL,				cmd_get_status,
 						"Get ON/OFF status"},
 	{"onoff",		"<0/1>",			cmd_set,
 						"Send \"SET ON/OFF\" command"},
-	{"back",		NULL,				cmd_back,
-						"Back to main menu"},
-	{"help",		NULL,				cmd_help,
-						"Config Commands"},
-	{}
+	{} },
 };
 
-static void cmd_help(const char *args)
-{
-	rl_printf("Client Configuration Menu\n");
-	print_cmd_menu(cfg_menu);
-}
-
-void onoff_set_node(const char *args) {
-	cmd_set_node(args);
-}
-
 static struct mesh_model_ops client_cbs = {
 	client_msg_recvd,
 	client_bind,
@@ -300,7 +279,7 @@ bool onoff_client_init(uint8_t ele)
 					&client_cbs, NULL))
 		return false;
 
-	add_cmd_menu("onoff", cfg_menu);
+	bt_shell_add_submenu(&onoff_menu);
 
 	return true;
 }
diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index 9add3f7c3..04803a5c8 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -37,11 +37,10 @@
 #include <json-c/json.h>
 #include <sys/stat.h>
 
-#include <readline/readline.h>
 #include <glib.h>
 
 #include "src/shared/util.h"
-#include "client/display.h"
+#include "src/shared/shell.h"
 
 #include "mesh/mesh-net.h"
 #include "mesh/crypto.h"
@@ -83,7 +82,7 @@ static char* prov_file_read(const char *filename)
 
 	sz = read(fd, str, st.st_size);
 	if (sz != st.st_size)
-		rl_printf("Incomplete read: %d vs %d\n", (int)sz,
+		bt_shell_printf("Incomplete read: %d vs %d\n", (int)sz,
 							(int)(st.st_size));
 
 	close(fd);
@@ -104,7 +103,7 @@ static void prov_file_write(json_object *jmain, bool local)
 
 	outfile = fopen(out_filename, "wr");
 	if (!outfile) {
-		rl_printf("Failed to open file %s for writing\n", out_filename);
+		bt_shell_printf("Failed to open file %s for writing\n", out_filename);
 		return;
 	}
 
@@ -577,10 +576,10 @@ void prov_db_print_node_composition(struct mesh_node *node)
 
 done:
 	if (res)
-		rl_printf("\tComposition data for node %4.4x %s\n",
+		bt_shell_printf("\tComposition data for node %4.4x %s\n",
 							primary, comp_str);
 	else
-		rl_printf("\tComposition data for node %4.4x not present\n",
+		bt_shell_printf("\tComposition data for node %4.4x not present\n",
 								primary);
 	g_free(in_str);
 
@@ -1380,7 +1379,7 @@ bool prov_db_show(const char *filename)
 	if (!str)
 		return false;
 
-	rl_printf("%s\n", str);
+	bt_shell_printf("%s\n", str);
 	g_free(str);
 	return true;
 }
@@ -1415,7 +1414,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 
 		json_object_object_get_ex(jmain, "node", &jnode);
 		if (!jnode) {
-			rl_printf("Cannot find \"node\" object");
+			bt_shell_printf("Cannot find \"node\" object");
 			goto done;
 		} else
 			result = parse_node(jnode, true);
@@ -1451,7 +1450,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 		goto done;
 
 	len = json_object_array_length(jarray);
-	rl_printf("# netkeys = %d\n", len);
+	bt_shell_printf("# netkeys = %d\n", len);
 
 	for (i = 0; i < len; ++i) {
 		uint32_t idx;
@@ -1489,7 +1488,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 	json_object_object_get_ex(jmain, "appKeys", &jarray);
 	if (jarray) {
 		len = json_object_array_length(jarray);
-		rl_printf("# appkeys = %d\n", len);
+		bt_shell_printf("# appkeys = %d\n", len);
 
 		for (i = 0; i < len; ++i) {
 			int app_idx;
@@ -1536,7 +1535,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 		goto done;
 
 	len = json_object_array_length(jarray);
-	rl_printf("# provisioners = %d\n", len);
+	bt_shell_printf("# provisioners = %d\n", len);
 
 	for (i = 0; i < len; ++i) {
 
@@ -1550,7 +1549,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 		}
 
 		if (!parse_unicast_range(jtemp)) {
-			rl_printf("Doneed to parse unicast range\n");
+			bt_shell_printf("Doneed to parse unicast range\n");
 			goto done;
 		}
 	}
@@ -1563,7 +1562,7 @@ static bool read_json_db(const char *filename, bool provisioner, bool local)
 
 	len = json_object_array_length(jarray);
 
-	rl_printf("# provisioned nodes = %d\n", len);
+	bt_shell_printf("# provisioned nodes = %d\n", len);
 	for (i = 0; i < len; ++i) {
 		json_object *jnode;
 		jnode = json_object_array_get_idx(jarray, i);
diff --git a/mesh/prov.c b/mesh/prov.c
index a3333f7b6..1ff5cedbb 100644
--- a/mesh/prov.c
+++ b/mesh/prov.c
@@ -38,10 +38,10 @@
 
 #include "src/shared/util.h"
 #include "src/shared/ecc.h"
+#include "src/shared/shell.h"
 
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
-#include "client/display.h"
 #include "mesh/node.h"
 #include "mesh/gatt.h"
 #include "mesh/crypto.h"
@@ -178,9 +178,9 @@ bool prov_open(struct mesh_node *node, GDBusProxy *prov_in, uint16_t net_idx,
 	prov->conf_in.invite.attention = invite[2];
 	prov->state = PROV_INVITE;
 
-	rl_printf("Open-Node: %p\n", node);
-	rl_printf("Open-Prov: %p\n", prov);
-	rl_printf("Open-Prov: proxy %p\n", prov_in);
+	bt_shell_printf("Open-Node: %p\n", node);
+	bt_shell_printf("Open-Prov: %p\n", prov);
+	bt_shell_printf("Open-Prov: proxy %p\n", prov_in);
 
 	return mesh_gatt_write(prov_in, invite, sizeof(invite), NULL, node);
 }
@@ -380,7 +380,7 @@ static void prov_calc_ecdh(DBusMessage *message, void *node)
 						"Enter %s on device\n",
 						in_ascii);
 			}
-			rl_printf("Agent String: %s\n", in_oob_display);
+			bt_shell_printf("Agent String: %s\n", in_oob_display);
 			agent_output_request(in_oob_display);
 			break;
 	}
@@ -436,7 +436,7 @@ bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
 	buf++;
 	len--;
 
-	rl_printf("Got provisioning data (%d bytes)\n", len);
+	bt_shell_printf("Got provisioning data (%d bytes)\n", len);
 
 	if (buf[0] > PROV_FAILED || expected_pdu_size[buf[0]] != len)
 		return prov_complete(node, PROV_ERR_INVALID_PDU);
@@ -611,7 +611,7 @@ bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
 				return prov_complete(node,
 						PROV_ERR_INVALID_PDU);
 
-			rl_printf("Confirmation Validated\n");
+			bt_shell_printf("Confirmation Validated\n");
 
 			prov_send_prov_data(node);
 
@@ -630,7 +630,7 @@ bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
 	/* Compose appropriate reply for the prov state message */
 	/* Send reply via mesh_gatt_write() */
 	/* If done, call prov_done calllback and free prov housekeeping data */
-	rl_printf("Got provisioning data (%d bytes)\n", len);
+	bt_shell_printf("Got provisioning data (%d bytes)\n", len);
 	print_byte_array("\t", buf, len);
 
 	return true;
diff --git a/mesh/util.c b/mesh/util.c
index fac4bab1b..d38d87514 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -28,175 +28,23 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <inttypes.h>
-#include <readline/readline.h>
+
 #include <glib.h>
 
-#include "client/display.h"
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "mesh/mesh-net.h"
 #include "mesh/node.h"
 #include "mesh/util.h"
 
-struct cmd_menu {
-	const char *name;
-	const struct menu_entry *table;
-};
-
-static struct menu_entry *main_cmd_table;
-static struct menu_entry *current_cmd_table;
-static GList *menu_list;
-
-static char *main_menu_prompt;
-static int main_menu_point;
-
-static int match_menu_name(const void *a, const void *b)
-{
-	const struct cmd_menu *menu = a;
-	const char *name = b;
-
-	return strcasecmp(menu->name, name);
-}
-
-bool cmd_menu_init(const struct menu_entry *cmd_table)
-{
-	struct cmd_menu *menu;
-
-	if (main_cmd_table) {
-		rl_printf("Main menu already registered\n");
-		return false;
-	}
-
-	menu = g_malloc(sizeof(struct cmd_menu));
-	if (!menu)
-		return false;
-
-	menu->name = "meshctl";
-	menu->table = cmd_table;
-	menu_list = g_list_append(menu_list, menu);
-	main_cmd_table = (struct menu_entry *) cmd_table;
-	current_cmd_table = (struct menu_entry *) main_cmd_table;
-
-	return true;
-}
-
-void cmd_menu_main(bool forced)
-{
-	current_cmd_table = main_cmd_table;
-
-	if (!forced) {
-		rl_set_prompt(main_menu_prompt);
-		rl_replace_line("", 0);
-		rl_point = main_menu_point;
-		rl_redisplay();
-	}
-
-	g_free(main_menu_prompt);
-	main_menu_prompt = NULL;
-}
-
-bool add_cmd_menu(const char *name, const struct menu_entry *cmd_table)
-{
-	struct cmd_menu *menu;
-	GList *l;
-
-	l = g_list_find_custom(menu_list, name, match_menu_name);
-	if (l) {
-		menu = l->data;
-		rl_printf("menu \"%s\" already registered\n", menu->name);
-		return false;
-	}
-
-	menu = g_malloc(sizeof(struct cmd_menu));
-	if (!menu)
-		return false;
-
-	menu->name = name;
-	menu->table = cmd_table;
-	menu_list = g_list_append(menu_list, menu);
-
-	return true;
-}
-
 void set_menu_prompt(const char *name, const char *id)
 {
 	char *prompt;
 
 	prompt = g_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", name,
 					id ? ": Target = " : "", id ? id : "");
-	rl_set_prompt(prompt);
+	bt_shell_set_prompt(prompt);
 	g_free(prompt);
-	rl_on_new_line();
-}
-
-bool switch_cmd_menu(const char *name)
-{
-	GList *l;
-	struct cmd_menu *menu;
-
-	l = g_list_find_custom(menu_list, name, match_menu_name);
-	if(!l)
-		return false;
-
-	menu = l->data;
-	current_cmd_table = (struct menu_entry *) menu->table;
-
-	main_menu_point = rl_point;
-	main_menu_prompt = g_strdup(rl_prompt);
-
-	return true;
-}
-
-void process_menu_cmd(const char *cmd, const char *arg)
-{
-	int i;
-	int len;
-	struct menu_entry *cmd_table = current_cmd_table;
-
-	if (!current_cmd_table)
-		return;
-
-	len = strlen(cmd);
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (strncmp(cmd, cmd_table[i].cmd, len))
-			continue;
-
-		if (cmd_table[i].func) {
-			cmd_table[i].func(arg);
-			return;
-		}
-	}
-
-	if (strncmp(cmd, "help", len)) {
-		rl_printf("Invalid command\n");
-		return;
-	}
-
-	print_cmd_menu(cmd_table);
-}
-
-void print_cmd_menu(const struct menu_entry *cmd_table)
-{
-	int i;
-
-	rl_printf("Available commands:\n");
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (cmd_table[i].desc)
-			rl_printf("  %s %-*s %s\n", cmd_table[i].cmd,
-					(int)(40 - strlen(cmd_table[i].cmd)),
-					cmd_table[i].arg ? : "",
-					cmd_table[i].desc ? : "");
-	}
-
-}
-
-void cmd_menu_cleanup(void)
-{
-	main_cmd_table = NULL;
-	current_cmd_table = NULL;
-
-	g_list_free_full(menu_list, g_free);
 }
 
 void print_byte_array(const char *prefix, const void *ptr, int len)
@@ -214,13 +62,13 @@ void print_byte_array(const char *prefix, const void *ptr, int len)
 		if ((i + 1) % 16) {
 			bytes += 3;
 		} else {
-			rl_printf("\r%s\n", line);
+			bt_shell_printf("\r%s\n", line);
 			bytes = line + strlen(prefix) + 1;
 		}
 	}
 
 	if (i % 16)
-		rl_printf("\r%s\n", line);
+		bt_shell_printf("\r%s\n", line);
 
 	g_free(line);
 }
@@ -272,7 +120,7 @@ uint16_t mesh_opcode_set(uint32_t opcode, uint8_t *buf)
 		put_be16(opcode, buf + 1);
 		return 3;
 	} else {
-		rl_printf("Illegal Opcode %x", opcode);
+		bt_shell_printf("Illegal Opcode %x", opcode);
 		return 0;
 	}
 }
@@ -310,7 +158,7 @@ bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, uint32_t *opcode, int *n)
 		break;
 
 	default:
-		rl_printf("Bad Packet:\n");
+		bt_shell_printf("Bad Packet:\n");
 		print_byte_array("\t", (void *) buf, sz);
 		return false;
 	}
@@ -347,14 +195,15 @@ const char *mesh_status_str(uint8_t status)
 void print_model_pub(uint16_t ele_addr, uint32_t mod_id,
 						struct mesh_publication *pub)
 {
-	rl_printf("\tElement: %4.4x\n", ele_addr);
-	rl_printf("\tPub Addr: %4.4x", pub->u.addr16);
+	bt_shell_printf("\tElement: %4.4x\n", ele_addr);
+	bt_shell_printf("\tPub Addr: %4.4x", pub->u.addr16);
 	if (mod_id > 0xffff0000)
-		rl_printf("\tModel: %8.8x \n", mod_id);
+		bt_shell_printf("\tModel: %8.8x \n", mod_id);
 	else
-		rl_printf("\tModel: %4.4x \n", (uint16_t) (mod_id & 0xffff));
-	rl_printf("\tApp Key Idx: %4.4x", pub->app_idx);
-	rl_printf("\tTTL: %2.2x", pub->ttl);
+		bt_shell_printf("\tModel: %4.4x \n",
+				(uint16_t) (mod_id & 0xffff));
+	bt_shell_printf("\tApp Key Idx: %4.4x", pub->app_idx);
+	bt_shell_printf("\tTTL: %2.2x", pub->ttl);
 }
 
 void swap_u256_bytes(uint8_t *u256)
diff --git a/mesh/util.h b/mesh/util.h
index 7f729ab62..c3facfa73 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -27,21 +27,7 @@ struct mesh_publication;
 
 #define OP_UNRELIABLE			0x0100
 
-struct menu_entry {
-	const char *cmd;
-	const char *arg;
-	void (*func) (const char *arg);
-	const char *desc;
-};
-
-bool cmd_menu_init(const struct menu_entry *cmd_table);
-void cmd_menu_main(bool forced);
-bool add_cmd_menu(const char *name, const struct menu_entry *cmd_table);
-bool switch_cmd_menu(const char *name);
-void set_menu_prompt(const char *prefix, const char * node);
-void process_menu_cmd(const char *cmd, const char *arg);
-void print_cmd_menu(const struct menu_entry *cmd_table);
-void cmd_menu_cleanup(void);
+void set_menu_prompt(const char *name, const char *id);
 void print_byte_array(const char *prefix, const void *ptr, int len);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out_buf,
 		uint16_t out_len);
-- 
2.13.6

