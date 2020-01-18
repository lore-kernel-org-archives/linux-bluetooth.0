Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9AEC33CB6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE622467C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgAREWg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:22:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:11361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgAREWf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 23:22:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 20:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="220926440"
Received: from ingas-nuc1.sea.intel.com ([10.251.138.89])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 20:22:35 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4] tools/mesh: Refactor code for generating model ID
Date:   Fri, 17 Jan 2020 20:22:30 -0800
Message-Id: <20200118042233.15338-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118042233.15338-1-inga.stotland@intel.com>
References: <20200118042233.15338-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Common code for populating message buffer with Model ID
(either SIG or vendor defined) for misc commands is refactored
into a single function.
---
 tools/mesh/cfgcli.c | 61 +++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 50d2ce706..23fca4df6 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -240,11 +240,11 @@ static void add_request(uint32_t opcode)
 	l_queue_push_tail(requests, req);
 }
 
-static uint32_t print_mod_id(uint8_t *data, bool vid, const char *offset)
+static uint32_t print_mod_id(uint8_t *data, bool vendor, const char *offset)
 {
 	uint32_t mod_id;
 
-	if (!vid) {
+	if (!vendor) {
 		mod_id = get_le16(data);
 		bt_shell_printf("%sModel Id\t%4.4x\n", offset, mod_id);
 		mod_id = VENDOR_ID_MASK | mod_id;
@@ -691,6 +691,21 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	return true;
 }
 
+static uint16_t put_model_id(uint8_t *buf, uint32_t *args, bool vendor)
+{
+	uint16_t n = 2;
+
+	if (vendor) {
+		put_le16(args[1], buf);
+		buf += 2;
+		n = 4;
+	}
+
+	put_le16(args[0], buf);
+
+	return n;
+}
+
 static uint32_t read_input_parameters(int argc, char *argv[])
 {
 	uint32_t i;
@@ -973,14 +988,7 @@ static void cmd_bind(uint32_t opcode, int argc, char *argv[])
 	put_le16(parms[1], msg + n);
 	n += 2;
 
-	if (parm_cnt == 4) {
-		put_le16(parms[3], msg + n);
-		put_le16(parms[2], msg + n + 2);
-		n += 4;
-	} else {
-		put_le16(parms[2], msg + n);
-		n += 2;
-	}
+	n += put_model_id(msg + n, &parms[2], parm_cnt == 4);
 
 	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -1178,14 +1186,7 @@ static void cmd_pub_set(int argc, char *argv[])
 	msg[n++] = parms[4];
 
 	/* Model Id */
-	if (parm_cnt == 7) {
-		put_le16(parms[6], msg + n);
-		put_le16(parms[5], msg + n + 2);
-		n += 4;
-	} else {
-		put_le16(parms[5], msg + n);
-		n += 2;
-	}
+	n += put_model_id(msg + n, &parms[5], parm_cnt == 7);
 
 	if (!config_send(msg, n, OP_CONFIG_MODEL_PUB_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -1212,14 +1213,7 @@ static void cmd_pub_get(int argc, char *argv[])
 	n += 2;
 
 	/* Model Id */
-	if (parm_cnt == 3) {
-		put_le16(parms[2], msg + n);
-		put_le16(parms[1], msg + n + 2);
-		n += 4;
-	} else {
-		put_le16(parms[1], msg + n);
-		n += 2;
-	}
+	n += put_model_id(msg + n, &parms[1], parm_cnt == 3);
 
 	if (!config_send(msg, n, OP_CONFIG_MODEL_PUB_GET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -1497,21 +1491,22 @@ static const struct bt_shell_menu cfg_menu = {
 				"Delete AppKey"},
 	{"appkey-get", "<net_idx>", cmd_appkey_get,
 				"List AppKeys bound to the NetKey"},
-	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_add_binding,
+	{"bind", "<ele_addr> <app_idx> <model_id> [vendor_id]", cmd_add_binding,
 				"Bind AppKey to a model"},
-	{"unbind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_del_binding,
+	{"unbind", "<ele_addr> <app_idx> <model_id> [vendor_id]",
+				cmd_del_binding,
 				"Remove AppKey from a model"},
-	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
+	{"mod-appidx-get", "<ele_addr> <model_id>", cmd_mod_appidx_get,
 				"Get model app_idx"},
 	{"ttl-set", "<ttl>", cmd_ttl_set,
 				"Set default TTL"},
 	{"ttl-get", NULL, cmd_ttl_get,
 				"Get default TTL"},
 	{"pub-set", "<ele_addr> <pub_addr> <app_idx> <per (step|res)> "
-			"<re-xmt (cnt|per)> <mod id> [vendor_id]",
+			"<re-xmt (cnt|per)> <model_id> [vendor_id]",
 				cmd_pub_set,
 				"Set publication"},
-	{"pub-get", "<ele_addr> <model>", cmd_pub_get,
+	{"pub-get", "<ele_addr> <model_id> [vendor_id]", cmd_pub_get,
 				"Get publication"},
 	{"proxy-set", "<proxy>", cmd_proxy_set,
 				"Set proxy state"},
@@ -1546,9 +1541,9 @@ static const struct bt_shell_menu cfg_menu = {
 				"Set heartbeat subscribe"},
 	{"hb-sub-get", NULL, cmd_hb_sub_get,
 				"Get heartbeat subscribe"},
-	{"sub-add", "<ele_addr> <sub_addr> <model id>", cmd_sub_add,
+	{"sub-add", "<ele_addr> <sub_addr> <model_id>", cmd_sub_add,
 				"Add subscription"},
-	{"sub-get", "<ele_addr> <model id>", cmd_sub_get,
+	{"sub-get", "<ele_addr> <model_id>", cmd_sub_get,
 				"Get subscription"},
 	{"node-reset", NULL, cmd_node_reset,
 				"Reset a node and remove it from network"},
-- 
2.21.1

