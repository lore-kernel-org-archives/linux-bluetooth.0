Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EFFC73C66
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E420C01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfGNXXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 19:23:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:39738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfGNXXb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 16:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="168805647"
Received: from rreichel-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.24.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 16:23:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 05/10 v3] mesh: Confine dependency on json-c to mesh-config-json.c
Date:   Sun, 14 Jul 2019 16:23:15 -0700
Message-Id: <20190714232320.20921-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes dependency on json-s/json.h header from everywhere
in the code except for mesh-config-json.c. The details about
node configuration storage format are obfuscated: a pointer
to an opaque mesh_config structure is stored with mesh_node and is
passed around to mae all the storage related operations.
---
 mesh/cfgmod-server.c    |  17 +-
 mesh/mesh-config-json.c | 558 +++++++++++++++++++++++++++-------------
 mesh/mesh-config.h      |  77 +++---
 mesh/model.c            |   1 -
 mesh/node.c             |  38 +--
 mesh/node.h             |   9 +-
 mesh/storage.c          | 205 +++++----------
 mesh/storage.h          |   4 +-
 8 files changed, 525 insertions(+), 384 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 0479a9185..c73e63b4e 100644
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
@@ -878,8 +876,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		count = (pkt[0] >> 5) + 1;
 		interval = ((pkt[0] & 0x1f) + 1) * 10;
-		if (storage_set_transmit_params(node_jconfig_get(node), count,
-								interval))
+		if (storage_set_transmit_params(node, count, interval))
 			mesh_net_transmit_params_set(net, count, interval);
 		/* Fall Through */
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index a0c3e27c0..096b93249 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -22,9 +22,14 @@
 #endif
 
 #define _GNU_SOURCE
+//#include <dirent.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <ftw.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <ell/ell.h>
 #include <json-c/json.h>
@@ -35,6 +40,12 @@
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
+struct mesh_config {
+	json_object *jnode;
+	char *node_path;
+	uint8_t uuid[16];
+};
+
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
 	json_object *jvalue;
@@ -446,13 +457,18 @@ fail:
 	return false;
 }
 
-bool mesh_config_net_key_add(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring;
+	json_object *jnode, *jarray = NULL, *jentry = NULL, *jstring;
 	char buf[5];
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	json_object_object_get_ex(jnode, "netKeys", &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
 
@@ -481,7 +497,7 @@ bool mesh_config_net_key_add(json_object *jobj, uint16_t idx,
 		jarray = json_object_new_array();
 		if (!jarray)
 			goto fail;
-		json_object_object_add(jobj, "netKeys", jarray);
+		json_object_object_add(jnode, "netKeys", jarray);
 	}
 
 	json_object_array_add(jarray, jentry);
@@ -494,13 +510,18 @@ fail:
 	return false;
 }
 
-bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry, *jstring;
+	json_object *jnode, *jarray, *jentry, *jstring;
 	const char *str;
 
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
 		return false;
 
 	jentry = get_key_object(jarray, idx);
@@ -525,11 +546,16 @@ bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
 	return true;
 }
 
-bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
+bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	json_object *jnode, *jarray, *jarray_new;
 
-	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
 		return true;
 
 	/* Check if matching entry exists */
@@ -537,7 +563,7 @@ bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
 		return true;
 
 	if (json_object_array_length(jarray) == 1) {
-		json_object_object_del(jobj, "netKeys");
+		json_object_object_del(jnode, "netKeys");
 		return true;
 	}
 
@@ -550,29 +576,40 @@ bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
 	if (!jarray_new)
 		return false;
 
-	json_object_object_del(jobj, "netKeys");
-	json_object_object_add(jobj, "netKeys", jarray_new);
+	json_object_object_del(jnode, "netKeys");
+	json_object_object_add(jnode, "netKeys", jarray_new);
 
 	return true;
 }
 
-bool mesh_config_write_device_key(json_object *jnode, uint8_t *key)
+bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
 {
-	return add_key_value(jnode, "deviceKey", key);
+	if (!cfg)
+		return false;
+
+	return add_key_value(cfg->jnode, "deviceKey", key);
 }
 
-bool mesh_config_write_token(json_object *jnode, uint8_t *token)
+bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
 {
-	return add_u64_value(jnode, "token", token);
+	if (!cfg)
+		return false;
+
+	return add_u64_value(cfg->jnode, "token", token);
 }
 
-bool mesh_config_app_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 					uint16_t app_idx, const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
+	json_object *jnode, *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
 
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	json_object_object_get_ex(jnode, "appKeys", &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
 
@@ -605,7 +642,7 @@ bool mesh_config_app_key_add(json_object *jobj, uint16_t net_idx,
 		jarray = json_object_new_array();
 		if (!jarray)
 			goto fail;
-		json_object_object_add(jobj, "appKeys", jarray);
+		json_object_object_add(jnode, "appKeys", jarray);
 	}
 
 	json_object_array_add(jarray, jentry);
@@ -619,13 +656,18 @@ fail:
 	return false;
 }
 
-bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	json_object *jnode, *jarray, *jentry = NULL, *jstring = NULL;
 	const char *str;
 
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	if (!json_object_object_get_ex(jnode, "appKeys", &jarray))
 		return false;
 
 	/* The key entry should exist if the key is updated */
@@ -644,11 +686,17 @@ bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
 	return add_key_value(jentry, "key", key);
 }
 
-bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
+bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
+								uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	json_object *jnode, *jarray, *jarray_new;
 
-	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	if (!json_object_object_get_ex(jnode, "appKeys", &jarray))
 		return true;
 
 	/* Check if matching entry exists */
@@ -656,7 +704,7 @@ bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 		return true;
 
 	if (json_object_array_length(jarray) == 1) {
-		json_object_object_del(jobj, "appKeys");
+		json_object_object_del(jnode, "appKeys");
 		return true;
 	}
 
@@ -669,19 +717,24 @@ bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 	if (!jarray_new)
 		return false;
 
