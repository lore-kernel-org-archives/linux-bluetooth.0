Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35B1C35E04
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480221744
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgBYSoW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:44:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:29706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbgBYSoV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 13:44:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 10:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="231546540"
Received: from ingas-nuc1.sea.intel.com ([10.254.39.252])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2020 10:44:19 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 1/6] tools/mesh-cfgclient: Add support for virtual labels
Date:   Tue, 25 Feb 2020 10:44:13 -0800
Message-Id: <20200225184418.12660-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225184418.12660-1-inga.stotland@intel.com>
References: <20200225184418.12660-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds commands to generate and use virtual addresses for
configuring remote node's publication and subscription.

New commands:
virt-add - generate a new label and calculate virtual address
group-list - displays group addresses that are in use and available
             virtual labels with corresponding virtual addresses
---
 Makefile.tools      |   3 +-
 tools/mesh/cfgcli.c | 203 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 188 insertions(+), 18 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 006554cf7..f43764adc 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -336,7 +336,8 @@ tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
 				tools/mesh/agent.h tools/mesh/agent.c \
 				tools/mesh/mesh-db.h tools/mesh/mesh-db.c \
 				mesh/util.h mesh/util.c \
-				mesh/mesh-config.h mesh/mesh-config-json.c
+				mesh/mesh-config.h mesh/mesh-config-json.c \
+				mesh/crypto.h mesh/crypto.c
 
 tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
 						$(ell_ldadd) -ljson-c -lreadline
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index cfa573de3..cd8fd425b 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -31,6 +31,8 @@
 #include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
+#include "mesh/util.h"
+#include "mesh/crypto.h"
 
 #include "tools/mesh/util.h"
 #include "tools/mesh/model.h"
@@ -58,7 +60,13 @@ struct pending_req {
 	uint16_t addr;
 };
 
+struct mesh_group {
+	uint16_t addr;
+	uint8_t label[16];
+};
+
 static struct l_queue *requests;
+static struct l_queue *groups;
 
 static void *send_data;
 static model_send_msg_func_t send_msg;
@@ -764,6 +772,53 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	return i;
 }
 
