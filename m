Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 1/3] mesh: meshctl: Add heartbeat get subscribe and publish
Date: Mon,  5 Feb 2018 16:28:46 -0500
Message-Id: <20180205212848.27856-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[config: Target = 0100]# hb-pub-get

Set heartbeat for node 0100 status: Success
Destination:	c000
Count:		00
Period:		00
TTL:		ff
Features:	0000
Net_Idx:	0000

[config: Target = 0100]# hb-sub-get

Heartbeat subscription status for node 0100 status: Success
Source:		0100
Destination:	0100
Period:		00
Count:		00
Min Hops:	7f
Max Hops:	00
---
 mesh/config-client.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 6c8c7ee87..bf91aa5de 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -1006,6 +1006,11 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLISH\"\n");
 }
 
+static void cmd_hb_pub_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_HEARTBEAT_PUB_GET);
+}
+
 static void cmd_hb_sub_set(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1039,6 +1044,11 @@ static void cmd_hb_sub_set(int argc, char *argv[])
 		bt_shell_printf("Failed to send \"SET HEARTBEAT SUBSCRIBE\"\n");
 }
 
+static void cmd_hb_sub_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_HEARTBEAT_SUB_GET);
+}
+
 static void cmd_get_ttl(int argc, char *argv[])
 {
 	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
@@ -1087,8 +1097,12 @@ static const struct bt_shell_menu cfg_menu = {
 						"Get relay"},
 	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
 				cmd_hb_pub_set,     "Set heartbeat publish"},
+	{"hb-pub-get",           NULL,                   cmd_hb_pub_get,
+						"Get heartbeat publish"},
 	{"hb-sub-set", "<src_addr> <dst_addr> <period>",
 				cmd_hb_sub_set,     "Set heartbeat subscribe"},
+	{"hb-sub-get",           NULL,                   cmd_hb_sub_get,
+						"Get heartbeat subscribe"},
 	{"sub-add", "<ele_addr> <sub_addr> <model id>",
 				cmd_sub_add,    "Subscription add"},
 	{"sub-get", "<ele_addr> <model id>",
-- 
2.14.1

