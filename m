Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F0ECA9ED0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD55217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKAS5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:29978 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833762"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:36 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/10 v2] tools/mesh: move remote node processing to a separate file
Date:   Fri,  1 Nov 2019 11:57:23 -0700
Message-Id: <20191101185729.31661-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This confines the functionality related to remote node
housekeeping into a separate file remote.c
---
 Makefile.tools         |   2 +
 tools/mesh-cfgclient.c |  76 +++----------------------
 tools/mesh/remote.c    | 124 +++++++++++++++++++++++++++++++++++++++++
 tools/mesh/remote.h    |  31 +++++++++++
 4 files changed, 165 insertions(+), 68 deletions(-)
 create mode 100644 tools/mesh/remote.c
 create mode 100644 tools/mesh/remote.h

diff --git a/Makefile.tools b/Makefile.tools
index 12687e495..0b4ddf576 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -332,7 +332,9 @@ tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
 				tools/mesh/cfgcli.h tools/mesh/cfgcli.c \
 				tools/mesh/keys.h tools/mesh/keys.c \
 				tools/mesh/util.h tools/mesh/util.c \
+				tools/mesh/remote.h tools/mesh/remote.c \
 				tools/mesh/agent.h tools/mesh/agent.c
+
 tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
 						$(ell_ldadd) -lreadline
 endif
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 24e0a910a..c932cc3c5 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -39,6 +39,7 @@
 #include "tools/mesh/cfgcli.h"
 #include "tools/mesh/keys.h"
 #include "tools/mesh/model.h"
+#include "tools/mesh/remote.h"
 
 #define PROMPT_ON	COLOR_BLUE "[mesh-cfgclient]" COLOR_OFF "# "
 #define PROMPT_OFF	"Waiting to connect to bluetooth-meshd..."
@@ -84,13 +85,6 @@ struct unprov_device {
 	uint8_t uuid[16];
 };
 
-struct remote_node {
-	uint16_t unicast;
-	uint16_t net_idx;
-	uint8_t uuid[16];
-	uint8_t num_ele;
-};
-
 static struct l_dbus *dbus;
 
 static struct l_queue *node_proxies;
@@ -99,7 +93,6 @@ static struct meshcfg_node *local;
 static struct model_info *cfgcli;
 
 static struct l_queue *devices;
-static struct l_queue *nodes;
 
 static bool prov_in_progress;
 static const char *caps[2] = {"out-numeric", "in-numeric"};
@@ -192,37 +185,6 @@ static void print_device(void *a, void *b)
 	l_free(str);
 }
 
