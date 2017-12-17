Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 1/9] mesh: meshctl: Change command names to <cmd>-<get/set>
Date: Sun, 17 Dec 2017 10:52:41 +0000
Message-Id: <20171217105249.7592-2-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Fix lines over 80 chars
Move cmd_default()
Add parameter to pub-set to control retransmit count
---
 mesh/config-client.c | 78 +++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index aad6525c2..3f3495905 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -170,9 +170,9 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 12 && len != 14)
 			return true;
 
-		bt_shell_printf("\nSet publication for node %4.4x status: %s\n", src,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nSet publication for node %4.4x status: %s\n",
+				src, data[0] == MESH_STATUS_SUCCESS ?
+				"Success" : mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
@@ -189,6 +189,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		pub.ttl = data[7];
 		pub.period = data[8];
 		n = (data[8] & 0x3f);
+		bt_shell_printf("Publication address: 0x%04x\n", pub.u.addr16);
 		switch (data[8] >> 6) {
 		case 0:
 			bt_shell_printf("Period: %d ms\n", n * 100);
@@ -206,7 +207,8 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 
 		pub.retransmit = data[9];
 		bt_shell_printf("Retransmit count: %d\n", data[9] >> 5);
-		bt_shell_printf("Retransmit Interval Steps: %d\n", data[9] & 0x1f);
+		bt_shell_printf("Retransmit Interval Steps: %d\n",
+				data[9] & 0x1f);
 
 		ele_idx = ele_addr - node_get_primary(node);
 
@@ -219,6 +221,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 				     node_model_pub_get(node, ele_idx, mod_id));
 		break;
 	}
+
 	return true;
 }
 
@@ -287,6 +290,23 @@ static bool config_send(uint8_t *buf, uint16_t len)
 
 }
 
+static void cmd_default(uint32_t opcode)
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(opcode, msg);
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send command (opcode 0x%x)\n",
+								opcode);
+}
+
 static void cmd_get_composition(int argc, char *argv[])
 {
 	uint16_t n;
@@ -556,7 +576,7 @@ static void cmd_set_pub(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 5) {
+	if (parm_cnt != 6) {
 		bt_shell_printf("Bad arguments\n");
 		return;
 	}
@@ -574,14 +594,14 @@ static void cmd_set_pub(int argc, char *argv[])
 	/* Publish period  step count and step resolution */
 	msg[n++] = parms[3];
 	/* Publish retransmit count & interval steps */
-	msg[n++] = (1 << 5) + 2;
+	msg[n++] = parms[4];
 	/* Model Id */
-	if (parms[4] > 0xffff) {
-		put_le16(parms[4] >> 16, msg + n);
-		put_le16(parms[4], msg + n + 2);
+	if (parms[5] > 0xffff) {
+		put_le16(parms[5] >> 16, msg + n);
+		put_le16(parms[5], msg + n + 2);
 		n += 4;
 	} else {
-		put_le16(parms[4], msg + n);
+		put_le16(parms[5], msg + n);
 		n += 2;
 	}
 
@@ -589,23 +609,6 @@ static void cmd_set_pub(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
-static void cmd_default(uint32_t opcode)
-{
-	uint16_t n;
-	uint8_t msg[32];
-
-	if (IS_UNASSIGNED(target)) {
-		bt_shell_printf("Destination not set\n");
-		return;
-	}
-
-	n = mesh_opcode_set(opcode, msg);
-
-	if (!config_send(msg, n))
-		bt_shell_printf("Failed to send command (opcode 0x%x)\n",
-								opcode);
-}
-
 static void cmd_get_ttl(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
@@ -615,27 +618,28 @@ static const struct bt_shell_menu cfg_menu = {
 	.name = "config",
 	.desc = "Configuration Model Submenu",
 	.entries = {
-	{"target",		"<unicast>",			cmd_set_node,
+	{"target",		"<unicast>",		cmd_set_node,
 						"Set target node to configure"},
-	{"get-composition",	"[<page_num>]",		cmd_get_composition,
+	{"composition-get",	"[<page_num>]",		cmd_get_composition,
 						"Get Composition Data"},
-	{"add-netkey",		"<net_idx>",			cmd_add_net_key,
+	{"netkey-add",		"<net_idx>",		cmd_add_net_key,
 						"Add network key"},
-	{"del-netkey",		"<net_idx>",			cmd_del_net_key,
+	{"netkey-del",		"<net_idx>",		cmd_del_net_key,
 						"Delete network key"},
-	{"add-appkey",		"<app_idx>",			cmd_add_app_key,
+	{"appkey-add",		"<app_idx>",		cmd_add_app_key,
 						"Add application key"},
-	{"del-appkey",		"<app_idx>",			cmd_del_app_key,
+	{"appkey-del",		"<app_idx>",		cmd_del_app_key,
 						"Delete application key"},
 	{"bind",		"<ele_idx> <app_idx> <mod_id> [cid]",
 				cmd_bind,	"Bind app key to a model"},
-	{"set-ttl",		"<ttl>",			cmd_set_ttl,
+	{"ttl-set",		"<ttl>",		cmd_set_ttl,
 						"Set default TTL"},
-	{"get-ttl",		NULL,			cmd_get_ttl,
+	{"ttl-get",		NULL,			cmd_get_ttl,
 						"Get default TTL"},
-	{"set-pub", "<ele_addr> <pub_addr> <app_idx> "
-						"<period (step|res)> <model>",
+	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
+			"<period (step|res)> <re-xmt (count|per)> <model>",
 				cmd_set_pub,	"Set publication"},
+
 	{} },
 };
 
-- 
2.11.0

