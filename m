Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64792CA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19273217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKAS5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:29987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833787"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 09/10 v2] tools/mesh: add initial support for config storage
Date:   Fri,  1 Nov 2019 11:57:28 -0700
Message-Id: <20191101185729.31661-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for storing the state of a mesh network.
The configuration is written out in JSON format. The initial
configuration file is generated automatically upon the
successful completion of "create" command form the main menu.
---
 Makefile.tools         |   7 +-
 tools/mesh-cfgclient.c | 161 +++++++-
 tools/mesh/cfgcli.c    |  34 +-
 tools/mesh/keys.c      |  13 +-
 tools/mesh/mesh-db.c   | 899 +++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h   |  54 +++
 tools/mesh/remote.c    | 168 +++++++-
 tools/mesh/remote.h    |  14 +-
 8 files changed, 1307 insertions(+), 43 deletions(-)
 create mode 100644 tools/mesh/mesh-db.c
 create mode 100644 tools/mesh/mesh-db.h

diff --git a/Makefile.tools b/Makefile.tools
index 0b4ddf576..006554cf7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -333,10 +333,13 @@ tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
 				tools/mesh/keys.h tools/mesh/keys.c \
 				tools/mesh/util.h tools/mesh/util.c \
 				tools/mesh/remote.h tools/mesh/remote.c \
-				tools/mesh/agent.h tools/mesh/agent.c
+				tools/mesh/agent.h tools/mesh/agent.c \
+				tools/mesh/mesh-db.h tools/mesh/mesh-db.c \
+				mesh/util.h mesh/util.c \
+				mesh/mesh-config.h mesh/mesh-config-json.c
 
 tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
-						$(ell_ldadd) -lreadline
+						$(ell_ldadd) -ljson-c -lreadline
 endif
 
 EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 65a5356a7..444b9e5aa 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -42,6 +42,7 @@
 #include "tools/mesh/agent.h"
 #include "tools/mesh/cfgcli.h"
 #include "tools/mesh/keys.h"
+#include "tools/mesh/mesh-db.h"
 #include "tools/mesh/model.h"
 #include "tools/mesh/remote.h"
 
@@ -54,6 +55,7 @@
 #define UNPROV_SCAN_MAX_SECS	300
 
 #define DEFAULT_START_ADDRESS	0x00aa
+#define DEFAULT_MAX_ADDRESS	(VIRTUAL_ADDRESS_LOW - 1)
 #define DEFAULT_NET_INDEX	0x0000
 
 #define DEFAULT_CFG_FILE	"config_db.json"
