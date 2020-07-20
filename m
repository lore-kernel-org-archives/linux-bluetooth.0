Return-Path: <SRS0=mCsq=A7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0648C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C9C20773
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGTUqq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:46:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:45818 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGTUqp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jul 2020 16:46:45 -0400
IronPort-SDR: pVZhd7zXUkODSkuPO1HGIn+wgzUdNc+4d3n/DZXrXE4EBykRzs53J3LIG/e1ERs8+SqaggYDHZ
 rMHzWqiGQZqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137492772"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="137492772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 13:46:43 -0700
IronPort-SDR: S0PIA5lqpRIrlU79H14GWSQ1tPTz1i0QqN9+fp8ALPC48lQodU7KjVSbuwPC2/Kc5O1FrwyUe+
 6mU270N6XYww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="327652404"
Received: from aukiwe-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.77.52])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2020 13:46:43 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Move model functionality out of node.c to model.c
Date:   Mon, 20 Jul 2020 13:46:42 -0700
Message-Id: <20200720204642.227014-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the model related code out of node.c to model.c providing
for better functional separation of modules.
---
 mesh/cfgmod.h           |   4 +-
 mesh/mesh-config-json.c |   5 +-
 mesh/model.c            | 548 +++++++++++++++++++++++++++++-----------
 mesh/model.h            |  37 +--
 mesh/node.c             | 304 +++-------------------
 mesh/node.h             |   4 +-
 6 files changed, 454 insertions(+), 448 deletions(-)

diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index 383fdbf6b..0bfa71680 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -17,8 +17,8 @@
  *
  */
 
-#define CONFIG_SRV_MODEL	(VENDOR_ID_MASK | 0x0000)
-#define CONFIG_CLI_MODEL	(VENDOR_ID_MASK | 0x0001)
+#define CONFIG_SRV_MODEL	0x0000
+#define CONFIG_CLI_MODEL	0x0001
 
 /* New List */
 #define OP_APPKEY_ADD				0x00
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 88f715fc1..deb0019f9 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1126,18 +1126,15 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 			if (sscanf(str, "%04x", &id) != 1)
 				goto fail;
 
-			id |= VENDOR_ID_MASK;
 		} else if (len == 8) {
 			if (sscanf(str, "%08x", &id) != 1)
 				goto fail;
+			mod->vendor = true;
 		} else
 			goto fail;
 
 		mod->id = id;
 
-		if (len == 8)
-			mod->vendor = true;
-
 		if (json_object_object_get_ex(jmodel, "bind", &jarray)) {
 			if (json_object_get_type(jarray) != json_type_array ||
 					!parse_bindings(jarray, mod))
diff --git a/mesh/model.c b/mesh/model.c
index afac6ec69..eac8c8b5b 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -54,7 +54,6 @@ struct mesh_model {
 	bool sub_enabled;
 	bool pub_enabled;
 	uint32_t id;
-	uint8_t ele_idx;
 };
 
 struct mesh_virtual {
@@ -131,44 +130,42 @@ static bool find_virt_by_label(const void *a, const void *b)
 
 static bool match_model_id(const void *a, const void *b)
 {
-	const struct mesh_model *model = a;
+	const struct mesh_model *mod = a;
 	uint32_t id = L_PTR_TO_UINT(b);
 
-	return (mesh_model_get_model_id(model) == id);
+	return (mod->id == id);
 }
 
-static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
-						uint32_t id, int *status)
+static int compare_model_id(const void *a, const void *b, void *user_data)
 {
-	struct l_queue *models;
-	struct mesh_model *model;
-
-	models = node_get_element_models(node, ele_idx, status);
-	if (!models) {
-		*status = MESH_STATUS_INVALID_MODEL;
-		return NULL;
-	}
+	const struct mesh_model *mod_a = a;
+	const struct mesh_model *mod_b = b;
 
-	model = l_queue_find(models, match_model_id, L_UINT_TO_PTR(id));
+	if (mod_a->id < mod_b->id)
+		return -1;
 
-	*status = (model) ? MESH_STATUS_SUCCESS : MESH_STATUS_INVALID_MODEL;
+	if (mod_a->id > mod_b->id)
+		return 1;
 
-	return model;
+	return 0;
 }
 
-static struct mesh_model *find_model(struct mesh_node *node, uint16_t addr,
-						uint32_t mod_id, int *status)
+static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
+								uint32_t id)
 {
-	int ele_idx;
-
-	ele_idx = node_get_element_idx(node, addr);
+	struct l_queue *mods;
+	struct mesh_model *mod;
 
-	if (ele_idx < 0) {
-		*status = MESH_STATUS_INVALID_ADDRESS;
+	mods = node_get_element_models(node, ele_idx);
+	if (!mods)
 		return NULL;
-	}
 
-	return get_model(node, (uint8_t) ele_idx, mod_id, status);
+	mod = l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id));
+
+	if (!mod)
+		l_debug("Model not found");
+
+	return mod;
 }
 
 static uint32_t pub_period_to_ms(uint8_t pub_period)
@@ -268,15 +265,14 @@ static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_dict(builder);
 }
 
-static void config_update_model_bindings(struct mesh_node *node,
+static void cfg_update_mod_bindings(struct mesh_node *node, uint16_t ele_idx,
 							struct mesh_model *mod)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
 	struct l_dbus_message_builder *builder;
 
-	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
-								&builder);
+	msg = create_config_update_msg(node, ele_idx, mod->id, &builder);
 	if (!msg)
 		return;
 
@@ -331,15 +327,14 @@ done:
 	l_dbus_message_builder_leave_dict(builder);
 }
 
