Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE0C2BD09
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBAB21835
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLFU5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:57:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:41333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfLFU5w (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Dec 2019 15:57:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 12:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="219502257"
Received: from ingas-nuc1.sea.intel.com ([10.255.83.133])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 12:57:51 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Clean up node.c
Date:   Fri,  6 Dec 2019 12:57:48 -0800
Message-Id: <20191206205749.12918-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206205749.12918-1-inga.stotland@intel.com>
References: <20191206205749.12918-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change makes the node initialization a bit easier to follow.
Replace if-else with switch when processing request type, descriptive
function names, more predictable code flow.
---
 mesh/model.c |  17 +--
 mesh/model.h |   4 +-
 mesh/node.c  | 331 ++++++++++++++++++++++++++-------------------------
 3 files changed, 171 insertions(+), 181 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 4091881ec..acdd94f7b 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1249,7 +1249,7 @@ void mesh_model_free(void *data)
 	l_free(mod);
 }
 
-static struct mesh_model *model_new(uint8_t ele_idx, uint32_t id)
+struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id)
 {
 	struct mesh_model *mod = l_new(struct mesh_model, 1);
 
@@ -1259,19 +1259,6 @@ static struct mesh_model *model_new(uint8_t ele_idx, uint32_t id)
 	return mod;
 }
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint16_t id)
-{
-	return model_new(ele_idx, id | VENDOR_ID_MASK);
-}
-
-struct mesh_model *mesh_model_vendor_new(uint8_t ele_idx, uint16_t vendor_id,
-								uint16_t mod_id)
-{
-	uint32_t id = mod_id | (vendor_id << 16);
-
-	return model_new(ele_idx, id);
-}
-
 /* Internal models only */
 static void restore_model_state(struct mesh_model *mod)
 {
@@ -1600,7 +1587,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		return NULL;
 	}
 
-	mod = model_new(ele_idx, db_mod->vendor ? db_mod->id :
+	mod = mesh_model_new(ele_idx, db_mod->vendor ? db_mod->id :
 						db_mod->id | VENDOR_ID_MASK);
 
 	/* Implicitly bind config server model to device key */
diff --git a/mesh/model.h b/mesh/model.h
index f30ca2e38..9c7ce9334 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -62,9 +62,7 @@ struct mesh_model_ops {
 	mesh_model_sub_cb sub;
 };
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint16_t mod_id);
-struct mesh_model *mesh_model_vendor_new(uint8_t ele_idx, uint16_t vendor_id,
-							uint16_t mod_id);
+struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t mod_id);
 void mesh_model_free(void *data);
 uint32_t mesh_model_get_model_id(const struct mesh_model *model);
 bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
diff --git a/mesh/node.c b/mesh/node.c
index b8c30c30a..edf6fce37 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -219,7 +219,6 @@ static int compare_model_id(const void *a, const void *b, void *user_data)
 	return 0;
 }
 
-
 struct mesh_node *node_find_by_addr(uint16_t addr)
 {
 	if (!IS_UNICAST(addr))
@@ -245,13 +244,46 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 	return node->uuid;
 }
 
+static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
+								uint8_t ele_idx)
+{
+	struct node_element *ele;
+	struct mesh_model *mod;
+
+	ele = l_queue_find(node->elements, match_element_idx,
+							L_UINT_TO_PTR(ele_idx));
+	if (!ele)
+		return;
+
+	if (l_queue_find(ele->models, match_model_id, L_UINT_TO_PTR(mod_id)))
+		return;
+
+	mod = mesh_model_new(ele_idx, mod_id);
+
+	l_queue_insert(ele->models, mod, compare_model_id, NULL);
+}
+
+static void set_defaults(struct mesh_node *node)
+{
+	/* TODO: these values should come from mesh.conf */
+	node->lpn = MESH_MODE_UNSUPPORTED;
+	node->proxy = MESH_MODE_UNSUPPORTED;
+	node->friend = MESH_MODE_UNSUPPORTED;
+	node->beacon = MESH_MODE_DISABLED;
+	node->relay.mode = MESH_MODE_DISABLED;
+	node->ttl = TTL_MASK;
+	node->seq_number = DEFAULT_SEQUENCE_NUMBER;
+}
+
 static struct mesh_node *node_new(const uint8_t uuid[16])
 {
 	struct mesh_node *node;
 
 	node = l_new(struct mesh_node, 1);
 	node->net = mesh_net_new(node);
+	node->elements = l_queue_new();
 	memcpy(node->uuid, uuid, sizeof(node->uuid));
+	set_defaults(node);
 
 	return node;
 }
