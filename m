Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85044C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 00:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E622080F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 00:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKKAYM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:24:12 -0500
Received: from hall.aurel32.net ([195.154.113.88]:48946 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfKKAYM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Nov 2019 19:24:12 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iTxV5-0004EZ-59; Mon, 11 Nov 2019 01:24:11 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iTxV2-0008UG-T6; Mon, 11 Nov 2019 01:24:08 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Date:   Mon, 11 Nov 2019 01:24:07 +0100
Message-Id: <20191111002407.32575-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is basically a copy of cmd_bind with OP_MODEL_APP_BIND replaced by
OP_MODEL_APP_UNBIND as cmds[] already has code to handle it.
---
 tools/mesh/cfgcli.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 086998910..a4de42943 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -897,6 +897,40 @@ static void cmd_bind(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_unbind(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3 && parm_cnt != 4) {
+		bt_shell_printf("Bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_MODEL_APP_UNBIND, msg);
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+	put_le16(parms[1], msg + n);
+	n += 2;
+
+	if (parm_cnt == 4) {
+		put_le16(parms[3], msg + n);
+		put_le16(parms[2], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[2], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n, OP_MODEL_APP_UNBIND))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_beacon_set(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1335,6 +1369,8 @@ static const struct bt_shell_menu cfg_menu = {
 				"Delete application key"},
 	{"bind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_bind,
 				"Bind app key to a model"},
+	{"unbind", "<ele_addr> <app_idx> <mod_id> [vendor_id]", cmd_unbind,
+				"Remove app key from a model"},
 	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
 				"Get model app_idx"},
 	{"ttl-set", "<ttl>", cmd_ttl_set,
-- 
2.24.0