-static void config_update_model_subscriptions(struct mesh_node *node,
+static void cfg_update_model_subs(struct mesh_node *node, uint16_t ele_idx,
 							struct mesh_model *mod)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
 	struct l_dbus_message_builder *builder;
 
-	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
-								&builder);
+	msg = create_config_update_msg(node, ele_idx, mod->id, &builder);
 	if (!msg)
 		return;
 
@@ -572,7 +567,8 @@ done:
 	return ret;
 }
 
-static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
+static void remove_pub(struct mesh_node *node, uint16_t ele_idx,
+							struct mesh_model *mod)
 {
 	if (mod->pub) {
 		if (mod->pub->virt)
@@ -584,31 +580,31 @@ static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_pub_period(node, mod->ele_idx, mod->id, 0);
+		config_update_model_pub_period(node, ele_idx, mod->id, 0);
 	else if (mod->cbs && mod->cbs->pub)
 		/* Internal models */
 		mod->cbs->pub(NULL);
 }
 
-static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
-								uint16_t idx)
+static void model_unbind_idx(struct mesh_node *node, uint16_t ele_idx,
+					struct mesh_model *mod, uint16_t idx)
 {
 	l_queue_remove(mod->bindings, L_UINT_TO_PTR(idx));
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_bindings(node, mod);
+		cfg_update_mod_bindings(node, ele_idx, mod);
 	else if (mod->cbs->bind)
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_DELETE);
 
 	/* Remove model publication if the publication key is unbound */
 	if (mod->pub && idx == mod->pub->idx)
-		remove_pub(node, mod);
+		remove_pub(node, ele_idx, mod);
 }
 
-static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
-								uint16_t idx)
+static void model_bind_idx(struct mesh_node *node, uint16_t ele_idx,
+					struct mesh_model *mod, uint16_t idx)
 {
 	if (!mod->bindings)
 		mod->bindings = l_queue_new();
@@ -619,7 +615,7 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_bindings(node, mod);
+		cfg_update_mod_bindings(node, ele_idx, mod);
 	else if (mod->cbs->bind)
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_ADD);
@@ -628,14 +624,16 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind)
 {
-	int status;
 	struct mesh_model *mod;
 	bool is_present, is_vendor;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod) {
-		l_debug("Model not found");
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 	}
 
 	is_vendor = id < VENDOR_ID_MASK && id > 0xffff;
@@ -656,7 +654,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return MESH_STATUS_SUCCESS;
 
 	if (unbind) {
-		model_unbind_idx(node, mod, app_idx);
+		model_unbind_idx(node, ele_idx, mod, app_idx);
 		if (!mesh_config_model_binding_del(node_config_get(node),
 					addr, is_vendor, id, app_idx))
 			return MESH_STATUS_STORAGE_FAIL;
@@ -672,7 +670,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 					addr, is_vendor, id, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
-	model_bind_idx(node, mod, app_idx);
+	model_bind_idx(node, ele_idx, mod, app_idx);
 
 	return MESH_STATUS_SUCCESS;
 
@@ -964,7 +962,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 
 	is_subscription = !(IS_UNICAST(dst));
 
-
 	for (i = 0; i < num_ele; i++) {
 		struct l_queue *models;
 
@@ -974,7 +971,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		forward.unicast = addr + i;
 		forward.has_dst = false;
 
-		models = node_get_element_models(node, i, NULL);
+		models = node_get_element_models(node, i);
 
 		/* Internal models */
 		l_queue_foreach(models, forward_model, &forward);
@@ -1023,16 +1020,15 @@ done:
 	return result;
 }
 
-int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
-				uint16_t src, uint8_t ttl,
-				const void *msg, uint16_t msg_len)
+static int model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
+				uint8_t ttl, const void *msg, uint16_t msg_len)
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
 	uint8_t *label = NULL;
 	uint16_t net_idx;
 	bool result;
-	int status;
+	int ele_idx;
 
 	if (!net || msg_len > 380)
 		return MESH_ERROR_INVALID_ARGS;
@@ -1041,14 +1037,16 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	if (src == 0)
 		src = mesh_net_get_address(net);
 
-	mod = find_model(node, src, mod_id, &status);
-	if (!mod) {
-		l_debug("model %x not found", mod_id);
+	ele_idx = node_get_element_idx(node, src);
+	if (ele_idx < 0)
+		return MESH_ERROR_NOT_FOUND;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
+	if (!mod)
 		return MESH_ERROR_NOT_FOUND;
-	}
 
 	if (!mod->pub) {
-		l_debug("publication doesn't exist (model %x)", mod_id);
+		l_debug("publication doesn't exist (model %x)", id);
 		return MESH_ERROR_DOES_NOT_EXIST;
 	}
 
@@ -1069,6 +1067,24 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 }
 
+int mesh_model_publish(struct mesh_node *node, uint16_t mod_id,
+				uint16_t src, uint8_t ttl,
+				const void *msg, uint16_t msg_len)
+{
+	uint32_t id = mod_id | VENDOR_ID_MASK;
+
+	return model_publish(node, id, src, ttl, msg, msg_len);
+}
+
+int mesh_model_vendor_publish(struct mesh_node *node, uint16_t vendor_id,
+				uint16_t mod_id, uint16_t src, uint8_t ttl,
+				const void *msg, uint16_t msg_len)
+{
+	uint32_t id = mod_id | ((uint32_t)(vendor_id) << 16);
+
+	return model_publish(node, id, src, ttl, msg, msg_len);
+}
+
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
 					uint8_t ttl, bool segmented,