@@ -129,23 +131,27 @@ static struct meshcfg_app app = {
 };
 
 static const struct option options[] = {
-	{ "config",	required_argument, 0, 'c' },
-	{ "address",	required_argument, 0, 'a' },
-	{ "net-index",	required_argument, 0, 'n' },
+	{ "config",		required_argument, 0, 'c' },
+	{ "address-start",	required_argument, 0, 'a' },
+	{ "address-range",	required_argument, 0, 'r' },
+	{ "net-index",		required_argument, 0, 'n' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *address_opt;
+static const char *range_opt;
 static const char *net_idx_opt;
 static const char *config_opt;
 
-static uint16_t prov_address;
+static uint16_t low_addr;
+static uint16_t high_addr;
 static uint16_t prov_net_idx;
 static const char *cfg_fname;
 
 static const char **optargs[] = {
 	&config_opt,
 	&address_opt,
+	&range_opt,
 	&net_idx_opt,
 };
 
@@ -249,6 +255,7 @@ static void send_msg_setup(struct l_dbus_message *msg, void *user_data)
 	l_dbus_message_builder_append_basic(builder, 'q', &req->dst);
 	if (req->is_dev_key)
 		l_dbus_message_builder_append_basic(builder, 'b', &req->rmt);
+
 	l_dbus_message_builder_append_basic(builder, 'q', &req->idx);
 	append_byte_array(builder, req->data, req->len);
 	l_dbus_message_builder_finalize(builder);
@@ -531,8 +538,19 @@ static void create_net_reply(struct l_dbus_proxy *proxy,
 	bt_shell_printf("Created new node with token %s\n", str);
 	l_free(str);
 
-	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+	if (!mesh_db_create(cfg_fname, local->token.u8,
+						"Mesh Config Client Network")) {
+		l_free(local);
+		local = NULL;
+		return;
+	}
+
+	mesh_db_set_addr_range(low_addr, high_addr);
 	keys_add_net_key(PRIMARY_NET_IDX);
+	mesh_db_net_key_add(PRIMARY_NET_IDX);
+
+	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
 
 	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
 						attach_node_reply, NULL,
@@ -556,6 +574,11 @@ static void create_net_setup(struct l_dbus_message *msg, void *user_data)
 
 static void cmd_create_network(int argc, char *argv[])
 {
+	if (have_config) {
+		l_error("Mesh network configuration exists (%s)", cfg_fname);
+		return;
+	}
+
 	l_dbus_proxy_method_call(net_proxy, "CreateNetwork", create_net_setup,
 						create_net_reply, NULL,
 						NULL);
@@ -626,6 +649,11 @@ static void cmd_list_nodes(int argc, char *argv[])
 	remote_print_all();
 }
 
+static void cmd_keys(int argc, char *argv[])
+{
+	keys_print_keys();
+}
+
 static void free_generic_request(void *data)
 {
 	struct generic_request *req = data;
@@ -846,12 +874,16 @@ static void mgr_key_reply(struct l_dbus_proxy *proxy,
 		return;
 	}
 
-	if (!strcmp("CreateSubnet", method))
+	if (!strcmp("CreateSubnet", method)) {
 		keys_add_net_key(idx);
-	else if (!strcmp("DeleteSubnet", method))
+		mesh_db_net_key_add(idx);
+	} else if (!strcmp("DeleteSubnet", method)) {
 		keys_del_net_key(idx);
-	else if (!strcmp("DeleteAppKey", method))
+		mesh_db_net_key_del(idx);
+	} else if (!strcmp("DeleteAppKey", method)) {
 		keys_del_app_key(idx);
+		mesh_db_app_key_del(idx);
+	}
 }
 
 static void mgr_key_setup(struct l_dbus_message *msg, void *user_data)
@@ -934,11 +966,13 @@ static void add_key_reply(struct l_dbus_proxy *proxy,
 
 	if (!strcmp(method, "ImportSubnet")) {
 		keys_add_net_key(net_idx);
+		mesh_db_net_key_add(net_idx);
 		return;
 	}
 
 	app_idx = (uint16_t) req->arg2;
 	keys_add_app_key(net_idx, app_idx);
+	mesh_db_app_key_add(net_idx, app_idx);
 }
 
 static void import_appkey_setup(struct l_dbus_message *msg, void *user_data)
@@ -1158,7 +1192,7 @@ static void cmd_start_prov(int argc, char *argv[])
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
-	{ "create", NULL, cmd_create_network,
+	{ "create", "[unicast_range_low]", cmd_create_network,
 			"Create new mesh network with one initial node" },
 	{ "discover-unprovisioned", "<on/off> [seconds]", cmd_scan_unprov,
 			"Look for devices to provision" },
@@ -1191,6 +1225,8 @@ static const struct bt_shell_menu main_menu = {
 			"Delete a remote node"},
 	{ "list-nodes", NULL, cmd_list_nodes,
 			"List remote mesh nodes"},
+	{ "keys", NULL, cmd_keys,
+			"List available keys"},
 	{ } },
 };
 
@@ -1203,6 +1239,16 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 	if (!strcmp(interface, MESH_NETWORK_INTERFACE)) {
 		net_proxy = proxy;
+
+		/*
+		 * If mesh network configuration has been read from
+		 * storage, attach the provisioner/config-client node.
+		 */
+		if (local)
+			l_dbus_proxy_method_call(net_proxy, "Attach",
+						attach_node_setup,
+						attach_node_reply, NULL,
+						NULL);
 		return;
 	}
 
@@ -1387,6 +1433,7 @@ static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	uint8_t cnt;
+	uint16_t unicast;
 	struct l_dbus_message *reply;
 
 	if (!l_dbus_message_get_arguments(msg, "y", &cnt)) {
@@ -1395,10 +1442,19 @@ static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
 
 	}
 
+	unicast = remote_get_next_unicast(low_addr, high_addr, cnt);
+
+	if (unicast == 0) {
+		l_error("Failed to allocate addresses for %u elements\n", cnt);
+		return l_dbus_message_new_error(msg,
+					"org.freedesktop.DBus.Error."
+					"Failed to allocate address", NULL);
+	}
+
 	bt_shell_printf("Assign addresses for %u elements\n", cnt);
-	reply = l_dbus_message_new_method_return(msg);
 
-	l_dbus_message_set_arguments(reply, "qq", prov_net_idx, prov_address);
+	reply = l_dbus_message_new_method_return(msg);
+	l_dbus_message_set_arguments(reply, "qq", prov_net_idx, unicast);
 
 	return reply;
 }
@@ -1445,7 +1501,8 @@ static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
 
 	remove_device(uuid);
 
-	prov_address = unicast + cnt;
+	if (!mesh_db_add_node(uuid, cnt, unicast, prov_net_idx))
+		l_error("Failed to store new remote node");
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -1659,7 +1716,21 @@ static bool setup_cfg_storage(void)
 		if (!mesh_dir)
 			return false;
 
-		cfg_fname = l_strdup_printf("mesh_dir/%s", DEFAULT_CFG_FILE);
+		if (stat(mesh_dir, &st) == 0) {
+			if (!S_ISDIR(st.st_mode)) {
+				l_error("%s not a directory", mesh_dir);
+				return false;
+			}
+		} else if (errno == ENOENT) {
+			if (mkdir(mesh_dir, 0700) != 0)
+				return false;
+		} else {
+			perror("Cannot open config directory");
+			return false;
+		}
+
+		cfg_fname = l_strdup_printf("%s/%s", mesh_dir,
+							DEFAULT_CFG_FILE);
 		l_free(mesh_dir);
 
 	} else {
@@ -1681,6 +1752,35 @@ static bool setup_cfg_storage(void)
 	return true;
 }
 
