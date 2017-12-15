Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V3 6/9] mesh: meshctl: Add set/get proxy
Date: Fri, 15 Dec 2017 06:46:03 +0000
Message-Id: <20171215064606.15051-7-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-1-sbrown@cortland.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
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
 mesh/config-client.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 9872ee11d..2d132dbef 100644
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
-- 
2.11.0