@@ -1093,11 +1109,14 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			bool is_virt, uint16_t *dst)
 {
 	struct mesh_model *mod;
-	int status;
+	int status, ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		return MESH_STATUS_INVALID_PUB_PARAM;
@@ -1110,7 +1129,7 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	 * remove the publication
 	 */
 	if (!is_virt && IS_UNASSIGNED(l_get_le16(pub_addr))) {
-		remove_pub(node, mod);
+		remove_pub(node, ele_idx, mod);
 		return MESH_STATUS_SUCCESS;
 	}
 
@@ -1134,7 +1153,7 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_pub_period(node, mod->ele_idx, id,
+		config_update_model_pub_period(node, ele_idx, id,
 						pub_period_to_ms(period));
 	else {
 		/* Internal model, call registered callbacks */
@@ -1149,10 +1168,18 @@ struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node, uint16_t addr,
 						uint32_t mod_id, int *status)
 {
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, mod_id, status);
-	if (!mod)
+	if (ele_idx < 0) {
+		*status = MESH_STATUS_INVALID_ADDRESS;
 		return NULL;
+	}
+
+	mod = get_model(node, (uint8_t) ele_idx, mod_id);
+	if (!mod) {
+		*status = MESH_STATUS_INVALID_MODEL;
+		return NULL;
+	}
 
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		*status = MESH_STATUS_INVALID_PUB_PARAM;
@@ -1173,12 +1200,25 @@ void mesh_model_free(void *data)
 	l_free(mod);
 }
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id)
+static void remove_subs(struct mesh_node *node, struct mesh_model *mod)
+{
+	const struct l_queue_entry *entry;
+	struct mesh_net *net = node_get_net(node);
+
+	entry = l_queue_get_entries(mod->subs);
+
+	for (; entry; entry = entry->next)
+		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
+
+	l_queue_clear(mod->subs, NULL);
+	l_queue_clear(mod->virtuals, unref_virt);
+}
+
+static struct mesh_model *model_new(uint32_t id)
 {
 	struct mesh_model *mod = l_new(struct mesh_model, 1);
 
 	mod->id = id;
-	mod->ele_idx = ele_idx;
 	mod->virtuals = l_queue_new();
 
 	/*
@@ -1190,6 +1230,92 @@ struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id)
 	return mod;
 }
 
+static void model_enable_pub(struct mesh_model *mod, bool enable)
+{
+	mod->pub_enabled = enable;
+
+	if (!mod->pub_enabled && mod->pub) {
+		if (mod->pub->virt)
+			unref_virt(mod->pub->virt);
+
+		l_free(mod->pub);
+		mod->pub = NULL;
+	}
+}
+
+static void model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
+								bool enable)
+{
+	mod->sub_enabled = enable;
+
+	if (!mod->sub_enabled)
+		remove_subs(node, mod);
+}
+
+static bool get_model_options(struct mesh_model *mod,
+					struct l_dbus_message_iter *opts)
+{
+	const char *key;
+	struct l_dbus_message_iter var;
+	bool opt;
+
+	while (l_dbus_message_iter_next_entry(opts, &key, &var)) {
+
+		if (!strcmp(key, "Publish")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
+				return false;
+
+			mod->pub_enabled = opt;
+		} else if (!strcmp(key, "Subscribe")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
+				return false;
+
+			mod->sub_enabled = opt;
+		} else
+			return false;
+	}
+
+	return true;
+}
+
+static bool add_model(struct mesh_node *node, struct l_queue *mods, uint32_t id,
+					struct l_dbus_message_iter *opts)
+{
+	struct mesh_model *mod;
+
+	/* Disallow duplicates */
+	mod = l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id));
+	if (mod)
+		return false;
+
+	mod = model_new(id);
+
+	if (opts && !get_model_options(mod, opts)) {
+		mesh_model_free(mod);
+		return false;
+	}
+
+	l_queue_insert(mods, mod, compare_model_id, NULL);
+	return true;
+}
+
+bool mesh_model_add(struct mesh_node *node, struct l_queue *mods,
+			uint16_t mod_id, struct l_dbus_message_iter *opts)
+{
+	uint32_t id = mod_id | VENDOR_ID_MASK;
+
+	return add_model(node, mods, id, opts);
+}
+
+bool mesh_model_vendor_add(struct mesh_node *node, struct l_queue *mods,
+					uint16_t vendor_id, uint16_t mod_id,
+					struct l_dbus_message_iter *opts)
+{
+	uint32_t id = mod_id | ((uint32_t)(vendor_id) << 16);
+
+	return add_model(node, mods, id, opts);
+}
+
 /* Internal models only */
 static void restore_model_state(struct mesh_model *mod)
 {
@@ -1213,26 +1339,21 @@ static void restore_model_state(struct mesh_model *mod)
 
 }
 
-uint32_t mesh_model_get_model_id(const struct mesh_model *model)
-{
-	return model->id;
-}
-
 /* This registers an internal model, i.e. implemented within meshd */
 bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
-					uint32_t mod_id,
+					uint16_t mod_id,
 					const struct mesh_model_ops *cbs,
 					void *user_data)
 {
 	struct mesh_model *mod;
-	int status;
+	uint32_t id;
 
 	/* Internal models are always SIG models */
-	mod_id = VENDOR_ID_MASK | mod_id;
+	id = VENDOR_ID_MASK | mod_id;
 
-	mod = get_model(node, ele_idx, mod_id, &status);
+	mod = get_model(node, ele_idx, id);
 	if (!mod)
-		return false;
+		return MESH_STATUS_INVALID_MODEL;
 
 	mod->cbs = cbs;
 	mod->user_data = user_data;
@@ -1242,15 +1363,15 @@ bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
 	return true;
 }
 