@@ -344,18 +376,8 @@ void node_remove(struct mesh_node *node)
 	free_node_resources(node);
 }
 
-static bool element_add_model(struct node_element *ele, struct mesh_model *mod)
-{
-	uint32_t mod_id = mesh_model_get_model_id(mod);
-
-	if (l_queue_find(ele->models, match_model_id, L_UINT_TO_PTR(mod_id)))
-		return false;
-
-	l_queue_insert(ele->models, mod, compare_model_id, NULL);
-	return true;
-}
-
-static bool add_models(struct mesh_node *node, struct node_element *ele,
+static bool add_models_from_storage(struct mesh_node *node,
+					struct node_element *ele,
 					struct mesh_config_element *db_ele)
 {
 	const struct l_queue_entry *entry;
@@ -364,52 +386,31 @@ static bool add_models(struct mesh_node *node, struct node_element *ele,
 		ele->models = l_queue_new();
 
 	entry = l_queue_get_entries(db_ele->models);
+
 	for (; entry; entry = entry->next) {
 		struct mesh_model *mod;
 		struct mesh_config_model *db_mod;
+		uint32_t id;
 
 		db_mod = entry->data;
+
+		id = db_mod->vendor ? db_mod->id : db_mod->id | VENDOR_ID_MASK;
+
+		if (l_queue_find(ele->models, match_model_id,
+							L_UINT_TO_PTR(id)))
+			return false;
+
 		mod = mesh_model_setup(node, ele->idx, db_mod);
 		if (!mod)
 			return false;
 
-		if (!element_add_model(ele, mod)) {
-			mesh_model_free(mod);
-			return false;
-		}
+		l_queue_insert(ele->models, mod, compare_model_id, NULL);
 	}
 
 	return true;
 }
 
-static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
-								uint8_t ele_idx)
-{
-	struct node_element *ele;
-	struct mesh_model *mod;
-	struct mesh_config_model db_mod;
-
-	ele = l_queue_find(node->elements, match_element_idx,
-							L_UINT_TO_PTR(ele_idx));
-
-	if (!ele)
-		return;
-
-	memset(&db_mod, 0, sizeof(db_mod));
-	db_mod.id = mod_id;
-
-	mod = mesh_model_setup(node, ele_idx, &db_mod);
-	if (!mod)
-		return;
-
-	if (!ele->models)
-		ele->models = l_queue_new();
-
-	if (!element_add_model(ele, mod))
-		mesh_model_free(mod);
-}
-
-static bool add_element(struct mesh_node *node,
+static bool add_element_from_storage(struct mesh_node *node,
 					struct mesh_config_element *db_ele)
 {
 	struct node_element *ele;
@@ -421,26 +422,26 @@ static bool add_element(struct mesh_node *node,
 	ele->idx = db_ele->index;
 	ele->location = db_ele->location;
 
-	if (!db_ele->models || !add_models(node, ele, db_ele))
+	if (!db_ele->models || !add_models_from_storage(node, ele, db_ele))
 		return false;
 
 	l_queue_push_tail(node->elements, ele);
 	return true;
 }
 
-static bool add_elements(struct mesh_node *node,
+static bool add_elements_from_storage(struct mesh_node *node,
 					struct mesh_config_node *db_node)
 {
 	const struct l_queue_entry *entry;
 
-	if (!node->elements)
-		node->elements = l_queue_new();
-
 	entry = l_queue_get_entries(db_node->elements);
 	for (; entry; entry = entry->next)
-		if (!add_element(node, entry->data))
+		if (!add_element_from_storage(node, entry->data))
 			return false;
 
+	/* Add configuration server model on the primary element */
+	add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+
 	return true;
 }
 
@@ -462,13 +463,35 @@ static void set_appkey(void *a, void *b)
 						appkey->key, appkey->new_key);
 }
 
+static bool init_storage_dir(struct mesh_node *node)
+{
+	char uuid[33];
+	char dir_name[PATH_MAX];
+
+	if (node->storage_dir)
+		return true;
+
+	if (!hex2str(node->uuid, 16, uuid, sizeof(uuid)))
+		return false;
+
+	snprintf(dir_name, PATH_MAX, "%s/%s", mesh_get_storage_dir(), uuid);
+
+	if (strlen(dir_name) >= PATH_MAX)
+		return false;
+
+	create_dir(dir_name);
+
+	node->storage_dir = l_strdup(dir_name);
+
+	return true;
+}
+
 static bool init_from_storage(struct mesh_config_node *db_node,
 			const uint8_t uuid[16], struct mesh_config *cfg,
 			void *user_data)
 {
 	unsigned int num_ele;
 	uint8_t mode;
-
 	struct mesh_node *node = node_new(uuid);
 
 	if (!nodes)
@@ -504,7 +527,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	node->num_ele = num_ele;
 
-	if (num_ele != 0 && !add_elements(node, db_node))
+	if (num_ele != 0 && !add_elements_from_storage(node, db_node))
 		goto fail;
 
 	node->primary = db_node->unicast;
@@ -512,6 +535,10 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	if (!db_node->netkeys)
 		goto fail;
 
+	if (!IS_UNASSIGNED(node->primary) &&
+		!mesh_net_register_unicast(node->net, node->primary, num_ele))
+		goto fail;
+
 	mesh_net_set_iv_index(node->net, db_node->iv_index, db_node->iv_update);
 
 	if (db_node->net_transmit)
@@ -544,15 +571,14 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
 		mesh_net_set_beacon_mode(node->net, mode == MESH_MODE_ENABLED);
 
-	if (!IS_UNASSIGNED(node->primary) &&
-		!mesh_net_register_unicast(node->net, node->primary, num_ele))
-		goto fail;
-
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
 	node->cfg = cfg;
 
+	/* Initialize directory for storing keyring info */
+	init_storage_dir(node);
+
 	return true;
 fail:
 	node_remove(node);
@@ -876,8 +902,6 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
 	uint16_t num_ele = 0;
-	uint8_t *cfgmod_idx = NULL;
-
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -940,9 +964,6 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 			mod_id = mesh_model_get_model_id(
 					(const struct mesh_model *) mod);
 
-			if (mod_id == CONFIG_SRV_MODEL)
-				cfgmod_idx = &ele->idx;
-
 			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
 				if (n + 2 > sz)
 					goto element_done;
@@ -988,9 +1009,6 @@ element_done:
 	if (!num_ele)
 		return 0;
 
-	if (!cfgmod_idx || *cfgmod_idx != PRIMARY_ELE_IDX)
-		return 0;
-
 	return n;
 }
 
@@ -1056,39 +1074,57 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	free_node_dbus_resources(node);
 }
 
-static void get_models_from_properties(struct node_element *ele,
-					struct l_dbus_message_iter *property,
-								bool vendor)
+static void get_sig_models_from_properties(struct node_element *ele,
+					struct l_dbus_message_iter *property)
 {
 	struct l_dbus_message_iter ids;
-	uint16_t mod_id, vendor_id;
-	const char *signature = !vendor ? "aq" : "a(qq)";
+	uint16_t mod_id;
 
 	if (!ele->models)
 		ele->models = l_queue_new();
 
-	if (!l_dbus_message_iter_get_variant(property, signature, &ids))
+	if (!l_dbus_message_iter_get_variant(property, "aq", &ids))
 		return;
 
 	/* Bluetooth SIG defined models */
-	if (!vendor) {
-		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
-			struct mesh_model *mod;
+	while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
+		struct mesh_model *mod;
+		uint32_t id = mod_id | VENDOR_ID_MASK;
 
-			mod = mesh_model_new(ele->idx, mod_id);
-			if (!element_add_model(ele, mod))
-				mesh_model_free(mod);
-		}
-		return;
+		if (l_queue_find(ele->models, match_model_id,
+						L_UINT_TO_PTR(id)))
+			continue;
+
+		mod = mesh_model_new(ele->idx, id);
+
+		l_queue_insert(ele->models, mod, compare_model_id, NULL);
 	}
+}
+
+static void get_vendor_models_from_properties(struct node_element *ele,
+					struct l_dbus_message_iter *property)
+{
+	struct l_dbus_message_iter ids;
+	uint16_t mod_id, vendor_id;
+
+	if (!ele->models)
+		ele->models = l_queue_new();
+
+	if (!l_dbus_message_iter_get_variant(property, "a(qq)", &ids))
+		return;
 
 	/* Vendor defined models */
 	while (l_dbus_message_iter_next_entry(&ids, &vendor_id, &mod_id)) {
 		struct mesh_model *mod;
+		uint32_t id = mod_id | (vendor_id << 16);
+
+		if (l_queue_find(ele->models, match_model_id,
+							L_UINT_TO_PTR(id)))
+			continue;
 
-		mod = mesh_model_vendor_new(ele->idx, vendor_id, mod_id);
-		if (!element_add_model(ele, mod))
-			mesh_model_free(mod);
+		mod = mesh_model_new(ele->idx, id);
+
+		l_queue_insert(ele->models, mod, compare_model_id, NULL);
 	}
 }
 
