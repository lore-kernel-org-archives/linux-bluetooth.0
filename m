Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V3 2/9] mesh: meshctl: Add add/get subscribe
Date: Fri, 15 Dec 2017 06:45:59 +0000
Message-Id: <20171215064606.15051-3-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-1-sbrown@cortland.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Adds a subscription for group address c000 to
model 1000 in element 0100.

[config: Target = 0100]# sub-add 0100 c000 1000

Subscription changed for node 0100 status: Success
ModelId 1000
Element Addr:   0100
Subscr Addr:    c000

Gets the current subscription list for model 1000
on element 0100.

[config: Target = 0100]# sub-get 0100 1000

Subscription list for node 0100 length: 7 status: Success
Element Addr:   0100
Model ID:       1000
Subscr Addr:    c000
---
 mesh/config-client.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 51adf2c52..aa7414cc3 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -61,6 +61,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	uint8_t ele_idx;
 	struct mesh_publication pub;
 	int n;
+	uint16_t i;
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -220,6 +221,43 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 			prov_db_node_set_model_pub(node, ele_idx, mod_id,
 				     node_model_pub_get(node, ele_idx, mod_id));
 		break;
+
+	/* Per Mesh Profile 4.3.2.19 */
+	case OP_CONFIG_MODEL_SUB_STATUS:
+		bt_shell_printf("\nSubscription changed"
+				" for node %4.4x status: %s\n", src,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Subscr Addr:\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 5));
+		break;
+
+		/* TODO */
+		/* Save subscription info in database */
+
+	/* Per Mesh Profile 4.3.2.27 */
+	case OP_CONFIG_MODEL_SUB_LIST:
+
+		bt_shell_printf("\nSubscription list for node %4.4x "
+				"length: %u status: %s\n", src, len,
+				data[0] == MESH_STATUS_SUCCESS ? "Success" :
+						mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 3));
+
+		for (i = 5; i < len; i += 2)
+			bt_shell_printf("Subscr Addr:\t%4.4x\n",
+					get_le16(data + i));
+		break;
 	}
 
 	return true;
@@ -609,6 +647,71 @@ static void cmd_set_pub(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
+static void cmd_sub_add(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_ADD, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return;
+	}
+
+	/* Per Mesh Profile 4.3.2.19 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Subscription Address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* SIG Model ID */
+	put_le16(parms[2], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
+}
+
+static void cmd_sub_get(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return;
+	}
+
+	/* Per Mesh Profile 4.3.2.27 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Model ID */
+	put_le16(parms[1], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
+}
+
 static void cmd_get_ttl(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
@@ -638,6 +741,10 @@ static const struct bt_shell_menu cfg_menu = {
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
 			"<period (step|res)> <re-xmt (count|per)> <model>",
 				cmd_set_pub,	"Set publication"},
+	{"sub-add", "<ele_addr> <sub_addr> <model id>",
+				cmd_sub_add,    "Subscription add"},
+	{"sub-get", "<ele_addr> <model id>",
+				cmd_sub_get,    "Subscription get"},
 
 	{} },
 };
-- 
2.11.0