-void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
-							uint16_t app_idx)
+void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
+				struct l_queue *models, uint16_t app_idx)
 {
 	const struct l_queue_entry *entry = l_queue_get_entries(models);
 
 	for (; entry; entry = entry->next) {
-		struct mesh_model *model = entry->data;
+		struct mesh_model *mod = entry->data;
 
-		model_unbind_idx(node, model, app_idx);
+		model_unbind_idx(node, ele_idx, mod, app_idx);
 	}
 }
 
@@ -1269,18 +1390,20 @@ int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int status;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 	uint16_t n;
 	uint32_t idx_pair;
-	int i;
+	int i, ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 
 	if (!mod) {
 		*size = 0;
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 	}
 
 	entry = l_queue_get_entries(mod->bindings);
@@ -1325,14 +1448,17 @@ done:
 int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int status;
 	int16_t n;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
+	int ele_idx = node_get_element_idx(node, addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
 
-	mod = find_model(node, addr, id, &status);
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1370,12 +1496,15 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1387,7 +1516,7 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -1395,13 +1524,16 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	struct l_queue *virtuals, *subs;
 	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
 
-	mod = find_model(node, addr, id, &status);
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1439,7 +1571,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return status;
 }
@@ -1447,13 +1579,16 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	uint16_t grp;
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1481,34 +1616,23 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 		if (!mod->cbs)
 			/* External models */
-			config_update_model_subscriptions(node, mod);
+			cfg_update_model_subs(node, ele_idx, mod);
 	}
 
 	return MESH_STATUS_SUCCESS;
 }
 
-static void remove_subs(struct mesh_node *node, struct mesh_model *mod)
-{
-	const struct l_queue_entry *entry;
-	struct mesh_net *net = node_get_net(node);
-
-	entry = l_queue_get_entries(mod->subs);
-
-	for (; entry; entry = entry->next)
-		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
-
-	l_queue_clear(mod->subs, NULL);
-	l_queue_clear(mod->virtuals, unref_virt);
-}
-
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 {
-	int status;
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1517,17 +1641,15 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return MESH_STATUS_SUCCESS;
 }
 
-struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
-								void *data)
+static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
+					struct mesh_config_model *db_mod)
 {
-	struct mesh_config_model *db_mod = data;
 	struct mesh_model *mod;
-	struct mesh_net *net;
 	struct mesh_config_pub *pub = db_mod->pub;
 	uint32_t i;
 
@@ -1537,7 +1659,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		return NULL;
 	}
 
-	mod = mesh_model_new(ele_idx, db_mod->vendor ? db_mod->id :
+	mod = model_new(db_mod->vendor ? db_mod->id :
 						db_mod->id | VENDOR_ID_MASK);
 
 	/* Implicitly bind config server model to device key */
@@ -1557,17 +1679,18 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		return mod;
 	}
 
-	net = node_get_net(node);
-
 	/* Add application key bindings if present */
 	if (db_mod->bindings) {
 		mod->bindings = l_queue_new();
 		for (i = 0; i < db_mod->num_bindings; i++)
-			model_bind_idx(node, mod, db_mod->bindings[i]);
+			l_queue_push_tail(mod->bindings,
+					L_UINT_TO_PTR(db_mod->bindings[i]));
 	}
 
-	/* Add publication if present */
-	if (pub) {
+	mod->pub_enabled = db_mod->pub_enabled;
+
+	/* Add publication if enabled and present */
+	if (mod->pub_enabled && pub) {
 		uint8_t retransmit = pub->count +
 					((pub->interval / 50 - 1) << 3);
 		if (pub->virt)
@@ -1579,8 +1702,10 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 				pub->ttl, pub->period, retransmit);
 	}
 
-	/* Add subscriptions if present */
-	if (!db_mod->subs)
+	mod->sub_enabled = db_mod->sub_enabled;
+
+	/* Add subscriptions if enabled and present */
+	if (!db_mod->subs || !mod->sub_enabled)
 		return mod;
 
 	for (i = 0; i < db_mod->num_subs; i++) {
@@ -1605,6 +1730,59 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	return mod;
 }
 
