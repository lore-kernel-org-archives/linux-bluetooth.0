Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A6C74A41
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE620C01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfGNG2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:28:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:30355 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfGNG2X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 02:28:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 23:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,489,1557212400"; 
   d="scan'208";a="318387988"
Received: from ingas-nuc1.sea.intel.com ([10.251.146.93])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 23:28:18 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/10 v2] mesh: Move load from storage functionality into node.c
Date:   Sat, 13 Jul 2019 23:28:06 -0700
Message-Id: <20190714062812.31041-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714062812.31041-1-inga.stotland@intel.com>
References: <20190714062812.31041-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the initialization of a mesh node from stored
configuration from storage.c to node.c
---
 mesh/mesh-config-json.c | 255 +++++++++++++++++++++++-----------------
 mesh/mesh-config.h      |  59 +++++-----
 mesh/node.c             |  40 ++++++-
 mesh/storage.c          |  61 +---------
 4 files changed, 215 insertions(+), 200 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 8fcb8afe3..a0c3e27c0 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -252,7 +252,7 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
-bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
+static bool read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
 
@@ -270,7 +270,7 @@ bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 	return true;
 }
 
-bool mesh_config_read_token(json_object *jobj, uint8_t token[8])
+static bool read_token(json_object *jobj, uint8_t token[8])
 {
 	json_object *jvalue;
 	char *str;
@@ -288,7 +288,7 @@ bool mesh_config_read_token(json_object *jobj, uint8_t token[8])
 	return true;
 }
 
-bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16])
+static bool read_device_key(json_object *jobj, uint8_t key_buf[16])
 {
 	json_object *jvalue;
 	char *str;
@@ -306,78 +306,86 @@ bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
-bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
-							void *user_data)
+static bool get_key_index(json_object *jobj, const char *keyword,
+								uint16_t *index)
+{
+	int idx;
+
+	if (!get_int(jobj, keyword, &idx))
+		return false;
+
+	if (!CHECK_KEY_IDX_RANGE(idx))
+		return false;
+
+	*index = (uint16_t) idx;
+	return true;
+}
+
+static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 {
 	json_object *jarray;
 	int len;
 	int i;
 
-	if (!cb)
-		return true;
-
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
-		return false;
+		return true;
 
 	if (json_object_get_type(jarray) != json_type_array)
 		return false;
 
+	/* Allow empty AppKey array */
 	len = json_object_array_length(jarray);
+	if (!len)
+		return true;
+
+	node->appkeys = l_queue_new();
 
 	for (i = 0; i < len; ++i) {
 		json_object *jtemp, *jvalue;
-		int app_idx, net_idx;
-		bool key_refresh = false;
 		char *str;
-		uint8_t key[16];
-		uint8_t new_key[16];
+		struct mesh_config_appkey *appkey;
+
+		appkey = l_new(struct mesh_config_appkey, 1);
 
 		jtemp = json_object_array_get_idx(jarray, i);
 
-		if (!get_int(jtemp, "index", &app_idx))
-			return false;
+		if (!get_key_index(jtemp, "index", &appkey->app_idx))
+			goto fail;
 
-		if (!CHECK_KEY_IDX_RANGE(app_idx))
-			return false;
+		if (!get_key_index(jtemp, "boundNetKey", &appkey->net_idx))
+			goto fail;
 
-		if (!get_int(jtemp, "boundNetKey", &net_idx))
-			return false;
+		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
+			goto fail;
 
-		if (!CHECK_KEY_IDX_RANGE(net_idx))
-			return false;
+		str = (char *)json_object_get_string(jvalue);
+		if (!str2hex(str, strlen(str), appkey->new_key, 16))
+			goto fail;
 
-		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
+		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue))
 			str = (char *)json_object_get_string(jvalue);
-			if (!str2hex(str, strlen(str), key, 16))
-				return false;
-			key_refresh = true;
-		}
-
-		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
-			return false;
 
-		str = (char *)json_object_get_string(jvalue);
-		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
-			return false;
+		if (!str2hex(str, strlen(str), appkey->key, 16))
+			goto fail;
 
-		if (!cb((uint16_t)net_idx, (uint16_t) app_idx, key,
-				key_refresh ? new_key : NULL, user_data))
-			return false;
+		l_queue_push_tail(node->appkeys, appkey);
 	}
 
 	return true;
+fail:
+	l_queue_destroy(node->appkeys, l_free);
+	node->appkeys = NULL;
+
+	return false;
 }
 
-bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
-								void *user_data)
+static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
 {
 	json_object *jarray;
 	int len;
 	int i;
 
-	if (!cb)
-		return true;
-
+	/* At least one NetKey must be present for a provisioned node */
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return false;
 
@@ -385,50 +393,57 @@ bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
 		return false;
 
 	len = json_object_array_length(jarray);
+	if (!len)
+		return false;
+
+	node->netkeys = l_queue_new();
 
 	for (i = 0; i < len; ++i) {
 		json_object *jtemp, *jvalue;
-		int idx;
 		char *str;
-		bool key_refresh = false;
-		int phase;
-		uint8_t key[16];
-		uint8_t new_key[16];
+		struct mesh_config_netkey *netkey;
 
-		jtemp = json_object_array_get_idx(jarray, i);
-
-		if (!get_int(jtemp, "index", &idx))
-			return false;
+		netkey = l_new(struct mesh_config_netkey, 1);
 
-		if (!CHECK_KEY_IDX_RANGE(idx))
-			return false;
+		jtemp = json_object_array_get_idx(jarray, i);
 
-		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
-			str = (char *)json_object_get_string(jvalue);
-			if (!str2hex(str, strlen(str), key, 16))
-				return false;
-			key_refresh = true;
-		}
+		if (!get_key_index(jtemp, "index", &netkey->idx))
+			goto fail;
 
 		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
-			return false;
+			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
-		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
-			return false;
+		if (!str2hex(str, strlen(str), netkey->new_key, 16))
+			goto fail;
 
 		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
-			phase = KEY_REFRESH_PHASE_NONE;
+			netkey->phase = KEY_REFRESH_PHASE_NONE;
 		else
-			phase = json_object_get_int(jvalue);
+			netkey->phase = (uint8_t) json_object_get_int(jvalue);
 
+		if (netkey->phase > KEY_REFRESH_PHASE_TWO)
+			goto fail;
 
-		if (!cb((uint16_t)idx, key, key_refresh ? new_key : NULL, phase,
-								user_data))
-			return false;
+		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
+			if (netkey->phase == KEY_REFRESH_PHASE_NONE)
+				goto fail;
+
+			str = (char *)json_object_get_string(jvalue);
+		}
+
+		if (!str2hex(str, strlen(str), netkey->key, 16))
+			goto fail;
+
+		l_queue_push_tail(node->netkeys, netkey);
 	}
 
 	return true;
+fail:
+	l_queue_destroy(node->netkeys, l_free);
+	node->netkeys = NULL;
+
+	return false;
 }
 
 bool mesh_config_net_key_add(json_object *jobj, uint16_t idx,
@@ -787,21 +802,6 @@ static bool parse_bindings(json_object *jarray, struct mesh_config_model *mod)
 	return true;
 }
 
-static bool get_key_index(json_object *jobj, const char *keyword,
-								uint16_t *index)
-{
-	int idx;
-
-	if (!get_int(jobj, keyword, &idx))
-		return false;
-
-	if (!CHECK_KEY_IDX_RANGE(idx))
-		return false;
-
-	*index = (uint16_t) idx;
-	return true;
-}
-
 static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 {
 	json_object *jvalue;
@@ -1162,12 +1162,40 @@ static bool parse_composition(json_object *jcomp, struct mesh_config_node *node)
 	return true;
 }
 
+static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
+{
+	json_object *jretransmit, *jvalue;
+	uint16_t interval;
+	uint8_t cnt;
+
+	if (!json_object_object_get_ex(jobj, "retransmit", &jretransmit))
+		return true;
+
+	if (!json_object_object_get_ex(jretransmit, "count", &jvalue))
+		return false;
+
+	/* TODO: add range checking */
+	cnt = (uint8_t) json_object_get_int(jvalue);
+
+	if (!json_object_object_get_ex(jretransmit, "interval", &jvalue))
+		return false;
+
+	interval = (uint16_t) json_object_get_int(jvalue);
+
+	node->net_transmit = l_new(struct mesh_config_transmit, 1);
+	node->net_transmit->count = cnt;
+	node->net_transmit->interval = interval;
+
+	return true;
+}
+
 bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 							void *user_data)
 {
 	struct mesh_config_node node;
 	json_object *jvalue;
 	char *str;
+	bool result = false;
 
 	if (!jnode)
 		return false;
@@ -1179,6 +1207,21 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 
 	memset(&node, 0, sizeof(node));
 
+	if (!read_iv_index(jnode, &node.iv_index, &node.iv_update)) {
+		l_info("Failed to read IV index");
+		return false;
+	}
+
+	if (!read_token(jnode, node.token)) {
+		l_info("Failed to read node token");
+		return false;
+	}
+
+	if (!read_device_key(jnode, node.dev_key)) {
+		l_info("Failed to read node device key");
+		return false;
+	}
+
 	if (!parse_composition(jnode, &node)) {
 		l_info("Failed to parse local node composition");
 		return false;
@@ -1210,10 +1253,34 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
 		return false;
 
-	if (!parse_elements(jvalue, &node))
+	if (!read_net_transmit(jnode, &node)) {
+		l_info("Failed to read node net transmit parameters");
 		return false;
+	}
 
-	return cb(&node, user_data);
+	if (!read_net_keys(jnode, &node)) {
+		l_info("Failed to read net keys");
+		goto done;
+	}
+
+	if (!read_app_keys(jnode, &node)) {
+		l_info("Failed to read app keys");
+		goto done;
+	}
+
+	if (!parse_elements(jvalue, &node)) {
+		l_info("Failed to parse elements");
+		goto done;
+	}
+
+	result = cb(&node, user_data);
+
+done:
+	l_free(node.net_transmit);
+	l_queue_destroy(node.netkeys, l_free);
+	l_queue_destroy(node.netkeys, l_free);
+
+	return result;
 }
 
 bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
@@ -1346,30 +1413,6 @@ fail:
 	return false;
 }
 
-bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
-							uint16_t *interval)
-{
-	json_object *jretransmit, *jvalue;
-
-	if (!jobj)
-		return false;
-
-	if (!json_object_object_get_ex(jobj, "retransmit", &jretransmit))
-		return false;
-
-	if (!json_object_object_get_ex(jretransmit, "count", &jvalue))
-		return false;
-
-	*cnt = (uint8_t) json_object_get_int(jvalue);
-
-	if (!json_object_object_get_ex(jretransmit, "interval", &jvalue))
-		return false;
-
-	*interval = (uint16_t) json_object_get_int(jvalue);
-
-	return true;
-}
-
 bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
 							uint16_t interval)
 {
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index f60ae18cd..4ba02babb 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -65,55 +65,52 @@ struct mesh_config_modes {
 	uint8_t beacon;
 };
 
+struct mesh_config_netkey {
+	uint16_t idx;
+	uint8_t key[16];
+	uint8_t new_key[16];
+	uint8_t phase;
+};
+
+struct mesh_config_appkey {
+	uint16_t net_idx;
+	uint16_t app_idx;
+	uint8_t key[16];
+	uint8_t new_key[16];
+};
+
+struct mesh_config_transmit {
+	uint16_t interval;
+	uint8_t count;
+};
+
 struct mesh_config_node {
-	bool provisioner;
+	struct l_queue *elements;
+	struct l_queue *netkeys;
+	struct l_queue *appkeys;
 	uint32_t seq_number;
-	struct mesh_config_modes modes;
+	uint32_t iv_index;
+	bool iv_update;
 	uint16_t cid;
 	uint16_t pid;
 	uint16_t vid;
 	uint16_t crpl;
 	uint16_t unicast;
+	struct mesh_config_transmit *net_transmit;
+	struct mesh_config_modes modes;
 	uint8_t ttl;
-	struct l_queue *elements;
+	uint8_t dev_key[16];
+	uint8_t token[8];
 };
 
-struct mesh_config_prov {
-	uint16_t algorithm;
-	struct {
-		uint16_t actions;
-		uint8_t size;
-	} input_oob;
-	uint8_t pub_type;
-	struct {
-		uint16_t actions;
-		uint8_t size;
-	} output_oob;
-	uint8_t static_type;
-	uint8_t priv_key[32];
-};
-
-typedef bool (*mesh_config_net_key_cb)(uint16_t idx, uint8_t key[16],
-			uint8_t new_key[16], int phase, void *user_data);
-typedef bool (*mesh_config_app_key_cb)(uint16_t idx, uint16_t net_idx,
-			uint8_t key[16], uint8_t new_key[16], void *user_data);
 typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
 							void *user_data);
 
 bool mesh_config_read_node(json_object *jobj, mesh_config_node_cb cb,
 							void *user_data);
 bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node);
-bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
-bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16]);
-bool mesh_config_read_token(json_object *jobj, uint8_t token[8]);
-bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
-							uint16_t *interval);
 bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
 							uint16_t interval);
-bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
-							void *user_data);
-bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
-							void *user_data);
 bool mesh_config_write_device_key(json_object *jobj, uint8_t *key);
 bool mesh_config_write_token(json_object *jobj, uint8_t *token);
 bool mesh_config_write_network_key(json_object *jobj, uint16_t idx,
diff --git a/mesh/node.c b/mesh/node.c
index 6ebdcf588..2b49f86d9 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -31,6 +31,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
 #include "mesh/net.h"
+#include "mesh/appkey.h"
 #include "mesh/mesh-config.h"
 #include "mesh/provision.h"
 #include "mesh/storage.h"
@@ -373,6 +374,24 @@ static bool add_elements(struct mesh_node *node,
 	return true;
 }
 
+static void set_net_key(void *a, void *b)
+{
+	struct mesh_config_netkey *netkey = a;
+	struct mesh_node *node = b;
+
+	mesh_net_set_key(node->net, netkey->idx, netkey->key, netkey->new_key,
+								netkey->phase);
+}
+
+static void set_app_key(void *a, void *b)
+{
+	struct mesh_config_appkey *appkey = a;
+	struct mesh_node *node = b;
+
+	appkey_key_init(node->net, appkey->net_idx, appkey->app_idx,
+						appkey->key, appkey->new_key);
+}
+
 bool node_init_from_storage(struct mesh_node *node, void *data)
 {
 	struct mesh_config_node *db_node = data;
@@ -399,6 +418,9 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 	node->ttl = db_node->ttl;
 	node->seq_number = db_node->seq_number;
 
+	memcpy(node->dev_key, db_node->dev_key, 16);
+	memcpy(node->token, db_node->token, 8);
+
 	num_ele = l_queue_length(db_node->elements);
 	if (num_ele > 0xff)
 		return false;
@@ -410,6 +432,21 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 
 	node->primary = db_node->unicast;
 
+	if (!db_node->netkeys)
+		return false;
+
+	mesh_net_set_iv_index(node->net, db_node->iv_index, db_node->iv_update);
+
+	if (db_node->net_transmit)
+		mesh_net_transmit_params_set(node->net,
+					db_node->net_transmit->count,
+					db_node->net_transmit->interval);
+
+	l_queue_foreach(db_node->netkeys, set_net_key, node);
+
+	if (db_node->appkeys)
+		l_queue_foreach(db_node->appkeys, set_app_key, node);
+
 	mesh_net_set_seq_num(node->net, node->seq_number);
 	mesh_net_set_default_ttl(node->net, node->ttl);
 
@@ -434,9 +471,6 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 		!mesh_net_register_unicast(node->net, node->primary, num_ele))
 		return false;
 
-	if (node->uuid)
-		mesh_net_id_uuid_set(node->net, node->uuid);
-
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
 
diff --git a/mesh/storage.c b/mesh/storage.c
index 601669791..645d84c97 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -64,65 +64,6 @@ static bool read_node_cb(struct mesh_config_node *db_node, void *user_data)
 	return true;
 }
 
-static bool read_net_keys_cb(uint16_t idx, uint8_t *key, uint8_t *new_key,
-						int phase, void *user_data)
-{
-	struct mesh_net *net = user_data;
-
-	if (!net)
-		return false;
-
-	return mesh_net_set_key(net, idx, key, new_key, phase);
-}
-
-static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
-					uint8_t *new_key, void *user_data)
-{
-	struct mesh_net *net = user_data;
-
-	if (!net)
-		return false;
-
-	return appkey_key_init(net, net_idx, app_idx, key, new_key);
-}
-
-static bool parse_node(struct mesh_node *node, json_object *jnode)
-{
-	bool bvalue;
-	uint32_t iv_index;
-	uint8_t key_buf[16];
-	uint8_t cnt;
-	uint16_t interval;
-	struct mesh_net *net = node_get_net(node);
-
-	if (mesh_config_read_iv_index(jnode, &iv_index, &bvalue))
-		mesh_net_set_iv_index(net, iv_index, bvalue);
-
-	if (mesh_config_read_net_transmit(jnode, &cnt, &interval))
-		mesh_net_transmit_params_set(net, cnt, interval);
-
-	/* Node composition/configuration info */
-	if (!mesh_config_read_node(jnode, read_node_cb, node))
-		return false;
-
-	if (!mesh_config_read_net_keys(jnode, read_net_keys_cb, net))
-		return false;
-
-	if (!mesh_config_read_token(jnode, key_buf))
-		return false;
-
-	node_set_token(node, key_buf);
-
-	if (!mesh_config_read_device_key(jnode, key_buf))
-		return false;
-
-	node_set_device_key(node, key_buf);
-
-	mesh_config_read_app_keys(jnode, read_app_keys_cb, net);
-
-	return true;
-}
-
 static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 {
 	int fd;
@@ -162,7 +103,7 @@ static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 
 	node = node_new(uuid);
 
-	result = parse_node(node, jnode);
+	result = mesh_config_read_node(jnode, read_node_cb, node);
 
 	if (!result) {
 		json_object_put(jnode);
-- 
2.21.0

