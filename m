Return-Path: <SRS0=Tmyd=5O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80AC43331
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Mar 2020 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962C42074A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Mar 2020 20:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgC2U4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:56:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:20805 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgC2U4R (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Mar 2020 16:56:17 -0400
IronPort-SDR: gVL2dAVWRoK5rqqhlz55PyL2Nqi9ZNiU77ybFa+g5IW8c2TfpmhBCbwMP6woeETwoe+cO7or39
 YIy9uO5GJvwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 13:56:17 -0700
IronPort-SDR: 2yZ91HX/YcbQX8CHwLDatVZf/ZmGn8xWJOFTNJUn8uF8wunRcrYu7MEXcNFGA698+AK8UQjJ84
 w5jPpFHDf8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,321,1580803200"; 
   d="scan'208";a="294412312"
Received: from ingas-nuc1.sea.intel.com ([10.252.139.119])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2020 13:56:17 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] tools/mesh-cfgclient: Add commands for Key Refresh Phase
Date:   Sun, 29 Mar 2020 13:56:15 -0700
Message-Id: <20200329205615.22090-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200329205615.22090-1-inga.stotland@intel.com>
References: <20200329205615.22090-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds two new menu commands:
"kr-phase-get" - sends Config Key Refresh Phase Get message
"kr-phase-set" - sends Config Key Refresh Phase Set message
---
 tools/mesh/cfgcli.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 tools/mesh/keys.c   | 15 ++++++++
 tools/mesh/keys.h   |  1 +
 3 files changed, 100 insertions(+)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 0c82d9f82..d9f1c9b72 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -516,6 +516,18 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		break;
 
+	case OP_CONFIG_KEY_REFRESH_PHASE_STATUS:
+		if (len != 4)
+			break;
+
+		bt_shell_printf("Node %4.4x Key Refresh Phase status %s\n", src,
+						mesh_status_str(data[0]));
+		net_idx = get_le16(data + 1) & 0xfff;
+
+		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
+		bt_shell_printf("\tKR Phase %2.2x\n", data[3]);
+		break;
+
 	case OP_MODEL_APP_STATUS:
 		if (len != 7 && len != 9)
 			break;
@@ -950,6 +962,74 @@ static void cmd_netkey_del(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_kr_phase_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_GET, msg);
+
+	if (read_input_parameters(argc, argv) != 1)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
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
+	uint8_t msg[32];
+	uint8_t phase;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_SET, msg);
+
+	if (read_input_parameters(argc, argv) != 2)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (parms[1] != KEY_REFRESH_PHASE_TWO &&
+				parms[1] != KEY_REFRESH_PHASE_THREE) {
+		bt_shell_printf("Invalid KR transition value %u\n", parms[1]);
+		bt_shell_printf("Allowed values: 2 or 3\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!keys_get_net_key_phase((uint16_t) parms[0], &phase)) {
+		bt_shell_printf("Subnet KR state not found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (phase != (parms[1] % KEY_REFRESH_PHASE_THREE)) {
+		bt_shell_printf("Subnet's phase must be updated first!\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	msg[n++] = parms[1];
+
+	if (!config_send(msg, n, OP_CONFIG_KEY_REFRESH_PHASE_SET))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_appkey_del(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1788,6 +1868,10 @@ static const struct bt_shell_menu cfg_menu = {
 				"Delete NetKey"},
 	{"netkey-get", NULL, cmd_netkey_get,
 				"List NetKeys known to the node"},
+	{"kr-phase-get", "<net_idx>", cmd_kr_phase_get,
+				"Get Key Refresh phase of a NetKey"},
+	{"kr-phase-set", "<net_idx> <phase>", cmd_kr_phase_set,
+				"Set Key Refresh phase transition of a NetKey"},
 	{"appkey-add", "<app_idx>", cmd_appkey_add,
 				"Add AppKey"},
 	{"appkey-update", "<app_idx>", cmd_appkey_update,
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index e7b065beb..b7d36599a 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -116,6 +116,21 @@ void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase)
 		bt_shell_printf("Failed to save updated KR phase\n");
 }
 
+bool keys_get_net_key_phase(uint16_t net_idx, uint8_t *phase)
+{
+	struct net_key *key;
+
+	if (!phase || !net_keys)
+		return false;
+
+	key = l_queue_find(net_keys, net_idx_match, L_UINT_TO_PTR(net_idx));
+	if (!key)
+		return false;
+
+	*phase = key->phase;
+	return true;
+}
+
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx)
 {
 	struct net_key *key;
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
index e05e57997..3a90fa14b 100644
--- a/tools/mesh/keys.h
+++ b/tools/mesh/keys.h
@@ -21,6 +21,7 @@
 void keys_add_net_key(uint16_t net_idx);
 void keys_del_net_key(uint16_t net_idx);
 void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase);
+bool keys_get_net_key_phase(uint16_t net_idx, uint8_t *phase);
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx);
 void keys_del_app_key(uint16_t app_idx);
 uint16_t keys_get_bound_key(uint16_t app_idx);
-- 
2.21.1

