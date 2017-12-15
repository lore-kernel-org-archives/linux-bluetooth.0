Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V3 5/9] mesh: meshctl: Add get publish
Date: Fri, 15 Dec 2017 06:46:02 +0000
Message-Id: <20171215064606.15051-6-sbrown@cortland.com>
In-Reply-To: <20171215064606.15051-1-sbrown@cortland.com>
References: <20171215064606.15051-1-sbrown@cortland.com>
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
 mesh/config-client.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 3d021269c..9872ee11d 100644
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
-- 
2.11.0