+static bool read_mesh_config(void)
+{
+	uint16_t range_l, range_h;
+
+	if (!mesh_db_load(cfg_fname)) {
+		l_error("Failed to load config from %s", cfg_fname);
+		return false;
+	}
+
+	local = l_new(struct meshcfg_node, 1);
+
+	if (!mesh_db_get_token(local->token.u8)) {
+		l_error("Failed to read the provisioner's token ID");
+		l_error("Check config file %s", cfg_fname);
+		l_free(local);
+		local = NULL;
+
+		return false;
+	}
+
+	l_info("Mesh configuration loaded from %s", cfg_fname);
+	if (mesh_db_get_addr_range(&range_l, &range_h)) {
+		low_addr = range_l;
+		high_addr = range_h;
+	}
+
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	struct l_dbus_client *client;
@@ -1689,14 +1789,34 @@ int main(int argc, char *argv[])
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
-	bt_shell_set_prompt(PROMPT_OFF);
 
 	l_log_set_stderr();
 
 	if (address_opt && sscanf(address_opt, "%04x", &val) == 1)
-		prov_address = (uint16_t) val;
-	else
-		prov_address = DEFAULT_START_ADDRESS;
+		low_addr = (uint16_t) val;
+
+	if (low_addr > DEFAULT_MAX_ADDRESS) {
+		l_error("Invalid start address");
+			bt_shell_cleanup();
+			return EXIT_FAILURE;
+	}
+
+	if (!low_addr)
+		low_addr = DEFAULT_START_ADDRESS;
+
+	if (range_opt && sscanf(address_opt, "%04x", &val) == 1) {
+		if (val == 0) {
+			l_error("Invalid address range");
+			bt_shell_cleanup();
+			return EXIT_FAILURE;
+		}
+
+		/* Inclusive */
+		high_addr = low_addr + val - 1;
+	}
+
+	if (!high_addr || high_addr > DEFAULT_MAX_ADDRESS)
+		high_addr = DEFAULT_MAX_ADDRESS;
 
 	if (net_idx_opt && sscanf(net_idx_opt, "%04x", &val) == 1)
 		prov_net_idx = (uint16_t) val;
@@ -1708,6 +1828,13 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (have_config && !read_mesh_config()) {
+		bt_shell_cleanup();
+		return EXIT_FAILURE;
+	}
+
+	bt_shell_set_prompt(PROMPT_OFF);
+
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 
 	l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 8d6a0ffee..086998910 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -35,6 +35,7 @@
 #include "tools/mesh/util.h"
 #include "tools/mesh/model.h"
 #include "tools/mesh/keys.h"
+#include "tools/mesh/mesh-db.h"
 #include "tools/mesh/remote.h"
 #include "tools/mesh/config-model.h"
 #include "tools/mesh/cfgcli.h"
@@ -340,6 +341,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 							uint16_t len)
 {
 	uint32_t opcode;
+	const struct cfg_cmd *cmd;
 	uint16_t app_idx, net_idx, addr;
 	uint16_t ele_addr;
 	uint32_t mod_id;
@@ -358,9 +360,11 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	req = get_req_by_rsp(src, (opcode & ~OP_UNRELIABLE));
 	if (req) {
+		cmd = req->cmd;
 		free_request(req);
 		l_queue_remove(requests, req);
-	}
+	} else
+		cmd = NULL;
 
 	switch (opcode & ~OP_UNRELIABLE) {
 	default:
@@ -386,6 +390,20 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("NetKey\t%3.3x\n", net_idx);
 		bt_shell_printf("AppKey\t%3.3x\n", app_idx);
 
+		if (data[0] != MESH_STATUS_SUCCESS)
+			break;
+
+		if (!cmd)
+			break;
+
+		if (cmd->opcode == OP_APPKEY_ADD) {
+			if (remote_add_app_key(src, app_idx))
+				mesh_db_node_app_key_add(src, app_idx);
+		} else if (cmd->opcode == OP_APPKEY_DELETE) {
+			if (remote_del_app_key(src, app_idx))
+				mesh_db_node_app_key_del(src, app_idx);
+		}
+
 		break;
 
 	case OP_NETKEY_STATUS:
@@ -398,6 +416,20 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
 
+		if (data[0] != MESH_STATUS_SUCCESS)
+			break;
+
+		if (!cmd)
+			break;
+
+		if (cmd->opcode == OP_NETKEY_ADD) {
+			if (remote_add_net_key(src, net_idx))
+				mesh_db_node_net_key_add(src, net_idx);
+		} else if (cmd->opcode == OP_NETKEY_DELETE) {
+			if (remote_del_net_key(src, net_idx))
+				mesh_db_node_net_key_del(src, net_idx);
+		}
+
 		break;
 
 	case OP_MODEL_APP_STATUS:
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index 3c887b319..7d2058294 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -26,6 +26,8 @@
 
 #include "src/shared/shell.h"
 #include "mesh/mesh-defs.h"
+
+#include "tools/mesh/mesh-db.h"
 #include "tools/mesh/keys.h"
 
 struct net_key {
@@ -48,6 +50,13 @@ static bool net_idx_match(const void *a, const void *b)
 	return key->idx == idx;
 }
 
+static void delete_bound_appkey(void *a)
+{
+	uint32_t idx = L_PTR_TO_UINT(a);
+
+	mesh_db_app_key_del(idx);
+}
+
 void keys_add_net_key(uint16_t net_idx)
 {
 	struct net_key *key;
@@ -75,7 +84,7 @@ void keys_del_net_key(uint16_t idx)
 	if (!key)
 		return;
 
-	l_queue_destroy(key->app_keys, NULL);
+	l_queue_destroy(key->app_keys, delete_bound_appkey);
 	l_free(key);
 }
 
@@ -143,7 +152,7 @@ static void print_appkey(void *app_key, void *user_data)
 {
 	uint16_t app_idx = L_PTR_TO_UINT(app_key);
 
-	bt_shell_printf("%3.3x ", app_idx);
+	bt_shell_printf("%3.3x, ", app_idx);
 }
 
 static void print_netkey(void *net_key, void *user_data)
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
new file mode 100644
index 000000000..8f5cd186f
--- /dev/null
+++ b/tools/mesh/mesh-db.c
@@ -0,0 +1,899 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <ftw.h>
+#include <libgen.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/time.h>
+
+#include <ell/ell.h>
+#include <json-c/json.h>
+
+#include "mesh/mesh-defs.h"
+#include "mesh/util.h"
+
+#include "tools/mesh/keys.h"
+#include "tools/mesh/remote.h"
+#include "tools/mesh/mesh-db.h"
+
+#define KEY_IDX_INVALID NET_IDX_INVALID
+
+struct mesh_db {
+	json_object *jcfg;
+	char *cfg_fname;
+	uint8_t token[8];
+	uint8_t pad[12];
+	struct timeval write_time;
+};
+
+struct mesh_db *cfg;
+
+static json_object *get_node_by_unicast(uint16_t unicast)
+{
+	json_object *jarray;
+	int i, sz;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "nodes", &jarray))
+		return NULL;
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return NULL;
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
+			return NULL;
+
+		str = json_object_get_string(jval);
+		if (sscanf(str, "%04hx", &addr) != 1)
+			continue;
+
+		if (addr == unicast)
+			return jentry;
+	}
+
+	return NULL;
+}
+
+static json_object *get_key_object(json_object *jarray, uint16_t idx)
+{
+	int i, sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry, *jval;
+		const char *str;
+		uint16_t jidx;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			return NULL;
+
+		str = json_object_get_string(jval);
+		if (sscanf(str, "%04hx", &jidx) != 1)
+			return NULL;
+
+		if (jidx == idx)
+			return jentry;
+	}
+
+	return NULL;
+}
+
+static bool write_int(json_object *jobj, const char *keyword, int val)
+{
+	json_object *jval;
+
+	json_object_object_del(jobj, keyword);
+
+	jval = json_object_new_int(val);
+	if (!jval)
+		return false;
+
+	json_object_object_add(jobj, keyword, jval);
+	return true;
+}
+
+static bool write_uint16_hex(json_object *jobj, const char *desc,
+								uint16_t value)
+{
+	json_object *jstring;
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", value);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
+static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
+{
+	json_object *jarray = NULL;
+	char buf[33];
+	int i, sz;
+
+	hex2str(uuid, 16, buf, sizeof(buf));
+
+	json_object_object_get_ex(jcfg, "nodes", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return NULL;
+
+	sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry, *jval;
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "uuid", &jval))
+			return NULL;
+
+		str = json_object_get_string(jval);
+		if (strlen(str) != 32)
+			continue;
+
+		if (!strcmp(buf, str))
+			return jentry;
+	}
+
+	return NULL;
+}
+
+static bool add_u8_8(json_object *jobj, const uint8_t value[8],
+							const char *desc)
+{
+	json_object *jstring;
+	char buf[17];
+
+	hex2str((uint8_t *) value, 8, buf, 17);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
+static bool add_u8_16(json_object *jobj, const uint8_t value[16],
+							const char *desc)
+{
+	json_object *jstring;
+	char buf[33];
+
+	hex2str((uint8_t *) value, 16, buf, 33);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
+static bool add_string(json_object *jobj, const char *str, const char *desc)
+{
+	json_object *jstring = json_object_new_string(str);
+
+	if (!jstring)
+		return false;
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
+static bool get_token(json_object *jobj, uint8_t token[8])
+{
+	json_object *jval;
+	const char *str;
+
+	if (!token)
+		return false;
+
+	if (!json_object_object_get_ex(jobj, "token", &jval))
+		return false;
+
+	str = json_object_get_string(jval);
+	if (!str2hex(str, strlen(str), token, 8))
+		return false;
+
+	return true;
+}
+
+static uint16_t node_parse_key(json_object *jarray, int i)
+{
+	json_object *jkey, *jval;
+	const char *str;
+	uint16_t idx;
+
+	jkey = json_object_array_get_idx(jarray, i);
+	if (!jkey)
+		return KEY_IDX_INVALID;
+
+	if (!json_object_object_get_ex(jkey, "index", &jval))
+		return KEY_IDX_INVALID;
+
+	str = json_object_get_string(jval);
+	if (sscanf(str, "%04hx", &idx) != 1)
+		return KEY_IDX_INVALID;
+
+	return idx;
+}
+
+static void load_remotes(json_object *jcfg)
+{
+	json_object *jnodes;
+	int i, sz, node_count = 0;
+
+	json_object_object_get_ex(jcfg, "nodes", &jnodes);
+	if (!jnodes || json_object_get_type(jnodes) != json_type_array)
+		return;
+
+	sz = json_object_array_length(jnodes);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jnode, *jval, *jarray;
+		uint8_t uuid[16];
+		uint16_t unicast, key_idx;
+		const char *str;
+		int ele_cnt, key_cnt;
+		int j;
+
+		jnode = json_object_array_get_idx(jnodes, i);
+		if (!jnode)
+			continue;
+
+		if (!json_object_object_get_ex(jnode, "uuid", &jval))
+			continue;
+
+		str = json_object_get_string(jval);
+		if (strlen(str) != 32)
+			continue;
+
+		str2hex(str, 32, uuid, 16);
+
+		if (!json_object_object_get_ex(jnode, "unicastAddress", &jval))
+			continue;
+
+		str = json_object_get_string(jval);
+		if (sscanf(str, "%04hx", &unicast) != 1)
+			continue;
+
+		json_object_object_get_ex(jnode, "elements", &jarray);
+		if (!jarray || json_object_get_type(jarray) != json_type_array)
+			continue;
+
+		ele_cnt = json_object_array_length(jarray);
+
+		if (ele_cnt > MAX_ELE_COUNT)
+			continue;
+
+		json_object_object_get_ex(jnode, "netKeys", &jarray);
+		if (!jarray || json_object_get_type(jarray) != json_type_array)
+			continue;
+
+		key_cnt = json_object_array_length(jarray);
+		if (key_cnt < 0)
+			continue;
+
+		key_idx = node_parse_key(jarray, 0);
+		if (key_idx == KEY_IDX_INVALID)
+			continue;
+
+		remote_add_node((const uint8_t *)uuid, unicast, ele_cnt,
+								key_idx);
+		for (j = 1; j < key_cnt; j++) {
+			key_idx = node_parse_key(jarray, j);
+
+			if (key_idx != KEY_IDX_INVALID)
+				remote_add_net_key(unicast, key_idx);
+		}
+
+		json_object_object_get_ex(jnode, "appKeys", &jarray);
+		if (!jarray || json_object_get_type(jarray) != json_type_array)
+			continue;
+
+		key_cnt = json_object_array_length(jarray);
+
+		for (j = 0; j < key_cnt; j++) {
+			key_idx = node_parse_key(jarray, j);
+
+			if (key_idx != KEY_IDX_INVALID)
+				remote_add_app_key(unicast, key_idx);
+		}
+
+		node_count++;
+
+		/* TODO: Add the rest of the configuration */
+	}
+
+	if (node_count != sz)
+		l_warn("The remote node configuration load is incomplete!");
+
+}
+
+static bool add_app_key(json_object *jobj, uint16_t net_idx, uint16_t app_idx)
+{
+	json_object *jval, *jkey, *jarray;
+	char buf[5];
+
+	json_object_object_get_ex(jobj, "appKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jkey = json_object_new_object();
+
+	snprintf(buf, 5, "%4.4x", net_idx);
+	jval = json_object_new_string(buf);
+	if (!jval)
+		goto fail;
+
+	json_object_object_add(jkey, "boundNetKey", jval);
+
+	snprintf(buf, 5, "%4.4x", app_idx);
+	jval = json_object_new_string(buf);
+	if (!jval)
+		goto fail;
+
+	json_object_object_add(jkey, "index", jval);
+
+	json_object_array_add(jarray, jkey);
+
+	return true;
+fail:
+	json_object_put(jkey);
+	return false;
+}
+
+static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
+{
+	json_object *jval, *jkey, *jarray;
+	char buf[5];
+
+	json_object_object_get_ex(jobj, desc, &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jkey = json_object_new_object();
+
+	snprintf(buf, 5, "%4.4x", idx);
+
+	jval = json_object_new_string(buf);
+	if (!jval) {
+		json_object_put(jkey);
+		return false;
+	}
+
+	json_object_object_add(jkey, "index", jval);
+	json_object_array_add(jarray, jkey);
+
+	return mesh_config_save((struct mesh_config *) cfg, true,
+								NULL, NULL);
+}
+
+bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	return add_node_key(jnode, "netKeys", idx);
+}
+
+static json_object *jarray_key_del(json_object *jarray, int16_t idx)
+{
+	json_object *jarray_new;
+	int i, sz = json_object_array_length(jarray);
+
+	jarray_new = json_object_new_array();
+	if (!jarray_new)
+		return NULL;
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry, *jval;
+		uint16_t val;
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			goto fail;
+
+		str = json_object_get_string(jval);
+
+		if (sscanf(str, "%04hx", &val) != 1)
+			goto fail;
+
+		if (val == idx)
+			continue;
+
+		json_object_get(jentry);
+		json_object_array_add(jarray_new, jentry);
+	}
+
+	return jarray_new;
+fail:
+	json_object_put(jarray_new);
+	return NULL;
+}
+
+static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
+{
+	json_object *jarray, *jarray_new;
+
+	if (!json_object_object_get_ex(jobj, desc, &jarray))
+		return true;
+
+	/* Check if matching entry exists */
+	if (!get_key_object(jarray, idx))
+		return true;
+
+	/*
+	 * There is no easy way to delete a value from a json array.
+	 * Create a new copy without specified element and
+	 * then remove old array.
+	 */
+	jarray_new = jarray_key_del(jarray, idx);
+	if (!jarray_new)
+		return false;
+
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jarray_new);
+
+	return mesh_config_save((struct mesh_config *) cfg, true,
+								NULL, NULL);
+}
+
+bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	return delete_key(jnode, "netKeys", net_idx);
+}
+
+bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	return add_node_key(jnode, "appKeys", idx);
+}
+
+bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	return delete_key(jnode, "appKeys", idx);
+}
+
+static bool load_keys(json_object *jobj)
+{
+	json_object *jarray, *jentry, *jval;
+	uint16_t net_idx, app_idx;
+	int i, key_cnt;
+
+	json_object_object_get_ex(jobj, "netKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	key_cnt = json_object_array_length(jarray);
+	if (key_cnt < 0)
+		return false;
+
+	for (i = 0; i < key_cnt; ++i) {
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			return false;
+
+		str = json_object_get_string(jval);
+
+		if (sscanf(str, "%04hx", &net_idx) != 1)
+			return false;
+
+		keys_add_net_key(net_idx);
+	}
+
+	json_object_object_get_ex(jobj, "appKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	key_cnt = json_object_array_length(jarray);
+	if (key_cnt < 0)
+		return false;
+
+	for (i = 0; i < key_cnt; ++i) {
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!json_object_object_get_ex(jentry, "boundNetKey", &jval))
+			return false;
+
+		str = json_object_get_string(jval);
+
+		if (sscanf(str, "%04hx", &net_idx) != 1)
+			return false;
+
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			return false;
+
+		str = json_object_get_string(jval);
+
+		if (sscanf(str, "%04hx", &app_idx) != 1)
+			return false;
+		keys_add_app_key(net_idx, app_idx);
+	}
+
+	return true;
+}
+
+bool mesh_db_net_key_add(uint16_t net_idx)
+{
+	json_object *jval, *jkey, *jarray;
+	char buf[5];
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	json_object_object_get_ex(cfg->jcfg, "netKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	if (get_key_object(jarray, net_idx))
+		return true;
+
+	jkey = json_object_new_object();
+
+	snprintf(buf, 5, "%4.4x", net_idx);
+
+	jval = json_object_new_string(buf);
+	if (!jval)
+		goto fail;
+
+	json_object_object_add(jkey, "index", jval);
+
+	jval = json_object_new_int(KEY_REFRESH_PHASE_NONE);
+	if (!jval)
+		goto fail;
+
+	json_object_object_add(jkey, "phase", jval);
+	json_object_array_add(jarray, jkey);
+
+	return mesh_config_save((struct mesh_config *) cfg, true,
+								NULL, NULL);
+fail:
+	json_object_put(jkey);
+	return false;
+}
+
+bool mesh_db_net_key_del(uint16_t net_idx)
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	return delete_key(cfg->jcfg, "netKeys", net_idx);
+}
+
+bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (!add_app_key(cfg->jcfg, net_idx, app_idx))
+		return false;
+
+	return mesh_config_save((struct mesh_config *) cfg, true,
+								NULL, NULL);
+}
+
+bool mesh_db_app_key_del(uint16_t app_idx)
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	return delete_key(cfg->jcfg, "appKeys", app_idx);
+}
+
+bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
+							uint16_t net_idx)
+{
+	json_object *jnode;
+	json_object *jelements, *jnodes, *jnetkeys, *jappkeys;
+	int i;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_uuid(cfg->jcfg, uuid);
+	if (jnode) {
+		l_error("Node already exists");
+		return false;
+	}
+
+	jnode = json_object_new_object();
+	if (!jnode)
+		return false;
+
+	if (!add_u8_16(jnode, uuid, "uuid"))
+		goto fail;
+
+	jelements = json_object_new_array();
+	if (!jelements)
+		goto fail;
+
+	for (i = 0; i < num_els; ++i) {
+		json_object *jelement = json_object_new_object();
+
+		if (!jelement) {
+			json_object_put(jelements);
+			goto fail;
+		}
+
+		write_int(jelement, "elementIndex", i);
+		json_object_array_add(jelements, jelement);
+	}
+
+	json_object_object_add(jnode, "elements", jelements);
+
+	jnetkeys = json_object_new_array();
+	if (!jnetkeys)
+		goto fail;
+
+	json_object_object_add(jnode, "netKeys", jnetkeys);
+
+	if (!add_node_key(jnode, "netKeys", net_idx))
+		goto fail;
+
+	jappkeys = json_object_new_array();
+	if (!jappkeys)
+		goto fail;
+
+	json_object_object_add(jnode, "appKeys", jappkeys);
+
+	if (!write_uint16_hex(jnode, "unicastAddress", unicast))
+		goto fail;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "nodes", &jnodes))
+		goto fail;
+
+	json_object_array_add(jnodes, jnode);
+
+	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
+		goto fail;
+
+	return true;
+
+fail:
+	json_object_put(jnode);
+	return false;
+}
+
+bool mesh_db_get_token(uint8_t token[8])
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	memcpy(token, cfg->token, 8);
+
+	return true;
+}
+
+bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high)
+{
+	json_object *jlow, *jhigh;
+	const char *str;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "low", &jlow) ||
+			!json_object_object_get_ex(cfg->jcfg, "high", &jhigh))
+		return false;
+
+	str = json_object_get_string(jlow);
+	if (sscanf(str, "%04hx", low) != 1)
+		return false;
+
+	str = json_object_get_string(jhigh);
+	if (sscanf(str, "%04hx", high) != 1)
+		return false;
+
+	return true;
+}
+
+bool mesh_db_set_addr_range(uint16_t low, uint16_t high)
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (!write_uint16_hex(cfg->jcfg, "low", low))
+		return false;
+
+	if (!write_uint16_hex(cfg->jcfg, "high", high))
+		return false;
+
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+}
+
+bool mesh_db_create(const char *fname, const uint8_t token[8],
+							const char *mesh_name)
+{
+	json_object *jcfg, *jarray;
+	uint8_t uuid[16];
+
+	if (cfg)
+		return false;
+
+	if (!fname)
+		return false;
+
+	jcfg = json_object_new_object();
+	if (!jcfg)
+		return false;
+
+	cfg = l_new(struct mesh_db, 1);
+	cfg->jcfg = jcfg;
+	cfg->cfg_fname = l_strdup(fname);
+	memcpy(cfg->token, token, 8);
+
+	if (!add_u8_8(jcfg, token, "token"))
+		goto fail;
+
+	l_getrandom(uuid, 16);
+
+	if (!add_u8_16(jcfg, uuid, "uuid"))
+		goto fail;
+
+	if (mesh_name && !add_string(jcfg, mesh_name, "name"))
+		goto fail;
+
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "nodes", jarray);
+
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "netKeys", jarray);
+
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "appKeys", jarray);
+
+	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
+		goto fail;
+
+	return true;
+
+fail:
+	mesh_config_release((struct mesh_config *)cfg);
+	cfg = NULL;
+
+	return false;
+}
+
+bool mesh_db_load(const char *fname)
+{
+	int fd;
+	char *str;
+	struct stat st;
+	ssize_t sz;
+	json_object *jcfg;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	if (fstat(fd, &st) == -1) {
+		close(fd);
+		return false;
+	}
+
+	str = (char *) l_new(char, st.st_size + 1);
+	if (!str) {
+		close(fd);
+		return false;
+	}
+
+	sz = read(fd, str, st.st_size);
+	if (sz != st.st_size) {
+		l_error("Failed to read configuration file %s", fname);
+		return false;
+	}
+
+	jcfg = json_tokener_parse(str);
+
+	close(fd);
+	l_free(str);
+
+	if (!jcfg)
+		return false;
+
+	cfg = l_new(struct mesh_db, 1);
+
+	cfg->jcfg = jcfg;
+	cfg->cfg_fname = l_strdup(fname);
+
+	if (!get_token(jcfg, cfg->token)) {
+		l_error("Configuration file missing token");
+		goto fail;
+	}
+
+	if (!load_keys(jcfg))
+		goto fail;
+
+	load_remotes(jcfg);
+
+	return true;
+fail:
+	mesh_config_release((struct mesh_config *)cfg);
+	cfg = NULL;
+	return false;
+}
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
new file mode 100644
index 000000000..4a7b16ab4
--- /dev/null
+++ b/tools/mesh/mesh-db.h
@@ -0,0 +1,54 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#include "mesh/mesh-config.h"
+
+bool mesh_db_create(const char *fname, const uint8_t token[8],
+							const char *name);
+bool mesh_db_load(const char *fname);
+
+bool mesh_db_get_token(uint8_t token[8]);
+
+bool mesh_db_net_key_add(uint16_t idx);
+bool mesh_db_net_key_del(uint16_t idx);
+bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx);
+bool mesh_db_app_key_del(uint16_t app_idx);
+bool mesh_db_set_addr_range(uint16_t low, uint16_t high);
+bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
+
+bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
+							uint16_t net_idx);
+bool mesh_db_del_node(uint16_t unicast);
+bool mesh_db_node_set_composition(uint16_t unicast, uint16_t cid, uint16_t pid,
+						uint16_t vid, uint16_t crpl,
+						struct mesh_config_modes modes,
+						struct l_queue *elements);
+
+bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
+							uint16_t interval);
+bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl);
+bool mesh_db_node_write_mode(uint16_t unicast, const char *keyword, int value);
+bool mesh_db_node_model_binding_add(uint16_t unicast, uint8_t ele, bool vendor,
+					uint32_t mod_id, uint16_t app_idx);
+bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
+					uint32_t mod_id, uint16_t app_idx);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 46839772f..673c7b0fb 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -27,15 +27,61 @@
 #include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/mesh-db.h"
 #include "tools/mesh/remote.h"
 
