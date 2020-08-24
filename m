Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245BC433E8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616292071E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 03:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgHXDyV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:54:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:64620 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgHXDyT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Aug 2020 23:54:19 -0400
IronPort-SDR: 1Rz1tuAxjoOXC8w2SaiVgloNcArpDNEPTquI7qZPltBqSzEpb+ACCD7BXAkGEccgNfruikyIdA
 qHAV81X1iKrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220106400"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="220106400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 20:54:18 -0700
IronPort-SDR: wFhIElAgv5k63IvF+mlHDR/w0D5ATAtnYKTtZ3xvFTphzbQPIhulAiz09Gbc+R8WUW3ci6UIax
 rzxhgcnqR3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="322017095"
Received: from jlpajela-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.252.134.16])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2020 20:54:17 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Handle "options" dictionary in Send/Publish methods
Date:   Sun, 23 Aug 2020 20:54:13 -0700
Message-Id: <20200824035415.13420-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824035415.13420-1-inga.stotland@intel.com>
References: <20200824035415.13420-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds processing of "options" dictionary argument in Send,
DevKeySend, Publish & VendorPublish methods on mesh.Node interface.

Only "ForceSegmented" keyword is defined to require sending small
payloads as one-segment messages.
---
 mesh/cfgmod-server.c |  2 +-
 mesh/model.c         |  6 +--
 mesh/model.h         |  9 ++--
 mesh/node.c          | 99 +++++++++++++++++++++++++++++++-------------
 4 files changed, 77 insertions(+), 39 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 239ea889d..2e5da863a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -1088,7 +1088,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 	if (n)
 		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
-						DEFAULT_TTL, false, msg, n);
+						DEFAULT_TTL, false, n, msg);
 
 	return true;
 }
diff --git a/mesh/model.c b/mesh/model.c
index bb5d30083..7bbc9cca7 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -999,7 +999,7 @@ done:
 }
 
 int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
-					const void *msg, uint16_t msg_len)
+			bool segmented, uint16_t msg_len, const void *msg)
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
@@ -1041,7 +1041,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 	result = msg_send(node, mod->pub->credential != 0, src, mod->pub->addr,
 				mod->pub->idx, net_idx, label, mod->pub->ttl,
 				mod->pub->rtx.cnt, mod->pub->rtx.interval,
-				false, msg, msg_len);
+				segmented, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 }
@@ -1049,7 +1049,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
 					uint8_t ttl, bool segmented,
-					const void *msg, uint16_t msg_len)
+					uint16_t msg_len, const void *msg)
 {
 	struct mesh_net *net = node_get_net(node);
 	uint8_t cnt;
diff --git a/mesh/model.h b/mesh/model.h
index a1afedd19..fe0648d04 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -112,19 +112,16 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
-					uint16_t app_idx, uint16_t net_idx,
-					uint8_t ttl, bool segmented,
-					const void *msg, uint16_t msg_len);
+			uint16_t app_idx, uint16_t net_idx, uint8_t ttl,
+			bool segmented, uint16_t len, const void *data);
 int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
-					const void *msg, uint16_t msg_len);
+			bool segmented, uint16_t len, const void *data);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
 			uint16_t src, uint16_t dst, uint8_t key_aid,
 			const uint8_t *data, uint16_t size);
-void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
 void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
 				struct l_queue *models, uint16_t app_idx);
-struct l_queue *mesh_model_get_appkeys(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
 bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size, uint32_t *opcode,
 								uint16_t *n);
diff --git a/mesh/node.c b/mesh/node.c
index a6e9cee65..a06c290f9 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -134,6 +134,10 @@ struct managed_obj_request {
 	};
 };
 
+struct send_options {
+	bool segmented;
+};
+
 static struct l_queue *nodes;
 
 static bool match_device_uuid(const void *a, const void *b)
@@ -1745,13 +1749,33 @@ void node_build_attach_reply(struct mesh_node *node,
 	l_dbus_message_builder_destroy(builder);
 }
 
+static bool parse_send_options(struct l_dbus_message_iter *itr,
+						struct send_options *opts)
+{
+	const char *key;
+	struct l_dbus_message_iter var;
+
+	opts->segmented = false;
+
+	while (l_dbus_message_iter_next_entry(itr, &key, &var)) {
+		if (!strcmp(key, "ForceSegmented")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b",
+							&opts->segmented))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static struct l_dbus_message *send_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
 	const char *sender, *ele_path;
-	struct l_dbus_message_iter iter_data;
+	struct l_dbus_message_iter dict, iter_data;
+	struct send_options opts;
 	struct node_element *ele;
 	uint16_t dst, app_idx, net_idx, src;
 	uint8_t *data;
@@ -1764,8 +1788,8 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &dst,
-							&app_idx, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqqa{sv}ay", &ele_path, &dst,
+						&app_idx, &dict, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -1773,6 +1797,9 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
 							"Element not found");
 
