Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V3 4/9] mesh: meshctl: Add get app keys
Date: Fri, 15 Dec 2017 06:46:01 +0000
Message-Id: <20171215064606.15051-5-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-1-sbrown@cortland.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

List application keys of model 1000 in element 0100.

[config: Target = 0100]# app-get 0100 1000

Model App Key list for node 0100 length: 7 status: Success
Element Addr:   0100
Model ID:       1000
Model App Key:  0001
---
 mesh/config-client.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 270a8ca36..3d021269c 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -259,6 +259,24 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 					get_le16(data + i));
 		break;
 
+	/* Per Mesh Profile 4.3.2.50 */
+	case OP_MODEL_APP_LIST:
+		bt_shell_printf("\nModel App Key list for node %4.4x "
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
+			bt_shell_printf("Model App Key:\t%4.4x\n",
+					get_le16(data + i));
+		break;
+
 	/* Per Mesh Profile 4.3.2.63 */
 	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
 		bt_shell_printf("\nSet heartbeat for node %4.4x status: %s\n",
@@ -730,6 +748,37 @@ static void cmd_sub_get(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
 }
 
+static void cmd_get_app(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_MODEL_APP_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return;
+	}
+
+	/* Per Mesh Profile 4.3.2.49 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Model ID */
+	put_le16(parms[1], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"GET APP GET\"\n");
+}
+
 static void cmd_set_hb(int argc, char *argv[])
 {
 	uint16_t n;
@@ -821,6 +870,9 @@ static const struct bt_shell_menu cfg_menu = {
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Subscription get"},
 
+	{"app-get", "<ele_addr> <model id>",
+				cmd_get_app,    "Get App Keys"},
+
 	{} },
 };
 
-- 
2.11.0