+struct remote_node {
+	uint16_t unicast;
+	struct l_queue *net_keys;
+	struct l_queue *app_keys;
+	uint8_t uuid[16];
+	uint8_t num_ele;
+};
+
 static struct l_queue *nodes;
 
-void remote_add_node(const uint8_t uuid[16], uint16_t unicast,
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static int compare_unicast(const void *a, const void *b, void *user_data)
+{
+	const struct remote_node *a_rmt = a;
+	const struct remote_node *b_rmt = b;
+
+	if (a_rmt->unicast < b_rmt->unicast)
+		return -1;
+
+	if (a_rmt->unicast > b_rmt->unicast)
+		return 1;
+
+	return 0;
+}
+
+static bool match_node_addr(const void *a, const void *b)
+{
+	const struct remote_node *rmt = a;
+	uint16_t addr = L_PTR_TO_UINT(b);
+
+	if (addr >= rmt->unicast &&
+				addr <= (rmt->unicast + rmt->num_ele - 1))
+		return true;
+
+	return false;
+}
+
+bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx)
 {
-	struct remote_node *rmt = l_new(struct remote_node, 1);
+	struct remote_node *rmt;
 
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
+	if (rmt)
+		return false;
+
+	rmt = l_new(struct remote_node, 1);
 	memcpy(rmt->uuid, uuid, 16);
 	rmt->unicast = unicast;
 	rmt->num_ele = ele_cnt;
@@ -46,19 +92,76 @@ void remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 	if (!nodes)
 		nodes = l_queue_new();
 
-	l_queue_push_tail(nodes, rmt);
+	l_queue_insert(nodes, rmt, compare_unicast, NULL);
+	return true;
 }
 