-	json_object_object_del(jobj, "appKeys");
-	json_object_object_add(jobj, "appKeys", jarray_new);
+	json_object_object_del(jnode, "appKeys");
+	json_object_object_add(jnode, "appKeys", jarray_new);
 
 	return true;
 }
 
-bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
+bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
 					bool vendor, uint32_t mod_id,
 							uint16_t app_idx)
 {
-	json_object *jmodel, *jstring, *jarray = NULL;
+	json_object *jnode, *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
 
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
 	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
 	if (!jmodel)
 		return false;
@@ -710,13 +763,18 @@ bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
 	return true;
 }
 
-bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
+bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
 					bool vendor, uint32_t mod_id,
 							uint16_t app_idx)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	json_object *jnode, *jmodel, *jarray, *jarray_new;
 	char buf[5];
 
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
 	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
 	if (!jmodel)
 		return false;
@@ -1189,45 +1247,32 @@ static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 	return true;
 }
 
-bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
-							void *user_data)
+static bool read_node(json_object *jnode, struct mesh_config_node *node)
 {
-	struct mesh_config_node node;
 	json_object *jvalue;
 	char *str;
-	bool result = false;
-
-	if (!jnode)
-		return false;
-
-	if (!cb) {
-		l_info("Node read callback is required");
-		return false;
-	}
 
-	memset(&node, 0, sizeof(node));
-
-	if (!read_iv_index(jnode, &node.iv_index, &node.iv_update)) {
+	if (!read_iv_index(jnode, &node->iv_index, &node->iv_update)) {
 		l_info("Failed to read IV index");
 		return false;
 	}
 
-	if (!read_token(jnode, node.token)) {
+	if (!read_token(jnode, node->token)) {
 		l_info("Failed to read node token");
 		return false;
 	}
 
-	if (!read_device_key(jnode, node.dev_key)) {
+	if (!read_device_key(jnode, node->dev_key)) {
 		l_info("Failed to read node device key");
 		return false;
 	}
 
-	if (!parse_composition(jnode, &node)) {
+	if (!parse_composition(jnode, node)) {
 		l_info("Failed to parse local node composition");
 		return false;
 	}
 
-	parse_features(jnode, &node);
+	parse_features(jnode, node);
 
 	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
 		l_info("Bad config: Unicast address must be present");
@@ -1235,7 +1280,7 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 	}
 
 	str = (char *)json_object_get_string(jvalue);
-	if (sscanf(str, "%04hx", &node.unicast) != 1)
+	if (sscanf(str, "%04hx", &node->unicast) != 1)
 		return false;
 
 	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
@@ -1243,55 +1288,45 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 
 		if (ttl < 0 || ttl == 1 || ttl > DEFAULT_TTL)
 			return false;
-		node.ttl = (uint8_t) ttl;
+		node->ttl = (uint8_t) ttl;
 	}
 
 	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
-		node.seq_number = json_object_get_int(jvalue);
+		node->seq_number = json_object_get_int(jvalue);
 
 	/* Check for required "elements" property */
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
 		return false;
 
-	if (!read_net_transmit(jnode, &node)) {
+	if (!read_net_transmit(jnode, node)) {
 		l_info("Failed to read node net transmit parameters");
 		return false;
 	}
 
-	if (!read_net_keys(jnode, &node)) {
+	if (!read_net_keys(jnode, node)) {
 		l_info("Failed to read net keys");
-		goto done;
+		return false;
 	}
 
-	if (!read_app_keys(jnode, &node)) {
+	if (!read_app_keys(jnode, node)) {
 		l_info("Failed to read app keys");
-		goto done;
+		return false;
 	}
 
-	if (!parse_elements(jvalue, &node)) {
+	if (!parse_elements(jvalue, node)) {
 		l_info("Failed to parse elements");
-		goto done;
+		return false;
 	}
 
-	result = cb(&node, user_data);
-
-done:
-	l_free(node.net_transmit);
-	l_queue_destroy(node.netkeys, l_free);
-	l_queue_destroy(node.netkeys, l_free);
-
-	return result;
+	return true;
 }
 
-bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
+static bool write_uint16_hex(json_object *jobj, const char *desc,
 								uint16_t value)
 {
 	json_object *jstring;
 	char buf[5];
 
-	if (!jobj)
-		return false;
-
 	snprintf(buf, 5, "%4.4x", value);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
@@ -1301,15 +1336,21 @@ bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_uint16_hex(struct mesh_config *cfg, const char *desc,
+								uint16_t value)
+{
+	if (!cfg)
+		return false;
+
+	return write_uint16_hex(cfg->jnode, desc, value);
+}
+
+static bool write_uint32_hex(json_object *jobj, const char *desc,
 								uint32_t value)
 {
 	json_object *jstring;
 	char buf[9];
 
-	if (!jobj)
-		return false;
-
 	snprintf(buf, 9, "%8.8x", value);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
@@ -1319,13 +1360,19 @@ bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_int(json_object *jobj, const char *keyword, int value)
+bool mesh_config_write_uint32_hex(struct mesh_config *cfg, const char *desc,
+								uint32_t value)
 {
-	json_object *jvalue;
-
-	if (!jobj)
+	if (!cfg)
 		return false;
 
+	return write_uint32_hex(cfg->jnode, desc, value);
+}
+
+static bool write_int(json_object *jobj, const char *keyword, int value)
+{
+	json_object *jvalue;
+
 	json_object_object_del(jobj, keyword);
 
 	jvalue = json_object_new_int(value);
@@ -1336,20 +1383,32 @@ bool mesh_config_write_int(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value)
+bool mesh_config_write_int(struct mesh_config *cfg, const char *keyword,
+								int value)
 {
-	json_object *jvalue;
+	if (!cfg)
+		return false;
+
+	return write_int(cfg->jnode, keyword, value);
+}
 
-	if (!jobj)
+bool mesh_config_write_bool(struct mesh_config *cfg, const char *keyword,
+								bool value)
+{
+	json_object *jnode, *jvalue;
+
+	if (!cfg)
 		return false;
 
-	json_object_object_del(jobj, keyword);
+	jnode = cfg->jnode;
+
+	json_object_object_del(jnode, keyword);
 
 	jvalue = json_object_new_boolean(value);
 	if (!jvalue)
 		return false;
 
-	json_object_object_add(jobj, keyword, jvalue);
+	json_object_object_add(jnode, keyword, jvalue);
 	return true;
 }
 
@@ -1365,13 +1424,10 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value)
+static bool write_mode(json_object *jobj, const char *keyword, int value)
 {
 	json_object *jstring;
 
-	if (!jobj)
-		return false;
-
 	jstring = json_object_new_string(mode_to_string(value));
 
 	if (!jstring)
@@ -1382,30 +1438,36 @@ bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
+bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
+								int value)
+{
+	if (!cfg)
+		return false;
+
+	return write_mode(cfg->jnode, keyword, value);
+}
+
+static bool write_relay_mode(json_object *jobj, uint8_t mode,
 					uint8_t count, uint16_t interval)
 {
 	json_object *jrelay;
 
-	if (!jnode)
-		return false;
-
-	json_object_object_del(jnode, "relay");
+	json_object_object_del(jobj, "relay");
 
 	jrelay = json_object_new_object();
 	if (!jrelay)
 		return false;
 
-	if (!mesh_config_write_mode(jrelay, "mode", mode))
+	if (!write_mode(jrelay, "mode", mode))
 		goto fail;
 
-	if (!mesh_config_write_int(jrelay, "count", count))
+	if (!write_int(jrelay, "count", count))
 		goto fail;
 
-	if (!mesh_config_write_int(jrelay, "interval", interval))
+	if (!write_int(jrelay, "interval", interval))
 		goto fail;
 
-	json_object_object_add(jnode, "relay", jrelay);
+	json_object_object_add(jobj, "relay", jrelay);
 
 	return true;
 fail:
@@ -1413,27 +1475,38 @@ fail:
 	return false;
 }
 
-bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
+					uint8_t count, uint16_t interval)
+{
+
+	if (!cfg)
+		return false;
+
+	return write_relay_mode(cfg->jnode, mode, count, interval);
+}
+
+bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval)
 {
-	json_object *jretransmit;
+	json_object *jnode, *jretransmit;
 
-	if (!jobj)
+	if (!cfg)
 		return false;
+	jnode = cfg->jnode;
 
-	json_object_object_del(jobj, "retransmit");
+	json_object_object_del(jnode, "retransmit");
 
 	jretransmit = json_object_new_object();
 	if (jretransmit)
 		return false;
 
-	if (!mesh_config_write_int(jretransmit, "count", cnt))
+	if (!write_int(jretransmit, "count", cnt))
 		goto fail;
 
-	if (!mesh_config_write_int(jretransmit, "interval", interval))
+	if (!write_int(jretransmit, "interval", interval))
 		goto fail;
 
-	json_object_object_add(jobj, "retransmit", jretransmit);
+	json_object_object_add(jnode, "retransmit", jretransmit);
 
 	return true;
 fail:
@@ -1442,28 +1515,26 @@ fail:
 
 }
 
-bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update)
+bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
+								bool update)
 {
+	json_object *jnode;
 	int tmp = update ? 1 : 0;
 
-	if (!jobj)
+	if (!cfg)
 		return false;
 
-	if (!mesh_config_write_int(jobj, "IVindex", idx))
+	jnode = cfg->jnode;
+
+	if (!write_int(jnode, "IVindex", idx))
 		return false;
 
-	if (!mesh_config_write_int(jobj, "IVupdate", tmp))
+	if (!write_int(jnode, "IVupdate", tmp))
 		return false;
 
 	return true;
 }
 
-void mesh_config_remove_property(json_object *jobj, const char *desc)
-{
-	if (jobj)
-		json_object_object_del(jobj, desc);
-}
-
 static void add_model(void *a, void *b)
 {
 	struct mesh_config_model *mod = a;
@@ -1474,55 +1545,59 @@ static void add_model(void *a, void *b)
 		return;
 
 	if (!mod->vendor)
-		mesh_config_write_uint16_hex(jmodel, "modelId",
+		write_uint16_hex(jmodel, "modelId",
 						(uint16_t) mod->id);
 	else
-		mesh_config_write_uint32_hex(jmodel, "modelId", mod->id);
+		write_uint32_hex(jmodel, "modelId", mod->id);
 
 	json_object_array_add(jmodels, jmodel);
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
+struct mesh_config *mesh_config_create(const char *cfg_path,
+						const uint8_t uuid[16],
+						struct mesh_config_node *node)
 {
 	struct mesh_config_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
-	json_object *jelems;
+	json_object *jnode, *jelems;
+	struct mesh_config *cfg;
 
-	if (!jnode)
-		return false;
+	if (!cfg_path || !node)
+		return NULL;
+
+	jnode = json_object_new_object();
 
 	/* CID, PID, VID, crpl */
-	if (!mesh_config_write_uint16_hex(jnode, "cid", node->cid))
-		return false;
+	if (!write_uint16_hex(jnode, "cid", node->cid))
+		return NULL;
 
-	if (!mesh_config_write_uint16_hex(jnode, "pid", node->pid))
-		return false;
+	if (!write_uint16_hex(jnode, "pid", node->pid))
+		return NULL;
 
-	if (!mesh_config_write_uint16_hex(jnode, "vid", node->vid))
-		return false;
+	if (!write_uint16_hex(jnode, "vid", node->vid))
+		return NULL;
 
-	if (!mesh_config_write_uint16_hex(jnode, "crpl", node->crpl))
-		return false;
+	if (!write_uint16_hex(jnode, "crpl", node->crpl))
+		return NULL;
 
 	/* Features: relay, LPN, friend, proxy*/
-	if (!mesh_config_write_relay_mode(jnode, modes->relay.state,
-						modes->relay.cnt,
-						modes->relay.interval))
-		return false;
+	if (!write_relay_mode(jnode, modes->relay.state,
+				modes->relay.cnt, modes->relay.interval))
+		return NULL;
 
-	if (!mesh_config_write_mode(jnode, "lowPower", modes->lpn))
-		return false;
+	if (!write_mode(jnode, "lowPower", modes->lpn))
+		return NULL;
 
-	if (!mesh_config_write_mode(jnode, "friend", modes->friend))
-		return false;
+	if (!write_mode(jnode, "friend", modes->friend))
+		return NULL;
 
-	if (!mesh_config_write_mode(jnode, "proxy", modes->proxy))
-		return false;
+	if (!write_mode(jnode, "proxy", modes->proxy))
+		return NULL;
 
 	/* Beaconing state */
-	if (!mesh_config_write_mode(jnode, "beacon", modes->beacon))
-		return false;
+	if (!write_mode(jnode, "beacon", modes->beacon))
+		return NULL;
 
 	/* Sequence number */
 	json_object_object_add(jnode, "sequenceNumber",
@@ -1535,7 +1610,7 @@ bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
 	/* Elements */
 	jelems = json_object_new_array();
 	if (!jelems)
-		return false;
+		return NULL;
 
 	entry = l_queue_get_entries(node->elements);
 
@@ -1547,12 +1622,11 @@ bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
 
 		if (!jelement) {
 			json_object_put(jelems);
-			return false;
+			return NULL;
 		}
 
-		mesh_config_write_int(jelement, "elementIndex", ele->index);
-		mesh_config_write_uint16_hex(jelement, "location",
-								ele->location);
+		write_int(jelement, "elementIndex", ele->index);
+		write_uint16_hex(jelement, "location", ele->location);
 		json_object_array_add(jelems, jelement);
 
 		/* Models */
@@ -1562,7 +1636,7 @@ bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
 		jmodels = json_object_new_array();
 		if (!jmodels) {
 			json_object_put(jelems);
-			return false;
+			return NULL;
 		}
 
 		json_object_object_add(jelement, "models", jmodels);
@@ -1571,7 +1645,13 @@ bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
 
 	json_object_object_add(jnode, "elements", jelems);
 
-	return true;
+	cfg = l_new(struct mesh_config, 1);
+
+	cfg->jnode = jnode;
+	memcpy(cfg->uuid, uuid, 16);
+	cfg->node_path = l_strdup(cfg_path);
+
+	return cfg;
 }
 
 static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
@@ -1605,15 +1685,17 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 }
 
-bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 								uint8_t phase)
 {
-	json_object *jarray, *jentry = NULL;
+	json_object *jnode, *jarray, *jentry = NULL;
 
-	if (!jobj)
+	if (!cfg)
 		return false;
 
-	if (json_object_object_get_ex(jobj, "netKeys", &jarray))
+	jnode = cfg->jnode;
+
+	if (json_object_object_get_ex(jnode, "netKeys", &jarray))
 		jentry = get_key_object(jarray, idx);
 
 	if (!jentry)
@@ -1625,23 +1707,25 @@ bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
 
 	if (phase == KEY_REFRESH_PHASE_NONE) {
 		json_object_object_del(jentry, "oldKey");
-		finish_key_refresh(jobj, idx);
+		finish_key_refresh(jnode, idx);
 	}
 
 	return true;
 }
 
-bool mesh_config_model_pub_add(json_object *jnode, uint16_t addr,
+bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t addr,
 					uint32_t mod_id, bool vendor,
 					struct mesh_config_pub *pub)
 {
-	json_object *jmodel, *jpub, *jretransmit;
+	json_object *jnode, *jmodel, *jpub, *jretransmit;
 	bool res;
 	int ele_idx;
 
-	if (!jnode)
+	if (!cfg)
 		return false;
 
+	jnode = cfg->jnode;
+
 	ele_idx = get_element_index(jnode, addr);
 	if (ele_idx < 0)
 		return false;
@@ -1659,21 +1743,21 @@ bool mesh_config_model_pub_add(json_object *jnode, uint16_t addr,
 	if (pub->virt)
 		res = add_key_value(jpub, "address", pub->virt_addr);
 	else
-		res = mesh_config_write_uint16_hex(jpub, "address", pub->addr);
+		res = write_uint16_hex(jpub, "address", pub->addr);
 
 	if (!res)
 		goto fail;
 
-	if (!mesh_config_write_uint16_hex(jpub, "index", pub->idx))
+	if (!write_uint16_hex(jpub, "index", pub->idx))
 		goto fail;
 
-	if (!mesh_config_write_int(jpub, "ttl", pub->ttl))
+	if (!write_int(jpub, "ttl", pub->ttl))
 		goto fail;
 
-	if (!mesh_config_write_int(jpub, "period", pub->period))
+	if (!write_int(jpub, "period", pub->period))
 		goto fail;
 
-	if (!mesh_config_write_int(jpub, "credentials",
+	if (!write_int(jpub, "credentials",
 						pub->credential ? 1 : 0))
 		goto fail;
 
@@ -1681,10 +1765,10 @@ bool mesh_config_model_pub_add(json_object *jnode, uint16_t addr,
 	if (!jretransmit)
 		goto fail;
 
-	if (!mesh_config_write_int(jretransmit, "count", pub->count))
+	if (!write_int(jretransmit, "count", pub->count))
 		goto fail;
 
-	if (!mesh_config_write_int(jretransmit, "interval", pub->interval))
+	if (!write_int(jretransmit, "interval", pub->interval))
 		goto fail;
 
 	json_object_object_add(jpub, "retransmit", jretransmit);
@@ -1715,26 +1799,29 @@ static bool delete_model_property(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_pub_del(json_object *jnode, uint16_t addr,
+bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
-	if (!jnode)
+	if (!cfg)
 		return false;
 
-	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
+	return delete_model_property(cfg->jnode, addr, mod_id, vendor,
+								"publish");
 }
 
-bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub)
 {
-	json_object *jmodel, *jstring, *jarray = NULL;
+	json_object *jnode, *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
 	char buf[33];
 
-	if (!jnode)
+	if (!cfg)
 		return false;
 
+	jnode = cfg->jnode;
+
 	ele_idx = get_element_index(jnode, addr);
 	if (ele_idx < 0)
 		return false;
@@ -1773,17 +1860,19 @@ bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	json_object *jnode, *jmodel, *jarray, *jarray_new;
 	char buf[33];
 	int len, ele_idx;
 
-	if (!jnode)
+	if (!cfg)
 		return false;
 
+	jnode = cfg->jnode;
+
 	ele_idx = get_element_index(jnode, addr);
 	if (ele_idx < 0)
 		return false;
@@ -1826,11 +1915,126 @@ bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
+	if (!cfg)
+		return false;
+
+	return delete_model_property(cfg->jnode, addr, mod_id, vendor,
+								"subscribe");
+}
+
+bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
+					mesh_config_node_cb cb, void *user_data)
+{
+	int fd;
+	char *str;
+	struct stat st;
+	ssize_t sz;
+	bool result = false;
+	json_object *jnode;
+	struct mesh_config_node node;
+
+	if (!cb) {
+		l_info("Node read callback is required");
+		return false;
+	}
+
+	l_info("Loading configuration from %s", cfg_path);
+
+	fd = open(cfg_path, O_RDONLY);
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
+		l_error("Failed to read configuration file %s", cfg_path);
+		goto done;
+	}
+
+	jnode = json_tokener_parse(str);
 	if (!jnode)
+		goto done;
+
+	memset(&node, 0, sizeof(node));
+	result = read_node(jnode, &node);
+
+	if (result) {
+		struct mesh_config *cfg = l_new(struct mesh_config, 1);
+
+		cfg->jnode = jnode;
+		memcpy(cfg->uuid, uuid, 16);
+		cfg->node_path = l_strdup(cfg_path);
+		result = cb(&node, uuid, cfg, user_data);
+
+		if (!result) {
+			l_free(cfg->node_path);
+			l_free(cfg);
+		}
+	}
+
+	/* Done with the node: free resources */
+	l_free(node.net_transmit);
+	l_queue_destroy(node.netkeys, l_free);
+	l_queue_destroy(node.appkeys, l_free);
+
+	if (!result)
+		json_object_put(jnode);
+
+done:
+	close(fd);
+	if (str)
+		l_free(str);
+
+	return result;
+}
+
+void mesh_config_release(struct mesh_config *cfg)
+{
+	if (!cfg)
+		return;
+
+	l_free(cfg->node_path);
+	json_object_put(cfg->jnode);
+	l_free(cfg);
+}
+
+bool mesh_config_save_config(struct mesh_config *cfg, const char *fname)
+{
+	FILE *outfile;
+	const char *str;
+	bool result = false;
+
+	if (!cfg)
+		return false;
+
+	outfile = fopen(fname, "w");
+	if (!outfile) {
+		l_error("Failed to save configuration to %s", fname);
 		return false;
+	}
+
+	str = json_object_to_json_string_ext(cfg->jnode,
+						JSON_C_TO_STRING_PRETTY);
+
+	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
+		l_warn("Incomplete write of mesh configuration");
+	else
+		result = true;
+
+	fclose(outfile);
 
-	return delete_model_property(jnode, addr, mod_id, vendor, "subscribe");
+	return result;
 }
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 4ba02babb..8d01e760c 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -17,10 +17,12 @@
  *
  */
 
+struct mesh_config;
+
 struct mesh_config_sub {
 	bool virt;
 	union {
-		uint16_t addr;
+		uint16_t	addr;
 		uint8_t	virt_addr[16];
 	} src;
 };
@@ -104,59 +106,70 @@ struct mesh_config_node {
 };
 
 typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
+							const uint8_t uuid[16],
+							struct mesh_config *cfg,
 							void *user_data);
 
-bool mesh_config_read_node(json_object *jobj, mesh_config_node_cb cb,
-							void *user_data);
-bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node);
-bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
+				mesh_config_node_cb cb, void *user_data);
+void mesh_config_release(struct mesh_config *cfg);
+bool mesh_config_save_config(struct mesh_config *cfg, const char *fname);
+struct mesh_config *mesh_config_create(const char *cfg_path,
+						const uint8_t uuid[16],
+						struct mesh_config_node *node);
+
+bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval);
-bool mesh_config_write_device_key(json_object *jobj, uint8_t *key);
-bool mesh_config_write_token(json_object *jobj, uint8_t *token);
-bool mesh_config_write_network_key(json_object *jobj, uint16_t idx,
+bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key);
+bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token);
+bool mesh_config_write_network_key(struct mesh_config *cfg, uint16_t idx,
 				uint8_t *key, uint8_t *new_key, int phase);
-bool mesh_config_write_app_key(json_object *jobj, uint16_t net_idx,
+bool mesh_config_write_app_key(struct mesh_config *cfg, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_config_write_int(json_object *jobj, const char *keyword, int value);
-bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_int(struct mesh_config *cfg,
+						const char *keyword, int value);
+bool mesh_config_write_uint16_hex(struct mesh_config *cfg, const char *desc,
 								uint16_t value);
-bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_uint32_hex(struct mesh_config *cfg, const char *desc,
 								uint32_t value);
-bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value);
-bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
+bool mesh_config_write_bool(struct mesh_config *cfg, const char *keyword,
+								bool value);
+bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
-bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value);
-bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
+bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
+								int value);
+bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
 						bool vendor, uint32_t mod_id,
 							uint16_t app_idx);
-bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
+bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
 						bool vendor, uint32_t mod_id,
 							uint16_t app_idx);
