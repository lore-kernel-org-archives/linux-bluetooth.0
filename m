Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD5C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346E82067B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKTzh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:55:37 -0500
Received: from hall.aurel32.net ([195.154.113.88]:58250 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfKKTzh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 14:55:37 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUFmi-00031X-GQ; Mon, 11 Nov 2019 20:55:36 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUFmh-00010U-5A; Mon, 11 Nov 2019 20:55:35 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH Bluez v2] tools/mesh-cfgclient: add network transmit get/set commands
Date:   Mon, 11 Nov 2019 20:55:30 +0100
Message-Id: <20191111195530.3354-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add network-transmit-get and network-transmit-set commands as per
Mesh Profile 4.3.2.69, 4.3.2.70 and 4.3.2.71.
---
 tools/mesh/cfgcli.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Changes v1 -> v2:
 - Fix the cnt/steps fields ordering

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index a4de42943..04edc706c 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -621,6 +621,15 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 				src, mesh_status_str(data[0]));
 
 		break;
+
+	/* Per Mesh Profile 4.3.2.71 */
+	case OP_CONFIG_NETWORK_TRANSMIT_STATUS:
+		if (len != 1)
+			return true;
+
+		bt_shell_printf("Node %4.4x: Network transmit cnt %d, steps %d\n",
+				src, data[0] & 7, data[0] >> 3);
+		break;
 	}
 
 	return true;
@@ -1334,6 +1343,33 @@ static void cmd_node_reset(int argc, char *argv[])
 	cmd_default(OP_NODE_RESET);
 }
 
+static void cmd_network_transmit_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_NETWORK_TRANSMIT_GET);
+}
+
+static void cmd_network_transmit_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 1];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0] | (parms[1] << 3);
+
+	if (!config_send(msg, n, OP_CONFIG_NETWORK_TRANSMIT_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
 {
 	if (!send_func)
@@ -1414,6 +1450,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Get subscription"},
 	{"node-reset", NULL, cmd_node_reset,
 				"Reset a node and remove it from network"},
+	{"network-transmit-get", NULL, cmd_network_transmit_get,
+				"Get network transmit state"},
+	{"network-transmit-set", "<count> <steps>", cmd_network_transmit_set,
+				"Set network transmit state"},
 	{} },
 };
 
-- 
2.24.0

