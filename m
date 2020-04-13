Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87340C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698932063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgDMRqK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:46:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:22053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgDMRqI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:46:08 -0400
IronPort-SDR: 7s4tejG5WxKJielnaOQrw7ES1chJ3ptGbGdUQSE8L0Gx0peSojgt3SG8vVJisIBBLjM5Z1UKri
 dDpY5ja3LO6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 10:46:08 -0700
IronPort-SDR: XiXG/uAU9SjcAoFgBibRpGxElk3vHRHx84X2oy4Mo602E+p9Vaa/nB40VeAf2TEtYO6idq4+Qx
 zSk86sZZyz+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="399680013"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.135.23.176])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 10:46:07 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, przemyslaw.fierek@silvair.com
Subject: [PATCH BlueZ v4 3/4] tools/mesh-cfgclient: Add waiting for 'JoinComplete'
Date:   Mon, 13 Apr 2020 10:45:34 -0700
Message-Id: <20200413174535.21488-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413174535.21488-1-brian.gix@intel.com>
References: <20200413174535.21488-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

---
 tools/mesh-cfgclient.c | 78 +++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 5b018eb4a..6db65cd49 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -707,44 +707,13 @@ static void attach_node_setup(struct l_dbus_message *msg, void *user_data)
 static void create_net_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *msg, void *user_data)
 {
-	char *str;
-	uint64_t tmp;
-
 	if (l_dbus_message_is_error(msg)) {
 		const char *name;
 
 		l_dbus_message_get_error(msg, &name, NULL);
 		l_error("Failed to create network: %s", name);
 		return;
-
-	}
-
-	if (!l_dbus_message_get_arguments(msg, "t", &tmp))
-		return;
-
-	local = l_new(struct meshcfg_node, 1);
-	local->token.u64 = l_get_be64(&tmp);
-	str = l_util_hexstring(&local->token.u8[0], 8);
-	bt_shell_printf("Created new node with token %s\n", str);
-	l_free(str);
-
-	if (!mesh_db_create(cfg_fname, local->token.u8,
-						"Mesh Config Client Network")) {
-		l_free(local);
-		local = NULL;
-		return;
 	}
-
-	mesh_db_set_addr_range(low_addr, high_addr);
-	keys_add_net_key(PRIMARY_NET_IDX);
-	mesh_db_net_key_add(PRIMARY_NET_IDX);
-
-	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
-	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
-
-	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
-						attach_node_reply, NULL,
-						NULL);
 }
 
 static void create_net_setup(struct l_dbus_message *msg, void *user_data)
@@ -1727,7 +1696,7 @@ static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
 static void setup_prov_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "ScanResult", 0, scan_result_call, "",
-						"naya{sv}", "rssi", "data", "options");
+					"naya{sv}", "rssi", "data", "options");
 
 	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
 				"qq", "y", "net_index", "unicast", "count");
@@ -1779,6 +1748,48 @@ static bool crpl_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static void attach_node(void *user_data)
+{
+	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
+						attach_node_reply, NULL,
+						NULL);
+}
+
+static struct l_dbus_message *join_complete(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	char *str;
+	uint64_t tmp;
+
+	if (!l_dbus_message_get_arguments(message, "t", &tmp))
+		return l_dbus_message_new_error(message, dbus_err_args, NULL);
+
+	local = l_new(struct meshcfg_node, 1);
+	local->token.u64 = l_get_be64(&tmp);
+	str = l_util_hexstring(&local->token.u8[0], 8);
+	bt_shell_printf("Created new node with token %s\n", str);
+	l_free(str);
+
+	if (!mesh_db_create(cfg_fname, local->token.u8,
+					"Mesh Config Client Network")) {
+		l_free(local);
+		local = NULL;
+		return l_dbus_message_new_error(message, dbus_err_fail, NULL);
+	}
+
+	mesh_db_set_addr_range(low_addr, high_addr);
+	keys_add_net_key(PRIMARY_NET_IDX);
+	mesh_db_net_key_add(PRIMARY_NET_IDX);
+
+	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+
+	l_idle_oneshot(attach_node, NULL, NULL);
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_app_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_property(iface, "CompanyID", 0, "q", cid_getter,
@@ -1789,6 +1800,9 @@ static void setup_app_iface(struct l_dbus_interface *iface)
 									NULL);
 	l_dbus_interface_property(iface, "CRPL", 0, "q", crpl_getter, NULL);
 
+	l_dbus_interface_method(iface, "JoinComplete", 0, join_complete,
+							"", "t", "token");
+
 	/* TODO: Methods */
 }
 
-- 
2.21.1

