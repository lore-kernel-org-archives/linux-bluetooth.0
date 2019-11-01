Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C3CA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CD0217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKAS5f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:29978 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5f (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833736"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:33 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 03/10 v2] tools: Add mesh-cfgclient tool
Date:   Fri,  1 Nov 2019 11:57:22 -0700
Message-Id: <20191101185729.31661-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a tool that allows to create  mesh networks
opreating over advertising (PB-ADV) provisioning bearer.
The main commands are:
create - Create new mesh network with one initial node
discover-unprovisioned - Look for devices to provision
list-unprovisioned - List unprovisioned devices
provision - Initiate provisioning
list-nodes - List remote mesh nodes
---
 .gitignore                |    1 +
 Makefile.tools            |   11 +
 tools/mesh-cfgclient.c    | 1238 +++++++++++++++++++++++++++++++++++++
 tools/mesh/cfgcli.c       | 1104 +++++++++++++++++++++++++++++++++
 tools/mesh/cfgcli.h       |   24 +
 tools/mesh/config-model.h |    3 +-
 tools/mesh/keys.c         |  166 +++++
 tools/mesh/keys.h         |   26 +
 tools/mesh/model.h        |   63 ++
 tools/mesh/util.c         |  140 +++++
 tools/mesh/util.h         |   29 +
 11 files changed, 2804 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh-cfgclient.c
 create mode 100644 tools/mesh/cfgcli.c
 create mode 100644 tools/mesh/cfgcli.h
 create mode 100644 tools/mesh/keys.c
 create mode 100644 tools/mesh/keys.h
 create mode 100644 tools/mesh/model.h
 create mode 100644 tools/mesh/util.c
 create mode 100644 tools/mesh/util.h

diff --git a/.gitignore b/.gitignore
index fb02ae024..eabdb273f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -129,6 +129,7 @@ emulator/b1ee
 emulator/hfp
 client/bluetoothctl
 tools/meshctl
+tools/mesh-cfgclient
 mesh/bluetooth-meshd
 
 src/bluetoothd.8
diff --git a/Makefile.tools b/Makefile.tools
index feb2c8550..12687e495 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -324,6 +324,17 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
+
+bin_PROGRAMS +=  tools/mesh-cfgclient
+
+tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
+				tools/mesh/model.h tools/mesh/config-model.h \
+				tools/mesh/cfgcli.h tools/mesh/cfgcli.c \
+				tools/mesh/keys.h tools/mesh/keys.c \
+				tools/mesh/util.h tools/mesh/util.c \
+				tools/mesh/agent.h tools/mesh/agent.c
+tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
+						$(ell_ldadd) -lreadline
 endif
 
 EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
new file mode 100644
index 000000000..24e0a910a
--- /dev/null
+++ b/tools/mesh-cfgclient.c
@@ -0,0 +1,1238 @@
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
+#include <assert.h>
+#include <ctype.h>
+#include <dbus/dbus.h>
+#include <stdio.h>
+#include <time.h>
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+
+#include "mesh/mesh.h"
+#include "mesh/mesh-defs.h"
+
+#include "tools/mesh/agent.h"
+#include "tools/mesh/cfgcli.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/model.h"
+
+#define PROMPT_ON	COLOR_BLUE "[mesh-cfgclient]" COLOR_OFF "# "
+#define PROMPT_OFF	"Waiting to connect to bluetooth-meshd..."
+
+#define CFG_SRV_MODEL	0x0000
+#define CFG_CLI_MODEL	0x0001
+
+#define UNPROV_SCAN_MAX_SECS	300
+
+#define DEFAULT_START_ADDRESS	0x00aa
+#define DEFAULT_NET_INDEX	0x0000
+
+struct meshcfg_el {
+	const char *path;
+	uint8_t index;
+	uint16_t mods[2];
+};
+
+struct meshcfg_app {
+	const char *path;
+	const char *agent_path;
+	struct meshcfg_el ele;
+	uint16_t cid;
+	uint16_t pid;
+	uint16_t vid;
+	uint16_t crpl;
+	uint8_t uuid[16];
+};
+
+struct meshcfg_node {
+	const char *path;
+	struct l_dbus_proxy *proxy;
+	struct l_dbus_proxy *mgmt_proxy;
+	union {
+		uint64_t u64;
+		uint8_t u8[8];
+	} token;
+};
+
+struct unprov_device {
+	time_t last_seen;
+	int16_t rssi;
+	uint8_t uuid[16];
+};
+
+struct remote_node {
+	uint16_t unicast;
+	uint16_t net_idx;
+	uint8_t uuid[16];
+	uint8_t num_ele;
+};
+
+static struct l_dbus *dbus;
+
+static struct l_queue *node_proxies;
+static struct l_dbus_proxy *net_proxy;
+static struct meshcfg_node *local;
+static struct model_info *cfgcli;
+
+static struct l_queue *devices;
+static struct l_queue *nodes;
+
+static bool prov_in_progress;
+static const char *caps[2] = {"out-numeric", "in-numeric"};
+
+static struct meshcfg_app app = {
+	.path = "/mesh/cfgclient",
+	.agent_path = "/mesh/cfgclient/agent",
+	.cid = 0x05f1,
+	.pid = 0x0002,
+	.vid = 0x0001,
+	.crpl = 10,
+	.ele = {
+		.path = "/mesh/cfgclient/ele0",
+		.index = 0,
+		.mods = {CFG_SRV_MODEL, CFG_CLI_MODEL}
+	}
+};
+
+static const struct option options[] = {
+	{ "address",	optional_argument, 0, 'a' },
+	{ "net-index",	optional_argument, 0, 'n' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *address_opt;
+static const char *net_idx_opt;
+
+static uint16_t prov_address;
+static uint16_t prov_net_idx;
+
+static const char **optargs[] = {
+	&address_opt,
+	&net_idx_opt,
+};
+
+static const char *help[] = {
+	"Starting unicast address for remote nodes",
+	"Net index for provisioning subnet"
+};
+
+static const struct bt_shell_opt opt = {
+	.options = options,
+	.optno = sizeof(options) / sizeof(struct option),
+	.optstr = "a:n:",
+	.optarg = optargs,
+	.help = help,
+};
+
+static const char *dbus_err_args = "org.freedesktop.DBus.Error.InvalidArgs";
+static const char *dbus_err_fail = "org.freedesktop.DBus.Error.Failed";
+static const char *dbus_err_support = "org.freedesktop.DBus.Error.NotSupported";
+
+static bool parse_argument_on_off(int argc, char *argv[], bool *value)
+{
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
+		*value = TRUE;
+		return TRUE;
+	}
+
+	if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no")) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
+	return FALSE;
+}
+
+static bool match_device_uuid(const void *a, const void *b)
+{
+	const struct unprov_device *dev = a;
+	const uint8_t *uuid = b;
+
+	return (memcmp(dev->uuid, uuid, 16) == 0);
+}
+
+static void print_device(void *a, void *b)
+{
+	const struct unprov_device *dev = a;
+	struct tm *tm = localtime(&dev->last_seen);
+	char buf[80];
+	char *str;
+
+	assert(strftime(buf, sizeof(buf), "%c", tm));
+
+	str = l_util_hexstring_upper(dev->uuid, sizeof(dev->uuid));
+	bt_shell_printf("UUID: %s, RSSI %d, Seen: %s\n",
+			str, dev->rssi, buf);
+
+	l_free(str);
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
+static uint16_t get_primary_subnet_idx(uint16_t addr)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+
+	if (!rmt) {
+		bt_shell_printf("Net key not found: trying %4.4x\n",
+			PRIMARY_NET_IDX);
+		return prov_net_idx;
+		/*
+		 * TODO: When the remote node recovery from storage is
+		 * implemented, return NET_IDX_INVALID" here.
+		 */
+	}
+
+	return rmt->net_idx;
+}
+
+struct send_data {
+	const char *ele_path;
+	bool rmt;
+	bool is_dev_key;
+	uint16_t dst;
+	uint16_t idx;
+	uint8_t *data;
+	uint16_t len;
+};
+
+struct key_data {
+	const char *ele_path;
+	uint16_t dst;
+	uint16_t idx;
+	uint16_t net_idx;
+	bool update;
+};
+
+static void send_msg_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct send_data *req = user_data;
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(msg);
+
+	l_dbus_message_builder_append_basic(builder, 'o', req->ele_path);
+	l_dbus_message_builder_append_basic(builder, 'q', &req->dst);
+	if (req->is_dev_key)
+		l_dbus_message_builder_append_basic(builder, 'b', &req->rmt);
+	l_dbus_message_builder_append_basic(builder, 'q', &req->idx);
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	while (req->len) {
+		l_dbus_message_builder_append_basic(builder, 'y', req->data);
+		req->data++;
+		req->len--;
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static bool send_msg(void *user_data, uint16_t dst, uint16_t idx,
+						uint8_t *data, uint16_t len)
+{
+	struct send_data *req;
+	uint16_t net_idx_tx = idx;
+	bool is_dev_key;
+	const char *method_name;
+
+	is_dev_key = (idx == APP_IDX_DEV_REMOTE || idx == APP_IDX_DEV_LOCAL);
+	method_name = is_dev_key ? "DevKeySend" : "Send";
+
+	if (is_dev_key) {
+		net_idx_tx = get_primary_subnet_idx(dst);
+		if (net_idx_tx == NET_IDX_INVALID)
+			return false;
+	}
+
+	req = l_new(struct send_data, 1);
+	req->ele_path = user_data;
+	req->dst = dst;
+	req->idx = net_idx_tx;
+	req->data = data;
+	req->len = len;
+	req->rmt = (idx == APP_IDX_DEV_REMOTE);
+	req->is_dev_key = is_dev_key;
+
+	return l_dbus_proxy_method_call(local->proxy, method_name,
+					send_msg_setup, NULL, req, l_free) != 0;
+}
+
+static void send_key_setup(struct l_dbus_message *msg, void *user_data)
+{
+	struct key_data *req = user_data;
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(msg);
+
+	l_dbus_message_builder_append_basic(builder, 'o', req->ele_path);
+	l_dbus_message_builder_append_basic(builder, 'q', &req->dst);
+	l_dbus_message_builder_append_basic(builder, 'q', &req->idx);
+	l_dbus_message_builder_append_basic(builder, 'q', &req->net_idx);
+	l_dbus_message_builder_append_basic(builder, 'b', &req->update);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static bool send_key(void *user_data, uint16_t dst, uint16_t key_idx,
+						bool is_appkey, bool update)
+{
+	struct key_data *req;
+	uint16_t net_idx;
+	const char *method_name = (!is_appkey) ? "AddNetKey" : "AddAppKey";
+
+	net_idx = get_primary_subnet_idx(dst);
+	if (net_idx == NET_IDX_INVALID)
+		return false;
+
+	req = l_new(struct key_data, 1);
+	req->ele_path = user_data;
+	req->dst = dst;
+	req->idx = key_idx;
+	req->net_idx = net_idx;
+	req->update = update;
+
+	return l_dbus_proxy_method_call(local->proxy, method_name,
+				send_key_setup, NULL, req, l_free) != 0;
+}
+
+static void client_init(void)
+{
+	cfgcli = cfgcli_init(send_key, (void *) app.ele.path);
+	cfgcli->ops.set_send_func(send_msg, (void *) app.ele.path);
+}
+
+static bool caps_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	uint32_t i;
+
+	if (!l_dbus_message_builder_enter_array(builder, "s"))
+		return false;
+	for (i = 0; i < L_ARRAY_SIZE(caps); i++)
+		l_dbus_message_builder_append_basic(builder, 's', caps[i]);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static struct l_dbus_message *disp_numeric_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	char *str;
+	uint32_t n;
+
+	if (!l_dbus_message_get_arguments(msg, "su", &str, &n)) {
+		l_error("Cannot parse \"DisplayNumeric\" arguments");
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+	}
+
+	if (!str || strlen(str) != strlen("in-numeric") ||
+			strncmp(str, "in-numeric", strlen("in-numeric")))
+		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
+
+	bt_shell_printf(COLOR_YELLOW "Enter %u on remote device" COLOR_OFF, n);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
+								void *user_data)
+{
+	struct l_dbus_message *msg = user_data;
+	struct l_dbus_message *reply;
+	uint32_t val_u32;
+
+	switch (type) {
+	case NONE:
+	case OUTPUT:
+	case ASCII:
+	case HEXADECIMAL:
+	default:
+		return;
+	case DECIMAL:
+		if (len >= 8) {
+			bt_shell_printf("Bad input length");
+			return;
+		}
+
+		val_u32 = l_get_be32(buf);
+		reply = l_dbus_message_new_method_return(msg);
+		l_dbus_message_set_arguments(reply, "u", val_u32);
+		l_dbus_send(dbus, reply);
+		break;
+	}
+}
+
+static struct l_dbus_message *prompt_numeric_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	char *str;
+
+	if (!l_dbus_message_get_arguments(msg, "s", &str)) {
+		l_error("Cannot parse \"PromptNumeric\" arguments");
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+	}
+
+	if (!str || strlen(str) != strlen("out-numeric") ||
+			strncmp(str, "out-numeric", strlen("out-numeric")))
+		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
+
+	l_dbus_message_ref(msg);
+	agent_input_request(DECIMAL, 8, agent_input_done, msg);
+
+	return NULL;
+}
+
+static void setup_agent_iface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_property(iface, "Capabilities", 0, "as", caps_getter,
+								NULL);
+	/* TODO: Other properties */
+	l_dbus_interface_method(iface, "DisplayNumeric", 0, disp_numeric_call,
+						"", "su", "type", "number");
+	l_dbus_interface_method(iface, "PromptNumeric", 0, prompt_numeric_call,
+						"u", "s", "number", "type");
+
+}
+
+static bool register_agent(void)
+{
+	if (!l_dbus_register_interface(dbus, MESH_PROVISION_AGENT_INTERFACE,
+					setup_agent_iface, NULL, false)) {
+		l_error("Unable to register agent interface");
+		return false;
+	}
+
+	if (!l_dbus_register_object(dbus, app.agent_path, NULL, NULL,
+				MESH_PROVISION_AGENT_INTERFACE, NULL, NULL)) {
+		l_error("Failed to register object %s", app.agent_path);
+		return false;
+	}
+
+	return true;
+}
+
+static void try_set_node_proxy(void *a, void *b)
+{
+	struct l_dbus_proxy *proxy = a;
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+
+	if (strcmp(local->path, path))
+		return;
+
+	if (!strcmp(interface, MESH_MANAGEMENT_INTERFACE))
+		local->mgmt_proxy = proxy;
+	else if (!strcmp(interface, MESH_NODE_INTERFACE))
+		local->proxy = proxy;
+}
+
+static void attach_node_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct meshcfg_node *node = user_data;
+	struct l_dbus_message_iter iter_cfg;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to attach node: %s", name);
+		goto fail;
+
+	}
+
+	if (!l_dbus_message_get_arguments(msg, "oa(ya(qa{sv}))",
+						&local->path, &iter_cfg))
+		goto fail;
+
+	bt_shell_printf("Attached with path %s\n", local->path);
+
+	/* Populate node's proxies */
+	l_queue_foreach(node_proxies, try_set_node_proxy, node);
+
+	/* Remove from orphaned proxies list */
+	if (local->proxy)
+		l_queue_remove(node_proxies, local->proxy);
+
+	if (local->mgmt_proxy)
+		l_queue_remove(node_proxies, local->mgmt_proxy);
+
+	/* Inititalize config client model */
+	client_init();
+
+	return;
+
+fail:
+	l_free(node);
+	node = NULL;
+}
+
+static void attach_node_setup(struct l_dbus_message *msg, void *user_data)
+{
+	l_dbus_message_set_arguments(msg, "ot", app.path,
+						l_get_be64(local->token.u8));
+}
+
+static void create_net_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	char *str;
+	uint64_t tmp;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to create network: %s", name);
+		return;
+
+	}
+
+	if (!l_dbus_message_get_arguments(msg, "t", &tmp))
+		return;
+
+	local = l_new(struct meshcfg_node, 1);
+	local->token.u64 = l_get_be64(&tmp);
+	str = l_util_hexstring(&local->token.u8[0], 8);
+	bt_shell_printf("Created new node with token %s\n", str);
+	l_free(str);
+
+	keys_add_net_key(PRIMARY_NET_IDX);
+
+	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
+						attach_node_reply, NULL,
+						NULL);
+}
+
+static void create_net_setup(struct l_dbus_message *msg, void *user_data)
+{
+	uint i;
+	struct l_dbus_message_builder *builder;
+
+	/* Generate random UUID */
+	l_getrandom(app.uuid, sizeof(app.uuid));
+
+	builder = l_dbus_message_builder_new(msg);
+
+	l_dbus_message_builder_append_basic(builder, 'o', app.path);
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < L_ARRAY_SIZE(app.uuid); i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+								&(app.uuid[i]));
+
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void cmd_create_network(int argc, char *argv[])
+{
+	l_dbus_proxy_method_call(net_proxy, "CreateNetwork", create_net_setup,
+						create_net_reply, NULL,
+						NULL);
+
+}
+
+static void scan_reply(struct l_dbus_proxy *proxy, struct l_dbus_message *msg,
+								void *user_data)
+{
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to start unprovisioned scan: %s", name);
+		return;
+	}
+
+	bt_shell_printf("Unprovisioned scan started\n");
+}
+
+static void scan_setup(struct l_dbus_message *msg, void *user_data)
+{
+	int32_t secs = L_PTR_TO_UINT(user_data);
+
+	l_dbus_message_set_arguments(msg, "q", (uint16_t) secs);
+}
+
+static void cmd_scan_unprov(int argc, char *argv[])
+{
+	uint32_t secs = 0;
+	bool enable;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (parse_argument_on_off(argc, argv, &enable) == FALSE) {
+		bt_shell_printf("Failed to parse input\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc == 3)
+		sscanf(argv[2], "%u", &secs);
+
+	if (secs > UNPROV_SCAN_MAX_SECS)
+		secs = UNPROV_SCAN_MAX_SECS;
+
+	if (enable)
+		l_dbus_proxy_method_call(local->mgmt_proxy, "UnprovisionedScan",
+						scan_setup, scan_reply,
+						L_UINT_TO_PTR(secs), NULL);
+	else
+		l_dbus_proxy_method_call(local->mgmt_proxy,
+						"UnprovisionedScanCancel",
+						NULL, NULL, NULL, NULL);
+
+}
+
+static void cmd_list_unprov(int argc, char *argv[])
+{
+	bt_shell_printf(COLOR_YELLOW "Unprovisioned devices:\n" COLOR_OFF);
+	l_queue_foreach(devices, print_device, NULL);
+}
+
+static void print_node(void *a, void *b)
+{
+	struct remote_node *node = a;
+	char *str;
+
+	bt_shell_printf(COLOR_YELLOW "Mesh node:\n" COLOR_OFF);
+	str = l_util_hexstring_upper(node->uuid, 16);
+	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
+	l_free(str);
+	bt_shell_printf("\t" COLOR_GREEN "primary = %4.4x\n" COLOR_OFF,
+								node->unicast);
+	bt_shell_printf("\t" COLOR_GREEN "elements = %u\n" COLOR_OFF,
+								node->num_ele);
+	bt_shell_printf("\t" COLOR_GREEN "net_key_idx = %3.3x\n" COLOR_OFF,
+								node->net_idx);
+}
+
+static void cmd_list_nodes(int argc, char *argv[])
+{
+	l_queue_foreach(nodes, print_node, NULL);
+}
+
+static void add_node_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		prov_in_progress = false;
+		l_dbus_message_get_error(msg, &name, NULL);
+		l_error("Failed to start provisioning: %s", name);
+		return;
+	}
+
+	bt_shell_printf("Provisioning started\n");
+}
+
+static void add_node_setup(struct l_dbus_message *msg, void *user_data)
+{
+	int i;
+	char *str = user_data;
+	size_t sz;
+	unsigned char *uuid;
+	struct l_dbus_message_builder *builder;
+
+	uuid = l_util_from_hexstring(str, &sz);
+	if (!uuid || sz != 16) {
+		l_error("Failed to generate UUID array from %s", str);
+		return;
+	}
+
+	builder = l_dbus_message_builder_new(msg);
+
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < (int)sz; i++)
+		l_dbus_message_builder_append_basic(builder, 'y', &(uuid[i]));
+
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_free(uuid);
+}
+
+static void cmd_start_prov(int argc, char *argv[])
+{
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	if (prov_in_progress) {
+		bt_shell_printf("Provisioning is already in progress\n");
+		return;
+	}
+
+	if (!argv[1] || (strlen(argv[1]) != 32)) {
+		bt_shell_printf(COLOR_RED "Requires UUID\n" COLOR_RED);
+		return;
+	}
+
+	if (l_dbus_proxy_method_call(local->mgmt_proxy, "AddNode",
+						add_node_setup, add_node_reply,
+						argv[1], NULL))
+		prov_in_progress = true;
+}
+
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
+	{ "create", NULL, cmd_create_network,
+			"Create new mesh network with one initial node" },
+	{ "discover-unprovisioned", "<on/off> [seconds]", cmd_scan_unprov,
+			"Look for devices to provision" },
+	{ "list-unprovisioned", NULL, cmd_list_unprov,
+			"List unprovisioned devices" },
+	{ "provision", "<uuid>", cmd_start_prov,
+			"Initiate provisioning"},
+	{ "list-nodes", NULL, cmd_list_nodes,
+			"List remote mesh nodes"},
+	{ } },
+};
+
+static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+
+	bt_shell_printf("Proxy added: %s (%s)\n", interface, path);
+
+	if (!strcmp(interface, MESH_NETWORK_INTERFACE)) {
+		net_proxy = proxy;
+		return;
+	}
+
+	if (!strcmp(interface, MESH_MANAGEMENT_INTERFACE)) {
+
+		if (local && local->path) {
+			if (!strcmp(local->path, path))
+				local->mgmt_proxy = proxy;
+		} else
+			l_queue_push_tail(node_proxies, proxy);
+		return;
+	}
+
+	if (!strcmp(interface, MESH_NODE_INTERFACE)) {
+
+		if (local && local->path) {
+			if (!strcmp(local->path, path))
+				local->proxy = proxy;
+		} else
+			l_queue_push_tail(node_proxies, proxy);
+	}
+}
+
+static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+
+	bt_shell_printf("Proxy removed: %s (%s)\n", interface, path);
+
+	if (!strcmp(interface, MESH_NETWORK_INTERFACE)) {
+		bt_shell_printf("Mesh removed, terminating.\n");
+		l_main_quit();
+		return;
+	}
+
+	if (!strcmp(interface, MESH_NODE_INTERFACE)) {
+		if (local && local->path && !strcmp(local->path, path))
+			local->proxy = NULL;
+
+		l_queue_remove(node_proxies, proxy);
+		return;
+	}
+
+	if (!strcmp(interface, MESH_MANAGEMENT_INTERFACE)) {
+		if (local && local->path && !strcmp(local->path, path))
+			local->mgmt_proxy = NULL;
+
+		l_queue_remove(node_proxies, proxy);
+	}
+}
+
+static bool mod_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_enter_array(builder, "q");
+	l_dbus_message_builder_append_basic(builder, 'q', &app.ele.mods[0]);
+	l_dbus_message_builder_append_basic(builder, 'q', &app.ele.mods[1]);
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool vmod_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_enter_array(builder, "(qq)");
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool ele_idx_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 'y', &app.ele.index);
+
+	return true;
+}
+
+static struct l_dbus_message *dev_msg_recv_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	uint16_t src, idx;
+	uint8_t *data;
+	uint32_t n;
+	bool rmt;
+
+	if (!l_dbus_message_get_arguments(msg, "qbqay", &src, &rmt, &idx,
+								&iter)) {
+		l_error("Cannot parse received message");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &data, &n)) {
+		l_error("Cannot parse received message: data");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	bt_shell_printf("Received dev key message (len %u):", n);
+
+	/* Pass to the configuration client */
+	if (cfgcli && cfgcli->ops.recv)
+		cfgcli->ops.recv(src, APP_IDX_DEV_REMOTE, data, n);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static void setup_ele_iface(struct l_dbus_interface *iface)
+{
+	/* Properties */
+	l_dbus_interface_property(iface, "Index", 0, "y", ele_idx_getter,
+									NULL);
+	l_dbus_interface_property(iface, "VendorModels", 0, "a(qq)",
+							vmod_getter, NULL);
+	l_dbus_interface_property(iface, "Models", 0, "aq", mod_getter, NULL);
+
+	/* Methods */
+	l_dbus_interface_method(iface, "DevKeyMessageReceived", 0,
+				dev_msg_recv_call, "", "qbqay", "source",
+				"remote", "net_index", "data");
+
+	/* TODO: Other methods */
+}
+
+static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	int16_t rssi;
+	uint32_t n;
+	uint8_t *prov_data;
+	char *str;
+	struct unprov_device *dev;
+
+	if (!l_dbus_message_get_arguments(msg, "nay", &rssi, &iter)) {
+		l_error("Cannot parse scan results");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &prov_data, &n) ||
+								n < 16) {
+		l_error("Cannot parse scan result: data");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	bt_shell_printf("Scan result:\n");
+	bt_shell_printf("\t" COLOR_GREEN "rssi = %d\n" COLOR_OFF, rssi);
+	str = l_util_hexstring_upper(prov_data, 16);
+	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
+	l_free(str);
+
+	/* TODO: Handle the rest of provisioning data if present */
+
+	dev = l_queue_find(devices, match_device_uuid, prov_data);
+	if (!dev) {
+		dev = l_new(struct unprov_device, 1);
+		memcpy(dev->uuid, prov_data, sizeof(dev->uuid));
+		/* TODO: timed self-destructor */
+		l_queue_push_tail(devices, dev);
+	}
+
+	/* Update with the latest rssi */
+	dev->rssi = rssi;
+	dev->last_seen = time(NULL);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static struct l_dbus_message *req_prov_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint8_t cnt;
+	struct l_dbus_message *reply;
+
+	if (!l_dbus_message_get_arguments(msg, "y", &cnt)) {
+		l_error("Cannot parse request for prov data");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	bt_shell_printf("Assign addresses for %u elements\n", cnt);
+	reply = l_dbus_message_new_method_return(msg);
+
+	l_dbus_message_set_arguments(reply, "qq", prov_net_idx, prov_address);
+
+	return reply;
+}
+
+static void remove_device(uint8_t *uuid)
+{
+	struct unprov_device *dev;
+
+	dev = l_queue_remove_if(devices, match_device_uuid, uuid);
+	l_free(dev);
+}
+
+static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	int16_t unicast;
+	uint8_t cnt;
+	uint32_t n;
+	uint8_t *uuid;
+	struct remote_node *node;
+
+	if (!prov_in_progress)
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+
+	prov_in_progress = false;
+
+	if (!l_dbus_message_get_arguments(msg, "ayqy", &iter, &unicast, &cnt)) {
+		l_error("Cannot parse add node complete message");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &uuid, &n) ||
+								n != 16) {
+		l_error("Cannot parse add node complete message: uuid");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	node = l_new(struct remote_node, 1);
+	memcpy(node->uuid, uuid, 16);
+	node->unicast = unicast;
+	node->num_ele = cnt;
+	node->net_idx = prov_net_idx;
+
+	bt_shell_printf("Provisioning done:\n");
+	print_node(node, NULL);
+	l_queue_push_tail(nodes, node);
+	remove_device(uuid);
+
+	prov_address = unicast + cnt;
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct l_dbus_message_iter iter;
+	uint32_t n;
+	uint8_t *uuid;
+	char *str, *reason;
+
+	if (!prov_in_progress)
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+
+	prov_in_progress = false;
+
+	if (!l_dbus_message_get_arguments(msg, "ays", &iter, &reason)) {
+		l_error("Cannot parse add node failed message");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+
+	}
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &uuid, &n) ||
+								n != 16) {
+		l_error("Cannot parse add node failed message: uuid");
+		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
+	}
+
+	bt_shell_printf("Provisioning failed:\n");
+	str = l_util_hexstring_upper(uuid, 16);
+	bt_shell_printf("\t" COLOR_RED "UUID = %s\n" COLOR_OFF, str);
+	l_free(str);
+	bt_shell_printf("\t" COLOR_RED "%s\n" COLOR_OFF, reason);
+
+	remove_device(uuid);
+
+	return l_dbus_message_new_method_return(msg);
+}
+
+static void setup_prov_iface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_method(iface, "ScanResult", 0, scan_result_call, "",
+							"nay", "rssi", "data");
+
+	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
+				"qq", "y", "net_index", "unicast", "count");
+
+	l_dbus_interface_method(iface, "AddNodeComplete", 0,
+					add_node_cmplt_call, "", "ayqy",
+					"uuid", "unicast", "count");
+
+	l_dbus_interface_method(iface, "AddNodeFailed", 0, add_node_fail_call,
+					"", "ays", "uuid", "reason");
+}
+
+static bool cid_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 'q', &app.cid);
+
+	return true;
+}
+
+static bool pid_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 'q', &app.pid);
+
+	return true;
+}
+
+static bool vid_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 'q', &app.vid);
+
+	return true;
+}
+static bool crpl_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	l_dbus_message_builder_append_basic(builder, 'q', &app.crpl);
+
+	return true;
+}
+
+static void setup_app_iface(struct l_dbus_interface *iface)
+{
+	l_dbus_interface_property(iface, "CompanyID", 0, "q", cid_getter,
+									NULL);
+	l_dbus_interface_property(iface, "VersionID", 0, "q", vid_getter,
+									NULL);
+	l_dbus_interface_property(iface, "ProductID", 0, "q", pid_getter,
+									NULL);
+	l_dbus_interface_property(iface, "CRPL", 0, "q", crpl_getter, NULL);
+
+	/* TODO: Methods */
+}
+
+static bool register_app(void)
+{
+	if (!l_dbus_register_interface(dbus, MESH_APPLICATION_INTERFACE,
+						setup_app_iface, NULL, false)) {
+		l_error("Failed to register interface %s",
+						MESH_APPLICATION_INTERFACE);
+		return false;
+	}
+
+	if (!l_dbus_register_interface(dbus, MESH_PROVISIONER_INTERFACE,
+					setup_prov_iface, NULL, false)) {
+		l_error("Failed to register interface %s",
+						MESH_PROVISIONER_INTERFACE);
+		return false;
+	}
+
+	if (!l_dbus_register_object(dbus, app.path, NULL, NULL,
+					MESH_APPLICATION_INTERFACE, NULL,
+					MESH_PROVISIONER_INTERFACE, NULL,
+									NULL)) {
+		l_error("Failed to register object %s", app.path);
+		return false;
+	}
+
+	if (!register_agent())
+		return false;
+
+	if (!l_dbus_register_interface(dbus, MESH_ELEMENT_INTERFACE,
+						setup_ele_iface, NULL, false)) {
+		l_error("Failed to register interface %s",
+						MESH_ELEMENT_INTERFACE);
+		return false;
+	}
+
+	if (!l_dbus_register_object(dbus, app.ele.path, NULL, NULL,
+				    MESH_ELEMENT_INTERFACE, NULL, NULL)) {
+		l_error("Failed to register object %s", app.ele.path);
+		return false;
+	}
+
+	if (!l_dbus_object_add_interface(dbus, app.path,
+					 L_DBUS_INTERFACE_OBJECT_MANAGER,
+									NULL)) {
+		l_error("Failed to add interface %s",
+					L_DBUS_INTERFACE_OBJECT_MANAGER);
+		return false;
+	}
+
+	return true;
+}
+
+static void client_ready(struct l_dbus_client *client, void *user_data)
+{
+	bt_shell_printf("D-Bus client ready\n");
+	if (!register_app())
+		bt_shell_quit(EXIT_FAILURE);
+
+	bt_shell_attach(fileno(stdin));
+}
+
+static void client_connected(struct l_dbus *dbus, void *user_data)
+{
+	bt_shell_printf("D-Bus client connected\n");
+	bt_shell_set_prompt(PROMPT_ON);
+}
+
+static void client_disconnected(struct l_dbus *dbus, void *user_data)
+{
+	bt_shell_printf("D-Bus client disconnected, exit\n");
+	bt_shell_quit(EXIT_SUCCESS);
+}
+
+static void ready_callback(void *user_data)
+{
+	bt_shell_printf("Connected to D-Bus\n");
+	if (!l_dbus_object_manager_enable(dbus, "/"))
+		bt_shell_printf("Failed to register the ObjectManager\n");
+}
+
+int main(int argc, char *argv[])
+{
+	struct l_dbus_client *client;
+	uint32_t val;
+	int status;
+
+	l_log_set_stderr();
+
+	bt_shell_init(argc, argv, &opt);
+	bt_shell_set_menu(&main_menu);
+	bt_shell_set_prompt(PROMPT_OFF);
+
+	if (address_opt && sscanf(address_opt, "%04x", &val) == 1)
+		prov_address = (uint16_t) val;
+	else
+		prov_address = DEFAULT_START_ADDRESS;
+
+	if (net_idx_opt && sscanf(net_idx_opt, "%04x", &val) == 1)
+		prov_net_idx = (uint16_t) val;
+	else
+		prov_net_idx = DEFAULT_NET_INDEX;
+
+	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
+
+	l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
+	client = l_dbus_client_new(dbus, BLUEZ_MESH_NAME, "/org/bluez/mesh");
+
+	l_dbus_client_set_connect_handler(client, client_connected, NULL, NULL);
+	l_dbus_client_set_disconnect_handler(client, client_disconnected, NULL,
+									NULL);
+	l_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							NULL, NULL, NULL);
+	l_dbus_client_set_ready_handler(client, client_ready, NULL, NULL);
+
+	node_proxies = l_queue_new();
+	devices = l_queue_new();
+	nodes = l_queue_new();
+
+	status = bt_shell_run();
+
+	l_dbus_client_destroy(client);
+	l_dbus_destroy(dbus);
+
+	return status;
+}
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
new file mode 100644
index 000000000..9e83f7b69
--- /dev/null
+++ b/tools/mesh/cfgcli.c
@@ -0,0 +1,1104 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdbool.h>
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+
+#include "mesh/mesh-defs.h"
+
+#include "tools/mesh/util.h"
+#include "tools/mesh/model.h"
+#include "tools/mesh/config-model.h"
+#include "tools/mesh/cfgcli.h"
+
+#define MIN_COMPOSITION_LEN 16
+
+static void *send_data;
+static model_send_msg_func_t send_msg;
+
+static void *key_data;
+static key_send_func_t send_key_msg;
+
+static uint16_t target = UNASSIGNED_ADDRESS;
+static uint32_t parms[8];
+
+static uint32_t print_mod_id(uint8_t *data, bool vid, const char *offset)
+{
+	uint32_t mod_id;
+
+	if (!vid) {
+		mod_id = get_le16(data);
+		bt_shell_printf("%sModel Id\t%4.4x\n", offset, mod_id);
+		mod_id = 0xffff0000 | mod_id;
+	} else {
+		mod_id = get_le16(data + 2);
+		bt_shell_printf("%sModel Id\t%4.4x %4.4x\n", offset,
+							get_le16(data), mod_id);
+		mod_id = get_le16(data) << 16 | mod_id;
+	}
+	return mod_id;
+}
+
+static void print_composition(uint8_t *data, uint16_t len)
+{
+	uint16_t features;
+	int i = 0;
+
+	bt_shell_printf("Received composion:\n");
+
+	/* skip page -- We only support Page Zero */
+	data++;
+	len--;
+
+	bt_shell_printf("\tCID: %4.4x", get_le16(&data[0]));
+	bt_shell_printf("\tPID: %4.4x", get_le16(&data[2]));
+	bt_shell_printf("\tVID: %4.4x", get_le16(&data[4]));
+	bt_shell_printf("\tCRPL: %4.4x", get_le16(&data[6]));
+
+	features = get_le16(&data[8]);
+	data += 10;
+	len -= 10;
+
+	bt_shell_printf("\tFeature support:\n");
+	bt_shell_printf("\t\trelay: %s\n", (features & FEATURE_RELAY) ?
+								"yes" : "no");
+	bt_shell_printf("\t\tproxy: %s\n", (features & FEATURE_PROXY) ?
+								"yes" : "no");
+	bt_shell_printf("\t\tfriend: %s\n", (features & FEATURE_FRIEND) ?
+								"yes" : "no");
+	bt_shell_printf("\t\tlpn: %s\n", (features & FEATURE_LPN) ?
+								"yes" : "no");
+
+	while (len) {
+		uint8_t m, v;
+
+		bt_shell_printf("\t Element %d:\n", i);
+		bt_shell_printf("\t\tlocation: %4.4x\n", get_le16(data));
+		data += 2;
+		len -= 2;
+
+		m = *data++;
+		v = *data++;
+		len -= 2;
+
+		if (m)
+			bt_shell_printf("\t\tSIG defined models:\n");
+
+		while (len >= 2 && m--) {
+			print_mod_id(data, false, "\t\t  ");
+			data += 2;
+			len -= 2;
+		}
+
+		if (v)
+			bt_shell_printf("\t\t Vendor defined models:\n");
+
+		while (len >= 4 && v--) {
+			print_mod_id(data, true, "\t\t  ");
+			data += 4;
+			len -= 4;
+		}
+
+		i++;
+	}
+}
+
+static void print_pub(uint16_t ele_addr, uint32_t mod_id,
+						struct model_pub *pub)
+{
+	bt_shell_printf("\tElement: %4.4x\n", ele_addr);
+	bt_shell_printf("\tPub Addr: %4.4x\n", pub->u.addr16);
+
+	if (mod_id > 0xffff0000)
+		bt_shell_printf("\tModel: %8.8x\n", mod_id);
+	else
+		bt_shell_printf("\tModel: %4.4x\n",
+				(uint16_t) (mod_id & 0xffff));
+
+	bt_shell_printf("\tApp Key Idx: %4.4x\n", pub->app_idx);
+	bt_shell_printf("\tTTL: %2.2x\n", pub->ttl);
+}
+
+static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
+							uint16_t len)
+{
+	uint32_t opcode;
+	uint16_t app_idx, net_idx, addr;
+	uint16_t ele_addr;
+	uint32_t mod_id;
+	struct model_pub pub;
+	int n;
+	uint16_t i;
+
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+	case OP_DEV_COMP_STATUS:
+		if (len < MIN_COMPOSITION_LEN)
+			break;
+
+		print_composition(data, len);
+
+		break;
+
+	case OP_APPKEY_STATUS:
+		if (len != 4)
+			break;
+
+		bt_shell_printf("Node %4.4x AppKey status %s\n", src,
+						mesh_status_str(data[0]));
+		net_idx = get_le16(data + 1) & 0xfff;
+		app_idx = get_le16(data + 2) >> 4;
+
+		bt_shell_printf("NetKey\t%3.3x\n", net_idx);
+		bt_shell_printf("AppKey\t%3.3x\n", app_idx);
+
+		break;
+
+	case OP_NETKEY_STATUS:
+		if (len != 3)
+			break;
+
+		bt_shell_printf("Node %4.4x NetKey status %s\n", src,
+						mesh_status_str(data[0]));
+		net_idx = get_le16(data + 1) & 0xfff;
+
+		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
+
+		break;
+
+	case OP_MODEL_APP_STATUS:
+		if (len != 7 && len != 9)
+			break;
+
+		bt_shell_printf("Node %4.4x: Model App status %s\n", src,
+						mesh_status_str(data[0]));
+		addr = get_le16(data + 1);
+		app_idx = get_le16(data + 3);
+
+		bt_shell_printf("Element Addr\t%4.4x\n", addr);
+
+		print_mod_id(data + 5, len == 9, "");
+
+		bt_shell_printf("AppIdx\t\t%3.3x\n ", app_idx);
+
+		break;
+
+	case OP_NODE_IDENTITY_STATUS:
+		if (len != 4)
+			return true;
+
+		bt_shell_printf("NetIdx %4.4x, NodeIdState 0x%02x, status %s\n",
+				get_le16(data + 1), data[3],
+				mesh_status_str(data[0]));
+		break;
+
+	case OP_CONFIG_BEACON_STATUS:
+		if (len != 1)
+			return true;
+
+		bt_shell_printf("Node %4.4x: Config Beacon Status 0x%02x\n",
+				src, data[0]);
+		break;
+
+	case OP_CONFIG_RELAY_STATUS:
+		if (len != 2)
+			return true;
+
+		bt_shell_printf("Node %4.4x: Relay 0x%02x, cnt %d, steps %d\n",
+				src, data[0], data[1]>>5, data[1] & 0x1f);
+		break;
+
+	case OP_CONFIG_PROXY_STATUS:
+		if (len != 1)
+			return true;
+
+		bt_shell_printf("Node %4.4x Proxy state 0x%02x\n",
+				src, data[0]);
+		break;
+
+	case OP_CONFIG_DEFAULT_TTL_STATUS:
+		if (len != 1)
+			return true;
+
+		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
+
+		break;
+
+	case OP_CONFIG_MODEL_PUB_STATUS:
+		if (len != 12 && len != 14)
+			return true;
+
+		bt_shell_printf("\nNode %4.4x Publication status %s\n",
+				src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		ele_addr = get_le16(data + 1);
+
+		mod_id = print_mod_id(data + 10, len == 14, "");
+
+		pub.u.addr16 = get_le16(data + 3);
+		pub.app_idx = get_le16(data + 5);
+		pub.ttl = data[7];
+		pub.period = data[8];
+		n = (data[8] & 0x3f);
+
+		print_pub(ele_addr, mod_id, &pub);
+
+		switch (data[8] >> 6) {
+		case 0:
+			bt_shell_printf("Period\t\t%d ms\n", n * 100);
+			break;
+		case 2:
+			n *= 10;
+			/* fall through */
+		case 1:
+			bt_shell_printf("Period\t\t%d sec\n", n);
+			break;
+		case 3:
+			bt_shell_printf("Period\t\t%d min\n", n * 10);
+			break;
+		}
+
+		bt_shell_printf("Rexmit count\t%d\n", data[9] >> 5);
+		bt_shell_printf("Rexmit steps\t%d\n", data[9] & 0x1f);
+
+		break;
+
+	/* Per Mesh Profile 4.3.2.19 */
+	case OP_CONFIG_MODEL_SUB_STATUS:
+		bt_shell_printf("\nNode %4.4x Subscription status %s\n",
+				src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		ele_addr = get_le16(data + 1);
+		addr = get_le16(data + 3);
+		bt_shell_printf("Element Addr\t%4.4x\n", ele_addr);
+
+		print_mod_id(data + 5, len == 9, "");
+
+		bt_shell_printf("Subscr Addr\t%4.4x\n", addr);
+
+		break;
+
+	/* Per Mesh Profile 4.3.2.27 */
+	case OP_CONFIG_MODEL_SUB_LIST:
+
+		bt_shell_printf("\nNode %4.4x Subscription List status %s\n",
+				src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
+
+		for (i = 5; i < len; i += 2)
+			bt_shell_printf("Subscr Addr\t%4.4x\n",
+							get_le16(data + i));
+		break;
+
+	/* Per Mesh Profile 4.3.2.50 */
+	case OP_MODEL_APP_LIST:
+		bt_shell_printf("\nNode %4.4x Model AppIdx status %s\n",
+						src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
+
+		for (i = 5; i < len; i += 2)
+			bt_shell_printf("Model AppIdx\t%4.4x\n",
+							get_le16(data + i));
+		break;
+
+	/* Per Mesh Profile 4.3.2.63 */
+	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
+		bt_shell_printf("\nNode %4.4x Heartbeat publish status %s\n",
+				src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Count\t\t%2.2x\n", data[3]);
+		bt_shell_printf("Period\t\t%2.2x\n", data[4]);
+		bt_shell_printf("TTL\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Features\t%4.4x\n", get_le16(data + 6));
+		bt_shell_printf("Net_Idx\t%4.4x\n", get_le16(data + 8));
+		break;
+
+	/* Per Mesh Profile 4.3.2.66 */
+	case OP_CONFIG_HEARTBEAT_SUB_STATUS:
+		bt_shell_printf("\nNode %4.4x Heartbeat subscribe status %s\n",
+				src, mesh_status_str(data[0]));
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		bt_shell_printf("Source\t\t%4.4x\n", get_le16(data + 1));
+		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 3));
+		bt_shell_printf("Period\t\t%2.2x\n", data[5]);
+		bt_shell_printf("Count\t\t%2.2x\n", data[6]);
+		bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
+		bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
+		break;
+
+	/* Per Mesh Profile 4.3.2.54 */
+	case OP_NODE_RESET_STATUS:
+		bt_shell_printf("Node %4.4x reset status %s\n",
+				src, mesh_status_str(data[0]));
+
+		break;
+	}
+
+	return true;
+}
+
+static uint32_t read_input_parameters(int argc, char *argv[])
+{
+	uint32_t i;
+
+	if (!argc)
+		return 0;
+
+	--argc;
+	++argv;
+
+	if (!argc || argv[0][0] == '\0')
+		return 0;
+
+	for (i = 0; i < L_ARRAY_SIZE(parms) && i < (uint32_t) argc; i++) {
+		if (sscanf(argv[i], "%x", &parms[i]) != 1)
+			break;
+	}
+
+	return i;
+}
+
+static void cmd_dst_set(int argc, char *argv[])
+{
+	uint32_t dst;
+	char *end;
+
+	dst = strtol(argv[1], &end, 16);
+
+	if (end != (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: "
+				"expected format 4 digit hex\n", argv[1]);
+		target = UNASSIGNED_ADDRESS;
+
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Configuring node %4.4x\n", dst);
+	target = dst;
+	set_menu_prompt("config", argv[1]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static bool config_send(uint8_t *buf, uint16_t len)
+{
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return false;
+	}
+
+	return send_msg(send_data, target, APP_IDX_DEV_REMOTE, buf, len);
+}
+
+static void cmd_default(uint32_t opcode)
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	n = mesh_opcode_set(opcode, msg);
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send command (opcode 0x%x)\n",
+								opcode);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_composition_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	n = mesh_opcode_set(OP_DEV_COMP_GET, msg);
+
+	/* By default, use page 0 */
+	msg[n++] = (read_input_parameters(argc, argv) == 1) ? parms[0] : 0;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"GET NODE COMPOSITION\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_netkey_del(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+
+	n = mesh_opcode_set(OP_NETKEY_DELETE, msg);
+
+	if (read_input_parameters(argc, argv) != 1) {
+		bt_shell_printf("Bad arguments %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(target + parms[0], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"DEL_NET KEY\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_netkey_add(int argc, char *argv[])
+{
+	/*TODO*/
+	bt_shell_printf("Not implemented\n");
+}
+
+static void cmd_netkey_update(int argc, char *argv[])
+{
+	/*TODO*/
+	bt_shell_printf("Not implemented\n");
+}
+
+static void cmd_appkey_add(int argc, char *argv[])
+{
+	/*TODO*/
+	bt_shell_printf("Not implemented\n");
+}
+
+static void cmd_appkey_update(int argc, char *argv[])
+{
+	/*TODO*/
+	bt_shell_printf("Not implemented\n");
+}
+
+static void cmd_appkey_del(int argc, char *argv[])
+{
+	/*TODO*/
+	bt_shell_printf("Not implemented\n");
+}
+
+static void cmd_bind(int argc, char *argv[])
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
+	n = mesh_opcode_set(OP_MODEL_APP_BIND, msg);
+
+	put_le16(target + parms[0], msg + n);
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
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_beacon_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 1];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_BEACON_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET BEACON\"\n");
+		return;
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_beacon_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_BEACON_GET);
+}
+
+static void cmd_ident_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 3 + 4];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_NODE_IDENTITY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+	msg[n++] = parms[1];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET IDENTITY\"\n");
+		return;
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_ident_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 2 + 4];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_NODE_IDENTITY_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"GET IDENTITY\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_proxy_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 1];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_PROXY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 1) {
+		bt_shell_printf("bad arguments");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET PROXY\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_proxy_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_PROXY_GET);
+}
+
+static void cmd_relay_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[2 + 2 + 4];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_RELAY_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	msg[n++] = parms[0];
+	msg[n++] = (parms[1] << 5) | parms[2];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET RELAY\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_relay_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_RELAY_GET);
+}
+
+static void cmd_ttl_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (!parm_cnt || parms[0] > TTL_MASK) {
+		bt_shell_printf("Bad TTL value\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	n = mesh_opcode_set(OP_CONFIG_DEFAULT_TTL_SET, msg);
+	msg[n++] = parms[0];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET_DEFAULT TTL\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_pub_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 6 && parm_cnt != 7) {
+		bt_shell_printf("Bad arguments\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Publish address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* AppKey index + credential (set to 0) */
+	put_le16(parms[2], msg + n);
+	n += 2;
+	/* TTL */
+	msg[n++] = DEFAULT_TTL;
+	/* Publish period  step count and step resolution */
+	msg[n++] = parms[3];
+	/* Publish retransmit count & interval steps */
+	msg[n++] = parms[4];
+
+	/* Model Id */
+	if (parm_cnt == 7) {
+		put_le16(parms[6], msg + n);
+		put_le16(parms[5], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[5], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_pub_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2 && parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+
+	/* Model Id */
+	if (parm_cnt == 3) {
+		put_le16(parms[2], msg + n);
+		put_le16(parms[1], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[1], msg + n);
+		n += 2;
+	}
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"GET MODEL PUBLICATION\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_sub_add(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_ADD, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Per Mesh Profile 4.3.2.19 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Subscription Address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* SIG Model ID */
+	put_le16(parms[2], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_sub_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Per Mesh Profile 4.3.2.27 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Model ID */
+	put_le16(parms[1], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"GET SUB GET\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_mod_appidx_get(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_MODEL_APP_GET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 2) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Per Mesh Profile 4.3.2.49 */
+	/* Element Address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Model ID */
+	put_le16(parms[1], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"GET APP GET\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_hb_pub_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 6) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Per Mesh Profile 4.3.2.62 */
+	/* Publish address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Count Log */
+	msg[n++] = parms[1];
+	/* Period Log */
+	msg[n++] = parms[2];
+	/* Heartbeat TTL */
+	msg[n++] = parms[3];
+	/* Features */
+	put_le16(parms[4], msg + n);
+	n += 2;
+	/* NetKey Index */
+	put_le16(parms[5], msg + n);
+	n += 2;
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLISH\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_hb_pub_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_HEARTBEAT_PUB_GET);
+}
+
+static void cmd_hb_sub_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	int parm_cnt;
+
+	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_SUB_SET, msg);
+
+	parm_cnt = read_input_parameters(argc, argv);
+	if (parm_cnt != 3) {
+		bt_shell_printf("Bad arguments: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Per Mesh Profile 4.3.2.65 */
+	/* Source address */
+	put_le16(parms[0], msg + n);
+	n += 2;
+	/* Destination address */
+	put_le16(parms[1], msg + n);
+	n += 2;
+	/* Period log */
+	msg[n++] = parms[2];
+
+	if (!config_send(msg, n)) {
+		bt_shell_printf("Failed to send \"SET HEARTBEAT SUBSCRIBE\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_hb_sub_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_HEARTBEAT_SUB_GET);
+}
+
+static void cmd_ttl_get(int argc, char *argv[])
+{
+	cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
+}
+
+static void cmd_node_reset(int argc, char *argv[])
+{
+	cmd_default(OP_NODE_RESET);
+}
+
+static bool tx_setup(model_send_msg_func_t send_func, void *user_data)
+{
+	if (!send_func)
+		return false;
+
+	send_msg = send_func;
+	send_data = user_data;
+
+	return true;
+}
+
+static const struct bt_shell_menu cfg_menu = {
+	.name = "config",
+	.desc = "Configuration Model Submenu",
+	.entries = {
+	{"target", "<unicast>", cmd_dst_set,
+				"Set target node to configure"},
+	{"composition-get", "[page_num]", cmd_composition_get,
+				"Get composition data"},
+	{"netkey-add", "<net_idx>", cmd_netkey_add,
+				"Add network key"},
+	{"netkey-update", "<net_idx>", cmd_netkey_update,
+				"Update network key"},
+	{"netkey-del", "<net_idx>", cmd_netkey_del,
+				"Delete network key"},
+	{"appkey-add", "<app_idx>", cmd_appkey_add,
+				"Add application key"},
+	{"appkey-update", "<app_idx>", cmd_appkey_update,
+				"Add application key"},
+	{"appkey-del", "<app_idx>", cmd_appkey_del,
+				"Delete application key"},
+	{"bind", "<ele_idx> <app_idx> <mod_id> [vendor_id]", cmd_bind,
+				"Bind app key to a model"},
+	{"mod-appidx-get", "<ele_addr> <model id>", cmd_mod_appidx_get,
+				"Get model app_idx"},
+	{"ttl-set", "<ttl>", cmd_ttl_set,
+				"Set default TTL"},
+	{"ttl-get", NULL, cmd_ttl_get,
+				"Get default TTL"},
+	{"pub-set", "<ele_addr> <pub_addr> <app_idx> <per (step|res)> "
+			"<re-xmt (cnt|per)> <mod id> [vendor_id]",
+				cmd_pub_set,
+				"Set publication"},
+	{"pub-get", "<ele_addr> <model>", cmd_pub_get,
+				"Get publication"},
+	{"proxy-set", "<proxy>", cmd_proxy_set,
+				"Set proxy state"},
+	{"proxy-get", NULL, cmd_proxy_get,
+				"Get proxy state"},
+	{"ident-set", "<net_idx> <state>", cmd_ident_set,
+				"Set node identity state"},
+	{"ident-get", "<net_idx>", cmd_ident_get,
+				"Get node identity state"},
+	{"beacon-set", "<state>", cmd_beacon_set,
+				"Set node identity state"},
+	{"beacon-get", NULL, cmd_beacon_get,
+				"Get node beacon state"},
+	{"relay-set", "<relay> <rexmt count> <rexmt steps>", cmd_relay_set,
+				"Set relay"},
+	{"relay-get", NULL, cmd_relay_get,
+				"Get relay"},
+	{"hb-pub-set", "<pub_addr> <count> <period> <ttl> <features> <net_idx>",
+				cmd_hb_pub_set,
+				"Set heartbeat publish"},
+	{"hb-pub-get", NULL, cmd_hb_pub_get,
+				"Get heartbeat publish"},
+	{"hb-sub-set", "<src_addr> <dst_addr> <period>", cmd_hb_sub_set,
+				"Set heartbeat subscribe"},
+	{"hb-sub-get", NULL, cmd_hb_sub_get,
+				"Get heartbeat subscribe"},
+	{"sub-add", "<ele_addr> <sub_addr> <model id>", cmd_sub_add,
+				"Add subscription"},
+	{"sub-get", "<ele_addr> <model id>", cmd_sub_get,
+				"Get subscription"},
+	{"node-reset", NULL, cmd_node_reset,
+				"Reset a node and remove it from network"},
+	{} },
+};
+
+static struct model_info cli_info = {
+	.ops = {
+		.set_send_func = tx_setup,
+		.set_pub_func = NULL,
+		.recv = msg_recvd,
+		.bind = NULL,
+		.pub = NULL
+	},
+	.mod_id = CONFIG_CLIENT_MODEL_ID,
+	.vendor_id = VENDOR_ID_INVALID
+};
+
+struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
+{
+	if (!key_send)
+		return NULL;
+
+	send_key_msg = key_send;
+	key_data = user_data;
+
+	bt_shell_add_submenu(&cfg_menu);
+
+	return &cli_info;
+}
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
new file mode 100644
index 000000000..077c340e5
--- /dev/null
+++ b/tools/mesh/cfgcli.h
@@ -0,0 +1,24 @@
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
+ *
+ */
+
+typedef bool (*key_send_func_t) (void *user_data, uint16_t dst,
+				 uint16_t idx, bool is_appkey, bool update);
+
+struct model_info *cfgcli_init(key_send_func_t key_func, void *user_data);
diff --git a/tools/mesh/config-model.h b/tools/mesh/config-model.h
index a5b811365..f08d3b890 100644
--- a/tools/mesh/config-model.h
+++ b/tools/mesh/config-model.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017, 2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -97,5 +97,6 @@
 #define OP_VEND_MODEL_APP_LIST			0x804E
 
 bool config_server_init(void);
+
 bool config_client_init(void);
 void config_client_get_composition(uint32_t dst);
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
new file mode 100644
index 000000000..3c887b319
--- /dev/null
+++ b/tools/mesh/keys.c
@@ -0,0 +1,166 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "mesh/mesh-defs.h"
+#include "tools/mesh/keys.h"
+
+struct net_key {
+	uint16_t idx;
+	struct l_queue *app_keys;
+};
+
+static struct l_queue *net_keys;
+
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool net_idx_match(const void *a, const void *b)
+{
+	const struct net_key *key = a;
+	uint32_t idx = L_PTR_TO_UINT(b);
+
+	return key->idx == idx;
+}
+
+void keys_add_net_key(uint16_t net_idx)
+{
+	struct net_key *key;
+
+	if (!net_keys)
+		net_keys = l_queue_new();
+
+	if (l_queue_find(net_keys, net_idx_match, L_UINT_TO_PTR(net_idx)))
+		return;
+
+	key = l_new(struct net_key, 1);
+	key->idx = net_idx;
+
+	l_queue_push_tail(net_keys, key);
+}
+
+void keys_del_net_key(uint16_t idx)
+{
+	struct net_key *key;
+
+	if (!net_keys)
+		return;
+
+	key = l_queue_remove_if(net_keys, net_idx_match, L_UINT_TO_PTR(idx));
+	if (!key)
+		return;
+
+	l_queue_destroy(key->app_keys, NULL);
+	l_free(key);
+}
+
+void keys_add_app_key(uint16_t net_idx, uint16_t app_idx)
+{
+	struct net_key *key;
+
+	if (!net_keys)
+		return;
+
+	key = l_queue_find(net_keys, net_idx_match, L_UINT_TO_PTR(net_idx));
+	if (!key)
+		return;
+
+	if (!key->app_keys)
+		key->app_keys = l_queue_new();
+
+	if (l_queue_find(key->app_keys, simple_match, L_UINT_TO_PTR(app_idx)))
+		return;
+
+	l_queue_push_tail(key->app_keys, L_UINT_TO_PTR(app_idx));
+}
+
+void keys_del_app_key(uint16_t app_idx)
+{
+	const struct l_queue_entry *l;
+
+	if (!net_keys)
+		return;
+
+	for (l = l_queue_get_entries(net_keys); l; l = l->next) {
+		struct net_key *key = l->data;
+
+		if (!key->app_keys)
+			continue;
+
+		if (l_queue_remove_if(key->app_keys, simple_match,
+							L_UINT_TO_PTR(app_idx)))
+			return;
+	}
+}
+
+uint16_t keys_get_bound_key(uint16_t app_idx)
+{
+	const struct l_queue_entry *l;
+
+	if (!net_keys)
+		return NET_IDX_INVALID;
+
+	for (l = l_queue_get_entries(net_keys); l; l = l->next) {
+		struct net_key *key = l->data;
+
+		if (!key->app_keys)
+			continue;
+
+		if (l_queue_find(key->app_keys, simple_match,
+							L_UINT_TO_PTR(app_idx)))
+			return key->idx;
+	}
+
+	return NET_IDX_INVALID;
+}
+
+static void print_appkey(void *app_key, void *user_data)
+{
+	uint16_t app_idx = L_PTR_TO_UINT(app_key);
+
+	bt_shell_printf("%3.3x ", app_idx);
+}
+
+static void print_netkey(void *net_key, void *user_data)
+{
+	struct net_key *key = net_key;
+
+	bt_shell_printf(COLOR_YELLOW "NetKey: %3.3x\n" COLOR_OFF, key->idx);
+
+	if (!key->app_keys || l_queue_isempty(key->app_keys))
+		return;
+
+	bt_shell_printf("\t" COLOR_GREEN "app_keys = ");
+	l_queue_foreach(key->app_keys, print_appkey, NULL);
+	bt_shell_printf("\n" COLOR_OFF);
+}
+
+void keys_print_keys(void)
+{
+	l_queue_foreach(net_keys, print_netkey, NULL);
+}
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
new file mode 100644
index 000000000..2a9faede6
--- /dev/null
+++ b/tools/mesh/keys.h
@@ -0,0 +1,26 @@
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
+ *
+ */
+
+void keys_add_net_key(uint16_t net_idx);
+void keys_del_net_key(uint16_t net_idx);
+void keys_add_app_key(uint16_t net_idx, uint16_t app_idx);
+void keys_del_app_key(uint16_t app_idx);
+uint16_t keys_get_bound_key(uint16_t app_idx);
+void keys_print_keys(void);
diff --git a/tools/mesh/model.h b/tools/mesh/model.h
new file mode 100644
index 000000000..449fe19b2
--- /dev/null
+++ b/tools/mesh/model.h
@@ -0,0 +1,63 @@
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
+ *
+ */
+
+#define OP_UNRELIABLE	0x0100
+#define VENDOR_ID_INVALID	0xFFFF
+
+typedef bool (*model_send_msg_func_t) (void *user_data, uint16_t dst,
+				uint16_t app_idx, uint8_t *data, uint16_t len);
+typedef bool (*model_send_pub_func_t) (void *user_data, uint16_t vendor_id,
+				uint16_t mod_id, uint8_t *data, uint16_t len);
+typedef bool (*model_set_send_func_t)(model_send_msg_func_t func,
+							void *user_data);
+typedef bool (*model_set_pub_func_t)(model_send_pub_func_t func,
+							void *user_data);
+
+typedef bool (*model_recv_func_t)(uint16_t src, uint16_t app_idx,
+						uint8_t *data, uint16_t len);
+typedef int (*model_bind_func_t)(uint16_t app_idx, int action);
+
+struct model_pub {
+	uint16_t app_idx;
+	union {
+		uint16_t addr16;
+		uint8_t va_128[16];
+	} u;
+	uint8_t ttl;
+	uint8_t credential;
+	uint8_t period;
+	uint8_t retransmit;
+};
+
+typedef int (*model_pub_func_t)(struct model_pub *pub);
+
+struct model_ops {
+	model_set_send_func_t set_send_func;
+	model_set_pub_func_t set_pub_func;
+	model_recv_func_t recv;
+	model_bind_func_t bind;
+	model_pub_func_t pub;
+};
+
+struct model_info {
+	struct model_ops ops;
+	uint16_t mod_id;
+	uint16_t vendor_id;
+};
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
new file mode 100644
index 000000000..7176cc562
--- /dev/null
+++ b/tools/mesh/util.c
@@ -0,0 +1,140 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017, 2019  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+
+#include "mesh/mesh-defs.h"
+
+#include "tools/mesh/util.h"
+
+void set_menu_prompt(const char *name, const char *id)
+{
+	char *prompt;
+
+	prompt = l_strdup_printf(COLOR_BLUE "[%s%s%s]" COLOR_OFF "# ", name,
+					id ? ": Target = " : "", id ? id : "");
+	bt_shell_set_prompt(prompt);
+	l_free(prompt);
+}
+
+uint16_t mesh_opcode_set(uint32_t opcode, uint8_t *buf)
+{
+	if (opcode <= 0x7e) {
+		buf[0] = opcode;
+		return 1;
+	} else if (opcode >= 0x8000 && opcode <= 0xbfff) {
+		put_be16(opcode, buf);
+		return 2;
+	} else if (opcode >= 0xc00000 && opcode <= 0xffffff) {
+		buf[0] = (opcode >> 16) & 0xff;
+		put_be16(opcode, buf + 1);
+		return 3;
+	}
+
+	bt_shell_printf("Illegal Opcode %x", opcode);
+	return 0;
+}
+
+bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, uint32_t *opcode, int *n)
+{
+	if (!n || !opcode || sz < 1)
+		return false;
+
+	switch (buf[0] & 0xc0) {
+	case 0x00:
+	case 0x40:
+		/* RFU */
+		if (buf[0] == 0x7f)
+			return false;
+
+		*n = 1;
+		*opcode = buf[0];
+		break;
+
+	case 0x80:
+		if (sz < 2)
+			return false;
+
+		*n = 2;
+		*opcode = get_be16(buf);
+		break;
+
+	case 0xc0:
+		if (sz < 3)
+			return false;
+
+		*n = 3;
+		*opcode = get_be16(buf + 1);
+		*opcode |= buf[0] << 16;
+		break;
+
+	default:
+		bt_shell_printf("Bad opcode");
+		return false;
+	}
+
+	return true;
+}
+
+const char *mesh_status_str(uint8_t status)
+{
+	switch (status) {
+	case MESH_STATUS_SUCCESS: return "Success";
+	case MESH_STATUS_INVALID_ADDRESS: return "Invalid Address";
+	case MESH_STATUS_INVALID_MODEL: return "Invalid Model";
+	case MESH_STATUS_INVALID_APPKEY: return "Invalid AppKey";
+	case MESH_STATUS_INVALID_NETKEY: return "Invalid NetKey";
+	case MESH_STATUS_INSUFF_RESOURCES: return "Insufficient Resources";
+	case MESH_STATUS_IDX_ALREADY_STORED: return "Key Idx Already Stored";
+	case MESH_STATUS_INVALID_PUB_PARAM: return "Invalid Publish Parameters";
+	case MESH_STATUS_NOT_SUB_MOD: return "Not a Subscribe Model";
+	case MESH_STATUS_STORAGE_FAIL: return "Storage Failure";
+	case MESH_STATUS_FEATURE_NO_SUPPORT: return "Feature Not Supported";
+	case MESH_STATUS_CANNOT_UPDATE: return "Cannot Update";
+	case MESH_STATUS_CANNOT_REMOVE: return "Cannot Remove";
+	case MESH_STATUS_CANNOT_BIND: return "Cannot bind";
+	case MESH_STATUS_UNABLE_CHANGE_STATE: return "Unable to change state";
+	case MESH_STATUS_CANNOT_SET: return "Cannot set";
+	case MESH_STATUS_UNSPECIFIED_ERROR: return "Unspecified error";
+	case MESH_STATUS_INVALID_BINDING: return "Invalid Binding";
+
+	default: return "Unknown";
+	}
+}
+
+void swap_u256_bytes(uint8_t *u256)
+{
+	int i;
+
+	/* End-to-End byte reflection of 32 octet buffer */
+	for (i = 0; i < 16; i++) {
+		u256[i] ^= u256[31 - i];
+		u256[31 - i] ^= u256[i];
+		u256[i] ^= u256[31 - i];
+	}
+}
diff --git a/tools/mesh/util.h b/tools/mesh/util.h
new file mode 100644
index 000000000..cca07cf96
--- /dev/null
+++ b/tools/mesh/util.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017, 2019  Intel Corporation. All rights reserved.
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
+#include <stdbool.h>
+
+struct mesh_publication;
+
+void set_menu_prompt(const char *name, const char *id);
+void print_byte_array(const char *prefix, const void *ptr, int len);
+uint16_t mesh_opcode_set(uint32_t opcode, uint8_t *buf);
+bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, uint32_t *opcode, int *n);
+const char *mesh_status_str(uint8_t status);
+void swap_u256_bytes(uint8_t *u256);
-- 
2.21.0

