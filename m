Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH V4 9/9] mesh: meshctl: Add Company ID parameter to pub-set and pub-get
Date: Sun, 17 Dec 2017 10:52:49 +0000
Message-Id: <20171217105249.7592-10-sbrown@cortland.com>
In-Reply-To: <20171217105249.7592-1-sbrown@cortland.com>
References: <20171217105249.7592-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

Add a CID parameter to both commands similar to bind.
Correct the prior assumption that a model id > 0xffff
was a vendor model.

pub-set 0100 c000 1 0 0 1000
03 0001 00c0 01 00 ff 00 00 0010

pub-set 0100 c000 1 0 0 1000 1
03 0001 00c0 01 00 ff 00 00 0100 0010
---
 mesh/config-client.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 3987c981a..fc6b3dc5d 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -781,7 +781,7 @@ static void cmd_set_pub(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 6) {
+	if (parm_cnt != 6 && parm_cnt != 7) {
 		bt_shell_printf("Bad arguments\n");
 		return;
 	}
@@ -801,8 +801,8 @@ static void cmd_set_pub(int argc, char *argv[])
 	/* Publish retransmit count & interval steps */
 	msg[n++] = parms[4];
 	/* Model Id */
-	if (parms[5] > 0xffff) {
-		put_le16(parms[5] >> 16, msg + n);
+	if (parm_cnt == 7) {
+		put_le16(parms[6], msg + n);
 		put_le16(parms[5], msg + n + 2);
 		n += 4;
 	} else {
@@ -828,7 +828,7 @@ static void cmd_get_pub(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_GET, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 2) {
+	if (parm_cnt != 2 && parm_cnt != 3) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return;
 	}
@@ -837,8 +837,8 @@ static void cmd_get_pub(int argc, char *argv[])
 	put_le16(parms[0], msg + n);
 	n += 2;
 	/* Model Id */
-	if (parms[1] > 0xffff) {
-		put_le16(parms[1] >> 16, msg + n);
+	if (parm_cnt == 3) {
+		put_le16(parms[2], msg + n);
 		put_le16(parms[1], msg + n + 2);
 		n += 4;
 	} else {
@@ -1014,8 +1014,9 @@ static const struct bt_shell_menu cfg_menu = {
 	{"ttl-get",		NULL,			cmd_get_ttl,
 						"Get default TTL"},
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> "
-			"<period (step|res)> <re-xmt (count|per)> <model>",
-				cmd_set_pub,	"Set publication"},
+			"<per (step|res)> <re-xmt (cnt|per)> <mod id> "
+			"[cid]",
+			cmd_set_pub,	"\n\t\t\t\t\t\t  Set publication"},
 	{"pub-get", "<ele_addr> <model>",               cmd_get_pub,
 						"Get publication"},
 	{"proxy-set",           "<proxy>",              cmd_set_proxy,
-- 
2.11.0