-bool mesh_config_model_pub_add(json_object *jnode, uint16_t ele_addr,
+bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_pub *pub);
-bool mesh_config_model_pub_del(json_object *jnode, uint16_t ele_addr,
+bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub);
-bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub);
-bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_config_app_key_add(json_object *jnode, uint16_t net_idx,
+bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 				uint16_t app_idx, const uint8_t key[16]);
-bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
-bool mesh_config_net_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
+								uint16_t idx);
+bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t net_idx,
 							const uint8_t key[16]);
-bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 							const uint8_t key[16]);
-bool mesh_config_net_key_del(json_object *jobj, uint16_t net_idx);
-bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t net_idx);
+bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 								uint8_t phase);
-bool mesh_config_write_address(json_object *jobj, uint16_t address);
-bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update);
-void mesh_config_remove_property(json_object *jobj, const char *desc);
+bool mesh_config_write_address(struct mesh_config *cfg, uint16_t address);
+bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
+								bool update);
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
index fd344ddd7..025c7b59d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,7 +26,6 @@
 #include <sys/time.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
@@ -83,7 +82,8 @@ struct mesh_node {
 	char *owner;
 	char *obj_path;
 	struct mesh_agent *agent;
-	void *jconfig;
+	char *path;
+	struct mesh_config *cfg;
 	char *node_path;
 	uint32_t disc_watch;
 	time_t upd_sec;
@@ -393,9 +393,9 @@ static void set_app_key(void *a, void *b)
 						appkey->key, appkey->new_key);
 }
 
