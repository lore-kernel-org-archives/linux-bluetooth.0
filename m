Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1EC4360F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04F620657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfCKVk4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:40:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:31644 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfCKVk4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 17:40:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="121792158"
Received: from bgix-dell-lap.sea.intel.com ([10.251.149.88])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2019 14:40:55 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 1/1] mesh: Fix json-c calling conventions
Date:   Mon, 11 Mar 2019 14:40:49 -0700
Message-Id: <20190311214049.28744-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix issue assuming that failed calls to json_object_object_get_ex() will
always NULL the out parameter. Re-coded to always check the returned
boolean for success or failure.
---
 mesh/mesh-db.c | 204 +++++++++++++++++++++++----------------------------------
 1 file changed, 82 insertions(+), 122 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index d5d19d52f..f1bf8d8fa 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -72,16 +72,14 @@ static int get_element_index(json_object *jnode, uint16_t ele_addr)
 	uint16_t addr, num_ele;
 	char *str;
 
-	json_object_object_get_ex(jnode, "unicastAddress", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue))
 		return -1;
 
 	str = (char *)json_object_get_string(jvalue);
 	if (sscanf(str, "%04hx", &addr) != 1)
 		return -1;
 
-	json_object_object_get_ex(jnode, "elements", &jelements);
-	if (!jelements)
+	if (!json_object_object_get_ex(jnode, "elements", &jelements))
 		return -1;
 
 	num_ele = json_object_array_length(jelements);
@@ -105,16 +103,14 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	else
 		snprintf(buf, 9, "%8.8x", mod_id);
 
-	json_object_object_get_ex(jnode, "elements", &jelements);
-	if (!jelements)
+	if (!json_object_object_get_ex(jnode, "elements", &jelements))
 		return NULL;
 
 	jelement = json_object_array_get_idx(jelements, ele_idx);
 	if (!jelement)
 		return NULL;
 
-	json_object_object_get_ex(jelement, "models", &jmodels);
-	if (!jmodels)
+	if (!json_object_object_get_ex(jelement, "models", &jmodels))
 		return NULL;
 
 	num_mods = json_object_array_length(jmodels);
@@ -134,8 +130,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 		char *str;
 
 		jmodel = json_object_array_get_idx(jmodels, i);
-		json_object_object_get_ex(jmodel, "modelId", &jvalue);
-		if (!jvalue)
+		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
 			return NULL;
 
 		str = (char *)json_object_get_string(jvalue);
@@ -270,8 +265,7 @@ bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
 	if (!key_buf)
 		return false;
 
-	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue) ||
-								!jvalue)
+	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
@@ -291,8 +285,10 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 	if (!cb)
 		return true;
 
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (!jarray || (json_object_get_type(jarray) != json_type_array))
+	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
+		return false;
+
+	if (json_object_get_type(jarray) != json_type_array)
 		return false;
 
 	len = json_object_array_length(jarray);
@@ -319,16 +315,14 @@ bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
 		if (!CHECK_KEY_IDX_RANGE(net_idx))
 			return false;
 
-		json_object_object_get_ex(jtemp, "oldKey", &jvalue);
-		if (jvalue) {
+		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
 			str = (char *)json_object_get_string(jvalue);
 			if (!str2hex(str, strlen(str), key, 16))
 				return false;
 			key_refresh = true;
 		}
 
-		json_object_object_get_ex(jtemp, "key", &jvalue);
-		if (!jvalue)
+		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
 			return false;
 
 		str = (char *)json_object_get_string(jvalue);
@@ -353,8 +347,10 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 	if (!cb)
 		return true;
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
-	if (!jarray || (json_object_get_type(jarray) != json_type_array))
+	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
+		return false;
+
+	if (json_object_get_type(jarray) != json_type_array)
 		return false;
 
 	len = json_object_array_length(jarray);
@@ -376,24 +372,21 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 		if (!CHECK_KEY_IDX_RANGE(idx))
 			return false;
 
-		json_object_object_get_ex(jtemp, "oldKey", &jvalue);
-		if (jvalue) {
+		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue)) {
 			str = (char *)json_object_get_string(jvalue);
 			if (!str2hex(str, strlen(str), key, 16))
 				return false;
 			key_refresh = true;
 		}
 
