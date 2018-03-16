Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        Atul Rai <a.rai@samsung.com>
Subject: [PATCH] Mesh: add 'node-reset' command
Date: Fri, 16 Mar 2018 13:12:19 +0530
Message-id: <1521186139-12275-1-git-send-email-a.rai@samsung.com>
References: <CGME20180316074231epcas2p40b46daed3307a524f41d8c9994912596@epcas2p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds 'node-reset' command which can be used to reset a
node (other than a Provisioner) and remove it from the network.
---
 mesh/config-client.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 19e617d..7cb8a37 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -342,6 +342,17 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
 		bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
 		break;
+
+	/* Per Mesh Profile 4.3.2.54 */
+	case OP_NODE_RESET_STATUS:
+		bt_shell_printf("Node %4.4x reset status %s\n",
+				src, mesh_status_str(data[0]));
+
+		net_release_address(node_get_primary(node),
+				(node_get_num_elements(node) - 1));
+		/* TODO: Remove node info from database */
+		node_free(node);
+		break;
 	}
 
 	return true;
@@ -1124,6 +1135,11 @@ static void cmd_ttl_get(int argc, char *argv[])
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
 }
 
+static void cmd_node_reset(int argc, char *argv[])
+{
+	cmd_default(OP_NODE_RESET);
+}
+
 static const struct bt_shell_menu cfg_menu = {
 	.name = "config",
 	.desc = "Configuration Model Submenu",
@@ -1179,6 +1195,8 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
+	{"node-reset",		NULL,                   cmd_node_reset,
+                                     "reset a node and remove it from network"},
 	{} },
 };
 
-- 
2.7.4

