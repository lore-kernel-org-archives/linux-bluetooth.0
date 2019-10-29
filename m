Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E129CA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ED7208E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJ2UlF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:41:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:15200 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2UlE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 16:41:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="401277228"
Received: from ingas-nuc1.sea.intel.com ([10.255.229.102])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 13:41:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 07/10] tools/mesh-cfgclient: Add timeout for expected response
Date:   Tue, 29 Oct 2019 13:40:51 -0700
Message-Id: <20191029204054.30599-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029204054.30599-1-inga.stotland@intel.com>
References: <20191029204054.30599-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a pending request queue for the issued commands awaiting
response from a remote config server. The tool forces "single-issue"
of a config command, i.e. only one command that has a specified return
type is allowed to be outstanding per a remote node address.
That is, if AppKeyAdd command to a node is pending response, the tool
disallows sending another AppKeyAdd, AppKeyUpdate or AppKeyDelete to
the same address until response timeout expires (notification will
be displayed).
The default response timeout is set to 2 seconds and is configurable
by "timeout" command.
---
 tools/mesh-cfgclient.c |   2 +
 tools/mesh/cfgcli.c    | 136 +++++++++++++++++++++++++++++++++++++++--
 tools/mesh/cfgcli.h    |   1 +
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 5d74be9dd..399dc05dd 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1663,5 +1663,7 @@ int main(int argc, char *argv[])
 	l_dbus_client_destroy(client);
 	l_dbus_destroy(dbus);
 
+	cfgcli_cleanup();
+
 	return status;
 }
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index ae8644049..df2a23b05 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -40,18 +40,30 @@
 #define MIN_COMPOSITION_LEN 16
 #define NO_RESPONSE 0xFFFFFFFF
 
+/* Default timeout for getting a response to a sent config command (seconds) */
+#define DEFAULT_TIMEOUT 2
+
 struct cfg_cmd {
 	uint32_t opcode;
-	uint32_t resp;
+	uint32_t rsp;
 	const char *desc;
 };
 
+struct pending_req {
+	struct l_timeout *timer;
+	const struct cfg_cmd *cmd;
+	uint16_t addr;
+};
+
+static struct l_queue *requests;
+
 static void *send_data;
 static model_send_msg_func_t send_msg;
 
 static void *key_data;
 static key_send_func_t send_key_msg;
 
+static uint32_t rsp_timeout = DEFAULT_TIMEOUT;
 static uint16_t target = UNASSIGNED_ADDRESS;
 static uint32_t parms[8];
 
@@ -150,16 +162,79 @@ static struct cfg_cmd cmds[] = {
 	{ OP_VEND_MODEL_APP_LIST, NO_RESPONSE, "VendorModelAppList" }
 };
 
-static const char *opcode_str(uint32_t opcode)
+static const struct cfg_cmd *get_cmd(uint32_t opcode)
 {
 	uint32_t n;
 
 	for (n = 0; n < L_ARRAY_SIZE(cmds); n++) {
 		if (opcode == cmds[n].opcode)
-			return cmds[n].desc;
+			return &cmds[n];
+	}
+
+	return NULL;
+}
+
+static const char *opcode_str(uint32_t opcode)
+{
+	const struct cfg_cmd *cmd;
+
+	cmd = get_cmd(opcode);
+	if (!cmd)
+		return "Unknown";
+
+	return cmd->desc;
+}
+
+static void free_request(void *a)
+{
+	struct pending_req *req = a;
+
+	l_timeout_remove(req->timer);
+	l_free(req);
+}
+
+static struct pending_req *get_req_by_rsp(uint16_t addr, uint32_t rsp)
+{
+	const struct l_queue_entry *entry;
+
+	entry = l_queue_get_entries(requests);
+
+	for (; entry; entry = entry->next) {
+		struct pending_req *req = entry->data;
+
+		if (req->addr == addr && req->cmd->rsp == rsp)
+			return req;
 	}
 
-	return "Unknown";
+	return NULL;
+}
+
+static void wait_rsp_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct pending_req *req = user_data;
+
+	bt_shell_printf("No response for \"%s\" from %4.4x\n",
+						req->cmd->desc, req->addr);
+
+	l_queue_remove(requests, req);
+	free_request(req);
+}
+
+static void add_request(uint32_t opcode)
+{
+	struct pending_req *req;
+	const struct cfg_cmd *cmd;
+
+	cmd = get_cmd(opcode);
+	if (!cmd)
+		return;
+
+	req = l_new(struct pending_req, 1);
+	req->cmd = cmd;
+	req->addr = target;
+	req->timer = l_timeout_create(rsp_timeout,
+				wait_rsp_timeout, req, NULL);
+	l_queue_push_tail(requests, req);
 }
 
 static uint32_t print_mod_id(uint8_t *data, bool vid, const char *offset)
