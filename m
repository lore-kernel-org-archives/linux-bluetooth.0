Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 5/9] mesh: meshctl: Add get publish
Date: Sun, 17 Dec 2017 10:52:45 +0000
Message-Id: <20171217105249.7592-6-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Get the publish address for model 1001 in element 0100

[config: Target = 0100]# pub-get 0100 1001

Set publication for node 0100 status: Success
Publication address: 0xc000
Period: 0 ms
Retransmit count: 0
Retransmit Interval Steps: 0
---
 mesh/config-client.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 80c7fd80d..92fca5a8b 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -683,6 +683,42 @@ static void cmd_set_pub(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
 }
 
+static void cmd_get_pub(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return;
+	}
+
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Model Id */
+	if (parms[1] > 0xffff) {
+		put_le16(parms[1] >> 16, msg + n);
+		put_le16(parms[1], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[1], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n))
+		bt_shell_printf("Failed to send \"GET MODEL PUBLICATION\"\n");
+}
+
 static void cmd_sub_add(int argc, char *argv[])
 {
 	uint16_t n;
@@ -849,6 +885,8 @@ static const struct bt_shell_menu cfg_menu = {
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
 			"<period (step|res)> <re-xmt (count|per)> <model>",
 				cmd_set_pub,	"Set publication"},
+	{"pub-get", "<ele_addr> <model>",               cmd_get_pub,
+						"Get publication"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_set_hb,     "Set heartbeati publish"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
-- 
2.11.0