-bool node_init_from_storage(struct mesh_node *node, void *data)
+bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
+					struct mesh_config_node *db_node)
 {
-	struct mesh_config_node *db_node = data;
 	unsigned int num_ele;
 	uint8_t mode;
 
@@ -759,7 +759,7 @@ bool node_proxy_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	proxy = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, proxy, "proxy");
+	res = storage_set_mode(node, proxy, "proxy");
 
 	if (res) {
 		node->proxy = proxy;
@@ -786,7 +786,7 @@ bool node_beacon_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	beacon = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, beacon, "beacon");
+	res = storage_set_mode(node, beacon, "beacon");
 
 	if (res) {
 		node->beacon = beacon;
@@ -813,7 +813,7 @@ bool node_friend_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	friend = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node->jconfig, friend, "friend");
+	res = storage_set_mode(node, friend, "friend");
 
 	if (res) {
 		node->friend = friend;
@@ -1356,14 +1356,14 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 }
 
-static bool create_node_config(struct mesh_node *node)
+static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 {
 	struct mesh_config_node db_node;
 	const struct l_queue_entry *entry;
 	bool res;
 
 	convert_node_to_storage(node, &db_node);
-	res = storage_create_node_config(node, &db_node);
+	res = storage_create_node_config(node, uuid, &db_node);
 
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
@@ -1471,16 +1471,16 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	mesh_net_set_iv_index(node->net, iv_idx, ivu);
 
-	if (!mesh_config_write_uint16_hex(node->jconfig, "unicastAddress",
+	if (!mesh_config_write_uint16_hex(node->cfg, "unicastAddress",
 								unicast))
 		return false;
 
 	l_getrandom(node->token, sizeof(node->token));
-	if (!mesh_config_write_token(node->jconfig, node->token))
+	if (!mesh_config_write_token(node->cfg, node->token))
 		return false;
 
 	memcpy(node->dev_key, dev_key, 16);
-	if (!mesh_config_write_device_key(node->jconfig, dev_key))
+	if (!mesh_config_write_device_key(node->cfg, dev_key))
 		return false;
 
 	node->primary = unicast;
@@ -1496,7 +1496,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 							MESH_STATUS_SUCCESS)
 			return false;
 
-		if (!mesh_config_net_key_set_phase(node->jconfig, net_key_idx,
+		if (!mesh_config_net_key_set_phase(node->cfg, net_key_idx,
 							KEY_REFRESH_PHASE_TWO))
 			return false;
 	}
@@ -1634,7 +1634,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		set_defaults(node);
 		memcpy(node->uuid, req->data, 16);
 
-		if (!create_node_config(node))
+		if (!create_node_config(node, node->uuid))
 			goto fail;
 
 		cb(node, agent);
@@ -1649,7 +1649,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		set_defaults(node);
 		memcpy(node->uuid, req->data, 16);
 
-		if (!create_node_config(node))
+		if (!create_node_config(node, node->uuid))
 			goto fail;
 
 		/* Generate device and primary network keys */
@@ -2059,14 +2059,14 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
 			info->device_key, info->net_index, info->net_key);
 }
 
-void node_jconfig_set(struct mesh_node *node, void *jconfig)
+void node_config_set(struct mesh_node *node, struct mesh_config *cfg)
 {
-	node->jconfig = jconfig;
+	node->cfg = cfg;
 }
 
-void *node_jconfig_get(struct mesh_node *node)
+struct mesh_config *node_config_get(struct mesh_node *node)
 {
-	return node->jconfig;
+	return node->cfg;
 }
 
 void node_path_set(struct mesh_node *node, char *path)
diff --git a/mesh/node.h b/mesh/node.h
index d69887ed1..ee62737fc 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -21,6 +21,8 @@ struct mesh_net;
 struct mesh_node;
 struct mesh_io;
 struct mesh_agent;
+struct mesh_config;
+struct mesh_config_node;
 
 /* To prevent local node JSON cache thrashing, minimum update times */
 #define MIN_SEQ_TRIGGER	32
@@ -67,7 +69,8 @@ int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr);
 struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx,
 								int *status);
 uint16_t node_get_crpl(struct mesh_node *node);
