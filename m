Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V2 6/8] mesh: meshctl: Add set/get proxy command
Date: Tue, 12 Dec 2017 12:58:30 +0000
Message-Id: <20171212125832.13440-7-sbrown@cortland.com>
In-Reply-To: <20171212125832.13440-1-sbrown@cortland.com>
References: <20171212125832.13440-1-sbrown@cortland.com>
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
index acef0363c..cc2bd9eaa 100644
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
@@ -884,6 +920,10 @@ static const struct bt_shell_menu cfg_menu = {
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
 			"<period (step|res)> <re-xmt (count|per)> <model>",
 				cmd_set_pub,	"Set publication"},
+	{"proxy-set",		"<proxy>",		cmd_set_proxy,
+						"Set proxy state"},
+	{"proxy-get",		NULL,			cmd_get_proxy,
+						"Get proxy state"},
 	{"pub-get", "<ele_addr> <model>",		cmd_get_pub,
 						"Get publication"},
 	{"hb-set", "<pub_addr> <count> <period> <features> <net_idx>",
-- 
2.11.0

