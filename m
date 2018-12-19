Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62169C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253E721873
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLSEVk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:21:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:4189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeLSEVk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:21:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820248"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:21:39 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 19/30] mesh: Restructure DB to support multiple nodes
Date:   Tue, 18 Dec 2018 20:20:05 -0800
Message-Id: <20181219042016.25538-20-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/mesh-db.c | 454 +++++++++++++++++++++++++++++++++++++--------------------
 mesh/mesh-db.h |   6 +-
 2 files changed, 296 insertions(+), 164 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 86e17ed9a..e6aa51340 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -162,6 +162,7 @@ static json_object *jarray_string_del(json_object *jarray, char *str,
 		if (str_entry && !strncmp(str, str_entry, len))
 			continue;
 
+		json_object_get(jentry);
 		json_object_array_add(jarray_new, jentry);
 	}
 
@@ -193,9 +194,6 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 {
 	json_object *jarray_new;
 	int i, sz = json_object_array_length(jarray);
-	char idx_str[5];
-
-	snprintf(idx_str, 5, "%4.4x", idx);
 
 	jarray_new = json_object_new_array();
 	if (!jarray_new)
@@ -203,16 +201,17 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 
 	for (i = 0; i < sz; ++i) {
 		json_object *jentry, *jvalue;
-		char *str;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
 		if (json_object_object_get_ex(jentry, "index", &jvalue)) {
-			str = (char *)json_object_get_string(jvalue);
-			if (str && !strncmp(str, idx_str, 4))
+			int tmp = json_object_get_int(jvalue);
+
+			if (tmp == idx)
 				continue;
 		}
 
+		json_object_get(jentry);
 		json_object_array_add(jarray_new, jentry);
 	}
 
@@ -389,19 +388,10 @@ bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
-	if (!jarray && (phase != KEY_REFRESH_PHASE_NONE))
-		return false;
 
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
 
-	/*
-	 * The key entry should exist if the key is updated
-	 * (i.e., Key Refresh is underway)
-	 */
-	if (!jentry && (phase != KEY_REFRESH_PHASE_NONE))
-		return false;
-
 	if (jentry) {
 		uint8_t buf[16];
 		json_object *jvalue;
@@ -422,7 +412,7 @@ bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 		return false;
 	}
 
-	if (phase == KEY_REFRESH_PHASE_NONE) {
+	if (!jentry) {
 		jentry = json_object_new_object();
 		if (!jentry)
 			goto fail;
@@ -442,6 +432,19 @@ bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 		if (!add_key(jentry, "key", key))
 			goto fail;
 
+		/* If Key Refresh underway, add placeholder for "Old Key" */
+		if (phase != KEY_REFRESH_PHASE_NONE) {
+			uint8_t buf[16];
+			uint8_t i;
+
+			/* Flip Bits to differentiate */
+			for (i = 0; i < sizeof(buf); i++)
+				buf[i] = key[i] ^ 0xff;
+
+			if (!add_key(jentry, "oldKey", buf))
+				goto fail;
+		}
+
 		if (!jarray) {
 			jarray = json_object_new_array();
 			if (!jarray)
@@ -733,7 +736,7 @@ static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
 	if (cnt > 0xffff)
 		return false;
 
-	mod->num_subs = cnt;
+	mod->num_bindings = cnt;
 
 	/* Allow empty bindings list */
 	if (!cnt)
@@ -761,6 +764,130 @@ static bool parse_bindings(json_object *jbindings, struct mesh_db_model *mod)
 	return true;
 }
 
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
+static struct mesh_db_pub *parse_model_publication(json_object *jpub)
+{
+	json_object *jvalue;
+	struct mesh_db_pub *pub;
+	int len, value;
+	char *str;
+
+	pub = l_new(struct mesh_db_pub, 1);
+	if (!pub)
+		return NULL;
+
+	json_object_object_get_ex(jpub, "address", &jvalue);
+	str = (char *)json_object_get_string(jvalue);
+	len = strlen(str);
+
+	switch (len) {
+	case 4:
+		if (sscanf(str, "%04hx", &pub->addr) != 1)
+			goto fail;
+		break;
+	case 32:
+		if (!str2hex(str, len, pub->virt_addr, 16))
+			goto fail;
+		pub->virt = true;
+		break;
+	default:
+		goto fail;
+	}
+
+	if (!get_key_index(jpub, "index", &pub->idx))
+		goto fail;
+
+	if (!get_int(jpub, "ttl", &value))
+		goto fail;
+	pub->ttl = (uint8_t) value;
+
+	if (!get_int(jpub, "period", &value))
+		goto fail;
+	pub->period = (uint8_t) value;
+
+	if (!get_int(jpub, "credentials", &value))
+		goto fail;
+	pub->credential = (uint8_t) value;
+
+	if (!get_int(jpub, "retransmit", &value))
+		goto fail;
+
+	pub->retransmit = (uint8_t) value;
+	return pub;
+
+fail:
+	l_free(pub);
+	return NULL;
+}
+
+static bool parse_model_subscriptions(json_object *jsubs,
+						struct mesh_db_model *mod)
+{
+	struct mesh_db_sub *subs;
+	int i, cnt;
+
+	if (json_object_get_type(jsubs) != json_type_array)
+		return NULL;
+
+	cnt = json_object_array_length(jsubs);
+	/* Allow empty array */
+	if (!cnt)
+		return true;
+
+	subs = l_new(struct mesh_db_sub, cnt);
+	if (!subs)
+		return false;
+
+	for (i = 0; i < cnt; ++i) {
+		char *str;
+		int len;
+		json_object *jvalue;
+
+		jvalue = json_object_array_get_idx(jsubs, i);
+		if (!jvalue)
+			return false;
+
+		str = (char *)json_object_get_string(jvalue);
+		len = strlen(str);
+
+		switch (len) {
+		case 4:
+			if (sscanf(str, "%04hx", &subs[i].src.addr) != 1)
+				goto fail;
+		break;
+		case 32:
+			if (!str2hex(str, len, subs[i].src.virt_addr, 16))
+				goto fail;
+			subs[i].virt = true;
+			break;
+		default:
+			goto fail;
+		}
+	}
+
+	mod->num_subs = cnt;
+	mod->subs = subs;
+
+	return true;
+fail:
+	l_free(subs);
+	return false;
+}
+
 static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 {
 	int i, num_models;
@@ -810,11 +937,22 @@ static bool parse_models(json_object *jmodels, struct mesh_db_element *ele)
 
 		json_object_object_get_ex(jmodel, "bind", &jarray);
 
-		if (jarray && (json_object_get_type(jmodels) != json_type_array
+		if (jarray && (json_object_get_type(jarray) != json_type_array
 					|| !parse_bindings(jarray, mod)))
 			goto fail;
 
-		/* TODO add pub/sub */
+		json_object_object_get_ex(jmodel, "publish", &jvalue);
+		if (jvalue) {
+			mod->pub = parse_model_publication(jvalue);
+			if (!mod->pub)
+				goto fail;
+		}
+
+		json_object_object_get_ex(jmodel, "subscribe", &jarray);
+
+		if (jarray && !parse_model_subscriptions(jarray, mod))
+			goto fail;
+
 		l_queue_push_tail(ele->models, mod);
 	}
 
@@ -1012,33 +1150,6 @@ static bool parse_composition(json_object *jcomp, struct mesh_db_node *node)
 	return true;
 }
 
-static uint16_t get_prov_flags(json_object *jarray, uint16_t max_value)
-{
-	int i, cnt;
-	uint16_t result = 0;
-
-	cnt = json_object_array_length(jarray);
-	if (!cnt)
-		return 0;
-
-	for (i = 0; i < cnt; ++i) {
-		json_object *jvalue;
-		int value;
-
-		jvalue = json_object_array_get_idx(jarray, i);
-		value = json_object_get_int(jvalue);
-		if (value > 16)
-			continue;
-
-		if ((1 << value) > max_value)
-			continue;
-
-		result |= (1 << value);
-	}
-
-	return result;
-}
-
 bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 {
 	struct mesh_db_node node;
@@ -1091,117 +1202,28 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	return cb(&node, user_data);
 }
 
-bool mesh_db_read_unprovisioned_device(json_object *jnode, mesh_db_node_cb cb,
-								void *user_data)
-{
-	struct mesh_db_node node;
-	json_object *jvalue;
-	char *str;
-
-	if (!cb) {
-		l_info("Device read callback is required");
-		return false;
-	}
-
-	memset(&node, 0, sizeof(node));
-
-	if (!parse_composition(jnode, &node)) {
-		l_info("Failed to parse local device composition");
-		return false;
-	}
-
-	parse_features(jnode, &node);
-
-	json_object_object_get_ex(jnode, "elements", &jvalue);
-	if (jvalue && json_object_get_type(jvalue) == json_type_array) {
-		if (!parse_elements(jvalue, &node))
-			return false;
-	}
-
-	json_object_object_get_ex(jnode, "UUID", &jvalue);
-	if (!jvalue)
-		return false;
-
-	str = (char *)json_object_get_string(jvalue);
-	if (!str2hex(str, strlen(str), node.uuid, 16))
-		return false;
-
-	return cb(&node, user_data);
-}
-
-bool mesh_db_read_prov_info(json_object *jnode, struct mesh_db_prov *prov)
+bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
+								uint16_t value)
 {
-	json_object *jprov, *jarray, *jvalue, *jobj;
-	int value;
-	char *str;
-
-	if (!prov)
-		return false;
-
-	json_object_object_get_ex(jnode, "provision", &jprov);
-	if (!jprov)
-		return false;
-
-	json_object_object_get_ex(jprov, "algorithms", &jarray);
-	if (!jarray || json_object_get_type(jarray) != json_type_array)
-		return false;
-
-	prov->algorithm = get_prov_flags(jarray, ALG_FIPS_256_ECC);
-	if (!prov->algorithm) {
-		l_info("At least one algorithm must be indicated");
-		return false;
-	}
-
-	json_object_object_get_ex(jprov, "outputOOB", &jobj);
-	json_object_object_get_ex(jobj, "size", &jvalue);
-	value = json_object_get_int(jvalue);
-	if (value > 8)
-		return false;
-
-	prov->output_oob.size = (uint8_t) value;
-	json_object_object_get_ex(jobj, "actions", &jarray);
-	if (!jarray || json_object_get_type(jarray) != json_type_array)
-		return false;
-
-	prov->output_oob.actions = get_prov_flags(jarray, OOB_OUT_ALPHA);
-
-	json_object_object_get_ex(jprov, "inputOOB", &jobj);
-	json_object_object_get_ex(jobj, "size", &jvalue);
-	value = json_object_get_int(jvalue);
-	if (value > 8)
-		return false;
-
-	prov->input_oob.size = (uint8_t) value;
-	json_object_object_get_ex(jobj, "actions", &jarray);
-	if (!jarray || json_object_get_type(jarray) != json_type_array)
-		return false;
-
-	prov->input_oob.actions = get_prov_flags(jarray, OOB_IN_ALPHA);
-
-	json_object_object_get_ex(jprov, "publicType", &jvalue);
-	prov->pub_type = (json_object_get_boolean(jvalue)) ? 1 : 0;
-
-	json_object_object_get_ex(jprov, "staticType", &jvalue);
-	prov->static_type = (json_object_get_boolean(jvalue)) ? 1 : 0;
-
-	json_object_object_get_ex(jprov, "privateKey", &jvalue);
-	if (!jvalue)
-		return false;
+	json_object *jstring;
+	char buf[5];
 
-	str = (char *)json_object_get_string(jvalue);
-	if (!str2hex(str, strlen(str), prov->priv_key, 32))
+	snprintf(buf, 5, "%4.4x", value);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
 		return false;
 
+	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
 
-bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
-								uint16_t value)
+bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+								uint32_t value)
 {
 	json_object *jstring;
-	char buf[5];
+	char buf[9];
 
-	snprintf(buf, 5, "%4.4x", value);
+	snprintf(buf, 9, "%8.8x", value);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
 		return false;
@@ -1238,23 +1260,23 @@ bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value)
 	return true;
 }
 
-bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
+static const char *mode_to_string(int mode)
 {
-	json_object *jstring;
-
-	switch (value) {
+	switch (mode) {
 	case MESH_MODE_DISABLED:
-		jstring = json_object_new_string("disabled");
-		break;
+		return "disabled";
 	case MESH_MODE_ENABLED:
-		jstring = json_object_new_string("enabled");
-		break;
-	case MESH_MODE_UNSUPPORTED:
-		jstring = json_object_new_string("unsupported");
-		break;
+		return "enabled";
 	default:
-		return false;
-	};
+		return "unsupported";
+	}
+}
+
+bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
+{
+	json_object *jstring;
+
+	jstring = json_object_new_string(mode_to_string(value));
 
 	if (!jstring)
 		return false;
@@ -1272,7 +1294,7 @@ bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
 	json_object_object_del(jnode, "relay");
 
 	jrelay = json_object_new_object();
-	if (jrelay)
+	if (!jrelay)
 		return false;
 
 	if (!mesh_db_write_mode(jrelay, "mode", mode))
@@ -1359,3 +1381,113 @@ void mesh_db_remove_property(json_object *jobj, const char *desc)
 {
 	json_object_object_del(jobj, desc);
 }
+
+static void add_model(void *a, void *b)
+{
+	struct mesh_db_model *mod = a;
+	json_object *jmodels = b, *jmodel;
+
+	jmodel = json_object_new_object();
+	if (!jmodel)
+		return;
+
+	if (!mod->vendor)
+		mesh_db_write_uint16_hex(jmodel, "modelId",
+						(uint16_t) mod->id);
+	else
+		mesh_db_write_uint32_hex(jmodel, "modelId", mod->id);
+
+	json_object_array_add(jmodels, jmodel);
+}
+
+/* Add unprovisioned node (local) */
+bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
+
+	struct mesh_db_modes *modes = &node->modes;
+	const struct l_queue_entry *entry;
+	json_object *jelements;
+
+	/* CID, PID, VID, crpl */
+	if (!mesh_db_write_uint16_hex(jnode, "cid", node->cid))
+		return false;
+
+	if (!mesh_db_write_uint16_hex(jnode, "pid", node->pid))
+		return false;
+
+	if (!mesh_db_write_uint16_hex(jnode, "vid", node->vid))
+		return false;
+
+	if (!mesh_db_write_uint16_hex(jnode, "crpl", node->crpl))
+		return false;
+
+	/* Device UUID */
+	if (!add_key(jnode, "UUID", node->uuid))
+		return false;
+
+	/* Features: relay, LPN, friend, proxy*/
+	if (!mesh_db_write_relay_mode(jnode, modes->relay.state,
+						modes->relay.cnt,
+						modes->relay.interval))
+		return false;
+
+	if (!mesh_db_write_mode(jnode, "lowPower", modes->lpn))
+		return false;
+
+	if (!mesh_db_write_mode(jnode, "friend", modes->friend))
+		return false;
+
+	if (!mesh_db_write_mode(jnode, "proxy", modes->proxy))
+		return false;
+
+	/* Beaconing state */
+	if (!mesh_db_write_mode(jnode, "beacon", modes->beacon))
+		return false;
+
+	/* Sequence number */
+	json_object_object_add(jnode, "sequenceNumber",
+					json_object_new_int(node->seq_number));
+
+	/* Default TTL */
+	json_object_object_add(jnode, "defaultTTL",
+						json_object_new_int(node->ttl));
+
+	/* Elements */
+	jelements = json_object_new_array();
+	if (!jelements)
+		return false;
+
+	entry = l_queue_get_entries(node->elements);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_db_element *ele = entry->data;
+		json_object *jelement, *jmodels;
+
+		jelement = json_object_new_object();
+
+		if (!jelement) {
+			json_object_put(jelements);
+			return false;
+		}
+
+		mesh_db_write_int(jelement, "elementIndex", ele->index);
+		mesh_db_write_uint16_hex(jelement, "location", ele->location);
+		json_object_array_add(jelements, jelement);
+
+		/* Models */
+		if (l_queue_isempty(ele->models))
+			continue;
+
+		jmodels = json_object_new_array();
+		if (!jmodels) {
+			json_object_put(jelements);
+			return false;
+		}
+
+		json_object_object_add(jelement, "models", jmodels);
+		l_queue_foreach(ele->models, add_model, jmodels);
+	}
+
+	json_object_object_add(jnode, "elements", jelements);
+
+	return true;
+}
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 336302f28..9a32e6c76 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -103,9 +103,7 @@ typedef bool (*mesh_db_app_key_cb)(uint16_t idx, uint16_t net_idx,
 typedef bool (*mesh_db_node_cb)(struct mesh_db_node *node, void *user_data);
 
 bool mesh_db_read_node(json_object *jobj, mesh_db_node_cb cb, void *user_data);
-bool mesh_db_read_unprovisioned_device(json_object *jnode, mesh_db_node_cb cb,
-							void *user_data);
-bool mesh_db_read_prov_info(json_object *jnode, struct mesh_db_prov *prov);
+bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node);
 bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
 bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16]);
 bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
@@ -124,6 +122,8 @@ bool mesh_db_write_app_key(json_object *jobj, uint16_t net_idx,
 bool mesh_db_write_int(json_object *jobj, const char *keyword, int value);
 bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
 								uint16_t value);
+bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
+								uint32_t value);
 bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value);
 bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
 							uint16_t interval);
-- 
2.14.5

