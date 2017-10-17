Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 1/2] mesh: Add heartbeat publish command and status display
Date: Tue, 17 Oct 2017 09:58:30 -0400
Message-Id: <20171017135831.31179-2-sbrown@cortland.com>
In-Reply-To: <20171017135831.31179-1-sbrown@cortland.com>
References: <20171017135831.31179-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Also display uninterpreted opcodes
---
 mesh/config-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index d80f784e6..90a5a9399 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -83,6 +83,8 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 
 	switch (opcode & ~OP_UNRELIABLE) {
 	default:
+		rl_printf("Unrecognized opcode: %8.8x\n", opcode);
+		print_byte_array("data: ", data, len);
 		return false;
 
 	case OP_DEV_COMP_STATUS:
@@ -219,6 +221,24 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 			prov_db_node_set_model_pub(node, ele_idx, mod_id,
 				     node_model_pub_get(node, ele_idx, mod_id));
 		break;
+
+	/* Per Mesh Profile 4.3.2.63 */
+	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
+
+		rl_printf("\nSet heartbeat for node %4.4x status: %s\n", src,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		rl_printf("Destination:\t%4.4x\n", get_le16(data + 1));
+		rl_printf("Count:\t\t%2.2x\n", data[3]);
+		rl_printf("Period:\t\t%2.2x\n", data[4]);
+		rl_printf("TTL:\t\t%2.2x\n", data[5]);
+		rl_printf("Features:\t%4.4x\n", get_le16(data + 6));
+		rl_printf("Net_Idx:\t%4.4x\n", get_le16(data + 8));
+		break;
 	}
 	return true;
 }
@@ -570,6 +590,46 @@ static void cmd_set_pub(const char *args)
 		rl_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
+static void cmd_set_hb(const char *args)
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
+	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
+
+	parm_cnt = read_input_parameters(args);
+	if (parm_cnt != 5) {
+		rl_printf("Bad arguments: %s\n", args);
+		return;
+	}
+
+	/* Per Mesh Profile 4.3.2.62 */
+	/* Publish address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Count Log */
+	msg[n++] = parms[1];
+	/* Period Log */
+	msg[n++] = parms[2];
+	/* Heartbeat TTL */
+	msg[n++] = DEFAULT_TTL;
+	/* Features */
+	put_le16(parms[3], msg + n);
+	n += 2;
+	/* NetKey Index */
+	put_le16(parms[4], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n))
+		rl_printf("Failed to send \"SET HEARTBEAT PUBLICATION\"\n");
+}
+
 static void cmd_default(uint32_t opcode)
 {
 	uint16_t n;
@@ -620,6 +680,8 @@ static const struct menu_entry cfg_menu[] = {
 	{"set-pub", "<ele_addr> <pub_addr> <app_idx> "
 						"<period (step|res)> <model>",
 				cmd_set_pub,	"Set publication"},
+	{"set-hb", "<pub_addr> <count> <period> <features> <net_idx>",
+				cmd_set_hb,	"Set heartbeat"},
 	{"back",		NULL,				cmd_back,
 						"Back to main menu"},
 	{"help",		NULL,				cmd_help,
-- 
2.11.0

