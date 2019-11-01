Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED43CA9ED2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD575217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfKAS5i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:29978 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5i (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833770"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 05/10 v2] tools/mesh-cfgclient: Commands for Management iface methods
Date:   Fri,  1 Nov 2019 11:57:24 -0700
Message-Id: <20191101185729.31661-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds complete list of commenads that excercise calls to
org.bluez.mesh.Manager1 methods:
"appkey-create": CreateAppKey()
"appkey-import": ImportAppKey()
"appkey-update": UpdateAppKey()
"appkey-delete": DeleteAppKey()
"subnet-create": CreateSubnet()
"subnet-import": SubnetImport()
"subnet-update": SubnetUpdate()
"subnet-delete": SubnetDelete()
"subnet-set-phase": SetKeyPhase()
"node-import": ImportRemoteNode()
"node-delete": DeleteRemoteNode()
---
 tools/mesh-cfgclient.c | 551 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 520 insertions(+), 31 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index c932cc3c5..d722ea9b7 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -85,6 +85,15 @@ struct unprov_device {
 	uint8_t uuid[16];
 };
 
+struct generic_request {
+	uint32_t arg1;
+	uint32_t arg2;
+	uint32_t arg3;
+	uint8_t *data1;
+	uint8_t *data2;
+	const char *str;
+};
+
 static struct l_dbus *dbus;
 
 static struct l_queue *node_proxies;
@@ -203,6 +212,19 @@ struct key_data {
 	bool update;
 };
 
+static void append_byte_array(struct l_dbus_message_builder *builder,
+					unsigned char *data, unsigned int len)
+{
+	unsigned int i;
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y', &(data[i]));
+
+	l_dbus_message_builder_leave_array(builder);
+}
+
 static void send_msg_setup(struct l_dbus_message *msg, void *user_data)
 {
 	struct send_data *req = user_data;
@@ -215,15 +237,7 @@ static void send_msg_setup(struct l_dbus_message *msg, void *user_data)
 	if (req->is_dev_key)
 		l_dbus_message_builder_append_basic(builder, 'b', &req->rmt);
 	l_dbus_message_builder_append_basic(builder, 'q', &req->idx);
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	while (req->len) {
-		l_dbus_message_builder_append_basic(builder, 'y', req->data);
-		req->data++;
-		req->len--;
-	}
-
-	l_dbus_message_builder_leave_array(builder);
+	append_byte_array(builder, req->data, req->len);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 }
@@ -434,8 +448,7 @@ static void try_set_node_proxy(void *a, void *b)
 }
 
 static void attach_node_reply(struct l_dbus_proxy *proxy,
-						struct l_dbus_message *msg,
-						void *user_data)
+				struct l_dbus_message *msg, void *user_data)
 {
 	struct meshcfg_node *node = user_data;
 	struct l_dbus_message_iter iter_cfg;
@@ -482,8 +495,7 @@ static void attach_node_setup(struct l_dbus_message *msg, void *user_data)
 }
 
 static void create_net_reply(struct l_dbus_proxy *proxy,
-						struct l_dbus_message *msg,
-						void *user_data)
+				struct l_dbus_message *msg, void *user_data)
 {
 	char *str;
 	uint64_t tmp;
@@ -516,7 +528,6 @@ static void create_net_reply(struct l_dbus_proxy *proxy,
 
 static void create_net_setup(struct l_dbus_message *msg, void *user_data)
 {
-	uint i;
 	struct l_dbus_message_builder *builder;
 
 	/* Generate random UUID */
@@ -525,14 +536,7 @@ static void create_net_setup(struct l_dbus_message *msg, void *user_data)
 	builder = l_dbus_message_builder_new(msg);
 
 	l_dbus_message_builder_append_basic(builder, 'o', app.path);
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	for (i = 0; i < L_ARRAY_SIZE(app.uuid); i++)
-		l_dbus_message_builder_append_basic(builder, 'y',
-								&(app.uuid[i]));
-
-	l_dbus_message_builder_leave_array(builder);
-
+	append_byte_array(builder, app.uuid, 16);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 }
@@ -609,6 +613,476 @@ static void cmd_list_nodes(int argc, char *argv[])
 	remote_print_all();
 }
 
+static void free_generic_request(void *data)
+{
+	struct generic_request *req = data;
+
+	l_free(req->data1);
+	l_free(req->data2);
+	l_free(req);
+}
+
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
+static void cmd_delete_node(int argc, char *argv[])
+{
+	struct generic_request *req;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 3) {
+		bt_shell_printf("Unicast and element count are required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	if (sscanf(argv[2], "%u", &req->arg2) != 1)
+		goto fail;
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "DeleteRemoteNode",
+				delete_node_setup, NULL, req, l_free);
+
+	/* TODO:: Delete node from configuration */
+	return;
+
+fail:
+	l_free(req);
+}
+
+static void import_node_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t primary, net_idx;
+	uint8_t ele_cnt;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to import remote node: %s", name);
+		return;
+	}
+
+	net_idx = (uint16_t) req->arg1;
+	primary = (uint16_t) req->arg2;
+	ele_cnt = (uint8_t) req->arg3;
+
+	remote_add_node(req->data1, primary, ele_cnt, net_idx);
+}
+
+static void import_node_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t primary;
+	uint8_t ele_cnt;
+	struct l_dbus_message_builder *builder;
+
+	primary = (uint16_t) req->arg2;
+	ele_cnt = (uint8_t) req->arg3;
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 'q', &primary);
+	l_dbus_message_builder_append_basic(builder, 'y', &ele_cnt);
+	append_byte_array(builder, req->data2, 16);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void cmd_import_node(int argc, char *argv[])
+{
+	struct generic_request *req;
+	size_t sz;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 6) {
+		bt_shell_printf("UUID, element count and device key");
+		bt_shell_printf("Unicast, element count and device key");
+		bt_shell_printf("are required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	/* Device UUID */
+	req->data1 = l_util_from_hexstring(argv[1], &sz);
+	if (!req->data1 || sz != 16) {
+		l_error("Failed to generate UUID array from %s", argv[1]);
+		goto fail;
+	}
+
+	/* NetKey Index*/
+	if (sscanf(argv[2], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	/* Unicast of the primary element */
+	if (sscanf(argv[3], "%04x", &req->arg2) != 1)
+		goto fail;
+
+	/* Number of elements */
+	if (sscanf(argv[4], "%u", &req->arg3) != 1)
+		return;
+
+	/* DevKey */
+	req->data2 = l_util_from_hexstring(argv[5], &sz);
+	if (!req->data2 || sz != 16) {
+		l_error("Failed to generate DevKey array from %s", argv[5]);
+		goto fail;
+	}
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "ImportRemoteNode",
+					import_node_setup, import_node_reply,
+					req, free_generic_request);
+
+	return;
+
+fail:
+	free_generic_request(req);
+}
+
+static void subnet_set_phase_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to set subnet phase: %s", name);
+	}
+
+	/* TODO: Set key phase in configuration */
+}
+
+static void subnet_set_phase_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t net_idx;
+	uint8_t phase;
+
+	net_idx = (uint16_t) req->arg1;
+	phase = (uint8_t) req->arg2;
+
+	l_dbus_message_set_arguments(msg, "qy", net_idx, phase);
+}
+
+static void cmd_subnet_set_phase(int argc, char *argv[])
+{
+	struct generic_request *req;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 3) {
+		bt_shell_printf("NetKey index and phase are required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	if (sscanf(argv[2], "%d", &req->arg2) != 1)
+		goto fail;
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "SetKeyPhase",
+					subnet_set_phase_setup,
+					subnet_set_phase_reply, req, l_free);
+
+	return;
+
+fail:
+	l_free(req);
+}
+
+static void mgr_key_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t idx = (uint16_t) req->arg1;
+	const char *method = req->str;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Method %s returned error: %s", method, name);
+		return;
+	}
+
+	if (!strcmp("CreateSubnet", method))
+		keys_add_net_key(idx);
+	else if (!strcmp("DeleteSubnet", method))
+		keys_del_net_key(idx);
+	else if (!strcmp("DeleteAppKey", method))
+		keys_del_app_key(idx);
+}
+
+static void mgr_key_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t idx = (uint16_t) req->arg1;
+
+	l_dbus_message_set_arguments(msg, "q", idx);
+}
+
+static void mgr_key_cmd(int argc, char *argv[], const char *method_name)
+{
+	struct generic_request *req;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 2) {
+		bt_shell_printf("Missing required arguments\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1) {
+		l_free(req);
+		return;
+	}
+
+	req->str = method_name;
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, method_name,
+					mgr_key_setup, mgr_key_reply,
+					req, l_free);
+}
+
+static void cmd_delete_appkey(int argc, char *argv[])
+{
+	mgr_key_cmd(argc, argv, "DeleteAppKey");
+}
+
+static void cmd_update_appkey(int argc, char *argv[])
+{
+	mgr_key_cmd(argc, argv, "UpdateAppKey");
+}
+
+static void cmd_delete_subnet(int argc, char *argv[])
+{
+	mgr_key_cmd(argc, argv, "DeleteSubnet");
+}
+
+static void cmd_update_subnet(int argc, char *argv[])
+{
+	mgr_key_cmd(argc, argv, "UpdateSubnet");
+}
+
+static void cmd_create_subnet(int argc, char *argv[])
+{
+	mgr_key_cmd(argc, argv, "CreateSubnet");
+}
+
+static void add_key_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t net_idx, app_idx;
+	const char *method = req->str;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("%s failed: %s", method, name);
+		return;
+	}
+
+	net_idx = (uint16_t) req->arg1;
+
+	if (!strcmp(method, "ImportSubnet")) {
+		keys_add_net_key(net_idx);
+		return;
+	}
+
+	app_idx = (uint16_t) req->arg2;
+	keys_add_app_key(net_idx, app_idx);
+}
+
+static void import_appkey_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t net_idx, app_idx;
+	struct l_dbus_message_builder *builder;
+
+	net_idx = (uint16_t) req->arg1;
+	app_idx = (uint16_t) req->arg2;
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 'q', &net_idx);
+	l_dbus_message_builder_append_basic(builder, 'q', &app_idx);
+	append_byte_array(builder, req->data1, 16);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void cmd_import_appkey(int argc, char *argv[])
+{
+	struct generic_request *req;
+	size_t sz;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 4) {
+		bt_shell_printf("Netkey and AppKey indices and");
+		bt_shell_printf("key value are required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	if (sscanf(argv[2], "%04x", &req->arg2) != 1)
+		goto fail;
+
+	req->data1 = l_util_from_hexstring(argv[3], &sz);
+	if (!req->data1 || sz != 16) {
+		l_error("Failed to generate key array from %s", argv[3]);
+		goto fail;
+	}
+
+	req->str = "ImportAppKey";
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "ImportAppKey",
+					import_appkey_setup, add_key_reply,
+					req, free_generic_request);
+
+	return;
+
+fail:
+	free_generic_request(req);
+}
+
+static void import_subnet_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t net_idx;
+	struct l_dbus_message_builder *builder;
+
+	net_idx = (uint16_t) req->arg1;
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 'q', &net_idx);
+	append_byte_array(builder, req->data1, 16);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void cmd_import_subnet(int argc, char *argv[])
+{
+	struct generic_request *req;
+	size_t sz;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 3) {
+		bt_shell_printf("NetKey index and value are required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	req->data1 = l_util_from_hexstring(argv[2], &sz);
+	if (!req->data1 || sz != 16) {
+		l_error("Failed to generate key array from %s", argv[2]);
+		goto fail;
+	}
+
+	req->str = "ImportSubnet";
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "ImportSubnet",
+					import_subnet_setup, add_key_reply,
+					req, free_generic_request);
+	return;
+
+fail:
+	free_generic_request(req);
+}
+
+static void create_appkey_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct generic_request *req = user_data;
+	uint16_t net_idx, app_idx;
+
+	net_idx = (uint16_t) req->arg1;
+	app_idx = (uint16_t) req->arg2;
+
+	l_dbus_message_set_arguments(msg, "qq", net_idx, app_idx);
+}
+
+static void cmd_create_appkey(int argc, char *argv[])
+{
+	struct generic_request *req;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (argc < 3) {
+		bt_shell_printf("AppKey index is required\n");
+		return;
+	}
+
+	req = l_new(struct generic_request, 1);
+
+	if (sscanf(argv[1], "%04x", &req->arg1) != 1)
+		goto fail;
+
+	if (sscanf(argv[2], "%04x", &req->arg2) != 1)
+		goto fail;
+
+	req->str = "CreateAppKey";
+
+	l_dbus_proxy_method_call(local->mgmt_proxy, "CreateAppKey",
+					create_appkey_setup, add_key_reply,
+					req, l_free);
+	return;
+
+fail:
+	l_free(req);
+}
+
 static void add_node_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *msg, void *user_data)
 {
@@ -626,7 +1100,6 @@ static void add_node_reply(struct l_dbus_proxy *proxy,
 
 static void add_node_setup(struct l_dbus_message *msg, void *user_data)
 {
-	int i;
 	char *str = user_data;
 	size_t sz;
 	unsigned char *uuid;
@@ -639,14 +1112,7 @@ static void add_node_setup(struct l_dbus_message *msg, void *user_data)
 	}
 
 	builder = l_dbus_message_builder_new(msg);
-
-	l_dbus_message_builder_enter_array(builder, "y");
-
-	for (i = 0; i < (int)sz; i++)
-		l_dbus_message_builder_append_basic(builder, 'y', &(uuid[i]));
-
-	l_dbus_message_builder_leave_array(builder);
-
+	append_byte_array(builder, uuid, 16);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
@@ -683,10 +1149,33 @@ static const struct bt_shell_menu main_menu = {
 			"Create new mesh network with one initial node" },
 	{ "discover-unprovisioned", "<on/off> [seconds]", cmd_scan_unprov,
 			"Look for devices to provision" },
+	{ "appkey-create", "<net_idx> <app_idx>", cmd_create_appkey,
+			"Create a new local AppKey" },
+	{ "appkey-import", "<net_idx> <app_idx> <key>", cmd_import_appkey,
+			"Import a new local AppKey" },
+	{ "appkey-update", "<app_idx>", cmd_update_appkey,
+			"Update local AppKey" },
+	{ "appkey-delete", "<app_idx>", cmd_delete_appkey,
+			"Delete local AppKey" },
+	{ "subnet-create", "<net_idx>", cmd_create_subnet,
+			"Create a new local subnet (NetKey)" },
+	{ "subnet-import", "<net_idx> <key>", cmd_import_subnet,
+			"Import a new local subnet (NetKey)" },
+	{ "subnet-update", "<net_idx>", cmd_update_subnet,
+			"Update local subnet (NetKey)" },
+	{ "subnet-delete", "<net_idx>", cmd_delete_subnet,
+			"Delete local subnet (NetKey)" },
+	{ "subnet-set-phase", "<net_idx> <phase>", cmd_subnet_set_phase,
+			"Set subnet (NetKey) phase" },
 	{ "list-unprovisioned", NULL, cmd_list_unprov,
 			"List unprovisioned devices" },
 	{ "provision", "<uuid>", cmd_start_prov,
 			"Initiate provisioning"},
+	{ "node-import", "<uuid> <net_idx> <primary> <ele_count> <dev_key>",
+			cmd_import_node,
+			"Import an externally provisioned remote node"},
+	{ "node-delete", "<primary> <ele_count>", cmd_delete_node,
+			"Delete a remote node"},
 	{ "list-nodes", NULL, cmd_list_nodes,
 			"List remote mesh nodes"},
 	{ } },
-- 
2.21.0

