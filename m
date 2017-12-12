Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V2 3/8] mesh: meshctl: Add set heartbeat command
Date: Tue, 12 Dec 2017 12:58:27 +0000
Message-Id: <20171212125832.13440-4-sbrown@cortland.com>
In-Reply-To: <20171212125832.13440-1-sbrown@cortland.com>
References: <20171212125832.13440-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Sets heartbeat for node 0100

[config: Target = 0100]# hb-set 0100 0 0 0 0

Set heartbeat for node 0100 status: Success
Destination:    0100
Count:          00
Period:         00
TTL:            ff
Features:       0000
Net_Idx:        0000
---
 mesh/config-client.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/net.c           | 20 +++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index aa7414cc3..18831dd4f 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -258,6 +258,24 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 			bt_shell_printf("Subscr Addr:\t%4.4x\n",
 					get_le16(data + i));
 		break;
+
+	/* Per Mesh Profile 4.3.2.63 */
+	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
+		bt_shell_printf("\nSet heartbeat for node %4.4x status: %s\n",
+				src,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Destination:\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Count:\t\t%2.2x\n", data[3]);
+		bt_shell_printf("Period:\t\t%2.2x\n", data[4]);
+		bt_shell_printf("TTL:\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Features:\t%4.4x\n", get_le16(data + 6));
+		bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data + 8));
+		break;
 	}
 
 	return true;
@@ -712,6 +730,46 @@ static void cmd_sub_get(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
 }
 
+static void cmd_set_hb(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 5) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
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
+		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLICATION\"\n");
+}
+
 static void cmd_get_ttl(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
@@ -741,6 +799,8 @@ static const struct bt_shell_menu cfg_menu = {
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
 			"<period (step|res)> <re-xmt (count|per)> <model>",
 				cmd_set_pub,	"Set publication"},
+	{"hb-set", "<pub_addr> <count> <period> <features> <net_idx>",
+				cmd_set_hb,     "Set heartbeat"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
 				cmd_sub_add,    "Subscription add"},
 	{"sub-get", "<ele_addr> <model id>",
diff --git a/mesh/net.c b/mesh/net.c
index 421dc6955..20dfcb8a8 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1399,6 +1399,24 @@ static bool ctl_rxed(uint16_t net_idx, uint32_t iv_index,
 		uint8_t *trans, uint16_t len)
 {
 	/* TODO: Handle control messages */
+
+	/* Per Mesh Profile 3.6.5.10 */
+	if (trans[0] == NET_OP_HEARTBEAT) {
+		uint16_t feat = get_be16(trans + 2);
+
+		bt_shell_printf("HEARTBEAT src: %4.4x dst: %4.4x \
+				TTL: %2.2x feat: %s%s%s%s\n",
+				src, dst, trans[1],
+				(feat & MESH_FEATURE_RELAY) ? "relay " : "",
+				(feat & MESH_FEATURE_PROXY) ? "proxy " : "",
+				(feat & MESH_FEATURE_FRIEND) ? "friend " : "",
+				(feat & MESH_FEATURE_LPN) ? "lpn" : "");
+		return true;
+	}
+
+	bt_shell_printf("unrecognized control message src:%4.4x dst:%4.4x len:%d\n",
+			src, dst, len);
+	print_byte_array("msg: ", trans, len);
 	return false;
 }
 
@@ -2098,7 +2116,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
 	if (!result)
 		return false;
 
-	segN = SEG_MAX(len + sizeof(uint32_t));
+	segN = SEG_MAX(len + sizeof(mic32));
 
 	/* Only one ACK required SAR message per destination at a time */
 	if (segN && IS_UNICAST(dst)) {
-- 
2.11.0

