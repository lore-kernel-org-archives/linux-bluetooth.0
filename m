Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2BC1975A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B50720752
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 22:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQWPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:15:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:25747 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWPs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 18:15:48 -0400
IronPort-SDR: 7tau6AsrCrqKTdtJdHBKMFLIFmtGW55aic6XlchKqihBJHBF0hpeHqPV+ZdfKSaM9k4zmzAunr
 N7kXlH1oX5RQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 15:15:47 -0700
IronPort-SDR: j7hSFeOLpEv24q6KPLodu1b/nXfc4OiOpUidarP2guwIEjDN7qC7PRKG5K64sl7Tm7Dpc92eas
 ZowFaCEJOzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="417711489"
Received: from ingas-nuc1.sea.intel.com ([10.255.228.139])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2020 15:15:47 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 1/2] tools/mesh-cfgclient: Implement node-reset command
Date:   Tue, 17 Mar 2020 15:15:45 -0700
Message-Id: <20200317221546.22440-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements one-pass removal oa a remote node from a mesh network
by issuing a node-reset command from config menu. The following actions
are performed:
- Config Node Reset message is sent to a remote node
- Upon either receiving Config Node Reset Status or response timeout,
  node record is removed from configuration client's database and,
  by calling DeleteRemoteNode() method on mesh.Management interface

node-delete command from the main menu is removed.
---
 tools/mesh-cfgclient.c | 77 ++++++++++++++++--------------------------
 tools/mesh/cfgcli.c    | 60 ++++++++++++++++++++++++++++----
 tools/mesh/cfgcli.h    |  4 ++-
 tools/mesh/mesh-db.c   | 39 +++++++++++++++++++++
 tools/mesh/remote.c    | 20 +++++++++++
 tools/mesh/remote.h    |  1 +
 6 files changed, 147 insertions(+), 54 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 4b7bd2200..e4523e5fc 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -342,9 +342,38 @@ static bool send_key(void *user_data, uint16_t dst, uint16_t key_idx,
 				send_key_setup, NULL, req, l_free) != 0;
 }
 
+static void delete_node_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t primary;
+	uint8_t ele_cnt;
+
+	primary = (uint16_t) req->arg1;
+	ele_cnt = (uint8_t) req->arg2;
+
+	l_dbus_message_set_arguments(msg, "qy", primary, ele_cnt);
+}
+
+static void delete_node(uint16_t primary, uint8_t ele_cnt)
+{
+	struct generic_request *req;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+	req->arg1 = primary;
+	req->arg2 = ele_cnt;
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "DeleteRemoteNode",
+				delete_node_setup, NULL, req, l_free);
+}
+
 static void client_init(void)
 {
-	cfgcli = cfgcli_init(send_key, (void *) app.ele.path);
+	cfgcli = cfgcli_init(send_key, delete_node, (void *) app.ele.path);
 	cfgcli->ops.set_send_func(send_msg, (void *) app.ele.path);
 }
 
@@ -801,50 +830,6 @@ static void free_generic_request(void *data)
 	l_free(req);
 }
 