-		json_object_object_get_ex(jtemp, "key", &jvalue);
-		if (!jvalue)
+		if (!json_object_object_get_ex(jtemp, "key", &jvalue))
 			return false;
 
 		str = (char *)json_object_get_string(jvalue);
 		if (!str2hex(str, strlen(str), key_refresh ? new_key : key, 16))
 			return false;
 
-		json_object_object_get_ex(jtemp, "keyRefresh", &jvalue);
-		if (!jvalue)
+		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
 			phase = KEY_REFRESH_PHASE_NONE;
 		else
 			phase = json_object_get_int(jvalue);
@@ -410,11 +403,10 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring;
+	json_object *jarray = NULL, *jentry = NULL, *jstring;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
-
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
 
@@ -462,9 +454,7 @@ bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
 	json_object *jarray, *jentry, *jstring;
 	const char *str;
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
-
-	if (!jarray)
+	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return false;
 
 	jentry = get_key_object(jarray, idx);
@@ -493,8 +483,7 @@ bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
-	if (!jarray)
+	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return true;
 
 	/* Check if matching entry exists */
@@ -529,11 +518,10 @@ bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
 bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16])
 {
-	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
-
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
 
@@ -586,8 +574,7 @@ bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
 	json_object *jarray, *jentry = NULL, *jstring = NULL;
 	const char *str;
 
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (!jarray)
+	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return false;
 
 	/* The key entry should exist if the key is updated */
@@ -610,8 +597,7 @@ bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
 
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (!jarray)
+	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return true;
 
 	/* Check if matching entry exists */
@@ -641,17 +627,16 @@ bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
 				uint32_t mod_id, uint16_t app_idx)
 {
-	json_object *jmodel, *jstring, *jarray;
+	json_object *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
 
 	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
 	if (!jmodel)
 		return false;
 
-	json_object_object_get_ex(jmodel, "bind", &jarray);
-
 	snprintf(buf, 5, "%4.4x", app_idx);
 
+	json_object_object_get_ex(jmodel, "bind", &jarray);
 	if (jarray && jarray_has_string(jarray, buf, 4))
 		return true;
 
@@ -683,11 +668,12 @@ bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
 	if (!jmodel)
 		return false;
 
-	json_object_object_get_ex(jmodel, "bind", &jarray);
+	if (!json_object_object_get_ex(jmodel, "bind", &jarray))
+		return true;
 
 	snprintf(buf, 5, "%4.4x", app_idx);
 
-	if (!jarray || !jarray_has_string(jarray, buf, 4))
+	if (!jarray_has_string(jarray, buf, 4))
 		return true;
 
 	if (json_object_array_length(jarray) == 1) {
@@ -787,13 +773,12 @@ static struct mesh_db_pub *parse_model_publication(json_object *jpub)
 	int len, value;
 	char *str;
 
-	pub = l_new(struct mesh_db_pub, 1);
-	if (!pub)
+	if (!json_object_object_get_ex(jpub, "address", &jvalue))
 		return NULL;
 
-	json_object_object_get_ex(jpub, "address", &jvalue);
 	str = (char *)json_object_get_string(jvalue);
 	len = strlen(str);
+	pub = l_new(struct mesh_db_pub, 1);
 
 	switch (len) {
 	case 4:
@@ -824,8 +809,7 @@ static struct mesh_db_pub *parse_model_publication(json_object *jpub)
 		goto fail;
 	pub->credential = (uint8_t) value;
 
-	json_object_object_get_ex(jpub, "retransmit", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jpub, "retransmit", &jvalue))
 		goto fail;
 
 	if (!get_int(jvalue, "count", &value))
@@ -917,10 +901,10 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 			goto fail;
 
 		mod = l_new(struct mesh_db_model, 1);
-		if (!ele)
+
+		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
 			goto fail;
 
-		json_object_object_get_ex(jmodel, "modelId", &jvalue);
 		str = (char *)json_object_get_string(jvalue);
 
 		len = strlen(str);
@@ -944,23 +928,22 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 		if (len == 8)
 			mod->vendor = true;
 
-		json_object_object_get_ex(jmodel, "bind", &jarray);
-
-		if (jarray && (json_object_get_type(jarray) != json_type_array
-					|| !parse_bindings(jarray, mod)))
-			goto fail;
+		if (json_object_object_get_ex(jmodel, "bind", &jarray)) {
+			if (json_object_get_type(jarray) != json_type_array ||
+					!parse_bindings(jarray, mod))
+				goto fail;
+		}
 
-		json_object_object_get_ex(jmodel, "publish", &jvalue);
-		if (jvalue) {
+		if (json_object_object_get_ex(jmodel, "publish", &jvalue)) {
 			mod->pub = parse_model_publication(jvalue);
 			if (!mod->pub)
 				goto fail;
 		}
 
-		json_object_object_get_ex(jmodel, "subscribe", &jarray);
-
-		if (jarray && !parse_model_subscriptions(jarray, mod))
-			goto fail;
+		if (json_object_object_get_ex(jmodel, "subscribe", &jarray)) {
+			if (!parse_model_subscriptions(jarray, mod))
+				goto fail;
+		}
 
 		l_queue_push_tail(ele->models, mod);
 	}
@@ -1002,24 +985,23 @@ static bool parse_elements(json_object *jelements, struct mesh_db_node *node)
 			goto fail;
 
 		ele = l_new(struct mesh_db_element, 1);
-		if (!ele)
-			goto fail;
-
 		ele->index = index;
 		ele->models = l_queue_new();
 		if (!ele->models)
 			goto fail;
 
-		json_object_object_get_ex(jelement, "location", &jvalue);
+		if (!json_object_object_get_ex(jelement, "location", &jvalue))
+			goto fail;
+
 		str = (char *)json_object_get_string(jvalue);
 		if (sscanf(str, "%04hx", &(ele->location)) != 1)
 			goto fail;
 
-		json_object_object_get_ex(jelement, "models", &jmodels);
-
-		if (jmodels && (json_object_get_type(jmodels) != json_type_array
-				|| !parse_models(jmodels, ele)))
-			goto fail;
+		if (json_object_object_get_ex(jelement, "models", &jmodels)) {
+			if (json_object_get_type(jmodels) != json_type_array ||
+						!parse_models(jmodels, ele))
+				goto fail;
+		}
 
 		l_queue_push_tail(node->elements, ele);
 	}
@@ -1059,40 +1041,34 @@ static void parse_features(json_object *jconfig, struct mesh_db_node *node)
 	int mode, count;
 	uint16_t interval;
 
-	json_object_object_get_ex(jconfig, "proxy", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jconfig, "proxy", &jvalue)) {
 		mode = get_mode(jvalue);
 		if (mode <= MESH_MODE_UNSUPPORTED)
 			node->modes.proxy = mode;
 	}
 
