Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46311C33CB6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FA72467C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgAREWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:22:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:11361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgAREWh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 23:22:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 20:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="220926454"
Received: from ingas-nuc1.sea.intel.com ([10.251.138.89])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 20:22:36 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] tools/mesh: Add support for Vendor Model App Get/List
Date:   Fri, 17 Jan 2020 20:22:32 -0800
Message-Id: <20200118042233.15338-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118042233.15338-1-inga.stotland@intel.com>
References: <20200118042233.15338-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for sending Config Vendor App Get message
and receiving Config Vendor App List response.
---
 tools/mesh/cfgcli.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 934205f0b..f9aaf137d 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -629,6 +629,24 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 							get_le16(data + i));
 		break;
 
+	case OP_VEND_MODEL_APP_LIST:
+		if (len < 7)
+			return true;
+
+		bt_shell_printf("\nNode %4.4x Vendor Model AppIdx status %s\n",
+						src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		print_mod_id(data + 3, true, "");
+
+		for (i = 7; i < len; i += 2)
+			bt_shell_printf("Model AppIdx\t%4.4x\n",
+							get_le16(data + i));
+		break;
+
 	/* Per Mesh Profile 4.3.2.63 */
 	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
 		if (len != 10)
@@ -1287,24 +1305,26 @@ static void cmd_mod_appidx_get(int argc, char *argv[])
 	uint16_t n;
 	uint8_t msg[32];
 	int parm_cnt;
-
-	n = mesh_opcode_set(OP_MODEL_APP_GET, msg);
+	bool vendor;
+	uint32_t opcode;
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 2) {
+	if (parm_cnt != 2 && parm_cnt != 3) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	/* Per Mesh Profile 4.3.2.49 */
+	vendor = (parm_cnt == 3);
+	opcode = !vendor ? OP_MODEL_APP_GET : OP_VEND_MODEL_APP_GET;
+	n = mesh_opcode_set(opcode, msg);
+
 	/* Element Address */
 	put_le16(parms[0], msg + n);
 	n += 2;
 	/* Model ID */
-	put_le16(parms[1], msg + n);
-	n += 2;
+	n += put_model_id(msg + n, &parms[1], vendor);
 
-	if (!config_send(msg, n, OP_MODEL_APP_GET))
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -1498,7 +1518,8 @@ static const struct bt_shell_menu cfg_menu = {
 	{"unbind", "<ele_addr> <app_idx> <model_id> [vendor_id]",
 				cmd_del_binding,
 				"Remove AppKey from a model"},
-	{"mod-appidx-get", "<ele_addr> <model_id>", cmd_mod_appidx_get,
+	{"mod-appidx-get", "<ele_addr> <model_id> [vendor_id]",
+				cmd_mod_appidx_get,
 				"Get model app_idx"},
 	{"ttl-set", "<ttl>", cmd_ttl_set,
 				"Set default TTL"},
-- 
2.21.1

