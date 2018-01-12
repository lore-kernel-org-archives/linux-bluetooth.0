Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: sbrown@cortland.com
Subject: [PATCH] mesh: meshctl: Add set heartbeat subscription command
Date: Fri, 12 Jan 2018 09:52:24 -0500
Message-Id: <20180112145224.26587-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

[config: Target = 0100]# hb-sub-set 0077 0100 2

Heartbeat subscription status for node 0100 status: Success
Source:		0077
Destination:	0100
Period:		01
Count:		00
Min Hops:	7f
Max Hops:	00
---
 mesh/config-client.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index f280441cc..e6a2e6e93 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -318,6 +318,25 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		bt_shell_printf("Features:\t%4.4x\n", get_le16(data + 6));
 		bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data + 8));
 		break;
+
+	/* Per Mesh Profile 4.3.2.66 */
+	case OP_CONFIG_HEARTBEAT_SUB_STATUS:
+		bt_shell_printf("\nHeartbeat subscription status for "
+				"node %4.4x status: %s\n",
+				src,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Source:\t\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Destination:\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Period:\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Count:\t\t%2.2x\n", data[6]);
+		bt_shell_printf("Min Hops:\t%2.2x\n", data[7]);
+		bt_shell_printf("Max Hops:\t%2.2x\n", data[8]);
+		break;
 	}
 
 	return true;
@@ -946,7 +965,7 @@ static void cmd_get_app(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"GET APP GET\"\n");
 }
 
-static void cmd_set_hb(int argc, char *argv[])
+static void cmd_hb_pub_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -983,7 +1002,40 @@ static void cmd_set_hb(int argc, char *argv[])
 	n += 2;
 
 	if (!config_send(msg, n))
-		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLICATION\"\n");
+		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLISH\"\n");
+}
+
+static void cmd_hb_sub_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return;
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_SUB_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return;
+	}
+
+	/* Per Mesh Profile 4.3.2.65 */
+	/* Source address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Destination address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* Period log */
+	msg[n++] = parms[2];
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"SET HEARTBEAT SUBSCRIBE\"\n");
 }
 
 static void cmd_get_ttl(int argc, char *argv[])
@@ -1033,7 +1085,9 @@ static const struct bt_shell_menu cfg_menu = {
 	{"relay-get",           NULL,                   cmd_get_relay,
 						"Get relay"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
-				cmd_set_hb,     "Set heartbeati publish"},
+				cmd_hb_pub_set,     "Set heartbeat publish"},
+	{"hb-sub-set", "<src_addr> <dst_addr> <period>",
+				cmd_hb_sub_set,     "Set heartbeat subscribe"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
 				cmd_sub_add,    "Subscription add"},
 	{"sub-get", "<ele_addr> <model id>",
-- 
2.14.1