@@ -1116,13 +1152,13 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 		}
 
 		if (!mods && !strcmp(key, "Models")) {
-			get_models_from_properties(ele, &var, false);
+			get_sig_models_from_properties(ele, &var);
 			mods = true;
 			continue;
 		}
 
 		if (!vendor_mods && !strcmp(key, "VendorModels")) {
-			get_models_from_properties(ele, &var, true);
+			get_vendor_models_from_properties(ele, &var);
 			vendor_mods = true;
 			continue;
 		}
@@ -1146,6 +1182,16 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 
 	ele->path = l_strdup(path);
 
+	/*
+	 * Add configuration server model on the primary element.
+	 * We allow the application not to specify the presense of
+	 * the Configuration Server model, since it's implemented by the
+	 * daemon. If the model is present in the application properties,
+	 * the operation below will be a "no-op".
+	 */
+	if (ele->idx == PRIMARY_ELE_IDX)
+		add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+
 	return true;
 fail:
 	l_free(ele);
@@ -1218,6 +1264,9 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 	storage_dir = mesh_get_storage_dir();
 	node->cfg = mesh_config_create(storage_dir, uuid, &db_node);
 
+	if (node->cfg)
+		init_storage_dir(node);
+
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
 	for (; entry; entry = entry->next) {
@@ -1231,21 +1280,6 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 	return node->cfg != NULL;
 }
 