+bool mesh_model_add_from_storage(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *mods, struct l_queue *db_mods)
+{
+	struct mesh_net *net = node_get_net(node);
+	const struct l_queue_entry *entry;
+
+	/* Allow empty elements */
+	if (!db_mods)
+		return true;
+
+	entry = l_queue_get_entries(db_mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod;
+		struct mesh_config_model *db_mod;
+		uint32_t id;
+
+		db_mod = entry->data;
+
+		id = db_mod->vendor ? db_mod->id : db_mod->id | VENDOR_ID_MASK;
+
+		if (l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id)))
+			return false;
+
+		mod = model_setup(net, ele_idx, db_mod);
+		if (!mod)
+			return false;
+
+		l_queue_insert(mods, mod, compare_model_id, NULL);
+	}
+
+	return true;
+}
+
+void mesh_model_convert_to_storage(struct l_queue *db_mods,
+							struct l_queue *mods)
+{
+
+	const struct l_queue_entry *entry = l_queue_get_entries(mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+		struct mesh_config_model *db_mod;
+
+		db_mod = l_new(struct mesh_config_model, 1);
+		db_mod->id = mod->id;
+		db_mod->vendor = mod->id < VENDOR_ID_MASK;
+		db_mod->pub_enabled = mod->pub_enabled;
+		db_mod->sub_enabled = mod->sub_enabled;
+		l_queue_push_tail(db_mods, db_mod);
+	}
+}
+
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf)
 {
 	if (opcode <= 0x7e) {
@@ -1669,7 +1847,7 @@ bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
 	return true;
 }
 
-void model_build_config(void *model, void *msg_builder)
+void mesh_model_build_config(void *model, void *msg_builder)
 {
 	struct l_dbus_message_builder *builder = msg_builder;
 	struct mesh_model *mod = model;
@@ -1715,36 +1893,44 @@ void model_build_config(void *model, void *msg_builder)
 	l_dbus_message_builder_leave_struct(builder);
 }
 
-void mesh_model_enable_pub(struct mesh_model *mod, bool enable)
+void mesh_model_update_opts(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *curr, struct l_queue *updated)
 {
-	mod->pub_enabled = enable;
+	uint16_t primary;
+	const struct l_queue_entry *entry;
 
-	if (!mod->pub_enabled && mod->pub) {
-		if (mod->pub->virt)
-			unref_virt(mod->pub->virt);
+	primary = node_get_primary(node);
+	entry = l_queue_get_entries(curr);
 
-		l_free(mod->pub);
-		mod->pub = NULL;
-	}
-}
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod, *updated_mod = entry->data;
+		uint32_t id = updated_mod->id;
+		bool updated_opt, vendor = id < VENDOR_ID_MASK;
 
-bool mesh_model_is_pub_enabled(struct mesh_model *mod)
-{
-	return mod->pub_enabled;
-}
+		mod = l_queue_find(curr, match_model_id, L_UINT_TO_PTR(id));
+		if (!mod)
+			continue;
 
-void mesh_model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
-								bool enable)
-{
-	mod->sub_enabled = enable;
+		if (!vendor)
+			id &= ~VENDOR_ID_MASK;
 
-	if (!mod->sub_enabled)
-		remove_subs(node, mod);
-}
+		updated_opt = updated_mod->pub_enabled;
+		if (mod->pub_enabled != updated_opt) {
+			model_enable_pub(mod, updated_opt);
+			mesh_config_model_pub_enable(node_config_get(node),
+							primary + ele_idx, id,
+							vendor, updated_opt);
+		}
 
-bool mesh_model_is_sub_enabled(struct mesh_model *mod)
-{
-	return mod->sub_enabled;
+		updated_opt = updated_mod->sub_enabled;
+
+		if (mod->pub_enabled != updated_opt) {
+			model_enable_sub(node, mod, updated_opt);
+			mesh_config_model_sub_enable(node_config_get(node),
+							primary + ele_idx, id,
+							vendor, updated_opt);
+			}
+		}
 }
 
 void mesh_model_init(void)
@@ -1757,3 +1943,59 @@ void mesh_model_cleanup(void)
 	l_queue_destroy(mesh_virtuals, l_free);
 	mesh_virtuals = NULL;
 }
+
+/* Populate composition buffer with model IDs */
+uint16_t mesh_model_generate_composition(struct l_queue *mods, uint16_t buf_sz,
+								uint8_t *buf)
+{
+	const struct l_queue_entry *entry;
+	uint8_t num_s = 0, num_v = 0;
+	uint8_t *mod_buf;
+	uint16_t n;
+
+	/* Store models IDs, store num_s and num_v later */
+	mod_buf = buf;
+	n = 2;
+
+	entry = l_queue_get_entries(mods);
+
+	/* Get SIG models */
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+
+		if (n + 2 > buf_sz)
+			goto done;
+
+		if ((mod->id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
+			l_put_le16((uint16_t) (mod->id & 0xffff), buf + n);
+			n += 2;
+			num_s++;
+		}
+	}
+
+	/* Get vendor models */
+	entry = l_queue_get_entries(mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+		uint16_t vendor;
+
+		if (n + 4 > buf_sz)
+			goto done;
+
+		if ((mod->id & VENDOR_ID_MASK) == VENDOR_ID_MASK)
+			continue;
+
+		vendor = (uint16_t) (mod->id >> 16);
+		l_put_le16(vendor, buf + n);
+		n += 2;
+		l_put_le16((uint16_t) (mod->id & 0xffff), buf + n);
+		n += 2;
+		num_v++;
+	}
+
+done:
+	mod_buf[0] = num_s;
+	mod_buf[1] = num_v;
+	return n;
+}
diff --git a/mesh/model.h b/mesh/model.h
index 0377d3fdd..b425fd66a 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -60,14 +60,19 @@ struct mesh_model_ops {
 	mesh_model_sub_cb sub;
 };
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t mod_id);
+bool mesh_model_add(struct mesh_node *node, struct l_queue *mods,
+			uint16_t mod_id, struct l_dbus_message_iter *opts);
+bool mesh_model_vendor_add(struct mesh_node *node, struct l_queue *mods,
+					uint16_t vendor_id, uint16_t mod_id,
+					struct l_dbus_message_iter *opts);
 void mesh_model_free(void *data);
-uint32_t mesh_model_get_model_id(const struct mesh_model *model);
 bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
-			uint32_t mod_id, const struct mesh_model_ops *cbs,
+			uint16_t mod_id, const struct mesh_model_ops *cbs,
 							void *user_data);
-struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
-								void *data);
+bool mesh_model_add_from_storage(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *mods, struct l_queue *db_mods);
+void mesh_model_convert_to_storage(struct l_queue *db_mods,
+							struct l_queue *mods);
 struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
 				uint16_t addr, uint32_t mod_id, int *status);
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
@@ -95,26 +100,26 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
 					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len);
-int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
+int mesh_model_publish(struct mesh_node *node, uint16_t mod_id, uint16_t src,
 				uint8_t ttl, const void *msg, uint16_t msg_len);
+int mesh_model_vendor_publish(struct mesh_node *node, uint16_t vendor_id,
+				uint16_t mod_id, uint16_t src, uint8_t ttl,
+				const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
 			uint16_t src, uint16_t dst, uint8_t key_aid,
 			const uint8_t *data, uint16_t size);
 void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
