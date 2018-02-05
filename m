Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 3/3] mesh: meshctl: Cleanup status messaging
Date: Mon,  5 Feb 2018 16:28:48 -0500
Message-Id: <20180205212848.27856-3-sbrown@cortland.com>
In-Reply-To: <20180205212848.27856-1-sbrown@cortland.com>
References: <20180205212848.27856-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove redundant status tests
  mesh_status_str() also decodes MESH_STATUS_SUCCESS
Regularize text in status messages
Add helper function to print model id
---
 mesh/config-client.c | 165 +++++++++++++++++++++++++--------------------------
 1 file changed, 82 insertions(+), 83 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index a0c8fa494..6b2132657 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -49,6 +49,23 @@
 
 #define MIN_COMPOSITION_LEN 16
 
+static uint32_t print_mod_id(uint8_t *data, bool vid)
+{
+	uint32_t mod_id;
+
+	if (!vid) {
+		mod_id = get_le16(data);
+		bt_shell_printf("Model Id\t%4.4x\n", mod_id);
+		mod_id = 0xffff0000 | mod_id;
+	} else {
+		mod_id = get_le16(data + 2);
+		bt_shell_printf("Model Id\t%4.4x %4.4x\n",
+				get_le16(data), mod_id);
+		mod_id = get_le16(data) << 16 | mod_id;
+	}
+	return mod_id;
+}
+
 static bool client_msg_recvd(uint16_t src, uint8_t *data,
 				uint16_t len, void *user_data)
 {
@@ -101,12 +118,13 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 4)
 			break;
 
