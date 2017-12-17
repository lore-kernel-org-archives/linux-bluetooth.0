Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 7/9] mesh: meshctl: Add get/set identity
Date: Sun, 17 Dec 2017 10:52:47 +0000
Message-Id: <20171217105249.7592-8-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Setting identity will cause connectable identity
beacons to be transmitted. The connect command
has an option to connect in this mode.

Sets the identity state to 1 in node 0100 on network
0000.

[config: Target = 0100]# ident-set 0 1
Network index 0x0000 has Node Identity state 0x01 Success

Fetched the identity state from node 0100

[config: Target = 0100]# ident-get 0
Network index 0x0000 has Node Identity state 0x01 Success
---
 mesh/config-client.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 38fbd68a2..3d58ece04 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -159,6 +159,15 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 			prov_db_add_binding(node, addr - src, mod_id, app_idx);
 		break;
 
+	case OP_NODE_IDENTITY_STATUS:
+		if (len != 4)
+			return true;
+		bt_shell_printf("Network index 0x%04x has "
+				"Node Identity state 0x%02x %s\n",
+				get_le16(data + 1), data[3],
+				mesh_status_str(data[0]));
+		break;
+
 	case OP_CONFIG_PROXY_STATUS:
 		if (len != 1)
 			return true;
@@ -619,6 +628,55 @@ static void cmd_bind(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
 }
 
+static void cmd_set_ident(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 3 + 4];
+	int parm_cnt;
+
+	if (!verify_config_target(target))
+		return;
+
+	n = mesh_opcode_set(OP_NODE_IDENTITY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("bad arguments\n");
+		return;
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+	msg[n++] = parms[1];
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"SET IDENTITY\"\n");
+}
+
+static void cmd_get_ident(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 2 + 4];
+	int parm_cnt;
+
+	if (!verify_config_target(target))
+		return;
+
+	n = mesh_opcode_set(OP_NODE_IDENTITY_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments\n");
+		return;
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"GET IDENTITY\"\n");
+}
+
 static void cmd_set_proxy(int argc, char *argv[])
 {
 	uint16_t n;
@@ -927,6 +985,10 @@ static const struct bt_shell_menu cfg_menu = {
 						"Set proxy state"},
 	{"proxy-get",           NULL,                   cmd_get_proxy,
 						"Get proxy state"},
+	{"ident-set",           "<net_idx> <state>",    cmd_set_ident,
+						"Set node identity state"},
+	{"ident-get",           "<net_idx>",            cmd_get_ident,
+						"Get node identity state"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_set_hb,     "Set heartbeati publish"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
-- 
2.11.0