-static void delete_node_setup(struct l_dbus_message *msg, void *user_data)
-{
-	struct generic_request *req = user_data;
-	uint16_t primary;
-	uint8_t ele_cnt;
-
-	primary = (uint16_t) req->arg1;
-	ele_cnt = (uint8_t) req->arg2;
-
-	l_dbus_message_set_arguments(msg, "qy", primary, ele_cnt);
-}
-
-static void cmd_delete_node(int argc, char *argv[])
-{
-	struct generic_request *req;
-
-	if (!local || !local->proxy || !local->mgmt_proxy) {
-		bt_shell_printf("Node is not attached\n");
-		return;
-	}
-
-	if (argc < 3) {
-		bt_shell_printf("Unicast and element count are required\n");
-		return;
-	}
-
-	req = l_new(struct generic_request, 1);
-
-	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
-		goto fail;
-
-	if (sscanf(argv[2], "%u", &req->arg2) != 1)
-		goto fail;
-
-	l_dbus_proxy_method_call(local->mgmt_proxy, "DeleteRemoteNode",
-				delete_node_setup, NULL, req, l_free);
-
-	/* TODO:: Delete node from configuration */
-	return;
-
-fail:
-	l_free(req);
-}
-
 static void import_node_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *msg, void *user_data)
 {
@@ -1359,8 +1344,6 @@ static const struct bt_shell_menu main_menu = {
 	{ "node-import", "<uuid> <net_idx> <primary> <ele_count> <dev_key>",
 			cmd_import_node,
 			"Import an externally provisioned remote node"},
-	{ "node-delete", "<primary> <ele_count>", cmd_delete_node,
-			"Delete a remote node"},
 	{ "list-nodes", NULL, cmd_list_nodes,
 			"List remote mesh nodes"},
 	{ "keys", NULL, cmd_keys,
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 33e77d878..0c82d9f82 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -65,6 +65,7 @@ static struct l_queue *groups;
 
 static void *send_data;
 static model_send_msg_func_t send_msg;
+static delete_remote_func_t mgr_del_remote;
 
 static void *key_data;
 static key_send_func_t send_key_msg;
@@ -191,6 +192,15 @@ static const char *opcode_str(uint32_t opcode)
 	return cmd->desc;
 }
 
+static void reset_remote_node(uint16_t addr)
+{
+	uint8_t ele_cnt = remote_del_node(addr);
+
+	bt_shell_printf("Remote removed (primary %4.4x)\n", addr);
+	if (ele_cnt && mgr_del_remote)
+		mgr_del_remote(addr, ele_cnt);
+}
+
 static void free_request(void *a)
 {
 	struct pending_req *req = a;
@@ -222,6 +232,10 @@ static void wait_rsp_timeout(struct l_timeout *timeout, void *user_data)
 	bt_shell_printf("No response for \"%s\" from %4.4x\n",
 						req->cmd->desc, req->addr);
 
+	/* Node reset case: delete the remote even if there is no response */
+	if (req->cmd->opcode == OP_NODE_RESET)
+		reset_remote_node(req->addr);
+
 	l_queue_remove(requests, req);
 	free_request(req);
 }
@@ -713,11 +727,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.54 */
 	case OP_NODE_RESET_STATUS:
-		if (len != 1)
-			return true;
 
-		bt_shell_printf("Node %4.4x reset status %s\n",
-				src, mesh_status_str(data[0]));
+		bt_shell_printf("Node %4.4x is reset\n", src);
+		reset_remote_node(src);
 
 		break;
 
@@ -1656,7 +1668,41 @@ static void cmd_friend_get(int argc, char *argv[])
 
 static void cmd_node_reset(int argc, char *argv[])
 {
-	cmd_default(OP_NODE_RESET);
+	uint16_t n, i;
+	uint8_t msg[8];
+	struct pending_req *req;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Cannot remet self */
+	if (target == 0x0001) {
+		bt_shell_printf("Resetting self not allowed\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_NODE_RESET, msg);
+
+	req = l_new(struct pending_req, 1);
+	req->addr = target;
+	req->cmd = get_cmd(OP_NODE_RESET);
+
+	/*
+	 * As a courtesy to the remote node, send the reset command
+	 * several times. Treat this as a single request with a longer
+	 * response timeout.
+	 */
+	req->timer = l_timeout_create(rsp_timeout * 2,
+				wait_rsp_timeout, req, NULL);
+
+	l_queue_push_tail(requests, req);
+
+	for (i = 0; i < 5; i++)
+		send_msg(send_data, target, APP_IDX_DEV_REMOTE, msg, n);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_netkey_get(int argc, char *argv[])
@@ -1831,13 +1877,15 @@ static struct model_info cli_info = {
 	.vendor_id = VENDOR_ID_INVALID
 };
 
-struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
+struct model_info *cfgcli_init(key_send_func_t key_send,
+				delete_remote_func_t del_node, void *user_data)
 {
 	if (!key_send)
 		return NULL;
 
 	send_key_msg = key_send;
 	key_data = user_data;
+	mgr_del_remote = del_node;
 	requests = l_queue_new();
 	groups = mesh_db_load_groups();
 	bt_shell_add_submenu(&cfg_menu);
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
index 9b283d9d5..89a67f5de 100644
--- a/tools/mesh/cfgcli.h
+++ b/tools/mesh/cfgcli.h
@@ -25,6 +25,8 @@ struct mesh_group {
 
 typedef bool (*key_send_func_t) (void *user_data, uint16_t dst,
 				 uint16_t idx, bool is_appkey, bool update);
+typedef void (*delete_remote_func_t) (uint16_t primary, uint8_t ele_cnt);
 
-struct model_info *cfgcli_init(key_send_func_t key_func, void *user_data);
+struct model_info *cfgcli_init(key_send_func_t key_func,
+				delete_remote_func_t del_node, void *user_data);
 void cfgcli_cleanup(void);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 4a26a667e..e938ee733 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -845,6 +845,45 @@ fail:
 	return false;
 }
 
+bool mesh_db_del_node(uint16_t unicast)
+{
+	json_object *jarray;
+	int i, sz;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "nodes", &jarray))
+		return false;
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry, *jval;
+		uint16_t addr;
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "unicastAddress",
+								&jval))
+			continue;
+
+		str = json_object_get_string(jval);
+		if (sscanf(str, "%04hx", &addr) != 1)
+			continue;
+
+		if (addr == unicast)
+			break;
+	}
+
+	if (i == sz)
+		return true;
+
+	json_object_array_del_idx(jarray, i, 1);
+
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+}
+
 bool mesh_db_get_token(uint8_t token[8])
 {
 	if (!cfg || !cfg->jcfg)
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 533d59b28..b9bc6b5c0 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -89,6 +89,26 @@ static bool match_bound_key(const void *a, const void *b)
 	return (net_idx == keys_get_bound_key(app_idx));
 }
 
+uint8_t remote_del_node(uint16_t unicast)
+{
+	struct remote_node *rmt;
+	uint8_t num_ele;
+
+	rmt = l_queue_remove_if(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
+	if (!rmt)
+		return 0;
+
+	num_ele = rmt->num_ele;
+
+	l_queue_destroy(rmt->net_keys, NULL);
+	l_queue_destroy(rmt->app_keys, NULL);
+	l_free(rmt);
+
+	mesh_db_del_node(unicast);
+
+	return num_ele;
+}
+
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx)
 {
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index f2a6f48dd..63382ed90 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -19,6 +19,7 @@
 
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx);
+uint8_t remote_del_node(uint16_t unicast);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
-- 
2.21.1