-bool node_init_from_storage(struct mesh_node *node, void *data);
+bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
+					struct mesh_config_node *db_node);
 uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz);
 uint8_t node_lpn_mode_get(struct mesh_node *node);
 bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
@@ -97,8 +100,8 @@ void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
-void node_jconfig_set(struct mesh_node *node, void *jconfig);
-void *node_jconfig_get(struct mesh_node *node);
+void node_config_set(struct mesh_node *node, struct mesh_config *cfg);
+struct mesh_config *node_config_get(struct mesh_node *node);
 void node_path_set(struct mesh_node *node, char *path);
 char *node_path_get(struct mesh_node *node);
 struct mesh_agent *node_get_agent(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 645d84c97..869c6d70e 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -29,7 +29,6 @@
 #include <libgen.h>
 #include <ftw.h>
 
-#include <json-c/json.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
@@ -41,7 +40,7 @@
 #include "mesh/storage.h"
 
 struct write_info {
-	json_object *jnode;
+	struct mesh_config *cfg;
 	const char *node_path;
 	void *user_data;
 	mesh_status_func_t cb;
@@ -52,80 +51,41 @@ static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
-static bool read_node_cb(struct mesh_config_node *db_node, void *user_data)
+static bool read_node_cb(struct mesh_config_node *db_node,
+			const uint8_t uuid[16], struct mesh_config *cfg,
+			void *user_data)
 {
 	struct mesh_node *node = user_data;
 
-	if (!node_init_from_storage(node, db_node)) {
+	if (!node_init_from_storage(node, uuid, db_node)) {
 		node_remove(node);
 		return false;
 	}
 
+	node_config_set(node, cfg);
 	return true;
 }
 
 static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 {
-	int fd;
-	char *str;
-	struct stat st;
-	ssize_t sz;
-	json_object *jnode = NULL;
 	bool result = false;
 	struct mesh_node *node;
 
-	l_info("Loading configuration from %s", in_file);
-
-	fd = open(in_file, O_RDONLY);
-	if (fd < 0)
-		return false;
-
-	if (fstat(fd, &st) == -1) {
-		close(fd);
-		return false;
-	}
-
-	str = (char *) l_new(char, st.st_size + 1);
-	if (!str) {
-		close(fd);
-		return false;
-	}
-
-	sz = read(fd, str, st.st_size);
-	if (sz != st.st_size) {
-		l_error("Failed to read configuration file %s", in_file);
-		goto done;
-	}
-
-	jnode = json_tokener_parse(str);
-	if (!jnode)
-		goto done;
-
 	node = node_new(uuid);
 
-	result = mesh_config_read_node(jnode, read_node_cb, node);
+	result = mesh_config_load_node(in_file, uuid, read_node_cb, node);
 
-	if (!result) {
-		json_object_put(jnode);
+	if (!result)
 		node_remove(node);
-	}
-
-	node_jconfig_set(node, jnode);
-	node_path_set(node, out_dir);
-
-done:
-	close(fd);
-	if (str)
-		l_free(str);
+	else
+		node_path_set(node, out_dir);
 
 	return result;
 }
 
 bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
-	json_object *jnode = node_jconfig_get(node);
-
-	if (!mesh_config_write_int(jnode, "defaultTTL", ttl))
+	if (!mesh_config_write_int(node_config_get(node), "defaultTTL", ttl))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -135,9 +95,8 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 bool storage_set_relay(struct mesh_node *node, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
-
-	if (!mesh_config_write_relay_mode(jnode, enable, count, interval))
+	if (!mesh_config_write_relay_mode(node_config_get(node), enable, count,
+								interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -147,9 +106,8 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval)
 {
-	json_object *jnode = node_jconfig_get(node);
-
-	if (!mesh_config_write_net_transmit(jnode, count, interval))
+	if (!mesh_config_write_net_transmit(node_config_get(node), count,
+								interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -159,9 +117,7 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 						const char *mode_name)
 {
-	json_object *jnode = node_jconfig_get(node);
-
-	if (!mesh_config_write_mode(jnode, mode_name, mode))
+	if (!mesh_config_write_mode(node_config_get(node), mode_name, mode))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -171,7 +127,7 @@ bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 				uint16_t app_idx, bool unbind)
 {
-	json_object *jnode;
+	struct mesh_config *cfg;
 	int ele_idx;
 	bool stored, is_vendor = (mod_id > 0xffff);
 
@@ -179,14 +135,14 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 	if (ele_idx < 0)
 		return false;
 
-	jnode = node_jconfig_get(node);
+	cfg = node_config_get(node);
 
 	if (unbind)
-		stored = mesh_config_model_binding_del(jnode, ele_idx,
-						is_vendor, mod_id, app_idx);
+		stored = mesh_config_model_binding_del(cfg, ele_idx, is_vendor,
+							mod_id, app_idx);
 	else
-		stored = mesh_config_model_binding_add(jnode, ele_idx,
-						is_vendor, mod_id, app_idx);
+		stored = mesh_config_model_binding_add(cfg, ele_idx, is_vendor,
+							mod_id, app_idx);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -197,18 +153,16 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update)
 {
-	json_object *jnode;
+	struct mesh_config *cfg;
 	struct mesh_node *node = mesh_net_node_get(net);
 	bool stored;
 
-	jnode = node_jconfig_get(node);
-	if (!jnode)
-		return false;
+	cfg = node_config_get(node);
 
 	if (update)
-		stored = mesh_config_app_key_update(jnode, app_idx, key);
+		stored = mesh_config_app_key_update(cfg, app_idx, key);
 	else
-		stored = mesh_config_app_key_add(jnode, net_idx, app_idx, key);
+		stored = mesh_config_app_key_add(cfg, net_idx, app_idx, key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -219,14 +173,12 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 					uint16_t app_idx)
 {
-	json_object *jnode;
+	struct mesh_config *cfg;
 	struct mesh_node *node = mesh_net_node_get(net);
 
-	jnode = node_jconfig_get(node);
-	if (!jnode)
-		return false;
+	cfg = node_config_get(node);
 
-	if (!mesh_config_app_key_del(jnode, net_idx, app_idx))
+	if (!mesh_config_app_key_del(cfg, net_idx, app_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -237,13 +189,13 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct mesh_config *cfg = node_config_get(node);
 	bool stored;
 
 	if (!update)
-		stored = mesh_config_net_key_add(jnode, net_idx, key);
+		stored = mesh_config_net_key_add(cfg, net_idx, key);
 	else
-		stored = mesh_config_net_key_update(jnode, net_idx, key);
+		stored = mesh_config_net_key_update(cfg, net_idx, key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -254,9 +206,9 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct mesh_config *cfg = node_config_get(node);
 
-	if (!mesh_config_net_key_del(jnode, net_idx))
+	if (!mesh_config_net_key_del(cfg, net_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -267,9 +219,9 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct mesh_config *cfg = node_config_get(node);
 
-	if (!mesh_config_write_iv_index(jnode, iv_index, update))
+	if (!mesh_config_write_iv_index(cfg, iv_index, update))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -280,9 +232,9 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct mesh_config *cfg = node_config_get(node);
 
-	if (!mesh_config_net_key_set_phase(jnode, net_idx, phase))
+	if (!mesh_config_net_key_set_phase(cfg, net_idx, phase))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -292,39 +244,15 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_jconfig_get(node);
+	struct mesh_config *cfg = node_config_get(node);
 
-	if (!mesh_config_write_int(jnode, "sequenceNumber", seq))
+	if (!mesh_config_write_int(cfg, "sequenceNumber", seq))
 		return false;
 
 	storage_save_config(node, false, NULL, NULL);
 	return true;
 }
 
-static bool save_config(json_object *jnode, const char *config_name)
-{
-	FILE *outfile;
-	const char *str;
-	bool result = false;
-
-	outfile = fopen(config_name, "w");
-	if (!outfile) {
-		l_error("Failed to save configuration to %s", config_name);
-		return false;
-	}
-
-	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
-
-	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
-		l_warn("Incomplete write of mesh configuration");
-	else
-		result = true;
-
-	fclose(outfile);
-
-	return result;
-}
-
 static void idle_save_config(void *user_data)
 {
 	struct write_info *info = user_data;
@@ -337,7 +265,7 @@ static void idle_save_config(void *user_data)
 	remove(tmp);
 
 	l_debug("Storage-Wrote");
-	result = save_config(info->jnode, tmp);
+	result = mesh_config_save_config(info->cfg, tmp);
 
 	if (result) {
 		remove(bak);
@@ -362,7 +290,7 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 	struct write_info *info;
 
 	info = l_new(struct write_info, 1);
-	info->jnode = node_jconfig_get(node);
+	info->cfg = node_config_get(node);
 	info->node_path = node_path_get(node);
 	info->cb = cb;
 	info->user_data = user_data;
@@ -462,48 +390,47 @@ bool storage_load_nodes(const char *dir_name)
 	return true;
 }
 
-bool storage_create_node_config(struct mesh_node *node, void *data)
+bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
+					struct mesh_config_node *db_node)
 {
-	struct mesh_config_node *db_node = data;
-	char uuid[33];
+	char uuid_buf[33];
 	char name_buf[PATH_MAX];
-	json_object *jnode;
+	struct mesh_config *cfg;
 	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
 
 	if (!storage_dir)
 		return false;
 
-	jnode = json_object_new_object();
-
-	if (!mesh_config_add_node(jnode, db_node))
+	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
 		return false;
 
-	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
-		goto fail;
-
-	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid);
+	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid_buf);
 
 	if (strlen(name_buf) + max_len >= PATH_MAX)
-		goto fail;
+		return false;
 
 	/* Create a new directory and node.json file */
 	if (mkdir(name_buf, 0755) != 0)
-		goto fail;
+		return false;
 
 	node_path_set(node, name_buf);
 
-	snprintf(name_buf, PATH_MAX, "%s/%s%s", storage_dir, uuid, cfg_name);
+	snprintf(name_buf, PATH_MAX, "%s/%s%s", storage_dir, uuid_buf,
+								cfg_name);
 	l_debug("New node config %s", name_buf);
 
-	if (!save_config(jnode, name_buf))
-		goto fail;
+	cfg = mesh_config_create(name_buf, uuid, db_node);
+	if (!cfg)
+		return false;
 
-	node_jconfig_set(node, jnode);
+	if (!mesh_config_save_config(cfg, name_buf)) {
+		mesh_config_release(cfg);
+		return false;
+	}
+
+	node_config_set(node, cfg);
 
 	return true;
-fail:
-	json_object_put(jnode);
-	return false;
 }
 
 static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
@@ -529,17 +456,13 @@ void storage_remove_node_config(struct mesh_node *node)
 {
 	char *node_path, *node_name;
 	char uuid[33];
-	struct json_object *jnode;
 
 	if (!node)
 		return;
 
-	/* Free the node config json object */
-	jnode = node_jconfig_get(node);
-	if (jnode)
-		json_object_put(jnode);
-
-	node_jconfig_set(node, NULL);
+	/* Release node config object */
+	mesh_config_release(node_config_get(node));
+	node_config_set(node, NULL);
 
 	node_path = node_path_get(node);
 	l_debug("Delete node config %s", node_path);
diff --git a/mesh/storage.h b/mesh/storage.h
index a537ddb25..1fa48ad7a 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -19,9 +19,11 @@
 
 struct mesh_net;
 struct mesh_node;
+struct mesh_config_node;
 
 bool storage_load_nodes(const char *dir);
-bool storage_create_node_config(struct mesh_node *node, void *db_node);
+bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
+					struct mesh_config_node *db_node);
 void storage_remove_node_config(struct mesh_node *node);
 void storage_save_config(struct mesh_node *node, bool no_wait,
 					mesh_status_func_t cb, void *user_data);
-- 
2.21.0

