Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
Subject: [PATCH BlueZ V2] Mesh: Fix TTL in Config Heartbeat Publication Set
Date: Thu, 22 Mar 2018 11:44:42 +0100
Message-Id: <20180322104442.27650-1-robert.lubas@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In Mesh Profile spec 4.2.17.4 Heartbeat Publication TTL value range is
0x00-0x7F. In cmd_hb_pub_set heartbeat ttl was set to DEFAULT_TTL 0xFF, this
patch fix this by adding ttl param to hb-pub-set.
---
 mesh/config-client.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 19e617d62..0b5b8677b 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -1042,7 +1042,7 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 5) {
+	if (parm_cnt != 6) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -1056,12 +1056,12 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 	/* Period Log */
 	msg[n++] = parms[2];
 	/* Heartbeat TTL */
-	msg[n++] = DEFAULT_TTL;
+	msg[n++] = parms[3];
 	/* Features */
-	put_le16(parms[3], msg + n);
+	put_le16(parms[4], msg + n);
 	n += 2;
 	/* NetKey Index */
-	put_le16(parms[4], msg + n);
+	put_le16(parms[5], msg + n);
 	n += 2;
 
 	if (!config_send(msg, n)) {
@@ -1167,8 +1167,8 @@ static const struct bt_shell_menu cfg_menu = {
 						"Set relay"},
 	{"relay-get",           NULL,                   cmd_relay_get,
 						"Get relay"},
-	{"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
-				cmd_hb_pub_set,     "Set heartbeat publish"},
+	{"hb-pub-set", "<pub_addr> <count> <period> <ttl> <features> <net_idx>",
+				cmd_hb_pub_set,	"Set heartbeat publish"},
 	{"hb-pub-get",           NULL,                   cmd_hb_pub_get,
 						"Get heartbeat publish"},
 	{"hb-sub-set", "<src_addr> <dst_addr> <period>",
-- 
2.11.0