-static bool match_node_addr(const void *a, const void *b)
-{
-	const struct remote_node *rmt = a;
-	uint16_t addr = L_PTR_TO_UINT(b);
-
-	if (addr >= rmt->unicast &&
-				addr <= (rmt->unicast + rmt->num_ele - 1))
-		return true;
-
-	return false;
-}
-
-static uint16_t get_primary_subnet_idx(uint16_t addr)
-{
-	struct remote_node *rmt;
-
-	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
-
-	if (!rmt) {
-		bt_shell_printf("Net key not found: trying %4.4x\n",
-			PRIMARY_NET_IDX);
-		return prov_net_idx;
-		/*
-		 * TODO: When the remote node recovery from storage is
-		 * implemented, return NET_IDX_INVALID" here.
-		 */
-	}
-
-	return rmt->net_idx;
-}
-
 struct send_data {
 	const char *ele_path;
 	bool rmt;
@@ -278,7 +240,7 @@ static bool send_msg(void *user_data, uint16_t dst, uint16_t idx,
 	method_name = is_dev_key ? "DevKeySend" : "Send";
 
 	if (is_dev_key) {
-		net_idx_tx = get_primary_subnet_idx(dst);
+		net_idx_tx = remote_get_subnet_idx(dst);
 		if (net_idx_tx == NET_IDX_INVALID)
 			return false;
 	}
@@ -319,7 +281,7 @@ static bool send_key(void *user_data, uint16_t dst, uint16_t key_idx,
 	uint16_t net_idx;
 	const char *method_name = (!is_appkey) ? "AddNetKey" : "AddAppKey";
 
-	net_idx = get_primary_subnet_idx(dst);
+	net_idx = remote_get_subnet_idx(dst);
 	if (net_idx == NET_IDX_INVALID)
 		return false;
 
@@ -544,6 +506,7 @@ static void create_net_reply(struct l_dbus_proxy *proxy,
 	bt_shell_printf("Created new node with token %s\n", str);
 	l_free(str);
 
+	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
 	keys_add_net_key(PRIMARY_NET_IDX);
 
 	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
@@ -641,26 +604,9 @@ static void cmd_list_unprov(int argc, char *argv[])
 	l_queue_foreach(devices, print_device, NULL);
 }
 
-static void print_node(void *a, void *b)
-{
-	struct remote_node *node = a;
-	char *str;
-
-	bt_shell_printf(COLOR_YELLOW "Mesh node:\n" COLOR_OFF);
-	str = l_util_hexstring_upper(node->uuid, 16);
-	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
-	l_free(str);
-	bt_shell_printf("\t" COLOR_GREEN "primary = %4.4x\n" COLOR_OFF,
-								node->unicast);
-	bt_shell_printf("\t" COLOR_GREEN "elements = %u\n" COLOR_OFF,
-								node->num_ele);
-	bt_shell_printf("\t" COLOR_GREEN "net_key_idx = %3.3x\n" COLOR_OFF,
-								node->net_idx);
-}
-
 static void cmd_list_nodes(int argc, char *argv[])
 {
-	l_queue_foreach(nodes, print_node, NULL);
+	remote_print_all();
 }
 
 static void add_node_reply(struct l_dbus_proxy *proxy,
@@ -972,7 +918,6 @@ static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
 	uint8_t cnt;
 	uint32_t n;
 	uint8_t *uuid;
-	struct remote_node *node;
 
 	if (!prov_in_progress)
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
@@ -991,15 +936,11 @@ static struct l_dbus_message *add_node_cmplt_call(struct l_dbus *dbus,
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
 	}
 
-	node = l_new(struct remote_node, 1);
-	memcpy(node->uuid, uuid, 16);
-	node->unicast = unicast;
-	node->num_ele = cnt;
-	node->net_idx = prov_net_idx;
+	remote_add_node(uuid, unicast, cnt, prov_net_idx);
 
 	bt_shell_printf("Provisioning done:\n");
-	print_node(node, NULL);
-	l_queue_push_tail(nodes, node);
+	remote_print_node(unicast);
+
 	remove_device(uuid);
 
 	prov_address = unicast + cnt;
@@ -1227,7 +1168,6 @@ int main(int argc, char *argv[])
 
 	node_proxies = l_queue_new();
 	devices = l_queue_new();
-	nodes = l_queue_new();
 
 	status = bt_shell_run();
 
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
new file mode 100644
index 000000000..46839772f
--- /dev/null
+++ b/tools/mesh/remote.c
@@ -0,0 +1,124 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+
+#include "mesh/mesh-defs.h"
+#include "tools/mesh/remote.h"
+
+static struct l_queue *nodes;
+
+void remote_add_node(const uint8_t uuid[16], uint16_t unicast,
+					uint8_t ele_cnt, uint16_t net_idx)
+{
+	struct remote_node *rmt = l_new(struct remote_node, 1);
+
+	memcpy(rmt->uuid, uuid, 16);
+	rmt->unicast = unicast;
+	rmt->num_ele = ele_cnt;
+	rmt->net_keys = l_queue_new();
+
+	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
+
+	if (!nodes)
+		nodes = l_queue_new();
+
+	l_queue_push_tail(nodes, rmt);
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
+uint16_t remote_get_subnet_idx(uint16_t addr)
+{
+	struct remote_node *rmt;
+	uint32_t net_idx;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+
+	if (!rmt || l_queue_isempty(rmt->net_keys))
+		return NET_IDX_INVALID;
+
+	net_idx = L_PTR_TO_UINT(l_queue_peek_head(rmt->net_keys));
+
+	return (uint16_t) net_idx;
+}
+
+static void print_subnet(void *net_key, void *user_data)
+{
+	uint16_t net_idx = L_PTR_TO_UINT(net_key);
+
+	bt_shell_printf("%3.3x ", net_idx);
+}
+
+static void print_node(void *rmt, void *user_data)
+{
+	struct remote_node *node = rmt;
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
+	bt_shell_printf("\t" COLOR_GREEN "net_keys = ");
+	l_queue_foreach(node->net_keys, print_subnet, NULL);
+	bt_shell_printf("\n" COLOR_OFF);
+}
+
+void remote_print_node(uint16_t addr)
+{
+	struct remote_node *rmt;
+
+	if (!nodes)
+		return;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return;
+
+	print_node(rmt, NULL);
+}
+
+void remote_print_all(void)
+{
+	if (!nodes)
+		return;
+
+	l_queue_foreach(nodes, print_node, NULL);
+}
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
new file mode 100644
index 000000000..dce1619c0
--- /dev/null
+++ b/tools/mesh/remote.h
@@ -0,0 +1,31 @@
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
+struct remote_node {
+	uint16_t unicast;
+	struct l_queue *net_keys;
+	uint8_t uuid[16];
+	uint8_t num_ele;
+};
+
+void remote_add_node(const uint8_t uuid[16], uint16_t unicast,
+					uint8_t ele_cnt, uint16_t net_idx);
+uint16_t remote_get_subnet_idx(uint16_t addr);
+void remote_print_node(uint16_t addr);
+void remote_print_all(void);
-- 
2.21.0

