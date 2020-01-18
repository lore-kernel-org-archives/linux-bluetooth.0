Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3499CC33CB7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719E24656
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAREWi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:22:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:11361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgAREWi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 23:22:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 20:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="220926461"
Received: from ingas-nuc1.sea.intel.com ([10.251.138.89])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 20:22:37 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] tools/mesh: Implement model group subscription commands
Date:   Fri, 17 Jan 2020 20:22:33 -0800
Message-Id: <20200118042233.15338-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118042233.15338-1-inga.stotland@intel.com>
References: <20200118042233.15338-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for:
Config Model Subscription Delete
Config Model Subscription Delete All
Config Model Subscription Overwrite

and adds handling vendor model IDs for
Config Model Subscription Add
Config Model Subscription Get
---
 tools/mesh/cfgcli.c | 105 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 19 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index f9aaf137d..cfa573de3 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -246,14 +246,15 @@ static uint32_t print_mod_id(uint8_t *data, bool vendor, const char *offset)
 
 	if (!vendor) {
 		mod_id = get_le16(data);
-		bt_shell_printf("%sModel Id\t%4.4x\n", offset, mod_id);
+		bt_shell_printf("%sModel ID\t%4.4x\n", offset, mod_id);
 		mod_id = VENDOR_ID_MASK | mod_id;
 	} else {
 		mod_id = get_le16(data + 2);
-		bt_shell_printf("%sModel Id\t%4.4x %4.4x\n", offset,
+		bt_shell_printf("%sModel ID\t%4.4x %4.4x\n", offset,
 							get_le16(data), mod_id);
 		mod_id = get_le16(data) << 16 | mod_id;
 	}
+
 	return mod_id;
 }
 
@@ -606,13 +607,29 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 				src, mesh_status_str(data[0]));
 
 		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
+		print_mod_id(data + 3, false, "");
 
 		for (i = 5; i < len; i += 2)
 			bt_shell_printf("Subscr Addr\t%4.4x\n",
 							get_le16(data + i));
 		break;
 
+	case OP_CONFIG_VEND_MODEL_SUB_LIST:
+		if (len < 7)
+			return true;
+
+		bt_shell_printf("\nNode %4.4x Subscription List status %s\n",
+				src, mesh_status_str(data[0]));
+
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		print_mod_id(data + 3, true, "");
+
+		for (i = 7; i < len; i += 2)
+			bt_shell_printf("Subscr Addr\t%4.4x\n",
+							get_le16(data + i));
+		break;
+
+
 	/* Per Mesh Profile 4.3.2.50 */
 	case OP_MODEL_APP_LIST:
 		if (len < 5)
@@ -1241,60 +1258,104 @@ static void cmd_pub_get(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_sub_add(int argc, char *argv[])
+static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 {
 	uint16_t n;
 	uint8_t msg[32];
 	int parm_cnt;
 
-	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_ADD, msg);
+	n = mesh_opcode_set(opcode, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 3) {
+	if (parm_cnt != 3 && parm_cnt != 4) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	/* Per Mesh Profile 4.3.2.19 */
 	/* Element Address */
 	put_le16(parms[0], msg + n);
 	n += 2;
 	/* Subscription Address */
 	put_le16(parms[1], msg + n);
 	n += 2;
-	/* SIG Model ID */
-	put_le16(parms[2], msg + n);
-	n += 2;
 
-	if (!config_send(msg, n, OP_CONFIG_MODEL_SUB_ADD))
+	/* Model ID */
+	n += put_model_id(msg + n, &parms[2], parm_cnt == 4);
+
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void cmd_sub_get(int argc, char *argv[])
+static void cmd_sub_add(int argc, char *argv[])
+{
+	subscription_cmd(argc, argv, OP_CONFIG_MODEL_SUB_ADD);
+}
+
+static void cmd_sub_del(int argc, char *argv[])
+{
+	subscription_cmd(argc, argv, OP_CONFIG_MODEL_SUB_DELETE);
+}
+
+static void cmd_sub_ovwrt(int argc, char *argv[])
+{
+	subscription_cmd(argc, argv, OP_CONFIG_MODEL_SUB_OVERWRITE);
+}
+
+static void cmd_sub_del_all(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
 	int parm_cnt;
 
-	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_GET, msg);
+	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE_ALL, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 2) {
+	if (parm_cnt != 2 && parm_cnt != 3) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	/* Per Mesh Profile 4.3.2.27 */
 	/* Element Address */
 	put_le16(parms[0], msg + n);
 	n += 2;
+
 	/* Model ID */
-	put_le16(parms[1], msg + n);
+	n += put_model_id(msg + n, &parms[1], parm_cnt == 3);
+
+	if (!config_send(msg, n, OP_CONFIG_MODEL_SUB_DELETE_ALL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_sub_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+	bool vendor;
+	uint32_t opcode;
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2 && parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	vendor = (parm_cnt == 3);
+	opcode = !vendor ? OP_CONFIG_MODEL_SUB_GET :
+						OP_CONFIG_VEND_MODEL_SUB_GET;
+	n = mesh_opcode_set(opcode, msg);
+
+	/* Element Address */
+	put_le16(parms[0], msg + n);
 	n += 2;
+	/* Model ID */
+	n += put_model_id(msg + n, &parms[1], vendor);
 
-	if (!config_send(msg, n, OP_CONFIG_MODEL_SUB_GET))
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -1564,9 +1625,15 @@ static const struct bt_shell_menu cfg_menu = {
 				"Set heartbeat subscribe"},
 	{"hb-sub-get", NULL, cmd_hb_sub_get,
 				"Get heartbeat subscribe"},
-	{"sub-add", "<ele_addr> <sub_addr> <model_id>", cmd_sub_add,
+	{"sub-add", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_add,
 				"Add subscription"},
-	{"sub-get", "<ele_addr> <model_id>", cmd_sub_get,
+	{"sub-del", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_del,
+				"Delete subscription"},
+	{"sub-wrt", "<ele_addr> <sub_addr> <model_id> [vendor]", cmd_sub_ovwrt,
+				"Overwrite subscription"},
+	{"sub-del-all", "<ele_addr> <model_id> [vendor]", cmd_sub_del_all,
+				"Delete subscription"},
+	{"sub-get", "<ele_addr> <model_id> [vendor]", cmd_sub_get,
 				"Get subscription"},
 	{"node-reset", NULL, cmd_node_reset,
 				"Reset a node and remove it from network"},
-- 
2.21.1