-static bool match_node_addr(const void *a, const void *b)
+bool remote_add_net_key(uint16_t addr, uint16_t net_idx)
 {
-	const struct remote_node *rmt = a;
-	uint16_t addr = L_PTR_TO_UINT(b);
+	struct remote_node *rmt;
 
-	if (addr >= rmt->unicast &&
-				addr <= (rmt->unicast + rmt->num_ele - 1))
-		return true;
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
 
-	return false;
+	if (l_queue_find(rmt->net_keys, simple_match, L_UINT_TO_PTR(net_idx)))
+		return false;
+
+	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
+	return true;
+}
+
+bool remote_del_net_key(uint16_t addr, uint16_t net_idx)
+{
+	struct remote_node *rmt;
+	const struct l_queue_entry *l;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	if (!l_queue_remove(rmt->net_keys, L_UINT_TO_PTR(net_idx)))
+		return false;
+
+	for (l = l_queue_get_entries(rmt->app_keys); l; l = l->next) {
+		uint16_t app_idx = (uint16_t) L_PTR_TO_UINT(l->data);
+
+		if (net_idx == keys_get_bound_key(app_idx)) {
+			l_queue_remove(rmt->app_keys, L_UINT_TO_PTR(app_idx));
+			mesh_db_node_app_key_del(rmt->unicast, app_idx);
+		}
+	}
+
+	return true;
+}
+
+bool remote_add_app_key(uint16_t addr, uint16_t app_idx)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	if (!rmt->app_keys)
+		rmt->app_keys = l_queue_new();
+
+	if (l_queue_find(rmt->app_keys, simple_match, L_UINT_TO_PTR(app_idx)))
+		return false;
+
+	l_queue_push_tail(rmt->app_keys, L_UINT_TO_PTR(app_idx));
+	return true;
+}
+
+bool remote_del_app_key(uint16_t addr, uint16_t app_idx)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	return l_queue_remove(rmt->app_keys, L_UINT_TO_PTR(app_idx));
 }
 
 uint16_t remote_get_subnet_idx(uint16_t addr)
