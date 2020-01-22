Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2167C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E6D2465A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVWfd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:35:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:63302 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVWfd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 17:35:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 14:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,351,1574150400"; 
   d="scan'208";a="275741947"
Received: from ingas-nuc1.sea.intel.com ([10.252.135.138])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2020 14:35:31 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh: Add commands for key refresh phase get/set
Date:   Wed, 22 Jan 2020 14:35:31 -0800
Message-Id: <20200122223531.19112-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add commands to send KEY_REFRESH_PHASE_GET and KEY_REFRESH_PHASE_SET
messages. Handle KEY_REFRESH_PHASE_STATUS response.
---
 tools/mesh/cfgcli.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index cfa573de3..97849ff0d 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -42,6 +42,7 @@
 
 #define MIN_COMPOSITION_LEN 16
 #define NO_RESPONSE 0xFFFFFFFF
+#define MAX_OPCODE_SZ 3
 
 /* Default timeout for getting a response to a sent config command (seconds) */
 #define DEFAULT_TIMEOUT 2
@@ -538,6 +539,19 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		break;
 
+	case OP_CONFIG_KEY_REFRESH_PHASE_STATUS:
+		if (len != 4)
+			return true;
+
+		bt_shell_printf("\nNode %4.4x Key Refresh Phase status %s\n",
+				src, mesh_status_str(data[0]));
+
+		net_idx = get_le16(data + 1);
+		bt_shell_printf("\tNetKey Index %3.3x, phase %d\n",
+							net_idx, data[3]);
+
+		break;
+
 	case OP_CONFIG_MODEL_PUB_STATUS:
 		if (len != 12 && len != 14)
 			return true;
@@ -1537,6 +1551,57 @@ static void cmd_netkey_get(int argc, char *argv[])
 	cmd_default(OP_NETKEY_GET);
 }
 
+static void cmd_kr_phase_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[MAX_OPCODE_SZ + 2];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* NetKey index */
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n, OP_CONFIG_KEY_REFRESH_PHASE_GET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_kr_phase_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[MAX_OPCODE_SZ + 3];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* NetKey index */
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	/* Transition */
+	msg[n++] = parms[1];
+
+	if (!config_send(msg, n, OP_CONFIG_KEY_REFRESH_PHASE_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
 {
 	if (!send_func)
@@ -1566,6 +1631,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Delete NetKey"},
 	{"netkey-get", NULL, cmd_netkey_get,
 				"List NetKeys known to the node"},
+	{"kr-phase-get", "<net_idx>", cmd_kr_phase_get,
+				"Get Key Refresh phase of the nodes's subnet"},
+	{"kr-phase-set", "<net_idx> <phase>", cmd_kr_phase_set,
+				"Set Key Refresh phase of the nodes's subnet"},
 	{"appkey-add", "<app_idx>", cmd_appkey_add,
 				"Add AppKey"},
 	{"appkey-update", "<app_idx>", cmd_appkey_update,
-- 
2.21.1

