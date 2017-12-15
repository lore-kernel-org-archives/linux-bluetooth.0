Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V3 8/9] mesh: meshctl: Add get/set relay
Date: Fri, 15 Dec 2017 06:46:05 +0000
Message-Id: <20171215064606.15051-9-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-1-sbrown@cortland.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
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
 mesh/config-client.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index f4012ad02..0118b1853 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -167,6 +167,14 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 				get_le16(data + 1), data[3],
 				mesh_status_str(data[0]));
 
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
@@ -705,6 +713,35 @@ static void cmd_get_proxy(int argc, char *argv[])
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
-- 
2.11.0