@@ -76,11 +179,11 @@ uint16_t remote_get_subnet_idx(uint16_t addr)
 	return (uint16_t) net_idx;
 }
 
-static void print_subnet(void *net_key, void *user_data)
+static void print_key(void *net_key, void *user_data)
 {
 	uint16_t net_idx = L_PTR_TO_UINT(net_key);
 
-	bt_shell_printf("%3.3x ", net_idx);
+	bt_shell_printf("%3.3x, ", net_idx);
 }
 
 static void print_node(void *rmt, void *user_data)
@@ -97,8 +200,14 @@ static void print_node(void *rmt, void *user_data)
 	bt_shell_printf("\t" COLOR_GREEN "elements = %u\n" COLOR_OFF,
 								node->num_ele);
 	bt_shell_printf("\t" COLOR_GREEN "net_keys = ");
-	l_queue_foreach(node->net_keys, print_subnet, NULL);
+	l_queue_foreach(node->net_keys, print_key, NULL);
 	bt_shell_printf("\n" COLOR_OFF);
+
+	if (node->app_keys && !l_queue_isempty(node->app_keys)) {
+		bt_shell_printf("\t" COLOR_GREEN "app_keys = ");
+		l_queue_foreach(node->app_keys, print_key, NULL);
+		bt_shell_printf("\n" COLOR_OFF);
+	}
 }
 
 void remote_print_node(uint16_t addr)
