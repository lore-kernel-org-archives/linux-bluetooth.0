Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44464C73C68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E972083D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfGJFKG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:28140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfGJFKG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050309"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/9] mesh: Change mesh_db prefix to mesh_config
Date:   Tue,  9 Jul 2019 22:09:53 -0700
Message-Id: <20190710050959.7321-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the naming the API declarations in mesh-config.h:
mesh_db_... ->mesh_config_...
---
 mesh/cfgmod-server.c    |  20 ++--
 mesh/mesh-config-json.c | 213 +++++++++++++++++++++-------------------
 mesh/mesh-config.h      | 122 ++++++++++++-----------
 mesh/model.c            |   4 +-
 mesh/node.c             |  36 +++----
 mesh/storage.c          |  54 +++++-----
 6 files changed, 234 insertions(+), 215 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 486c87307..0479a9185 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -197,14 +197,14 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 		/* Remove model publication from config file */
 		if (status == MESH_STATUS_SUCCESS)
-			mesh_db_model_pub_del(node_jconfig_get(node), ele_addr,
-					vendor ? mod_id : mod_id & 0x0000ffff,
-					vendor);
+			mesh_config_model_pub_del(node_jconfig_get(node),
+				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
+									vendor);
 		goto done;
 	}
 
 	if (status == MESH_STATUS_SUCCESS) {
-		struct mesh_db_pub db_pub = {
+		struct mesh_config_pub db_pub = {
 			.virt = b_virt,
 			.addr = ota,
 			.idx = idx,
@@ -219,7 +219,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 			memcpy(db_pub.virt_addr, pub_addr, 16);
 
 		/* Save model publication to config file */
-		if (!mesh_db_model_pub_add(node_jconfig_get(node), ele_addr,
+		if (!mesh_config_model_pub_add(node_jconfig_get(node), ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_pub))
 			status = MESH_STATUS_STORAGE_FAIL;
@@ -321,7 +321,7 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
 					const uint8_t *addr, bool virt,
 					uint16_t grp, uint32_t opcode)
 {
-	struct mesh_db_sub db_sub = {
+	struct mesh_config_sub db_sub = {
 				.virt = virt,
 				.src.addr = grp
 				};
@@ -331,18 +331,18 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
 
 	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
 					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
-		mesh_db_model_sub_del_all(node_jconfig_get(node),
+		mesh_config_model_sub_del_all(node_jconfig_get(node),
 				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
 									vendor);
 
 	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
 			opcode != OP_CONFIG_MODEL_SUB_DELETE)
-		return mesh_db_model_sub_add(node_jconfig_get(node),
+		return mesh_config_model_sub_add(node_jconfig_get(node),
 					ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_sub);
 	else
-		return mesh_db_model_sub_del(node_jconfig_get(node),
+		return mesh_config_model_sub_del(node_jconfig_get(node),
 					ele_addr,
 					vendor ? mod_id : mod_id & 0x0000ffff,
 					vendor, &db_sub);
@@ -419,7 +419,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
 
 		if (status == MESH_STATUS_SUCCESS)
-			mesh_db_model_sub_del_all(node_jconfig_get(node),
+			mesh_config_model_sub_del_all(node_jconfig_get(node),
 				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
 									vendor);
 		break;
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 35d0bd27e..8fcb8afe3 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -252,7 +252,7 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
-bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
+bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
 
@@ -270,7 +270,7 @@ bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 	return true;
 }
 
-bool mesh_db_read_token(json_object *jobj, uint8_t token[8])
+bool mesh_config_read_token(json_object *jobj, uint8_t token[8])
 {
 	json_object *jvalue;
 	char *str;
@@ -288,7 +288,7 @@ bool mesh_db_read_token(json_object *jobj, uint8_t token[8])
 	return true;
 }
 
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
+bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16])
 {
 	json_object *jvalue;
 	char *str;
@@ -306,7 +306,7 @@ bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
-bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
+bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
 							void *user_data)
 {
 	json_object *jarray;
@@ -368,7 +368,7 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 	return true;
 }
 
-bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
+bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
 								void *user_data)
 {
 	json_object *jarray;
@@ -431,7 +431,7 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 	return true;
 }
 
-bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_add(json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
 	json_object *jarray = NULL, *jentry = NULL, *jstring;
@@ -479,7 +479,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
 	json_object *jarray, *jentry, *jstring;
@@ -510,7 +510,7 @@ bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
 	return true;
 }
 
-bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
+bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
 
@@ -541,18 +541,18 @@ bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 	return true;
 }
 
-bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
+bool mesh_config_write_device_key(json_object *jnode, uint8_t *key)
 {
 	return add_key_value(jnode, "deviceKey", key);
 }
 
-bool mesh_db_write_token(json_object *jnode, uint8_t *token)
+bool mesh_config_write_token(json_object *jnode, uint8_t *token)
 {
 	return add_u64_value(jnode, "token", token);
 }
 
-bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
-							const uint8_t key[16])
+bool mesh_config_app_key_add(json_object *jobj, uint16_t net_idx,
+					uint16_t app_idx, const uint8_t key[16])
 {
 	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
@@ -604,7 +604,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16])
 {
 	json_object *jarray, *jentry = NULL, *jstring = NULL;
@@ -629,7 +629,7 @@ bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
 	return add_key_value(jentry, "key", key);
 }
 
-bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
+bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
 
@@ -660,8 +660,9 @@ bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 	return true;
 }
 
-bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
-				uint32_t mod_id, uint16_t app_idx)
+bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
+					bool vendor, uint32_t mod_id,
+							uint16_t app_idx)
 {
 	json_object *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
@@ -694,8 +695,9 @@ bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
 	return true;
 }
 
-bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
-				uint32_t mod_id, uint16_t app_idx)
+bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
+					bool vendor, uint32_t mod_id,
+							uint16_t app_idx)
 {
 	json_object *jmodel, *jarray, *jarray_new;
 	char buf[5];
@@ -734,7 +736,7 @@ bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
 
 static void free_model(void *data)
 {
-	struct mesh_db_model *mod = data;
+	struct mesh_config_model *mod = data;
 
 	l_free(mod->bindings);
 	l_free(mod->subs);
@@ -744,18 +746,18 @@ static void free_model(void *data)
 
 static void free_element(void *data)
 {
-	struct mesh_db_element *ele = data;
+	struct mesh_config_element *ele = data;
 
 	l_queue_destroy(ele->models, free_model);
 	l_free(ele);
 }
 
-static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
+static bool parse_bindings(json_object *jarray, struct mesh_config_model *mod)
 {
 	int cnt;
 	int i;
 
-	cnt = json_object_array_length(jbindings);
+	cnt = json_object_array_length(jarray);
 	if (cnt > 0xffff)
 		return false;
 
@@ -771,7 +773,7 @@ static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
 		int idx;
 		json_object *jvalue;
 
-		jvalue = json_object_array_get_idx(jbindings, i);
+		jvalue = json_object_array_get_idx(jarray, i);
 		if (!jvalue)
 			return false;
 
@@ -800,10 +802,10 @@ static bool get_key_index(json_object *jobj, const char *keyword,
 	return true;
 }
 
-static struct mesh_db_pub *parse_model_publication(json_object *jpub)
+static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 {
 	json_object *jvalue;
-	struct mesh_db_pub *pub;
+	struct mesh_config_pub *pub;
 	int len, value;
 	char *str;
 
@@ -812,7 +814,7 @@ static struct mesh_db_pub *parse_model_publication(json_object *jpub)
 
 	str = (char *)json_object_get_string(jvalue);
 	len = strlen(str);
-	pub = l_new(struct mesh_db_pub, 1);
+	pub = l_new(struct mesh_config_pub, 1);
 
 	switch (len) {
 	case 4:
@@ -862,9 +864,9 @@ fail:
 }
 
 static bool parse_model_subscriptions(json_object *jsubs,
-						struct mesh_db_model *mod)
+						struct mesh_config_model *mod)
 {
-	struct mesh_db_sub *subs;
+	struct mesh_config_sub *subs;
 	int i, cnt;
 
 	if (json_object_get_type(jsubs) != json_type_array)
@@ -875,7 +877,7 @@ static bool parse_model_subscriptions(json_object *jsubs,
 	if (!cnt)
 		return true;
 
-	subs = l_new(struct mesh_db_sub, cnt);
+	subs = l_new(struct mesh_config_sub, cnt);
 
 	for (i = 0; i < cnt; ++i) {
 		char *str;
@@ -913,7 +915,7 @@ fail:
 	return false;
 }
 
-static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
+static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 {
 	int i, num_models;
 
@@ -923,7 +925,7 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 
 	for (i = 0; i < num_models; ++i) {
 		json_object *jmodel, *jarray, *jvalue;
-		struct mesh_db_model *mod;
+		struct mesh_config_model *mod;
 		uint32_t id;
 		int len;
 		char *str;
@@ -932,7 +934,7 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 		if (!jmodel)
 			goto fail;
 
-		mod = l_new(struct mesh_db_model, 1);
+		mod = l_new(struct mesh_config_model, 1);
 
 		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
 			goto fail;
@@ -987,14 +989,14 @@ fail:
 	return false;
 }
 
-static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
+static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
 {
 	int i, num_ele;
 
-	if (json_object_get_type(jelements) != json_type_array)
+	if (json_object_get_type(jelems) != json_type_array)
 		return false;
 
-	num_ele = json_object_array_length(jelements);
+	num_ele = json_object_array_length(jelems);
 	if (!num_ele)
 		/* Allow "empty" nodes */
 		return true;
@@ -1005,11 +1007,11 @@ static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 		json_object *jelement;
 		json_object *jmodels;
 		json_object *jvalue;
-		struct mesh_db_element *ele;
+		struct mesh_config_element *ele;
 		int index;
 		char *str;
 
-		jelement = json_object_array_get_idx(jelements, i);
+		jelement = json_object_array_get_idx(jelems, i);
 		if (!jelement)
 			goto fail;
 
@@ -1017,7 +1019,7 @@ static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 								index > num_ele)
 			goto fail;
 
-		ele = l_new(struct mesh_db_element, 1);
+		ele = l_new(struct mesh_config_element, 1);
 		ele->index = index;
 		ele->models = l_queue_new();
 
@@ -1066,7 +1068,7 @@ static int get_mode(json_object *jvalue)
 	return 0xffffffff;
 }
 
-static void parse_features(json_object *jconfig, struct mesh_db_node *node)
+static void parse_features(json_object *jconfig, struct mesh_config_node *node)
 {
 	json_object *jvalue, *jrelay;
 	int mode, count;
@@ -1123,7 +1125,7 @@ static void parse_features(json_object *jconfig, struct mesh_db_node *node)
 	node->modes.relay.interval = interval;
 }
 
-static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
+static bool parse_composition(json_object *jcomp, struct mesh_config_node *node)
 {
 	json_object *jvalue;
 	char *str;
@@ -1160,9 +1162,10 @@ static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
 	return true;
 }
 
-bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
+bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
+							void *user_data)
 {
-	struct mesh_db_node node;
+	struct mesh_config_node node;
 	json_object *jvalue;
 	char *str;
 
@@ -1213,7 +1216,7 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	return cb(&node, user_data);
 }
 
-bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
 								uint16_t value)
 {
 	json_object *jstring;
@@ -1231,7 +1234,7 @@ bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
 								uint32_t value)
 {
 	json_object *jstring;
@@ -1249,7 +1252,7 @@ bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_db_write_int(json_object *jobj, const char *keyword, int value)
+bool mesh_config_write_int(json_object *jobj, const char *keyword, int value)
 {
 	json_object *jvalue;
 
@@ -1266,7 +1269,7 @@ bool mesh_db_write_int(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value)
+bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value)
 {
 	json_object *jvalue;
 
@@ -1295,7 +1298,7 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
+bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value)
 {
 	json_object *jstring;
 
@@ -1312,8 +1315,8 @@ bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
-							uint16_t interval)
+bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
+					uint8_t count, uint16_t interval)
 {
 	json_object *jrelay;
 
@@ -1326,13 +1329,13 @@ bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
 	if (!jrelay)
 		return false;
 
-	if (!mesh_db_write_mode(jrelay, "mode", mode))
+	if (!mesh_config_write_mode(jrelay, "mode", mode))
 		goto fail;
 
-	if (!mesh_db_write_int(jrelay, "count", count))
+	if (!mesh_config_write_int(jrelay, "count", count))
 		goto fail;
 
-	if (!mesh_db_write_int(jrelay, "interval", interval))
+	if (!mesh_config_write_int(jrelay, "interval", interval))
 		goto fail;
 
 	json_object_object_add(jnode, "relay", jrelay);
@@ -1343,7 +1346,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
+bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
 							uint16_t *interval)
 {
 	json_object *jretransmit, *jvalue;
@@ -1367,7 +1370,7 @@ bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
 	return true;
 }
 
-bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
 							uint16_t interval)
 {
 	json_object *jretransmit;
@@ -1381,10 +1384,10 @@ bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
 	if (jretransmit)
 		return false;
 
-	if (!mesh_db_write_int(jretransmit, "count", cnt))
+	if (!mesh_config_write_int(jretransmit, "count", cnt))
 		goto fail;
 
-	if (!mesh_db_write_int(jretransmit, "interval", interval))
+	if (!mesh_config_write_int(jretransmit, "interval", interval))
 		goto fail;
 
 	json_object_object_add(jobj, "retransmit", jretransmit);
@@ -1396,23 +1399,23 @@ fail:
 
 }
 
-bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update)
+bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update)
 {
 	int tmp = update ? 1 : 0;
 
 	if (!jobj)
 		return false;
 
-	if (!mesh_db_write_int(jobj, "IVindex", idx))
+	if (!mesh_config_write_int(jobj, "IVindex", idx))
 		return false;
 
-	if (!mesh_db_write_int(jobj, "IVupdate", tmp))
+	if (!mesh_config_write_int(jobj, "IVupdate", tmp))
 		return false;
 
 	return true;
 }
 