@@ -269,6 +344,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	struct model_pub pub;
 	int n;
 	uint16_t i;
+	struct pending_req *req;
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -278,6 +354,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	bt_shell_printf("Received %s\n", opcode_str(opcode));
 
+	req = get_req_by_rsp(src, (opcode & ~OP_UNRELIABLE));
+	if (req) {
+		free_request(req);
+		l_queue_remove(requests, req);
+	}
+
 	switch (opcode & ~OP_UNRELIABLE) {
 	default:
 		return false;
@@ -531,6 +613,19 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	return i;
 }
 
+static void cmd_timeout_set(int argc, char *argv[])
+{
+	if (read_input_parameters(argc, argv) != 1)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	rsp_timeout = parms[0];
+
+	bt_shell_printf("Timeout to wait for remote node's response: %d secs\n",
+								rsp_timeout);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_dst_set(int argc, char *argv[])
 {
 	uint32_t dst;
@@ -555,6 +650,7 @@ static void cmd_dst_set(int argc, char *argv[])
 
 static bool config_send(uint8_t *buf, uint16_t len, uint32_t opcode)
 {
+	const struct cfg_cmd *cmd;
 	bool res;
 
 	if (IS_UNASSIGNED(target)) {
@@ -562,10 +658,22 @@ static bool config_send(uint8_t *buf, uint16_t len, uint32_t opcode)
 		return false;
 	}
 
+	cmd = get_cmd(opcode);
+	if (!cmd)
+		return false;
+
+	if (get_req_by_rsp(target, cmd->rsp)) {
+		bt_shell_printf("Another command is pending\n");
+		return false;
+	}
+
 	res = send_msg(send_data, target, APP_IDX_DEV_REMOTE, buf, len);
 	if (!res)
 		bt_shell_printf("Failed to send \"%s\"\n", opcode_str(opcode));
 
+	if (cmd->rsp != NO_RESPONSE)
+		add_request(opcode);
+
 	return res;
 }
 
@@ -640,6 +748,7 @@ static void cmd_key_add(uint32_t opcode, int argc, char *argv[])
 {
 	uint16_t key_idx;
 	bool is_appkey, update;
+	const struct cfg_cmd *cmd;
 
 	if (IS_UNASSIGNED(target)) {
 		bt_shell_printf("Destination not set\n");
@@ -656,6 +765,15 @@ static void cmd_key_add(uint32_t opcode, int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	cmd = get_cmd(opcode);
+	if (!cmd)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (get_req_by_rsp(target, cmd->rsp)) {
+		bt_shell_printf("Another key command is pending\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	key_idx = (uint16_t) parms[0];
 
 	update = (opcode == OP_NETKEY_UPDATE || opcode == OP_APPKEY_UPDATE);
@@ -664,6 +782,8 @@ static void cmd_key_add(uint32_t opcode, int argc, char *argv[])
 	if (!send_key_msg(key_data, target, key_idx, is_appkey, update))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
+	add_request(opcode);
+
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
@@ -1141,6 +1261,8 @@ static const struct bt_shell_menu cfg_menu = {
 	.entries = {
 	{"target", "<unicast>", cmd_dst_set,
 				"Set target node to configure"},
+	{"timeout", "<seconds>", cmd_timeout_set,
+				"Set response timeout (seconds)"},
 	{"composition-get", "[page_num]", cmd_composition_get,
 				"Get composition data"},
 	{"netkey-add", "<net_idx>", cmd_netkey_add,
@@ -1222,8 +1344,14 @@ struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
 
 	send_key_msg = key_send;
 	key_data = user_data;
+	requests = l_queue_new();
 
 	bt_shell_add_submenu(&cfg_menu);
 
 	return &cli_info;
 }
+
+void cfgcli_cleanup(void)
+{
+	l_queue_destroy(requests, free_request);
+}
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
index 077c340e5..16d2e0a61 100644
--- a/tools/mesh/cfgcli.h
+++ b/tools/mesh/cfgcli.h
@@ -22,3 +22,4 @@ typedef bool (*key_send_func_t) (void *user_data, uint16_t dst,
 				 uint16_t idx, bool is_appkey, bool update);
 
 struct model_info *cfgcli_init(key_send_func_t key_func, void *user_data);
+void cfgcli_cleanup(void);
-- 
2.21.0

