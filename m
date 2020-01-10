Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0160C32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 03:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAA20678
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 03:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgAJDEm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:04:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:55361 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJDEm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 22:04:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 19:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; 
   d="scan'208";a="396293606"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 19:04:41 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh: add commands for AppKey Get and NetKey Get
Date:   Thu,  9 Jan 2020 19:04:40 -0800
Message-Id: <20200110030440.5725-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements commands to send AppKey Get and NetKey Get messages and
to process AppKey List and NetKey List reponses
---
 tools/mesh/cfgcli.c | 100 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 2403c9293..50d2ce706 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -406,6 +406,33 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		break;
 
+	case OP_APPKEY_LIST:
+		if (len < 3)
+			break;
+
+		bt_shell_printf("AppKey List (node %4.4x) Status %s\n",
+						src, mesh_status_str(data[0]));
+		bt_shell_printf("NetKey %3.3x\n", l_get_le16(&data[1]));
+		len -= 3;
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			break;
+
+		bt_shell_printf("AppKeys:\n");
+		data += 3;
+
+		while (len >= 3) {
+			bt_shell_printf("\t%3.3x\n", l_get_le16(data) & 0xfff);
+			bt_shell_printf("\t%3.3x\n", l_get_le16(data + 1) >> 4);
+			len -= 3;
+			data += 3;
+		}
+
+		if (len == 2)
+			bt_shell_printf("\t%3.3x\n", l_get_le16(data));
+
+		break;
+
 	case OP_NETKEY_STATUS:
 		if (len != 3)
 			break;
@@ -432,6 +459,26 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		break;
 
+	case OP_NETKEY_LIST:
+		if (len < 2)
+			break;
+
+		bt_shell_printf("NetKey List (node %4.4x):\n", src);
+
+		while (len >= 3) {
+			net_idx = l_get_le16(data) & 0xfff;
+			bt_shell_printf("\t%3.3x\n", net_idx);
+			net_idx = l_get_le16(data + 1) >> 4;
+			bt_shell_printf("\t%3.3x\n", net_idx);
+			data += 3;
+			len -= 3;
+		}
+
+		if (len == 2)
+			bt_shell_printf("\t%3.3x\n", l_get_le16(data) & 0xfff);
+
+		break;
+
 	case OP_MODEL_APP_STATUS:
 		if (len != 7 && len != 9)
 			break;
@@ -818,6 +865,32 @@ static void cmd_appkey_del(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_appkey_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_APPKEY_GET, msg);
+
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n, OP_APPKEY_GET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_key_add(uint32_t opcode, int argc, char *argv[])
 {
 	uint16_t key_idx;
@@ -1382,6 +1455,11 @@ static void cmd_node_reset(int argc, char *argv[])
 	cmd_default(OP_NODE_RESET);
 }
 
+static void cmd_netkey_get(int argc, char *argv[])
+{
+	cmd_default(OP_NETKEY_GET);
+}
+
 static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
 {
 	if (!send_func)
@@ -1404,21 +1482,25 @@ static const struct bt_shell_menu cfg_menu = {
 	{"composition-get", "[page_num]", cmd_composition_get,
 				"Get composition data"},
 	{"netkey-add", "<net_idx>", cmd_netkey_add,
-				"Add network key"},
+				"Add NetKey"},
 	{"netkey-update", "<net_idx>", cmd_netkey_update,
-				"Update network key"},
+				"Update NetKey"},
 	{"netkey-del", "<net_idx>", cmd_netkey_del,
-				"Delete network key"},
+				"Delete NetKey"},
+	{"netkey-get", NULL, cmd_netkey_get,
+				"List NetKeys known to the node"},
 	{"appkey-add", "<app_idx>", cmd_appkey_add,
-				"Add application key"},
+				"Add AppKey"},
 	{"appkey-update", "<app_idx>", cmd_appkey_update,
-				"Add application key"},
+				"Add AppKey"},
 	{"appkey-del", "<app_idx>", cmd_appkey_del,
-				"Delete application key"},
+				"Delete AppKey"},
+	{"appkey-get", "<net_idx>", cmd_appkey_get,
+				"List AppKeys bound to the NetKey"},
 	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_add_binding,
-				"Bind app key to a model"},
+				"Bind AppKey to a model"},
 	{"unbind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_del_binding,
-				"Remove app key from a model"},
+				"Remove AppKey from a model"},
 	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
 				"Get model app_idx"},
 	{"ttl-set", "<ttl>", cmd_ttl_set,
-- 
2.21.1