@@ -122,3 +231,36 @@ void remote_print_all(void)
 
 	l_queue_foreach(nodes, print_node, NULL);
 }
+
+uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt)
+{
+	struct remote_node *rmt;
+	const struct l_queue_entry *l;
+	uint16_t addr;
+
+	/* Note: the address space includes both low and high terminal values */
+	if (ele_cnt > (high - low + 1))
+		return 0;
+
+	if (!nodes || l_queue_isempty(nodes))
+		return low;
+
+	addr = low;
+	l = l_queue_get_entries(nodes);
+
+	/* Cycle through the sorted (by unicast) node list */
+	for (; l; l = l->next) {
+		rmt = l->data;
+
+		if (rmt->unicast >= (addr + ele_cnt))
+			return addr;
+
+		if ((rmt->unicast + rmt->num_ele) > addr)
+			addr = rmt->unicast + rmt->num_ele;
+	}
+
+	if ((addr + ele_cnt - 1) <= high)
+		return addr;
+
+	return 0;
+}
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index dce1619c0..f2a6f48dd 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -17,15 +17,13 @@
  *
  */
 
-struct remote_node {
-	uint16_t unicast;
-	struct l_queue *net_keys;
-	uint8_t uuid[16];
-	uint8_t num_ele;
-};
-
-void remote_add_node(const uint8_t uuid[16], uint16_t unicast,
+bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx);
+uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
+bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
+bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
+bool remote_add_app_key(uint16_t addr, uint16_t app_idx);
+bool remote_del_app_key(uint16_t addr, uint16_t app_idx);
 uint16_t remote_get_subnet_idx(uint16_t addr);
 void remote_print_node(uint16_t addr);
 void remote_print_all(void);
-- 
2.21.0