-void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
-								uint16_t idx);
+void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
+				struct l_queue *models, uint16_t app_idx);
 struct l_queue *mesh_model_get_appkeys(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
 bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size, uint32_t *opcode,
 								uint16_t *n);
-void model_build_config(void *model, void *msg_builder);
-
-void mesh_model_enable_pub(struct mesh_model *mod, bool enable);
-bool mesh_model_is_pub_enabled(struct mesh_model *mod);
-void mesh_model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
-								bool enable);
-bool mesh_model_is_sub_enabled(struct mesh_model *mod);
-
+void mesh_model_build_config(void *model, void *msg_builder);
+void mesh_model_update_opts(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *curr, struct l_queue *updated);
+uint16_t mesh_model_generate_composition(struct l_queue *mods, uint16_t buf_sz,
+								uint8_t *buf);
 void mesh_model_init(void);
 void mesh_model_cleanup(void);
diff --git a/mesh/node.c b/mesh/node.c
index 9b97aa927..93020c93d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -186,28 +186,6 @@ static bool match_element_path(const void *a, const void *b)
 	return (!strcmp(element->path, path));
 }
 
-static bool match_model_id(const void *a, const void *b)
-{
-	const struct mesh_model *mod = a;
-	uint32_t mod_id = L_PTR_TO_UINT(b);
-
-	return mesh_model_get_model_id(mod) == mod_id;
-}
-
-static int compare_model_id(const void *a, const void *b, void *user_data)
-{
-	uint32_t a_id = mesh_model_get_model_id(a);
-	uint32_t b_id = mesh_model_get_model_id(b);
-
-	if (a_id < b_id)
-		return -1;
-
-	if (a_id > b_id)
-		return 1;
-
-	return 0;
-}
-
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
 {
 	return l_queue_find(nodes, match_device_uuid, uuid);
@@ -225,25 +203,6 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 	return node->uuid;
 }
 
-static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
-								uint8_t ele_idx)
-{
-	struct node_element *ele;
-	struct mesh_model *mod;
-
-	ele = l_queue_find(node->elements, match_element_idx,
-							L_UINT_TO_PTR(ele_idx));
-	if (!ele)
-		return;
-
-	if (l_queue_find(ele->models, match_model_id, L_UINT_TO_PTR(mod_id)))
-		return;
-
-	mod = mesh_model_new(ele_idx, mod_id);
-
-	l_queue_insert(ele->models, mod, compare_model_id, NULL);
-}
-
 static void set_defaults(struct mesh_node *node)
 {
 	node->lpn = MESH_MODE_UNSUPPORTED;
@@ -359,46 +318,6 @@ void node_remove(struct mesh_node *node)
 	free_node_resources(node);
 }
 
-static bool add_models_from_storage(struct mesh_node *node,
-					struct node_element *ele,
-					struct mesh_config_element *db_ele)
-{
-	const struct l_queue_entry *entry;
-
-	if (!ele->models)
-		ele->models = l_queue_new();
-
-	entry = l_queue_get_entries(db_ele->models);
-
-	for (; entry; entry = entry->next) {
-		struct mesh_model *mod;
-		struct mesh_config_model *db_mod;
-		uint32_t id;
-
-		db_mod = entry->data;
-
-		id = db_mod->vendor ? db_mod->id : db_mod->id | VENDOR_ID_MASK;
-
-		if (l_queue_find(ele->models, match_model_id,
-							L_UINT_TO_PTR(id)))
-			return false;
-
-		mod = mesh_model_setup(node, ele->idx, db_mod);
-		if (!mod)
-			return false;
-
-		if (!db_mod->pub_enabled)
-			mesh_model_enable_pub(mod, false);
-
-		if (!db_mod->sub_enabled)
-			mesh_model_enable_sub(node, mod, false);
-
-		l_queue_insert(ele->models, mod, compare_model_id, NULL);
-	}
-
-	return true;
-}
-
 static bool add_element_from_storage(struct mesh_node *node,
 					struct mesh_config_element *db_ele)
 {
@@ -411,7 +330,12 @@ static bool add_element_from_storage(struct mesh_node *node,
 	ele->idx = db_ele->index;
 	ele->location = db_ele->location;
 
-	if (!db_ele->models || !add_models_from_storage(node, ele, db_ele))
+
+	if (!ele->models)
+		ele->models = l_queue_new();
+
+	if (!mesh_model_add_from_storage(node, ele->idx, ele->models,
+							db_ele->models))
 		return false;
 
 	l_queue_push_tail(node->elements, ele);
@@ -424,12 +348,13 @@ static bool add_elements_from_storage(struct mesh_node *node,
 	const struct l_queue_entry *entry;
 
 	entry = l_queue_get_entries(db_node->elements);
+
 	for (; entry; entry = entry->next)
 		if (!add_element_from_storage(node, entry->data))
 			return false;
 
 	/* Add configuration server model on the primary element */
-	add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+	mesh_model_add(node, PRIMARY_ELE_IDX, CONFIG_SRV_MODEL, NULL);
 
 	return true;
 }
@@ -628,7 +553,7 @@ void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
 
-		mesh_model_app_key_delete(node, ele->models, app_idx);
+		mesh_model_app_key_delete(node, ele->idx, ele->models, app_idx);
 	}
 }
 
@@ -666,27 +591,17 @@ uint8_t node_get_num_elements(struct mesh_node *node)
 	return node->num_ele;
 }
 
-struct l_queue *node_get_element_models(struct mesh_node *node,
-						uint8_t ele_idx, int *status)
+struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx)
 {
 	struct node_element *ele;
 
-	if (!node) {
-		if (status)
-			*status = MESH_STATUS_INVALID_ADDRESS;
+	if (!node)
 		return NULL;
-	}
 
 	ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(ele_idx));
