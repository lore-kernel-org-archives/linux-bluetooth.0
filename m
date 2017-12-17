Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 6/9] mesh: meshctl: Add set/get proxy
Date: Sun, 17 Dec 2017 10:52:46 +0000
Message-Id: <20171217105249.7592-7-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Set the current proxy state of node 0100
Setting the proxy state to 0 will disconnect
the GATT proxy connection.

[config: Target = 0100]# proxy-set 1

Node 0100 Proxy state: 0x01

Get the current proxy state of element 0100

[config: Target = 0100]# proxy-get

Node 0100 Proxy state: 0x01
---
 mesh/config-client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 92fca5a8b..38fbd68a2 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -159,6 +159,13 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 			prov_db_add_binding(node, addr - src, mod_id, app_idx);
 		break;
 
+	case OP_CONFIG_PROXY_STATUS:
+		if (len != 1)
+			return true;
+		bt_shell_printf("Node %4.4x Proxy state: 0x%02x\n",
+				src, data[0]);
+		break;
+
 	case OP_CONFIG_DEFAULT_TTL_STATUS:
 		if (len != 1)
 			return true;
@@ -612,6 +619,35 @@ static void cmd_bind(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
 }
 
+static void cmd_set_proxy(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 1 + 4];
+	int parm_cnt;
+
+	if (!verify_config_target(target))
+		return;
+
+	n = mesh_opcode_set(OP_CONFIG_PROXY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments");
+		return;
+	}
+
+	msg[n++] = parms[0];
+	msg[n++] = parms[1];
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"SET PROXY\"\n");
+}
+
+static void cmd_get_proxy(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_PROXY_GET);
+}
+
 static void cmd_set_ttl(int argc, char *argv[])
 {
 	uint16_t n;
@@ -887,6 +923,10 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_set_pub,	"Set publication"},
 	{"pub-get", "<ele_addr> <model>",               cmd_get_pub,
 						"Get publication"},
+	{"proxy-set",           "<proxy>",              cmd_set_proxy,
+						"Set proxy state"},
+	{"proxy-get",           NULL,                   cmd_get_proxy,
+						"Get proxy state"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_set_hb,     "Set heartbeati publish"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
-- 
2.11.0