-void mesh_db_remove_property(json_object *jobj, const char *desc)
+void mesh_config_remove_property(json_object *jobj, const char *desc)
 {
 	if (jobj)
 		json_object_object_del(jobj, desc);
@@ -1420,7 +1423,7 @@ void mesh_db_remove_property(json_object *jobj, const char *desc)
 
 static void add_model(void *a, void *b)
 {
-	struct mesh_db_model *mod = a;
+	struct mesh_config_model *mod = a;
 	json_object *jmodels = b, *jmodel;
 
 	jmodel = json_object_new_object();
@@ -1428,54 +1431,54 @@ static void add_model(void *a, void *b)
 		return;
 
 	if (!mod->vendor)
-		mesh_db_write_uint16_hex(jmodel, "modelId",
+		mesh_config_write_uint16_hex(jmodel, "modelId",
 						(uint16_t) mod->id);
 	else
-		mesh_db_write_uint32_hex(jmodel, "modelId", mod->id);
+		mesh_config_write_uint32_hex(jmodel, "modelId", mod->id);
 
 	json_object_array_add(jmodels, jmodel);
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
-
-	struct mesh_db_modes *modes = &node->modes;
+bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
+{
+	struct mesh_config_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
-	json_object *jelements;
+	json_object *jelems;
 
 	if (!jnode)
 		return false;
 
 	/* CID, PID, VID, crpl */
-	if (!mesh_db_write_uint16_hex(jnode, "cid", node->cid))
+	if (!mesh_config_write_uint16_hex(jnode, "cid", node->cid))
 		return false;
 
-	if (!mesh_db_write_uint16_hex(jnode, "pid", node->pid))
+	if (!mesh_config_write_uint16_hex(jnode, "pid", node->pid))
 		return false;
 
-	if (!mesh_db_write_uint16_hex(jnode, "vid", node->vid))
+	if (!mesh_config_write_uint16_hex(jnode, "vid", node->vid))
 		return false;
 
-	if (!mesh_db_write_uint16_hex(jnode, "crpl", node->crpl))
+	if (!mesh_config_write_uint16_hex(jnode, "crpl", node->crpl))
 		return false;
 
 	/* Features: relay, LPN, friend, proxy*/
-	if (!mesh_db_write_relay_mode(jnode, modes->relay.state,
+	if (!mesh_config_write_relay_mode(jnode, modes->relay.state,
 						modes->relay.cnt,
 						modes->relay.interval))
 		return false;
 
-	if (!mesh_db_write_mode(jnode, "lowPower", modes->lpn))
+	if (!mesh_config_write_mode(jnode, "lowPower", modes->lpn))
 		return false;
 
-	if (!mesh_db_write_mode(jnode, "friend", modes->friend))
+	if (!mesh_config_write_mode(jnode, "friend", modes->friend))
 		return false;
 
-	if (!mesh_db_write_mode(jnode, "proxy", modes->proxy))
+	if (!mesh_config_write_mode(jnode, "proxy", modes->proxy))
 		return false;
 
 	/* Beaconing state */
-	if (!mesh_db_write_mode(jnode, "beacon", modes->beacon))
+	if (!mesh_config_write_mode(jnode, "beacon", modes->beacon))
 		return false;
 
 	/* Sequence number */
@@ -1487,26 +1490,27 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 						json_object_new_int(node->ttl));
 
 	/* Elements */
-	jelements = json_object_new_array();
-	if (!jelements)
+	jelems = json_object_new_array();
+	if (!jelems)
 		return false;
 
 	entry = l_queue_get_entries(node->elements);
 
 	for (; entry; entry = entry->next) {
-		struct mesh_db_element *ele = entry->data;
+		struct mesh_config_element *ele = entry->data;
 		json_object *jelement, *jmodels;
 
 		jelement = json_object_new_object();
 
 		if (!jelement) {
-			json_object_put(jelements);
+			json_object_put(jelems);
 			return false;
 		}
 
-		mesh_db_write_int(jelement, "elementIndex", ele->index);
-		mesh_db_write_uint16_hex(jelement, "location", ele->location);
-		json_object_array_add(jelements, jelement);
+		mesh_config_write_int(jelement, "elementIndex", ele->index);
+		mesh_config_write_uint16_hex(jelement, "location",
+								ele->location);
+		json_object_array_add(jelems, jelement);
 
 		/* Models */
 		if (l_queue_isempty(ele->models))
@@ -1514,7 +1518,7 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 
 		jmodels = json_object_new_array();
 		if (!jmodels) {
-			json_object_put(jelements);
+			json_object_put(jelems);
 			return false;
 		}
 
@@ -1522,7 +1526,7 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 		l_queue_foreach(ele->models, add_model, jmodels);
 	}
 
-	json_object_object_add(jnode, "elements", jelements);
+	json_object_object_add(jnode, "elements", jelems);
 
 	return true;
 }
@@ -1558,7 +1562,8 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 }
 
-bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
+bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
+								uint8_t phase)
 {
 	json_object *jarray, *jentry = NULL;
 
@@ -1583,8 +1588,9 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 	return true;
 }
 
-bool mesh_db_model_pub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_pub *pub)
+bool mesh_config_model_pub_add(json_object *jnode, uint16_t addr,
+					uint32_t mod_id, bool vendor,
+					struct mesh_config_pub *pub)
 {
 	json_object *jmodel, *jpub, *jretransmit;
 	bool res;
@@ -1610,31 +1616,32 @@ bool mesh_db_model_pub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	if (pub->virt)
 		res = add_key_value(jpub, "address", pub->virt_addr);
 	else
-		res = mesh_db_write_uint16_hex(jpub, "address", pub->addr);
+		res = mesh_config_write_uint16_hex(jpub, "address", pub->addr);
 
 	if (!res)
 		goto fail;
 
-	if (!mesh_db_write_uint16_hex(jpub, "index", pub->idx))
+	if (!mesh_config_write_uint16_hex(jpub, "index", pub->idx))
 		goto fail;
 
-	if (!mesh_db_write_int(jpub, "ttl", pub->ttl))
+	if (!mesh_config_write_int(jpub, "ttl", pub->ttl))
 		goto fail;
 
-	if (!mesh_db_write_int(jpub, "period", pub->period))
+	if (!mesh_config_write_int(jpub, "period", pub->period))
 		goto fail;
 
-	if (!mesh_db_write_int(jpub, "credentials", pub->credential ? 1 : 0))
+	if (!mesh_config_write_int(jpub, "credentials",
+						pub->credential ? 1 : 0))
 		goto fail;
 
 	jretransmit = json_object_new_object();
 	if (!jretransmit)
 		goto fail;
 
-	if (!mesh_db_write_int(jretransmit, "count", pub->count))
+	if (!mesh_config_write_int(jretransmit, "count", pub->count))
 		goto fail;
 
-	if (!mesh_db_write_int(jretransmit, "interval", pub->interval))
+	if (!mesh_config_write_int(jretransmit, "interval", pub->interval))
 		goto fail;
 
 	json_object_object_add(jpub, "retransmit", jretransmit);
@@ -1665,8 +1672,8 @@ static bool delete_model_property(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
-								bool vendor)
+bool mesh_config_model_pub_del(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor)
 {
 	if (!jnode)
 		return false;
@@ -1674,8 +1681,9 @@ bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
 }
 
-bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub)
+bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor,
+						struct mesh_config_sub *sub)
 {
 	json_object *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
@@ -1722,8 +1730,9 @@ bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	return true;
 }
 
-bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
-			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub)
+bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor,
+						struct mesh_config_sub *sub)
 {
 	json_object *jmodel, *jarray, *jarray_new;
 	char buf[33];
@@ -1774,7 +1783,7 @@ bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
 	if (!jnode)
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index da5efa12a..f60ae18cd 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -17,7 +17,7 @@
  *
  */
 
-struct mesh_db_sub {
+struct mesh_config_sub {
 	bool virt;
 	union {
 		uint16_t addr;
@@ -25,7 +25,7 @@ struct mesh_db_sub {
 	} src;
 };
 
-struct mesh_db_pub {
+struct mesh_config_pub {
 	bool virt;
 	uint32_t period;
 	uint16_t addr;
@@ -37,9 +37,9 @@ struct mesh_db_pub {
 	uint8_t virt_addr[16];
 };
 
-struct mesh_db_model {
-	struct mesh_db_sub *subs;
-	struct mesh_db_pub *pub;
+struct mesh_config_model {
+	struct mesh_config_sub *subs;
+	struct mesh_config_pub *pub;
 	uint16_t *bindings;
 	uint32_t id;
 	bool vendor;
@@ -47,13 +47,13 @@ struct mesh_db_model {
 	uint32_t num_subs;
 };
 
-struct mesh_db_element {
+struct mesh_config_element {
 	struct l_queue *models;
 	uint16_t location;
 	uint8_t index;
 };
 
-struct mesh_db_modes {
+struct mesh_config_modes {
 	struct {
 		uint16_t interval;
 		uint8_t cnt;
@@ -65,10 +65,10 @@ struct mesh_db_modes {
 	uint8_t beacon;
 };
 
-struct mesh_db_node {
+struct mesh_config_node {
 	bool provisioner;
 	uint32_t seq_number;
-	struct mesh_db_modes modes;
+	struct mesh_config_modes modes;
 	uint16_t cid;
 	uint16_t pid;
 	uint16_t vid;
@@ -78,7 +78,7 @@ struct mesh_db_node {
 	struct l_queue *elements;
 };
 
-struct mesh_db_prov {
+struct mesh_config_prov {
 	uint16_t algorithm;
 	struct {
 		uint16_t actions;
@@ -93,65 +93,73 @@ struct mesh_db_prov {
 	uint8_t priv_key[32];
 };
 
-typedef bool (*mesh_db_net_key_cb)(uint16_t idx, uint8_t key[16],
+typedef bool (*mesh_config_net_key_cb)(uint16_t idx, uint8_t key[16],
 			uint8_t new_key[16], int phase, void *user_data);
-typedef bool (*mesh_db_app_key_cb)(uint16_t idx, uint16_t net_idx,
+typedef bool (*mesh_config_app_key_cb)(uint16_t idx, uint16_t net_idx,
 			uint8_t key[16], uint8_t new_key[16], void *user_data);
-typedef bool (*mesh_db_node_cb)(struct mesh_db_node *node, void *user_data);
+typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
+							void *user_data);
 
-bool mesh_db_read_node(json_object *jobj, mesh_db_node_cb cb, void *user_data);
-bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node);
-bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16]);
-bool mesh_db_read_token(json_object *jobj, uint8_t token[8]);
-bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
+bool mesh_config_read_node(json_object *jobj, mesh_config_node_cb cb,
+							void *user_data);
+bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node);
+bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
+bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16]);
+bool mesh_config_read_token(json_object *jobj, uint8_t token[8]);
+bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
 							uint16_t *interval);
-bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
+bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
 							uint16_t interval);
-bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
+bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
 							void *user_data);
-bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
+bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
 							void *user_data);
-bool mesh_db_write_device_key(json_object *jobj, uint8_t *key);
-bool mesh_db_write_token(json_object *jobj, uint8_t *token);
-bool mesh_db_write_network_key(json_object *jobj, uint16_t idx, uint8_t *key,
-						uint8_t *new_key, int phase);
-bool mesh_db_write_app_key(json_object *jobj, uint16_t net_idx,
+bool mesh_config_write_device_key(json_object *jobj, uint8_t *key);
+bool mesh_config_write_token(json_object *jobj, uint8_t *token);
+bool mesh_config_write_network_key(json_object *jobj, uint16_t idx,
+				uint8_t *key, uint8_t *new_key, int phase);
+bool mesh_config_write_app_key(json_object *jobj, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_db_write_int(json_object *jobj, const char *keyword, int value);
-bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_int(json_object *jobj, const char *keyword, int value);
+bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
 								uint16_t value);
-bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
 								uint32_t value);
-bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value);
-bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
-							uint16_t interval);
-bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value);
-bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
-					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
-					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_model_pub_add(json_object *jnode, uint16_t ele_addr,
-			uint32_t mod_id, bool vendor, struct mesh_db_pub *pub);
-bool mesh_db_model_pub_del(json_object *jnode, uint16_t ele_addr,
+bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value);
+bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
+					uint8_t count, uint16_t interval);
+bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value);
+bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
+						bool vendor, uint32_t mod_id,
+							uint16_t app_idx);
+bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
+						bool vendor, uint32_t mod_id,
+							uint16_t app_idx);
+bool mesh_config_model_pub_add(json_object *jnode, uint16_t ele_addr,
+						uint32_t mod_id, bool vendor,
+						struct mesh_config_pub *pub);
+bool mesh_config_model_pub_del(json_object *jnode, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub);
-bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub);
-bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor,
+						struct mesh_config_sub *sub);
+bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor,
+						struct mesh_config_sub *sub);
+bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_app_key_add(json_object *jnode, uint16_t net_idx, uint16_t app_idx,
-							const uint8_t key[16]);
-bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_app_key_add(json_object *jnode, uint16_t net_idx,
+				uint16_t app_idx, const uint8_t key[16]);
+bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
-bool mesh_db_net_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
+bool mesh_config_net_key_add(json_object *jobj, uint16_t net_idx,
 							const uint8_t key[16]);
-bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
 							const uint8_t key[16]);
-bool mesh_db_net_key_del(json_object *jobj, uint16_t net_idx);
-bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase);
-bool mesh_db_write_address(json_object *jobj, uint16_t address);
-bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update);
-void mesh_db_remove_property(json_object *jobj, const char *desc);
+bool mesh_config_net_key_del(json_object *jobj, uint16_t net_idx);
+bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
+								uint8_t phase);
+bool mesh_config_write_address(json_object *jobj, uint16_t address);
+bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update);
+void mesh_config_remove_property(json_object *jobj, const char *desc);
diff --git a/mesh/model.c b/mesh/model.c
index 0474762e0..9331e1044 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1406,10 +1406,10 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 								void *data)
 {
-	struct mesh_db_model *db_mod = data;
+	struct mesh_config_model *db_mod = data;
 	struct mesh_model *mod;
 	struct mesh_net *net;
-	struct mesh_db_pub *pub = db_mod->pub;
+	struct mesh_config_pub *pub = db_mod->pub;
 	uint32_t i;
 
 	if (db_mod->num_bindings > MAX_BINDINGS) {
diff --git a/mesh/node.c b/mesh/node.c
index 06e809706..6ebdcf588 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -289,7 +289,7 @@ void node_remove(struct mesh_node *node)
 }
 
 static bool add_models(struct mesh_node *node, struct node_element *ele,
-						struct mesh_db_element *db_ele)
+					struct mesh_config_element *db_ele)
 {
 	const struct l_queue_entry *entry;
 
@@ -299,7 +299,7 @@ static bool add_models(struct mesh_node *node, struct node_element *ele,
 	entry = l_queue_get_entries(db_ele->models);
 	for (; entry; entry = entry->next) {
 		struct mesh_model *mod;
-		struct mesh_db_model *db_mod;
+		struct mesh_config_model *db_mod;
 
 		db_mod = entry->data;
 		mod = mesh_model_setup(node, ele->idx, db_mod);
@@ -317,7 +317,7 @@ static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
 {
 	struct node_element *ele;
 	struct mesh_model *mod;
-	struct mesh_db_model db_mod;
+	struct mesh_config_model db_mod;
 
 	ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(ele_idx));
@@ -338,7 +338,8 @@ static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
 	l_queue_push_tail(ele->models, mod);
 }
 
-static bool add_element(struct mesh_node *node, struct mesh_db_element *db_ele)
+static bool add_element(struct mesh_node *node,
+					struct mesh_config_element *db_ele)
 {
 	struct node_element *ele;
 
@@ -356,7 +357,8 @@ static bool add_element(struct mesh_node *node, struct mesh_db_element *db_ele)
 	return true;
 }
 
-static bool add_elements(struct mesh_node *node, struct mesh_db_node *db_node)
+static bool add_elements(struct mesh_node *node,
+					struct mesh_config_node *db_node)
 {
 	const struct l_queue_entry *entry;
 
@@ -373,7 +375,7 @@ static bool add_elements(struct mesh_node *node, struct mesh_db_node *db_node)
 
 bool node_init_from_storage(struct mesh_node *node, void *data)
 {
-	struct mesh_db_node *db_node = data;
+	struct mesh_config_node *db_node = data;
 	unsigned int num_ele;
 	uint8_t mode;
 
@@ -1260,7 +1262,7 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 }
 
 static void convert_node_to_storage(struct mesh_node *node,
-						struct mesh_db_node *db_node)
+					struct mesh_config_node *db_node)
 {
 	const struct l_queue_entry *entry;
 
@@ -1286,10 +1288,10 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
-		struct mesh_db_element *db_ele;
+		struct mesh_config_element *db_ele;
 		const struct l_queue_entry *mod_entry;
 
-		db_ele = l_new(struct mesh_db_element, 1);
+		db_ele = l_new(struct mesh_config_element, 1);
 
 		db_ele->index = ele->idx;
 		db_ele->location = ele->location;
@@ -1299,10 +1301,10 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 		for (; mod_entry; mod_entry = mod_entry->next) {
 			struct mesh_model *mod = mod_entry->data;
-			struct mesh_db_model *db_mod;
+			struct mesh_config_model *db_mod;
 			uint32_t mod_id = mesh_model_get_model_id(mod);
 
-			db_mod = l_new(struct mesh_db_model, 1);
+			db_mod = l_new(struct mesh_config_model, 1);
 			db_mod->id = mod_id;
 			db_mod->vendor = ((mod_id & VENDOR_ID_MASK)
 							!= VENDOR_ID_MASK);
@@ -1316,7 +1318,7 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 static bool create_node_config(struct mesh_node *node)
 {
-	struct mesh_db_node db_node;
+	struct mesh_config_node db_node;
 	const struct l_queue_entry *entry;
 	bool res;
 
@@ -1326,7 +1328,7 @@ static bool create_node_config(struct mesh_node *node)
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
 	for (; entry; entry = entry->next) {
-		struct mesh_db_element *db_ele = entry->data;
+		struct mesh_config_element *db_ele = entry->data;
 
 		l_queue_destroy(db_ele->models, l_free);
 	}
@@ -1429,16 +1431,16 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	mesh_net_set_iv_index(node->net, iv_idx, ivu);
 
-	if (!mesh_db_write_uint16_hex(node->jconfig, "unicastAddress",
+	if (!mesh_config_write_uint16_hex(node->jconfig, "unicastAddress",
 								unicast))
 		return false;
 
 	l_getrandom(node->token, sizeof(node->token));
-	if (!mesh_db_write_token(node->jconfig, node->token))
+	if (!mesh_config_write_token(node->jconfig, node->token))
 		return false;
 
 	memcpy(node->dev_key, dev_key, 16);
-	if (!mesh_db_write_device_key(node->jconfig, dev_key))
+	if (!mesh_config_write_device_key(node->jconfig, dev_key))
 		return false;
 
 	node->primary = unicast;
@@ -1454,7 +1456,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 							MESH_STATUS_SUCCESS)
 			return false;
 
-		if (!mesh_db_net_key_set_phase(node->jconfig, net_key_idx,
+		if (!mesh_config_net_key_set_phase(node->jconfig, net_key_idx,
 							KEY_REFRESH_PHASE_TWO))
 			return false;
 	}
diff --git a/mesh/storage.c b/mesh/storage.c
index bba2ef348..601669791 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -52,7 +52,7 @@ static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
-static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
+static bool read_node_cb(struct mesh_config_node *db_node, void *user_data)
 {
 	struct mesh_node *node = user_data;
 
@@ -95,30 +95,30 @@ static bool parse_node(struct mesh_node *node, json_object *jnode)
 	uint16_t interval;
 	struct mesh_net *net = node_get_net(node);
 
-	if (mesh_db_read_iv_index(jnode, &iv_index, &bvalue))
+	if (mesh_config_read_iv_index(jnode, &iv_index, &bvalue))
 		mesh_net_set_iv_index(net, iv_index, bvalue);
 
-	if (mesh_db_read_net_transmit(jnode, &cnt, &interval))
+	if (mesh_config_read_net_transmit(jnode, &cnt, &interval))
 		mesh_net_transmit_params_set(net, cnt, interval);
 
 	/* Node composition/configuration info */
-	if (!mesh_db_read_node(jnode, read_node_cb, node))
+	if (!mesh_config_read_node(jnode, read_node_cb, node))
 		return false;
 
-	if (!mesh_db_read_net_keys(jnode, read_net_keys_cb, net))
+	if (!mesh_config_read_net_keys(jnode, read_net_keys_cb, net))
 		return false;
 
-	if (!mesh_db_read_token(jnode, key_buf))
+	if (!mesh_config_read_token(jnode, key_buf))
 		return false;
 
 	node_set_token(node, key_buf);
 
-	if (!mesh_db_read_device_key(jnode, key_buf))
+	if (!mesh_config_read_device_key(jnode, key_buf))
 		return false;
 
 	node_set_device_key(node, key_buf);
 
-	mesh_db_read_app_keys(jnode, read_app_keys_cb, net);
+	mesh_config_read_app_keys(jnode, read_app_keys_cb, net);
 
 	return true;
 }
@@ -184,7 +184,7 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_int(jnode, "defaultTTL", ttl))
+	if (!mesh_config_write_int(jnode, "defaultTTL", ttl))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -196,7 +196,7 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 {
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_relay_mode(jnode, enable, count, interval))
+	if (!mesh_config_write_relay_mode(jnode, enable, count, interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -208,7 +208,7 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 {
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_net_transmit(jnode, count, interval))
+	if (!mesh_config_write_net_transmit(jnode, count, interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -220,7 +220,7 @@ bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 {
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_mode(jnode, mode_name, mode))
+	if (!mesh_config_write_mode(jnode, mode_name, mode))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -241,11 +241,11 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 	jnode = node_jconfig_get(node);
 
 	if (unbind)
-		stored = mesh_db_model_binding_del(jnode, ele_idx, is_vendor,
-							mod_id, app_idx);
+		stored = mesh_config_model_binding_del(jnode, ele_idx,
+						is_vendor, mod_id, app_idx);
 	else
-		stored = mesh_db_model_binding_add(jnode, ele_idx, is_vendor,
-							mod_id, app_idx);
+		stored = mesh_config_model_binding_add(jnode, ele_idx,
+						is_vendor, mod_id, app_idx);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -265,9 +265,9 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 		return false;
 
 	if (update)
-		stored = mesh_db_app_key_update(jnode, app_idx, key);
+		stored = mesh_config_app_key_update(jnode, app_idx, key);
 	else
-		stored = mesh_db_app_key_add(jnode, net_idx, app_idx, key);
+		stored = mesh_config_app_key_add(jnode, net_idx, app_idx, key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -285,7 +285,7 @@ bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 	if (!jnode)
 		return false;
 
-	if (!mesh_db_app_key_del(jnode, net_idx, app_idx))
+	if (!mesh_config_app_key_del(jnode, net_idx, app_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -300,9 +300,9 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 	bool stored;
 
 	if (!update)
-		stored = mesh_db_net_key_add(jnode, net_idx, key);
+		stored = mesh_config_net_key_add(jnode, net_idx, key);
 	else
-		stored = mesh_db_net_key_update(jnode, net_idx, key);
+		stored = mesh_config_net_key_update(jnode, net_idx, key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -315,7 +315,7 @@ bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_net_key_del(jnode, net_idx))
+	if (!mesh_config_net_key_del(jnode, net_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -328,7 +328,7 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_iv_index(jnode, iv_index, update))
+	if (!mesh_config_write_iv_index(jnode, iv_index, update))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -341,7 +341,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_net_key_set_phase(jnode, net_idx, phase))
+	if (!mesh_config_net_key_set_phase(jnode, net_idx, phase))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -353,7 +353,7 @@ bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	if (!mesh_db_write_int(jnode, "sequenceNumber", seq))
+	if (!mesh_config_write_int(jnode, "sequenceNumber", seq))
 		return false;
 
 	storage_save_config(node, false, NULL, NULL);
@@ -523,7 +523,7 @@ bool storage_load_nodes(const char *dir_name)
 
 bool storage_create_node_config(struct mesh_node *node, void *data)
 {
-	struct mesh_db_node *db_node = data;
+	struct mesh_config_node *db_node = data;
 	char uuid[33];
 	char name_buf[PATH_MAX];
 	json_object *jnode;
@@ -534,7 +534,7 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 
 	jnode = json_object_new_object();
 
-	if (!mesh_db_add_node(jnode, db_node))
+	if (!mesh_config_add_node(jnode, db_node))
 		return false;
 
 	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
-- 
2.21.0

