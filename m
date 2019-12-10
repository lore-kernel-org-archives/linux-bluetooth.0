Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B464C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 22:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2510B2077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 22:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLJWXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:23:07 -0500
Received: from hall.aurel32.net ([195.154.113.88]:33756 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfLJWXH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 17:23:07 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1ienuJ-0000gc-BN; Tue, 10 Dec 2019 23:23:03 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1ienuI-003BiR-R5; Tue, 10 Dec 2019 23:23:02 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: add friend get/set commands
Date:   Tue, 10 Dec 2019 23:22:50 +0100
Message-Id: <20191210222250.759969-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add friend-get and friend-set commands as per Mesh Profile 4.3.2.55,
4.3.2.56 and 4.3.2.57.
---
 tools/mesh/cfgcli.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index ec9fabb3b..9020bb752 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -621,6 +621,15 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 				src, mesh_status_str(data[0]));
 
 		break;
+
+	/* Per Mesh Profile 4.3.2.57 */
+	case OP_CONFIG_FRIEND_STATUS:
+		if (len != 1)
+			return true;
+
+		bt_shell_printf("Node %4.4x Friend state 0x%02x\n",
+				src, data[0]);
+		break;
 	}
 
 	return true;
@@ -1310,6 +1319,33 @@ static void cmd_node_reset(int argc, char *argv[])
 	cmd_default(OP_NODE_RESET);
 }
 
+static void cmd_friend_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 1];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_FRIEND_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0];
+
+	if (!config_send(msg, n, OP_CONFIG_FRIEND_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_friend_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_FRIEND_GET);
+}
+
 static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
 {
 	if (!send_func)
@@ -1390,6 +1426,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Get subscription"},
 	{"node-reset", NULL, cmd_node_reset,
 				"Reset a node and remove it from network"},
+	{"friend-set", "<friend>", cmd_friend_set,
+				"Set friend state"},
+	{"friend-get", NULL, cmd_friend_get,
+				"Get friend state"},
 	{} },
 };
 
-- 
2.24.0