-static void set_defaults(struct mesh_node *node)
-{
-	/* TODO: these values should come from mesh.conf */
-	node->lpn = MESH_MODE_UNSUPPORTED;
-	node->proxy = MESH_MODE_UNSUPPORTED;
-	node->friend = MESH_MODE_UNSUPPORTED;
-	node->beacon = MESH_MODE_DISABLED;
-	node->relay.mode = MESH_MODE_DISABLED;
-	node->ttl = TTL_MASK;
-	node->seq_number = DEFAULT_SEQUENCE_NUMBER;
-
-	/* Add configuration server model on primary element */
-	add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
-}
-
 static bool get_app_properties(struct mesh_node *node, const char *path,
 					struct l_dbus_message_iter *properties)
 {
@@ -1357,29 +1391,6 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	return true;
 }
 
-static bool init_storage_dir(struct mesh_node *node)
-{
-	char uuid[33];
-	char dir_name[PATH_MAX];
-
-	if (node->storage_dir)
-		return true;
-
-	if (!hex2str(node->uuid, 16, uuid, sizeof(uuid)))
-		return false;
-
-	snprintf(dir_name, PATH_MAX, "%s/%s", mesh_get_storage_dir(), uuid);
-
-	if (strlen(dir_name) >= PATH_MAX)
-		return false;
-
-	create_dir(dir_name);
-
-	node->storage_dir = l_strdup(dir_name);
-
-	return true;
-}
-
 static bool check_req_node(struct managed_obj_request *req)
 {
 	uint8_t node_comp[MAX_MSG_LEN - 2];
@@ -1409,12 +1420,19 @@ static bool check_req_node(struct managed_obj_request *req)
 	return true;
 }
 
