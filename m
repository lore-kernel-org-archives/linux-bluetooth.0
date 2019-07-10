Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AACCC73C6E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1624C20844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGJFKH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:28140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfGJFKH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050336"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:06 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 5/9] mesh: Change variable prefix "jconfig" to "config"
Date:   Tue,  9 Jul 2019 22:09:55 -0700
Message-Id: <20190710050959.7321-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adjust variable naming by changing "jconfig" prefix to more generic
"config. This also removes #include json-c/json.h for model.c,
cfg-server.c and node.c as they no longer rely on the specifics of node
configuration storage implementation.
---
 mesh/cfgmod-server.c | 16 +++++++---------
 mesh/model.c         |  1 -
 mesh/node.c          | 25 ++++++++++++-------------
 mesh/node.h          |  4 ++--
 mesh/storage.c       | 34 +++++++++++++++++-----------------
 5 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 0479a9185..1aa7c85da 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -24,8 +24,6 @@
 #include <sys/time.h>
 #include <ell/ell.h>
 
-#include "json-c/json.h"
-
 #include "mesh/mesh-defs.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
@@ -197,7 +195,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 		/* Remove model publication from config file */
 		if (status == MESH_STATUS_SUCCESS)
-			mesh_config_model_pub_del(node_jconfig_get(node),
+			mesh_config_model_pub_del(node_config_get(node),
 				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
 									vendor);
 		goto done;
@@ -219,7 +217,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 			memcpy(db_pub.virt_addr, pub_addr, 16);
 
 		/* Save model publication to config file */
-		if (!mesh_config_model_pub_add(node_jconfig_get(node), ele_addr,
+		if (!mesh_config_model_pub_add(node_config_get(node), ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_pub))
 			status = MESH_STATUS_STORAGE_FAIL;
@@ -331,18 +329,18 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
 
 	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
 					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
-		mesh_config_model_sub_del_all(node_jconfig_get(node),
+		mesh_config_model_sub_del_all(node_config_get(node),
 				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
 									vendor);
 
 	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
 			opcode != OP_CONFIG_MODEL_SUB_DELETE)
-		return mesh_config_model_sub_add(node_jconfig_get(node),
+		return mesh_config_model_sub_add(node_config_get(node),
 					ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_sub);
 	else
-		return mesh_config_model_sub_del(node_jconfig_get(node),
+		return mesh_config_model_sub_del(node_config_get(node),
 					ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_sub);
@@ -419,7 +417,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
 
 		if (status == MESH_STATUS_SUCCESS)
-			mesh_config_model_sub_del_all(node_jconfig_get(node),
+			mesh_config_model_sub_del_all(node_config_get(node),
 				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
 									vendor);
 		break;
@@ -878,7 +876,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		count = (pkt[0] >> 5) + 1;
 		interval = ((pkt[0] & 0x1f) + 1) * 10;
-		if (storage_set_transmit_params(node_jconfig_get(node), count,
+		if (storage_set_transmit_params(node_config_get(node), count,
 								interval))
 			mesh_net_transmit_params_set(net, count, interval);
 		/* Fall Through */
diff --git a/mesh/model.c b/mesh/model.c
index 9331e1044..0f10727b4 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -23,7 +23,6 @@
 
 #include <sys/time.h>
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 
diff --git a/mesh/node.c b/mesh/node.c
index 6ebdcf588..82d917337 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,7 +26,6 @@
 #include <sys/time.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
@@ -81,7 +80,7 @@ struct mesh_node {
 	char *app_path;
 	char *owner;
 	char *path;
-	void *jconfig;
+	void *config;
 	char *node_path;
 	uint32_t disc_watch;
 	time_t upd_sec;
@@ -719,7 +718,7 @@ bool node_proxy_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	proxy = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, proxy, "proxy");
+	res = storage_set_mode(node->config, proxy, "proxy");
 
 	if (res) {
 		node->proxy = proxy;
@@ -746,7 +745,7 @@ bool node_beacon_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	beacon = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, beacon, "beacon");
+	res = storage_set_mode(node->config, beacon, "beacon");
 
 	if (res) {
 		node->beacon = beacon;
@@ -773,7 +772,7 @@ bool node_friend_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	friend = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, friend, "friend");
+	res = storage_set_mode(node->config, friend, "friend");
 
 	if (res) {
 		node->friend = friend;
@@ -1431,16 +1430,16 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	mesh_net_set_iv_index(node->net, iv_idx, ivu);
 
-	if (!mesh_config_write_uint16_hex(node->jconfig, "unicastAddress",
+	if (!mesh_config_write_uint16_hex(node->config, "unicastAddress",
 								unicast))
 		return false;
 
 	l_getrandom(node->token, sizeof(node->token));
-	if (!mesh_config_write_token(node->jconfig, node->token))
+	if (!mesh_config_write_token(node->config, node->token))
 		return false;
 
 	memcpy(node->dev_key, dev_key, 16);
-	if (!mesh_config_write_device_key(node->jconfig, dev_key))
+	if (!mesh_config_write_device_key(node->config, dev_key))
 		return false;
 
 	node->primary = unicast;
@@ -1456,7 +1455,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 							MESH_STATUS_SUCCESS)
 			return false;
 
-		if (!mesh_config_net_key_set_phase(node->jconfig, net_key_idx,
+		if (!mesh_config_net_key_set_phase(node->config, net_key_idx,
 							KEY_REFRESH_PHASE_TWO))
 			return false;
 	}
@@ -2016,14 +2015,14 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
 			info->device_key, info->net_index, info->net_key);
 }
 
-void node_jconfig_set(struct mesh_node *node, void *jconfig)
+void node_config_set(struct mesh_node *node, void *config)
 {
-	node->jconfig = jconfig;
+	node->config = config;
 }
 
-void *node_jconfig_get(struct mesh_node *node)
+void *node_config_get(struct mesh_node *node)
 {
-	return node->jconfig;
+	return node->config;
 }
 
 void node_path_set(struct mesh_node *node, char *path)
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..055862a7f 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -95,7 +95,7 @@ void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
-void node_jconfig_set(struct mesh_node *node, void *jconfig);
-void *node_jconfig_get(struct mesh_node *node);
+void node_config_set(struct mesh_node *node, void *config);
+void *node_config_get(struct mesh_node *node);
 void node_path_set(struct mesh_node *node, char *path);
 char *node_path_get(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 601669791..e87b58c59 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -169,7 +169,7 @@ static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 		node_remove(node);
 	}
 
-	node_jconfig_set(node, jnode);
+	node_config_set(node, jnode);
 	node_path_set(node, out_dir);
 
 done:
@@ -182,7 +182,7 @@ done:
 
 bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_int(jnode, "defaultTTL", ttl))
 		return false;
@@ -194,7 +194,7 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 bool storage_set_relay(struct mesh_node *node, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_relay_mode(jnode, enable, count, interval))
 		return false;
@@ -206,7 +206,7 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_net_transmit(jnode, count, interval))
 		return false;
@@ -218,7 +218,7 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 						const char *mode_name)
 {
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_mode(jnode, mode_name, mode))
 		return false;
@@ -238,7 +238,7 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 	if (ele_idx < 0)
 		return false;
 
-	jnode = node_jconfig_get(node);
+	jnode = node_config_get(node);
 
 	if (unbind)
 		stored = mesh_config_model_binding_del(jnode, ele_idx,
@@ -260,7 +260,7 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 	struct mesh_node *node = mesh_net_node_get(net);
 	bool stored;
 
-	jnode = node_jconfig_get(node);
+	jnode = node_config_get(node);
 	if (!jnode)
 		return false;
 
@@ -281,7 +281,7 @@ bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 	json_object *jnode;
 	struct mesh_node *node = mesh_net_node_get(net);
 
-	jnode = node_jconfig_get(node);
+	jnode = node_config_get(node);
 	if (!jnode)
 		return false;
 
@@ -296,7 +296,7 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 	bool stored;
 
 	if (!update)
@@ -313,7 +313,7 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_net_key_del(jnode, net_idx))
 		return false;
@@ -326,7 +326,7 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_iv_index(jnode, iv_index, update))
 		return false;
@@ -339,7 +339,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_net_key_set_phase(jnode, net_idx, phase))
 		return false;
@@ -351,7 +351,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	json_object *jnode = node_config_get(node);
 
 	if (!mesh_config_write_int(jnode, "sequenceNumber", seq))
 		return false;
@@ -421,7 +421,7 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 	struct write_info *info;
 
 	info = l_new(struct write_info, 1);
-	info->jnode = node_jconfig_get(node);
+	info->jnode = node_config_get(node);
 	info->node_path = node_path_get(node);
 	info->cb = cb;
 	info->user_data = user_data;
@@ -557,7 +557,7 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	if (!save_config(jnode, name_buf))
 		goto fail;
 
-	node_jconfig_set(node, jnode);
+	node_config_set(node, jnode);
 
 	return true;
 fail:
@@ -594,11 +594,11 @@ void storage_remove_node_config(struct mesh_node *node)
 		return;
 
 	/* Free the node config json object */
-	jnode = node_jconfig_get(node);
+	jnode = node_config_get(node);
 	if (jnode)
 		json_object_put(jnode);
 
-	node_jconfig_set(node, NULL);
+	node_config_set(node, NULL);
 
 	node_path = node_path_get(node);
 	l_debug("Delete node config %s", node_path);
-- 
2.21.0