+static bool match_group_addr(const void *a, const void *b)
+{
+	const struct mesh_group *grp = a;
+	uint16_t addr = L_PTR_TO_UINT(b);
+
+	return grp->addr == addr;
+}
+
+static int compare_group_addr(const void *a, const void *b, void *user_data)
+{
+	const struct mesh_group *grp0 = a;
+	const struct mesh_group *grp1 = b;
+
+	if (grp0->addr < grp1->addr)
+		return -1;
+
+	if (grp0->addr > grp1->addr)
+		return 1;
+
+	return 0;
+}
+
+static void print_virtual_not_found(uint16_t addr)
+{
+	bt_shell_printf("Virtual group with hash %4.4x not found\n", addr);
+	bt_shell_printf("To see available, use \"group-list\"\n");
+	bt_shell_printf("To create new, use \"virt-add\"\n");
+}
+
+static struct mesh_group *add_group(uint16_t addr)
+{
+	struct mesh_group *grp;
+
+	if (!IS_GROUP(addr))
+		return NULL;
+
+	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(addr));
+	if (grp)
+		return grp;
+
+	grp = l_new(struct mesh_group, 1);
+	grp->addr = addr;
+	l_queue_insert(groups, grp, compare_group_addr, NULL);
+
+	return grp;
+}
+
 static void cmd_timeout_set(int argc, char *argv[])
 {
 	if (read_input_parameters(argc, argv) != 1)
@@ -1196,22 +1251,47 @@ static void cmd_ttl_set(int argc, char *argv[])
 static void cmd_pub_set(int argc, char *argv[])
 {
 	uint16_t n;
-	uint8_t msg[32];
+	uint8_t msg[48];
 	int parm_cnt;
-
-	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
+	struct mesh_group *grp;
+	uint32_t opcode;
+	uint16_t pub_addr;
 
 	parm_cnt = read_input_parameters(argc, argv);
+
 	if (parm_cnt != 6 && parm_cnt != 7) {
 		bt_shell_printf("Bad arguments\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	pub_addr = parms[1];
+
+	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(pub_addr));
+	if (!grp)
+		grp = add_group(pub_addr);
+
+	if (!grp && IS_VIRTUAL(pub_addr)) {
+		print_virtual_not_found(pub_addr);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	opcode = (!IS_VIRTUAL(pub_addr)) ? OP_CONFIG_MODEL_PUB_SET :
+						OP_CONFIG_MODEL_PUB_VIRT_SET;
+
+	n = mesh_opcode_set(opcode, msg);
+
 	put_le16(parms[0], msg + n);
 	n += 2;
+
 	/* Publish address */
-	put_le16(parms[1], msg + n);
-	n += 2;
+	if (!IS_VIRTUAL(pub_addr)) {
+		put_le16(pub_addr, msg + n);
+		n += 2;
+	} else {
+		memcpy(msg + n, grp->label, 16);
+		n += 16;
+	}
+
 	/* AppKey index + credential (set to 0) */
 	put_le16(parms[2], msg + n);
 	n += 2;
@@ -1225,10 +1305,10 @@ static void cmd_pub_set(int argc, char *argv[])
 	/* Model Id */
 	n += put_model_id(msg + n, &parms[5], parm_cnt == 7);
 
-	if (!config_send(msg, n, OP_CONFIG_MODEL_PUB_SET))
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_pub_get(int argc, char *argv[])
@@ -1263,8 +1343,8 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 	uint16_t n;
 	uint8_t msg[32];
 	int parm_cnt;
-
-	n = mesh_opcode_set(opcode, msg);
+	struct mesh_group *grp;
+	uint16_t sub_addr;
 
 	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt != 3 && parm_cnt != 4) {
@@ -1272,12 +1352,42 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	sub_addr = parms[1];
+
+	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(sub_addr));
+
+	if (!grp && opcode != OP_CONFIG_MODEL_SUB_DELETE) {
+		grp = add_group(sub_addr);
+
+		if (!grp && IS_VIRTUAL(sub_addr)) {
+			print_virtual_not_found(sub_addr);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (IS_VIRTUAL(sub_addr)) {
+		if (opcode == OP_CONFIG_MODEL_SUB_ADD)
+			opcode = OP_CONFIG_MODEL_SUB_VIRT_ADD;
+		else if (opcode == OP_CONFIG_MODEL_SUB_DELETE)
+			opcode = OP_CONFIG_MODEL_SUB_VIRT_DELETE;
+		else if (opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
+			opcode = OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE;
+	}
+
+	n = mesh_opcode_set(opcode, msg);
+
 	/* Element Address */
 	put_le16(parms[0], msg + n);
 	n += 2;
+
 	/* Subscription Address */
-	put_le16(parms[1], msg + n);
-	n += 2;
+	if (!IS_VIRTUAL(sub_addr)) {
+		put_le16(sub_addr, msg + n);
+		n += 2;
+	} else {
+		memcpy(msg + n, grp->label, 16);
+		n += 16;
+	}
 
 	/* Model ID */
 	n += put_model_id(msg + n, &parms[2], parm_cnt == 4);
@@ -1399,6 +1509,9 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 
 	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
 
+	if (!l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(parms[1])))
+		add_group(parms[1]);
+
 	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt != 6) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
@@ -1447,6 +1560,9 @@ static void cmd_hb_sub_set(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(parms[1])))
+		add_group(parms[1]);
+
 	/* Per Mesh Profile 4.3.2.65 */
 	/* Source address */
 	put_le16(parms[0], msg + n);
@@ -1537,6 +1653,54 @@ static void cmd_netkey_get(int argc, char *argv[])
 	cmd_default(OP_NETKEY_GET);
 }
 
+static void print_group(void *a, void *b)
+{
+	struct mesh_group *grp = a;
+	char buf[33];
+
+	if (!IS_VIRTUAL(grp->addr)) {
+		bt_shell_printf("\tGroup addr: %4.4x\n", grp->addr);
+		return;
+	}
+
+	hex2str(grp->label, 16, buf, sizeof(buf));
+	bt_shell_printf("\tVirtual addr: %4.4x, label: %s\n", grp->addr, buf);
+}
+
+static void cmd_add_virt(int argc, char *argv[])
+{
+	struct mesh_group *grp, *tmp;
+	uint8_t max_tries = 3;
+
+	grp = l_new(struct mesh_group, 1);
+
+retry:
+	l_getrandom(grp->label, 16);
+	mesh_crypto_virtual_addr(grp->label, &grp->addr);
+
+	/* For simplicity sake, avoid labels that map to the same hash */
+	tmp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(grp->addr));
+	if (!tmp) {
+		l_queue_insert(groups, grp, compare_group_addr, NULL);
+		print_group(grp, NULL);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	max_tries--;
+	if (max_tries)
+		goto retry;
+
+	l_free(grp);
+	bt_shell_printf("Failed to generate unique label. Try again.");
+	bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_list_groups(int argc, char *argv[])
+{
+	l_queue_foreach(groups, print_group, NULL);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
 {
 	if (!send_func)
@@ -1625,12 +1789,15 @@ static const struct bt_shell_menu cfg_menu = {
 				"Set heartbeat subscribe"},
 	{"hb-sub-get", NULL, cmd_hb_sub_get,
 				"Get heartbeat subscribe"},
-	{"sub-add", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_add,
-				"Add subscription"},
-	{"sub-del", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_del,
-				"Delete subscription"},
-	{"sub-wrt", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_ovwrt,
-				"Overwrite subscription"},
+	{"virt-add", NULL, cmd_add_virt, "Generate and add a virtual label"},
+	{"group-list", NULL, cmd_list_groups,
+			"Display existing group addresses and virtual labels"},
+	{"sub-add", "<ele_addr> <sub_addr> <model_id> [vendor]",
+				cmd_sub_add, "Add subscription"},
+	{"sub-del", "<ele_addr> <sub_addr> <model_id> [vendor]",
+				cmd_sub_del, "Delete subscription"},
+	{"sub-wrt", "<ele_addr> <sub_addr> <model_id> [vendor]",
+				cmd_sub_ovwrt, "Overwrite subscription"},
 	{"sub-del-all", "<ele_addr> <model_id> [vendor]", cmd_sub_del_all,
 				"Delete subscription"},
 	{"sub-get", "<ele_addr> <model_id> [vendor]", cmd_sub_get,
@@ -1660,6 +1827,7 @@ struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
 	send_key_msg = key_send;
 	key_data = user_data;
 	requests = l_queue_new();
+	groups = l_queue_new();
 
 	bt_shell_add_submenu(&cfg_menu);
 
@@ -1669,4 +1837,5 @@ struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
 void cfgcli_cleanup(void)
 {
 	l_queue_destroy(requests, free_request);
+	l_queue_destroy(groups, l_free);
 }
-- 
2.21.1