-	if (!ele) {
-		if (status)
-			*status = MESH_STATUS_INVALID_ADDRESS;
+	if (!ele)
 		return NULL;
-	}
-
-	if (status)
-		*status = MESH_STATUS_SUCCESS;
 
 	return ele->models;
 }
@@ -888,9 +803,8 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 								uint16_t sz)
 {
-	uint16_t n, features;
-	uint16_t num_ele = 0;
-	const struct l_queue_entry *ele_entry;
+	uint16_t n, features, num_ele = 0;
+	const struct l_queue_entry *entry;
 
 	if (!node || sz < MIN_COMP_SIZE)
 		return 0;
@@ -920,12 +834,10 @@ static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 	l_put_le16(features, buf + n);
 	n += 2;
 
-	ele_entry = l_queue_get_entries(node->elements);
-	for (; ele_entry; ele_entry = ele_entry->next) {
-		struct node_element *ele = ele_entry->data;
-		const struct l_queue_entry *mod_entry;
-		uint8_t num_s = 0, num_v = 0;
-		uint8_t *mod_buf;
+	entry = l_queue_get_entries(node->elements);
+
+	for (; entry; entry = entry->next) {
+		struct node_element *ele = entry->data;
 
 		if (ele->idx != num_ele)
 			return 0;
@@ -939,59 +851,8 @@ static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 		l_put_le16(ele->location, buf + n);
 		n += 2;
 
-		/* Store models IDs, store num_s and num_v later */
-		mod_buf = buf + n;
-		n += 2;
-
-		/* Get SIG models */
-		mod_entry = l_queue_get_entries(ele->models);
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			uint32_t mod_id;
-
-			mod_id = mesh_model_get_model_id(
-					(const struct mesh_model *) mod);
-
-			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
-				if (n + 2 > sz)
-					goto element_done;
-
-				l_put_le16((uint16_t) (mod_id & 0xffff),
+		n += mesh_model_generate_composition(ele->models, sz - n,
 								buf + n);
-				n += 2;
-				num_s++;
-			}
-		}
-
-		/* Get vendor models */
-		mod_entry = l_queue_get_entries(ele->models);
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			uint32_t mod_id;
-			uint16_t vendor;
-
-			mod_id = mesh_model_get_model_id(
-					(const struct mesh_model *) mod);
-
-			vendor = (uint16_t) (mod_id >> 16);
-			if (vendor != 0xffff) {
-				if (n + 4 > sz)
-					goto element_done;
-
-				l_put_le16(vendor, buf + n);
-				n += 2;
-				l_put_le16((uint16_t) (mod_id & 0xffff),
-								buf + n);
-				n += 2;
-				num_v++;
-			}
-
-		}
-
-element_done:
-		mod_buf[0] = num_s;
-		mod_buf[1] = num_v;
-
 	}
 
 	if (!num_ele)
@@ -1128,52 +989,6 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	free_node_dbus_resources(node);
 }
 
-static bool get_model_options(struct mesh_node *node, struct mesh_model *mod,
-					struct l_dbus_message_iter *opts)
-{
-	const char *key;
-	struct l_dbus_message_iter var;
-	bool opt;
-
-	while (l_dbus_message_iter_next_entry(opts, &key, &var)) {
-
-		if (!strcmp(key, "Publish")) {
-			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
-				return false;
-			mesh_model_enable_pub(mod, opt);
-		} else if (!strcmp(key, "Subscribe")) {
-			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
-				return false;
-			mesh_model_enable_sub(node, mod, opt);
-		} else
-			return false;
-	}
-
-	return true;
-}
-
-static bool generate_model(struct mesh_node *node, struct node_element *ele,
-				uint32_t id, struct l_dbus_message_iter *opts)
-{
-	struct mesh_model *mod;
-
-	/* Disallow duplicates */
-	if (l_queue_find(ele->models, match_model_id,
-			 L_UINT_TO_PTR(id)))
-		return false;
-
-	mod = mesh_model_new(ele->idx, id);
-
-	if (!get_model_options(node, mod, opts)) {
-		l_free(mod);
-		return false;
-	}
-
-	l_queue_insert(ele->models, mod, compare_model_id, NULL);
-
-	return true;
-}
-
 static bool get_sig_models_from_properties(struct mesh_node *node,
 					struct node_element *ele,
 					struct l_dbus_message_iter *property)