+	if (!parse_send_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
@@ -1790,7 +1817,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 							"Key not found");
 
 	if (!mesh_model_send(node, src, dst, app_idx, net_idx, DEFAULT_TTL,
-							false, data, len))
+						opts.segmented, len, data))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1802,7 +1829,8 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 {
 	struct mesh_node *node = user_data;
 	const char *sender, *ele_path;
-	struct l_dbus_message_iter iter_data;
+	struct l_dbus_message_iter iter_data, dict;
+	struct send_options opts;
 	struct node_element *ele;
 	uint16_t dst, app_idx, net_idx, src;
 	bool remote;
@@ -1816,8 +1844,8 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqbqay", &ele_path, &dst,
-						&remote, &net_idx, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqbqa{sv}ay", &ele_path, &dst,
+					&remote, &net_idx, &dict, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	/* Loopbacks to local servers must use *remote* addressing */
@@ -1829,6 +1857,9 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
 							"Element not found");
 
+	if (!parse_send_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
@@ -1838,7 +1869,7 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 
 	app_idx = remote ? APP_IDX_DEV_REMOTE : APP_IDX_DEV_LOCAL;
 	if (!mesh_model_send(node, src, dst, app_idx, net_idx, DEFAULT_TTL,
-							false, data, len))
+						opts.segmented, len, data))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1896,7 +1927,7 @@ static struct l_dbus_message *add_netkey_call(struct l_dbus *dbus,
 	l_put_le16(sub_idx, &data[2]);
 
 	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
-						DEFAULT_TTL, false, data, 20))
+						DEFAULT_TTL, false, 20, data))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1962,7 +1993,7 @@ static struct l_dbus_message *add_appkey_call(struct l_dbus *dbus,
 	data[3] = app_idx >> 4;
 
 	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
-						DEFAULT_TTL, false, data, 20))
+						DEFAULT_TTL, false, 20, data))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1974,8 +2005,9 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 {
 	struct mesh_node *node = user_data;
 	const char *sender, *ele_path;
-	struct l_dbus_message_iter iter_data;
+	struct l_dbus_message_iter iter_data, dict;
 	uint16_t mod_id, src;
+	struct send_options opts;
 	struct node_element *ele;
 	uint8_t *data;
 	uint32_t len, id;
@@ -1988,8 +2020,8 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqay", &ele_path, &mod_id,
-								&iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqa{sv}ay", &ele_path, &mod_id,
+							&dict, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -1997,6 +2029,9 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
 							"Element not found");
 
+	if (!parse_send_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
@@ -2005,7 +2040,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 							"Incorrect data");
 
 	id = SET_ID(SIG_VENDOR, mod_id);
-	result = mesh_model_publish(node, id, src, data, len);
+	result = mesh_model_publish(node, id, src, opts.segmented, len, data);
 
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
@@ -2019,8 +2054,9 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 {
 	struct mesh_node *node = user_data;
 	const char *sender, *ele_path;
-	struct l_dbus_message_iter iter_data;
+	struct l_dbus_message_iter iter_data, dict;
 	uint16_t src, mod_id, vendor_id;
+	struct send_options opts;
 	struct node_element *ele;
 	uint8_t *data = NULL;
 	uint32_t len;
@@ -2033,8 +2069,8 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &vendor_id,
-							&mod_id, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqqa{sv}ay", &ele_path,
+					&vendor_id, &mod_id, &dict, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -2042,6 +2078,9 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
 							"Element not found");
 
+	if (!parse_send_options(&dict, &opts))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
@@ -2050,7 +2089,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 							"Incorrect data");
 
 	result = mesh_model_publish(node, SET_ID(vendor_id, mod_id), src,
-								data, len);
+						opts.segmented, len, data);
 
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
@@ -2192,27 +2231,29 @@ static bool addresses_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 
 static void setup_node_interface(struct l_dbus_interface *iface)
 {
-	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
+	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqa{sv}ay",
 						"element_path", "destination",
-						"key_index", "data");
-	l_dbus_interface_method(iface, "DevKeySend", 0, dev_key_send_call,
-						"", "oqbqay", "element_path",
+						"key_index", "options", "data");
+	l_dbus_interface_method(iface, "DevKeySend", 0, dev_key_send_call, "",
+						"oqbqa{sv}ay", "element_path",
 						"destination", "remote",
-						"net_index", "data");
+						"net_index", "options", "data");
 	l_dbus_interface_method(iface, "AddNetKey", 0, add_netkey_call, "",
 					"oqqqb", "element_path", "destination",
 					"subnet_index", "net_index", "update");
 	l_dbus_interface_method(iface, "AddAppKey", 0, add_appkey_call, "",
 					"oqqqb", "element_path", "destination",
 					"app_index", "net_index", "update");
-	l_dbus_interface_method(iface, "Publish", 0, publish_call, "", "oqay",
-					"element_path", "model_id", "data");
+	l_dbus_interface_method(iface, "Publish", 0, publish_call, "",
+					"oqa{sv}ay", "element_path", "model_id",
+							"options", "data");
 	l_dbus_interface_method(iface, "VendorPublish", 0, vendor_publish_call,
-						"", "oqqay", "element_path",
-						"vendor", "model_id", "data");
+					"", "oqqa{sv}ay", "element_path",
+						"vendor", "model_id", "options",
+									"data");
 
-	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
-									NULL);
+	l_dbus_interface_property(iface, "Features", 0, "a{sv}",
+							features_getter, NULL);
 	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
 	l_dbus_interface_property(iface, "IvUpdate", 0, "b", ivupdate_getter,
 									NULL);
-- 
2.26.2

