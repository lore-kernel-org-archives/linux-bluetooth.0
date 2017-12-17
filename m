Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 8/9] mesh: meshctl: Add get/set relay
Date: Sun, 17 Dec 2017 10:52:48 +0000
Message-Id: <20171217105249.7592-9-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Sets the relay state in node 0100 to 1

[config: Target = 0100]# relay-set 1 0 0

Node 0100 Relay state: 0x01 count: 0 steps: 0

Fetches the relay state of node 0100

[config: Target = 0100]# relay-get

Node 0100 Relay state: 0x01 count: 0 steps: 0
---
 mesh/config-client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 3d58ece04..3987c981a 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -168,6 +168,14 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 				mesh_status_str(data[0]));
 		break;
 
+	case OP_CONFIG_RELAY_STATUS:
+		if (len != 2)
+			return true;
+		bt_shell_printf("Node %4.4x Relay state: 0x%02x"
+				" count: %d steps: %d\n",
+				src, data[0], data[1]>>5, data[1] & 0x1f);
+		break;
+
 	case OP_CONFIG_PROXY_STATUS:
 		if (len != 1)
 			return true;
@@ -706,6 +714,35 @@ static void cmd_get_proxy(int argc, char *argv[])
 	cmd_default(OP_CONFIG_PROXY_GET);
 }
 
+static void cmd_set_relay(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 2 + 4];
+	int parm_cnt;
+
+	if (!verify_config_target(target))
+		return;
+
+	n = mesh_opcode_set(OP_CONFIG_RELAY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("bad arguments\n");
+		return;
+	}
+
+	msg[n++] = parms[0];
+	msg[n++] = (parms[1] << 5) | parms[2];
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"SET RELAY\"\n");
+}
+
+static void cmd_get_relay(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_RELAY_GET);
+}
+
 static void cmd_set_ttl(int argc, char *argv[])
 {
 	uint16_t n;
@@ -989,6 +1026,11 @@ static const struct bt_shell_menu cfg_menu = {
 						"Set node identity state"},
 	{"ident-get",           "<net_idx>",            cmd_get_ident,
 						"Get node identity state"},
+	{"relay-set",           "<relay> <rexmt count> <rexmt steps>",
+						cmd_set_relay,
+						"Set relay"},
+	{"relay-get",           NULL,                   cmd_get_relay,
+						"Get relay"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_set_hb,     "Set heartbeati publish"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
-- 
2.11.0