@@ -1189,13 +1004,12 @@ static bool get_sig_models_from_properties(struct mesh_node *node,
 
 	/* Bluetooth SIG defined models */
 	while (l_dbus_message_iter_next_entry(&mods, &m_id, &var)) {
-		uint32_t id = m_id | VENDOR_ID_MASK;
 
 		/* Allow Config Server Model only on the primary element */
-		if (ele->idx != PRIMARY_ELE_IDX && id == CONFIG_SRV_MODEL)
+		if (ele->idx != PRIMARY_ELE_IDX && m_id == CONFIG_SRV_MODEL)
 			return false;
 
-		if (!generate_model(node, ele, id, &var))
+		if (!mesh_model_add(node, ele->models, m_id, &var))
 			return false;
 	}
 
@@ -1217,9 +1031,7 @@ static bool get_vendor_models_from_properties(struct mesh_node *node,
 
 	/* Vendor defined models */
 	while (l_dbus_message_iter_next_entry(&mods, &v_id, &m_id, &var)) {
-		uint32_t id = m_id | (v_id << 16);
-
-		if (!generate_model(node, ele, id, &var))
+		if (!mesh_model_vendor_add(node, ele->models, v_id, m_id, &var))
 			return false;
 	}
 
@@ -1295,7 +1107,7 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	 * the operation below will be a "no-op".
 	 */
 	if (ele->idx == PRIMARY_ELE_IDX)
-		add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+		mesh_model_add(node, ele->models, CONFIG_SRV_MODEL, NULL);
 
 	return true;
 fail:
@@ -1332,7 +1144,6 @@ static void convert_node_to_storage(struct mesh_node *node,
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
 		struct mesh_config_element *db_ele;
-		const struct l_queue_entry *mod_entry;
 
 		db_ele = l_new(struct mesh_config_element, 1);
 
@@ -1340,21 +1151,8 @@ static void convert_node_to_storage(struct mesh_node *node,
 		db_ele->location = ele->location;
 		db_ele->models = l_queue_new();
 
-		mod_entry = l_queue_get_entries(ele->models);
+		mesh_model_convert_to_storage(db_ele->models, ele->models);
 
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			struct mesh_config_model *db_mod;
-			uint32_t mod_id = mesh_model_get_model_id(mod);
-
-			db_mod = l_new(struct mesh_config_model, 1);
-			db_mod->id = mod_id;
-			db_mod->vendor = ((mod_id & VENDOR_ID_MASK)
-							!= VENDOR_ID_MASK);
-			db_mod->pub_enabled = mesh_model_is_pub_enabled(mod);
-			db_mod->sub_enabled = mesh_model_is_sub_enabled(mod);
-			l_queue_push_tail(db_ele->models, db_mod);
-		}
 		l_queue_push_tail(db_node->elements, db_ele);
 	}
 
@@ -1375,6 +1173,7 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
+
 	for (; entry; entry = entry->next) {
 		struct mesh_config_element *db_ele = entry->data;
 
@@ -1517,7 +1316,6 @@ static void update_model_options(struct mesh_node *node,
 	len = l_queue_length(node->elements);
 
 	for (i = 0; i < len; i++) {
-		const struct l_queue_entry *entry;
 
 		ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(i));
@@ -1526,42 +1324,8 @@ static void update_model_options(struct mesh_node *node,
 		if (!ele || !ele_attach)
 			continue;
 
-		entry = l_queue_get_entries(ele->models);
-
-		for (; entry; entry = entry->next) {
-			struct mesh_model *mod, *updated_mod = entry->data;
-			uint32_t id = mesh_model_get_model_id(updated_mod);
-			bool opt, updated_opt;
-			bool vendor = id < VENDOR_ID_MASK;
-
-			mod = l_queue_find(ele_attach->models, match_model_id,
-							L_UINT_TO_PTR(id));
-			if (!mod)
-				continue;
-
-			if (!vendor)
-				id &= ~VENDOR_ID_MASK;
-
-			opt = mesh_model_is_pub_enabled(mod);
-			updated_opt = mesh_model_is_pub_enabled(updated_mod);
-
-			if (updated_opt != opt) {
-				mesh_model_enable_pub(mod, updated_opt);
-				mesh_config_model_pub_enable(attach->cfg,
-							attach->primary + i, id,
-							vendor, updated_opt);
-			}
-
-			opt = mesh_model_is_sub_enabled(mod);
-			updated_opt = mesh_model_is_sub_enabled(updated_mod);
-
-			if (updated_opt != opt) {
-				mesh_model_enable_sub(node, mod, updated_opt);
-				mesh_config_model_sub_enable(attach->cfg,
-							attach->primary + i, id,
-							vendor, updated_opt);
-			}
-		}
+		mesh_model_update_opts(node, ele->idx, ele_attach->models,
+								ele->models);
 	}
 }
 
@@ -1964,7 +1728,7 @@ static void build_element_config(void *a, void *b)
 	l_dbus_message_builder_enter_array(builder, "(qa{sv})");
 
 	/* Iterate over models */
-	l_queue_foreach(ele->models, model_build_config, builder);
+	l_queue_foreach(ele->models, mesh_model_build_config, builder);
 
 	l_dbus_message_builder_leave_array(builder);
 
@@ -2243,7 +2007,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	result = mesh_model_publish(node, VENDOR_ID_MASK | mod_id, src,
+	result = mesh_model_publish(node, mod_id, src,
 				mesh_net_get_default_ttl(node->net), data, len);
 
 	if (result != MESH_ERROR_NONE)
@@ -2260,8 +2024,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	const char *sender, *ele_path;
 	struct l_dbus_message_iter iter_data;
 	uint16_t src;
-	uint16_t model_id, vendor;
-	uint32_t vendor_mod_id;
+	uint16_t mod_id, vendor_id;
 	struct node_element *ele;
 	uint8_t *data = NULL;
 	uint32_t len;
@@ -2274,8 +2037,8 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &vendor,
-							&model_id, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &vendor_id,
+							&mod_id, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -2290,8 +2053,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	vendor_mod_id = (vendor << 16) | model_id;
-	result = mesh_model_publish(node, vendor_mod_id, src,
+	result = mesh_model_vendor_publish(node, vendor_id, mod_id, src,
 				mesh_net_get_default_ttl(node->net), data, len);
 
 	if (result != MESH_ERROR_NONE)
diff --git a/mesh/node.h b/mesh/node.h
index df058458a..47c998530 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -58,8 +58,8 @@ bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl);
 bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
 uint32_t node_get_sequence_number(struct mesh_node *node);
 int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr);
-struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx,
-								int *status);
+struct l_queue *node_get_element_models(struct mesh_node *node,
+							uint8_t ele_idx);
 uint16_t node_get_crpl(struct mesh_node *node);
 bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
-- 
2.26.2