-		bt_shell_printf("Node %4.4x AppKey Status %s\n", src,
+		bt_shell_printf("Node %4.4x AppKey status %s\n", src,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 		app_idx = get_le16(data + 2) >> 4;
 
-		bt_shell_printf("\tNetKey %3.3x, AppKey %3.3x\n", net_idx, app_idx);
+		bt_shell_printf("NetKey\t%3.3x\n", net_idx);
+		bt_shell_printf("AppKey\t%3.3x\n", app_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS &&
 				data[0] != MESH_STATUS_IDX_ALREADY_STORED &&
@@ -119,7 +137,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 3)
 			break;
 
-		bt_shell_printf("Node %4.4x NetKey Status %s\n", src,
+		bt_shell_printf("Node %4.4x NetKey status %s\n", src,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 
@@ -136,23 +154,16 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 7 && len != 9)
 			break;
 
-		bt_shell_printf("Node %4.4x Model App Status %s\n", src,
+		bt_shell_printf("Node %4.4x Model App status %s\n", src,
 						mesh_status_str(data[0]));
 		addr = get_le16(data + 1);
 		app_idx = get_le16(data + 3);
 
-		bt_shell_printf("\tElement %4.4x AppIdx %3.3x\n ", addr, app_idx);
-
-		if (len == 7) {
-			mod_id = get_le16(data + 5);
-			bt_shell_printf("ModelId %4.4x\n", mod_id);
-			mod_id = 0xffff0000 | mod_id;
-		} else {
-			mod_id = get_le16(data + 7);
-			bt_shell_printf("ModelId %4.4x %4.4x\n", get_le16(data + 5),
-									mod_id);
-			mod_id = get_le16(data + 5) << 16 | mod_id;
-		}
+		bt_shell_printf("Element Addr\t%4.4x\n", addr);
+
+		mod_id = print_mod_id(data + 5, (len == 9) ? true : false);
+
+		bt_shell_printf("AppIdx\t\t%3.3x\n ", app_idx);
 
 		if (data[0] == MESH_STATUS_SUCCESS &&
 			node_add_binding(node, addr - src, mod_id, app_idx))
@@ -162,8 +173,8 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	case OP_NODE_IDENTITY_STATUS:
 		if (len != 4)
 			return true;
-		bt_shell_printf("Network index 0x%04x has "
-				"Node Identity state 0x%02x %s\n",
+		bt_shell_printf("Network index 0x%04x "
+				"Node Identity state 0x%02x status %s\n",
 				get_le16(data + 1), data[3],
 				mesh_status_str(data[0]));
 		break;
@@ -171,15 +182,15 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	case OP_CONFIG_RELAY_STATUS:
 		if (len != 2)
 			return true;
-		bt_shell_printf("Node %4.4x Relay state: 0x%02x"
-				" count: %d steps: %d\n",
+		bt_shell_printf("Node %4.4x Relay state 0x%02x"
+				" count %d steps %d\n",
 				src, data[0], data[1]>>5, data[1] & 0x1f);
 		break;
 
 	case OP_CONFIG_PROXY_STATUS:
 		if (len != 1)
 			return true;
-		bt_shell_printf("Node %4.4x Proxy state: 0x%02x\n",
+		bt_shell_printf("Node %4.4x Proxy state 0x%02x\n",
 				src, data[0]);
 		break;
 
@@ -195,45 +206,42 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (len != 12 && len != 14)
 			return true;
 
-		bt_shell_printf("\nSet publication for node %4.4x status: %s\n",
-				src, data[0] == MESH_STATUS_SUCCESS ?
-				"Success" : mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Publication status %s\n",
+				src, mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
 		ele_addr = get_le16(data + 1);
-		mod_id = get_le16(data + 10);
-		if (len == 14)
-			mod_id = (mod_id << 16)  | get_le16(data + 12);
-		else
-			mod_id |= 0xffff0000;
+
+		bt_shell_printf("Element Addr\t%04x\n", ele_addr);
+
+		mod_id = print_mod_id(data + 10, (len == 14) ? true : false);
 
 		pub.u.addr16 = get_le16(data + 3);
 		pub.app_idx = get_le16(data + 5);
 		pub.ttl = data[7];
 		pub.period = data[8];
 		n = (data[8] & 0x3f);
-		bt_shell_printf("Publication address: 0x%04x\n", pub.u.addr16);
+		bt_shell_printf("Pub Addr\t%04x\n", pub.u.addr16);
 		switch (data[8] >> 6) {
 		case 0:
-			bt_shell_printf("Period: %d ms\n", n * 100);
+			bt_shell_printf("Period\t\t%d ms\n", n * 100);
 			break;
 		case 2:
 			n *= 10;
 			/* fall through */
 		case 1:
-			bt_shell_printf("Period: %d sec\n", n);
+			bt_shell_printf("Period\t\t%d sec\n", n);
 			break;
 		case 3:
-			bt_shell_printf("Period: %d min\n", n * 10);
+			bt_shell_printf("Period\t\t%d min\n", n * 10);
 			break;
 		}
 
 		pub.retransmit = data[9];
-		bt_shell_printf("Retransmit count: %d\n", data[9] >> 5);
-		bt_shell_printf("Retransmit Interval Steps: %d\n",
-				data[9] & 0x1f);
+		bt_shell_printf("Rexmit count\t%d\n", data[9] >> 5);
+		bt_shell_printf("Rexmit steps\t%d\n", data[9] & 0x1f);
 
 		ele_idx = ele_addr - node_get_primary(node);
 
@@ -248,17 +256,17 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.19 */
 	case OP_CONFIG_MODEL_SUB_STATUS:
-		bt_shell_printf("\nSubscription changed"
-				" for node %4.4x status: %s\n", src,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Subscription status %s\n",
+				src, mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Subscr Addr:\t%4.4x\n", get_le16(data + 3));
-		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 5));
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+
+		mod_id = print_mod_id(data + 5, (len == 9) ? true : false);
+
+		bt_shell_printf("Subscr Addr\t%4.4x\n", get_le16(data + 3));
 		break;
 
 		/* TODO */
@@ -267,76 +275,67 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	/* Per Mesh Profile 4.3.2.27 */
 	case OP_CONFIG_MODEL_SUB_LIST:
 
-		bt_shell_printf("\nSubscription list for node %4.4x "
-				"length: %u status: %s\n", src, len,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Subscription List status %s\n",
+				src, mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
 
 		for (i = 5; i < len; i += 2)
-			bt_shell_printf("Subscr Addr:\t%4.4x\n",
+			bt_shell_printf("Subscr Addr\t%4.4x\n",
 					get_le16(data + i));
 		break;
 
 	/* Per Mesh Profile 4.3.2.50 */
 	case OP_MODEL_APP_LIST:
-		bt_shell_printf("\nModel App Key list for node %4.4x "
-				"length: %u status: %s\n", src, len,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Model AppIdx "
+				"status %s\n", src,
+				mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
 
 		for (i = 5; i < len; i += 2)
-			bt_shell_printf("Model App Key:\t%4.4x\n",
+			bt_shell_printf("Model AppIdx\t%4.4x\n",
 					get_le16(data + i));
 		break;
 
 	/* Per Mesh Profile 4.3.2.63 */
 	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
-		bt_shell_printf("\nHeartbeat publication status for "
-				"node %4.4x status: %s\n",
-				src,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Heartbeat publish status %s\n",
+				src, mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Destination:\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Count:\t\t%2.2x\n", data[3]);
-		bt_shell_printf("Period:\t\t%2.2x\n", data[4]);
-		bt_shell_printf("TTL:\t\t%2.2x\n", data[5]);
-		bt_shell_printf("Features:\t%4.4x\n", get_le16(data + 6));
-		bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data + 8));
+		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Count\t\t%2.2x\n", data[3]);
+		bt_shell_printf("Period\t\t%2.2x\n", data[4]);
+		bt_shell_printf("TTL\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Features\t%4.4x\n", get_le16(data + 6));
+		bt_shell_printf("Net_Idx\t%4.4x\n", get_le16(data + 8));
 		break;
 
 	/* Per Mesh Profile 4.3.2.66 */
 	case OP_CONFIG_HEARTBEAT_SUB_STATUS:
-		bt_shell_printf("\nHeartbeat subscription status for "
-				"node %4.4x status: %s\n",
-				src,
-				data[0] == MESH_STATUS_SUCCESS ? "Success" :
-						mesh_status_str(data[0]));
+		bt_shell_printf("\nNode %4.4x Heartbeat subscribe status %s\n",
+				src, mesh_status_str(data[0]));
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Source:\t\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Destination:\t%4.4x\n", get_le16(data + 3));
-		bt_shell_printf("Period:\t\t%2.2x\n", data[5]);
-		bt_shell_printf("Count:\t\t%2.2x\n", data[6]);
-		bt_shell_printf("Min Hops:\t%2.2x\n", data[7]);
-		bt_shell_printf("Max Hops:\t%2.2x\n", data[8]);
+		bt_shell_printf("Source\t\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Period\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Count\t\t%2.2x\n", data[6]);
+		bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
+		bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
 		break;
 	}
 
@@ -482,7 +481,7 @@ static void cmd_net_key(int argc, char *argv[], uint32_t opcode)
 
 		key = keys_net_key_get(net_idx, true);
 		if (!key) {
-			bt_shell_printf("Network key with index %4.4x not found\n",
+			bt_shell_printf("NetKey with index %4.4x not found\n",
 								net_idx);
 			return;
 		}
@@ -552,7 +551,7 @@ static void cmd_app_key(int argc, char *argv[], uint32_t opcode)
 	app_idx = parms[0];
 	net_idx = keys_app_key_get_bound(app_idx);
 	if (net_idx == NET_IDX_INVALID) {
-		bt_shell_printf("App key with index %4.4x not found\n", app_idx);
+		bt_shell_printf("AppKey with index %4.4x not found\n", app_idx);
 		return;
 	}
 
@@ -564,7 +563,7 @@ static void cmd_app_key(int argc, char *argv[], uint32_t opcode)
 	if (opcode != OP_APPKEY_DELETE) {
 		key = keys_app_key_get(app_idx, true);
 		if (!key) {
-			bt_shell_printf("App key %4.4x not found\n", net_idx);
+			bt_shell_printf("AppKey %4.4x not found\n", net_idx);
 			return;
 		}
 
@@ -811,7 +810,7 @@ static void cmd_pub_set(int argc, char *argv[])
 	/* Publish address */
 	put_le16(parms[1], msg + n);
 	n += 2;
-	/* App key index + credential (set to 0) */
+	/* AppKey index + credential (set to 0) */
 	put_le16(parms[2], msg + n);
 	n += 2;
 	/* TTL */
-- 
2.14.1

