Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD1C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB6020578
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 20:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKKUUN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:20:13 -0500
Received: from hall.aurel32.net ([195.154.113.88]:58442 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfKKUUN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 15:20:13 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUGAW-00043q-7c; Mon, 11 Nov 2019 21:20:12 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUGAV-00019c-L4; Mon, 11 Nov 2019 21:20:11 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH BlueZ v2] tools/mesh-cfgclient: add unbind command
Date:   Mon, 11 Nov 2019 21:20:09 +0100
Message-Id: <20191111202009.4281-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reuses the existing cmd_bind for both opcodes. cmds[] already has
code to handle it.
---
 tools/mesh/cfgcli.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Changes v1 -> v2:
- Reuse the existing code by passing an opcode instead of duplicating
  the code. Thanks to Inga Stotland for the hint.

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 6dffbeefc..39e8a0b2c 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -872,7 +872,7 @@ static void cmd_appkey_update(int argc, char *argv[])
 	cmd_key_add(OP_APPKEY_UPDATE, argc, argv);
 }
 
-static void cmd_bind(int argc, char *argv[])
+static void cmd_bind(uint32_t opcode, int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
@@ -884,7 +884,7 @@ static void cmd_bind(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	n = mesh_opcode_set(OP_MODEL_APP_BIND, msg);
+	n = mesh_opcode_set(opcode, msg);
 
 	put_le16(parms[0], msg + n);
 	n += 2;
@@ -900,12 +900,22 @@ static void cmd_bind(int argc, char *argv[])
 		n += 2;
 	}
 
-	if (!config_send(msg, n, OP_MODEL_APP_BIND))
+	if (!config_send(msg, n, opcode))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_add_binding(int argc, char *argv[])
+{
+	cmd_bind(OP_MODEL_APP_BIND, argc, argv);
+}
+
+static void cmd_del_binding(int argc, char *argv[])
+{
+	cmd_bind(OP_MODEL_APP_UNBIND, argc, argv);
+}
+
 static void cmd_beacon_set(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1369,8 +1379,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Add application key"},
 	{"appkey-del", "<app_idx>", cmd_appkey_del,
 				"Delete application key"},
-	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_bind,
+	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_add_binding,
 				"Bind app key to a model"},
+	{"unbind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_del_binding,
+				"Remove app key from a model"},
 	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
 				"Get model app_idx"},
 	{"ttl-set", "<ttl>", cmd_ttl_set,
-- 
2.24.0