-static struct mesh_node *attach_req_node(struct mesh_node *attach,
-							struct mesh_node *node)
+static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 {
 	const struct l_queue_entry *attach_entry;
 	const struct l_queue_entry *node_entry;
 
+	attach->obj_path = node->obj_path;
+	node->obj_path = NULL;
+
+	if (!register_node_object(attach)) {
+		free_node_dbus_resources(attach);
+		return false;
+	}
+
 	attach_entry = l_queue_get_entries(attach->elements);
 	node_entry = l_queue_get_entries(node->elements);
 
@@ -1447,7 +1465,7 @@ static struct mesh_node *attach_req_node(struct mesh_node *attach,
 
 	node_remove(node);
 
-	return attach;
+	return true;
 }
 
 static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
@@ -1456,9 +1474,12 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	struct managed_obj_request *req = user_data;
 	const char *path;
 	struct mesh_node *node = req->node;
+	struct node_import *import;
 	void *agent = NULL;
 	bool have_app = false;
 	unsigned int num_ele;
+	struct keyring_net_key net_key;
+	uint8_t dev_key[16];
 
 	if (l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
@@ -1470,9 +1491,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	if (!node->elements)
-		node->elements = l_queue_new();
-
 	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
 		struct l_dbus_message_iter properties;
 		const char *interface;
@@ -1531,7 +1549,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	set_defaults(node);
 	num_ele = l_queue_length(node->elements);
 
 	if (num_ele > MAX_ELE_COUNT)
@@ -1542,26 +1559,19 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	if (!check_req_node(req))
 		goto fail;
 
-	if (req->type == REQUEST_TYPE_ATTACH) {
-		struct l_dbus *bus = dbus_get_bus();
-
-		node = attach_req_node(req->attach, node);
-
-		if (!register_node_object(node))
+	switch (req->type) {
+	case REQUEST_TYPE_ATTACH:
+		if (!attach_req_node(req->attach, node))
 			goto fail;
 
-		/*
-		 * TODO: For now always initialize directory for storing
-		 * keyring info. Need to figure out what checks need
-		 * to be performed to do this conditionally, i.e., presence of
-		 * Provisioner interface, etc.
-		 */
-		init_storage_dir(node);
+		req->attach->disc_watch = l_dbus_add_disconnect_watch(
+					dbus_get_bus(), req->attach->owner,
+					app_disc_cb, req->attach, NULL);
 
-		node->disc_watch = l_dbus_add_disconnect_watch(bus,
-				node->owner, app_disc_cb, node, NULL);
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, req->attach);
+		return;
 
-	} else if (req->type == REQUEST_TYPE_JOIN) {
+	case REQUEST_TYPE_JOIN:
 		if (!node->agent) {
 			l_error("Interface %s not found",
 						MESH_PROVISION_AGENT_INTERFACE);
@@ -1571,26 +1581,27 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
-	} else if (req->type == REQUEST_TYPE_IMPORT) {
-		struct node_import *import = req->import;
+		req->join_ready_cb(node, node->agent);
+
+		return;
 
+	case REQUEST_TYPE_IMPORT:
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
+		import = req->import;
 		if (!add_local_node(node, import->unicast, import->flags.kr,
 					import->flags.ivu,
 					import->iv_index, import->dev_key,
 					import->net_idx, import->net_key))
 			goto fail;
 
-		/* Initialize directory for storing keyring info */
-		init_storage_dir(node);
+		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
+		l_free(import);
 
-	} else {
-		/* Callback for create node request */
-		struct keyring_net_key net_key;
-		uint8_t dev_key[16];
+		return;
 
+	case REQUEST_TYPE_CREATE:
 		if (!create_node_config(node, node->uuid))
 			goto fail;
 
@@ -1606,9 +1617,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 						net_key.old_key))
 			goto fail;
 
-		/* Initialize directory for storing keyring info */
-		init_storage_dir(node);
-
 		if (!keyring_put_remote_dev_key(node, DEFAULT_NEW_UNICAST,
 						node->num_ele, dev_key))
 			goto fail;
@@ -1616,14 +1624,12 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-	}
-
-	if (req->type == REQUEST_TYPE_JOIN)
-		req->join_ready_cb(node, node->agent);
-	else
 		req->ready_cb(req->pending_msg, MESH_ERROR_NONE, node);
+		return;
 
-	goto done;
+	default:
+		goto fail;
+	}
 
 fail:
 	if (agent)
@@ -1638,7 +1644,6 @@ fail:
 	else
 		req->ready_cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
 
-done:
 	if (req->type == REQUEST_TYPE_IMPORT)
 		l_free(req->import);
 }
-- 
2.21.0