-	json_object_object_get_ex(jconfig, "friend", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jconfig, "friend", &jvalue)) {
 		mode = get_mode(jvalue);
 		if (mode <= MESH_MODE_UNSUPPORTED)
 			node->modes.friend = mode;
 	}
 
-	json_object_object_get_ex(jconfig, "lowPower", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jconfig, "lowPower", &jvalue)) {
 		mode = get_mode(jvalue);
 		if (mode <= MESH_MODE_UNSUPPORTED)
 			node->modes.friend = mode;
 	}
 
-	json_object_object_get_ex(jconfig, "beacon", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jconfig, "beacon", &jvalue)) {
 		mode = get_mode(jvalue);
-		if (mode <= MESH_MODE_ENABLED)
+		if (mode <= MESH_MODE_UNSUPPORTED)
 			node->modes.beacon = mode;
 	}
 
-	json_object_object_get_ex(jconfig, "relay", &jrelay);
-	if (!jrelay)
+	if (!json_object_object_get_ex(jconfig, "relay", &jrelay))
 		return;
 
-	json_object_object_get_ex(jrelay, "mode", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jrelay, "mode", &jvalue)) {
 		mode = get_mode(jvalue);
 		if (mode <= MESH_MODE_UNSUPPORTED)
 			node->modes.relay.state = mode;
@@ -1101,16 +1077,14 @@ static void parse_features(json_object *jconfig, struct mesh_db_node *node)
 	} else
 		return;
 
-	json_object_object_get_ex(jrelay, "count", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jrelay, "count", &jvalue))
 		return;
 
 	/* TODO: check range */
 	count = json_object_get_int(jvalue);
 	node->modes.relay.cnt = count;
 
-	json_object_object_get_ex(jrelay, "interval", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jrelay, "interval", &jvalue))
 		return;
 
 	/* TODO: check range */
@@ -1124,32 +1098,28 @@ static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
 	char *str;
 
 	/* All the fields in node composition are mandatory */
-	json_object_object_get_ex(jcomp, "cid", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jcomp, "cid", &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
 	if (sscanf(str, "%04hx", &node->cid) != 1)
 		return false;
 
-	json_object_object_get_ex(jcomp, "pid", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jcomp, "pid", &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
 	if (sscanf(str, "%04hx", &node->pid) != 1)
 		return false;
 
-	json_object_object_get_ex(jcomp, "vid", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jcomp, "vid", &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
 	if (sscanf(str, "%04hx", &node->vid) != 1)
 		return false;
 
-	json_object_object_get_ex(jcomp, "crpl", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jcomp, "crpl", &jvalue))
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
@@ -1182,8 +1152,7 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 
 	parse_features(jnode, &node);
 
-	json_object_object_get_ex(jnode, "unicastAddress", &jvalue);
-	if (!jvalue) {
+	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
 		l_info("Bad config: Unicast address must be present");
 		return false;
 	}
@@ -1192,8 +1161,7 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	if (sscanf(str, "%04hx", &node.unicast) != 1)
 		return false;
 
-	json_object_object_get_ex(jnode, "defaultTTL", &jvalue);
-	if (jvalue) {
+	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
 		int ttl = json_object_get_int(jvalue);
 
 		if (ttl < 0 || ttl == 1 || ttl > DEFAULT_TTL)
@@ -1201,14 +1169,14 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 		node.ttl = (uint8_t) ttl;
 	}
 
-	json_object_object_get_ex(jnode, "sequenceNumber", &jvalue);
-	if (jvalue)
+	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
 		node.seq_number = json_object_get_int(jvalue);
 
-	json_object_object_get_ex(jnode, "elements", &jvalue);
-	if (jvalue && json_object_get_type(jvalue) == json_type_array) {
-		if (!parse_elements(jvalue, &node))
-			return false;
+	if (json_object_object_get_ex(jnode, "elements", &jvalue)) {
+		if (json_object_get_type(jvalue) == json_type_array) {
+			if (!parse_elements(jvalue, &node))
+				return false;
+		}
 	}
 
 	return cb(&node, user_data);
@@ -1352,18 +1320,15 @@ bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
 	if (!jobj)
 		return false;
 
-	json_object_object_get_ex(jobj, "retransmit", &jretransmit);
-	if (!jretransmit)
+	if (!json_object_object_get_ex(jobj, "retransmit", &jretransmit))
 		return false;
 
-	json_object_object_get_ex(jretransmit, "count", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jretransmit, "count", &jvalue))
 		return false;
 
 	*cnt = (uint8_t) json_object_get_int(jvalue);
 
-	json_object_object_get_ex(jretransmit, "interval", &jvalue);
-	if (!jvalue)
+	if (!json_object_object_get_ex(jretransmit, "interval", &jvalue))
 		return false;
 
 	*interval = (uint16_t) json_object_get_int(jvalue);
@@ -1541,8 +1506,7 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 	int i, len;
 
 	/* Clean up all the bound appkeys */
-	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (!jarray)
+	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return;
 
 	len = json_object_array_length(jarray);
@@ -1574,9 +1538,7 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 	if (!jobj)
 		return false;
 
-	json_object_object_get_ex(jobj, "netKeys", &jarray);
-
-	if (jarray)
+	if (json_object_object_get_ex(jobj, "netKeys", &jarray))
 		jentry = get_key_object(jarray, idx);
 
 	if (!jentry)
@@ -1688,7 +1650,7 @@ bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
 bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 					bool vendor, struct mesh_db_sub *sub)
 {
-	json_object *jmodel, *jstring, *jarray;
+	json_object *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
 	char buf[33];
 
@@ -1703,8 +1665,6 @@ bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 	if (!jmodel)
 		return false;
 
-	json_object_object_get_ex(jmodel, "subscribe", &jarray);
-
 	if (!sub->virt) {
 		snprintf(buf, 5, "%4.4x", sub->src.addr);
 		len = 4;
@@ -1713,6 +1673,7 @@ bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
 		len = 32;
 	}
 
+	json_object_object_get_ex(jmodel, "subscribe", &jarray);
 	if (jarray && jarray_has_string(jarray, buf, len))
 		return true;
 
@@ -1752,8 +1713,7 @@ bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
 	if (!jmodel)
 		return false;
 
-	json_object_object_get_ex(jmodel, "subscribe", &jarray);
-	if (!jarray)
+	if (!json_object_object_get_ex(jmodel, "subscribe", &jarray))
 		return true;
 
 	if (!sub->virt) {
-- 
2.14.5

