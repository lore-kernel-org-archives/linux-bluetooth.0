Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195BCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA59A61130
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhIWD2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:16377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239046AbhIWD2l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555900"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555900"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072340"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:53 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/20] tools/mesh-cfgclient: Keep track of updated keys
Date:   Wed, 22 Sep 2021 20:25:47 -0700
Message-Id: <20210923032603.50536-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh/cfgcli.c  |  33 ++++----
 tools/mesh/mesh-db.c | 151 ++++++++++++++++++++++++++++++-----
 tools/mesh/mesh-db.h |   2 +
 tools/mesh/remote.c  | 182 +++++++++++++++++++++++++++++++++----------
 tools/mesh/remote.h  |   9 ++-
 5 files changed, 299 insertions(+), 78 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index d8eee4edc..485d13b5a 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -447,13 +447,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (!cmd)
 			break;
 
-		if (cmd->opcode == OP_APPKEY_ADD) {
-			if (remote_add_app_key(src, app_idx))
-				mesh_db_node_app_key_add(src, app_idx);
-		} else if (cmd->opcode == OP_APPKEY_DELETE) {
-			if (remote_del_app_key(src, app_idx))
-				mesh_db_node_app_key_del(src, app_idx);
-		}
+		if (cmd->opcode == OP_APPKEY_ADD)
+			remote_add_app_key(src, app_idx, true);
+		else if (cmd->opcode == OP_APPKEY_DELETE)
+			remote_del_app_key(src, app_idx);
+		else if (cmd->opcode == OP_APPKEY_UPDATE)
+			remote_update_app_key(src, app_idx, true, true);
 
 		break;
 
@@ -492,13 +491,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (!cmd)
 			break;
 
-		if (cmd->opcode == OP_NETKEY_ADD) {
-			if (remote_add_net_key(src, net_idx))
-				mesh_db_node_net_key_add(src, net_idx);
-		} else if (cmd->opcode == OP_NETKEY_DELETE) {
-			if (remote_del_net_key(src, net_idx))
-				mesh_db_node_net_key_del(src, net_idx);
-		}
+		if (cmd->opcode == OP_NETKEY_ADD)
+			remote_add_net_key(src, net_idx, true);
+		else if (cmd->opcode == OP_NETKEY_DELETE)
+			remote_del_net_key(src, net_idx);
+		else if (cmd->opcode == OP_NETKEY_UPDATE)
+			remote_update_net_key(src, net_idx, true, true);
 
 		break;
 
@@ -534,6 +532,13 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("\tNetKey %u (0x%3.3x)\n", net_idx, net_idx);
 		bt_shell_printf("\tKR Phase %2.2x\n", data[3]);
+
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		if (data[3] == KEY_REFRESH_PHASE_NONE)
+			remote_finish_key_refresh(src, net_idx);
+
 		break;
 
 	case OP_MODEL_APP_STATUS:
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 5b3c4b2f7..a57a5d547 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -200,6 +200,38 @@ static bool write_int(json_object *jobj, const char *keyword, int val)
 	return true;
 }
 
+static bool get_bool(json_object *jobj, const char *keyword, bool *value)
+{
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
+		return false;
+
+	if (json_object_get_type(jvalue) != json_type_boolean) {
+		l_error("Error: %s should contain a boolean value\n",
+								keyword);
+		return false;
+	}
+
+	*value = json_object_get_boolean(jvalue);
+
+	return true;
+}
+
+static bool write_bool(json_object *jobj, const char *keyword, bool val)
+{
+	json_object *jval;
+
+	json_object_object_del(jobj, keyword);
+
+	jval = json_object_new_boolean(val);
+	if (!jval)
+		return false;
+
+	json_object_object_add(jobj, keyword, jval);
+	return true;
+}
+
 static json_object *get_key_object(json_object *jarray, uint16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
@@ -347,6 +379,20 @@ static uint16_t node_parse_key(json_object *jarray, int i)
 	return (uint16_t)idx;
 }
 
+static bool node_check_key_updated(json_object *jarray, int i, bool *updated)
+{
+	json_object *jkey;
+
+	jkey = json_object_array_get_idx(jarray, i);
+	if (!jkey)
+		return false;
+
+	if (!get_bool(jkey, "updated", updated))
+		return false;
+
+	return true;
+}
+
 static int compare_group_addr(const void *a, const void *b, void *user_data)
 {
 	const struct mesh_group *grp0 = a;
@@ -483,10 +529,17 @@ static void load_remotes(json_object *jcfg)
 		remote_add_node((const uint8_t *)uuid, unicast, ele_cnt,
 								key_idx);
 		for (j = 1; j < key_cnt; j++) {
+			bool updated = false;
+
 			key_idx = node_parse_key(jarray, j);
 
-			if (key_idx != KEY_IDX_INVALID)
-				remote_add_net_key(unicast, key_idx);
+			if (key_idx == KEY_IDX_INVALID)
+				continue;
+
+			remote_add_net_key(unicast, key_idx, false);
+
+			node_check_key_updated(jarray, j, &updated);
+			remote_update_net_key(unicast, key_idx, updated, false);
 		}
 
 		json_object_object_get_ex(jnode, "appKeys", &jarray);
@@ -496,10 +549,17 @@ static void load_remotes(json_object *jcfg)
 		key_cnt = json_object_array_length(jarray);
 
 		for (j = 0; j < key_cnt; j++) {
+			bool updated = false;
+
 			key_idx = node_parse_key(jarray, j);
 
-			if (key_idx != KEY_IDX_INVALID)
-				remote_add_app_key(unicast, key_idx);
+			if (key_idx == KEY_IDX_INVALID)
+				continue;
+
+			remote_add_app_key(unicast, key_idx, false);
+
+			node_check_key_updated(jarray, j, &updated);
+			remote_update_app_key(unicast, key_idx, updated, false);
 		}
 
 		load_composition(jnode, unicast);
@@ -554,28 +614,19 @@ static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
 
 	jkey = json_object_new_object();
 
-	if (!write_int(jkey, "index", (int)idx)) {
-		json_object_put(jkey);
-		return false;
-	}
+	if (!write_int(jkey, "index", (int)idx))
+		goto fail;
+
+	if (!write_bool(jkey, "updated", false))
+		goto fail;
 
 	json_object_array_add(jarray, jkey);
 
 	return save_config();
-}
-
-bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
-{
-	json_object *jnode;
-
-	if (!cfg || !cfg->jcfg)
-		return false;
 
-	jnode = get_node_by_unicast(unicast);
-	if (!jnode)
-		return false;
-
-	return add_node_key(jnode, "netKeys", idx);
+fail:
+	json_object_put(jkey);
+	return false;
 }
 
 bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
@@ -628,6 +679,20 @@ static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
 	return save_config();
 }
 
+bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	return add_node_key(jnode, "netKeys", idx);
+}
+
 bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
 {
 	json_object *jnode;
@@ -642,6 +707,45 @@ bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
 	return delete_key(jnode, "netKeys", net_idx);
 }
 
+static bool key_update(uint16_t unicast, int16_t idx, bool updated,
+							const char *desc)
+{
+	json_object *jnode, *jarray;
+	int i, sz;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	if (!json_object_object_get_ex(jnode, desc, &jarray))
+		return false;
+
+	sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry;
+		int val;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!get_int(jentry, "index", &val))
+			continue;
+
+		if ((val == idx) && write_bool(jentry, "updated", updated))
+			return save_config();
+	}
+
+	return false;
+}
+
+bool mesh_db_node_net_key_update(uint16_t unicast, uint16_t idx, bool updated)
+{
+	return key_update(unicast, idx, updated, "netKeys");
+}
+
 bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx)
 {
 	json_object *jnode;
@@ -670,6 +774,11 @@ bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx)
 	return delete_key(jnode, "appKeys", idx);
 }
 
+bool mesh_db_node_app_key_update(uint16_t unicast, uint16_t idx, bool updated)
+{
+	return key_update(unicast, idx, updated, "appKeys");
+}
+
 static bool load_keys(json_object *jobj)
 {
 	json_object *jarray, *jentry;
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index efd579553..c1bcb3ae6 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -38,8 +38,10 @@ bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
 							uint16_t interval);
 bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx);
 bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_net_key_update(uint16_t unicast, uint16_t idx, bool updated);
 bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx);
 bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_app_key_update(uint16_t unicast, uint16_t idx, bool updated);
 bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl);
 bool mesh_db_node_write_mode(uint16_t unicast, const char *keyword, int value);
 bool mesh_db_node_model_binding_add(uint16_t unicast, uint8_t ele, bool vendor,
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index e60a3681d..5f598cb8b 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -25,6 +25,11 @@
 
 #define abs_diff(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
 
+struct remote_key {
+	uint16_t idx;
+	bool updated;
+};
+
 struct remote_node {
 	uint16_t unicast;
 	struct l_queue *net_keys;
@@ -42,20 +47,6 @@ struct rejected_addr {
 static struct l_queue *nodes;
 static struct l_queue *reject_list;
 
-static bool key_present(struct l_queue *keys, uint16_t app_idx)
-{
-	const struct l_queue_entry *l;
-
-	for (l = l_queue_get_entries(keys); l; l = l->next) {
-		uint16_t idx = L_PTR_TO_UINT(l->data);
-
-		if (idx == app_idx)
-			return true;
-	}
-
-	return false;
-}
-
 static int compare_mod_id(const void *a, const void *b, void *user_data)
 {
 	uint32_t id1 = L_PTR_TO_UINT(a);
@@ -102,12 +93,20 @@ static bool match_node_addr(const void *a, const void *b)
 	return false;
 }
 
+static bool match_key(const void *a, const void *b)
+{
+	const struct remote_key *key = a;
+	uint16_t idx = L_PTR_TO_UINT(b);
+
+	return (key->idx == idx);
+}
+
 static bool match_bound_key(const void *a, const void *b)
 {
-	uint16_t app_idx = L_PTR_TO_UINT(a);
+	const struct remote_key *app_key = a;
 	uint16_t net_idx = L_PTR_TO_UINT(b);
 
-	return (net_idx == keys_get_bound_key(app_idx));
+	return (net_idx == keys_get_bound_key(app_key->idx));
 }
 
 uint8_t remote_del_node(uint16_t unicast)
@@ -142,6 +141,7 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx)
 {
 	struct remote_node *rmt;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
 	if (rmt)
@@ -153,7 +153,10 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 	rmt->num_ele = ele_cnt;
 	rmt->net_keys = l_queue_new();
 
-	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
+	key = l_new(struct remote_key, 1);
+	key->idx = net_idx;
+
+	l_queue_push_tail(rmt->net_keys, key);
 
 	rmt->els = l_new(struct l_queue *, ele_cnt);
 
@@ -161,6 +164,7 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 		nodes = l_queue_new();
 
 	l_queue_insert(nodes, rmt, compare_unicast, NULL);
+
 	return true;
 }
 
@@ -188,49 +192,84 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 	return true;
 }
 
-bool remote_add_net_key(uint16_t addr, uint16_t net_idx)
+bool remote_add_net_key(uint16_t addr, uint16_t net_idx, bool save)
 {
 	struct remote_node *rmt;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
 		return false;
 
-	if (key_present(rmt->net_keys, net_idx))
-		return false;
+	if (l_queue_find(rmt->net_keys, match_key, L_UINT_TO_PTR(net_idx)))
+		return true;
 
-	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
-	return true;
+	key = l_new(struct remote_key, 1);
+	key->idx = net_idx;
+
+	l_queue_push_tail(rmt->net_keys, key);
+
+	if (save)
+		return mesh_db_node_net_key_add(addr, net_idx);
+	else
+		return true;
 }
 
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx)
 {
 	struct remote_node *rmt;
-	void *data;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
 		return false;
 
-	if (!l_queue_remove(rmt->net_keys, L_UINT_TO_PTR(net_idx)))
+	key = l_queue_remove_if(rmt->net_keys, match_key,
+							L_UINT_TO_PTR(net_idx));
+	if (!key)
 		return false;
 
-	data = l_queue_remove_if(rmt->app_keys, match_bound_key,
+	mesh_db_node_net_key_del(addr, net_idx);
+
+	l_free(key);
+	key = l_queue_remove_if(rmt->app_keys, match_bound_key,
 						L_UINT_TO_PTR(net_idx));
-	while (data) {
-		uint16_t app_idx = (uint16_t) L_PTR_TO_UINT(data);
 
-		mesh_db_node_app_key_del(rmt->unicast, app_idx);
-		data = l_queue_remove_if(rmt->app_keys, match_bound_key,
+	while (key) {
+		mesh_db_node_app_key_del(rmt->unicast, key->idx);
+		l_free(key);
+
+		key = l_queue_remove_if(rmt->app_keys, match_bound_key,
 						L_UINT_TO_PTR(net_idx));
 	}
 
 	return true;
 }
 
-bool remote_add_app_key(uint16_t addr, uint16_t app_idx)
+bool remote_update_net_key(uint16_t addr, uint16_t net_idx, bool update,
+								bool save)
+{
+	struct remote_node *rmt;
+	struct remote_key *key;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	key = l_queue_find(rmt->net_keys, match_key,
+						L_UINT_TO_PTR(net_idx));
+	key->updated = update;
+
+	if (save)
+		return mesh_db_node_net_key_update(addr, net_idx, update);
+	else
+		return true;
+}
+
+bool remote_add_app_key(uint16_t addr, uint16_t app_idx, bool save)
 {
 	struct remote_node *rmt;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
@@ -239,44 +278,105 @@ bool remote_add_app_key(uint16_t addr, uint16_t app_idx)
 	if (!rmt->app_keys)
 		rmt->app_keys = l_queue_new();
 
-	if (key_present(rmt->app_keys, app_idx))
-		return false;
+	if (l_queue_find(rmt->app_keys, match_key, L_UINT_TO_PTR(app_idx)))
+		return true;
 
-	l_queue_push_tail(rmt->app_keys, L_UINT_TO_PTR(app_idx));
-	return true;
+	key = l_new(struct remote_key, 1);
+	key->idx = app_idx;
+
+	l_queue_push_tail(rmt->app_keys, key);
+
+	if (save)
+		return mesh_db_node_app_key_add(addr, app_idx);
+	else
+		return true;
 }
 
 bool remote_del_app_key(uint16_t addr, uint16_t app_idx)
 {
 	struct remote_node *rmt;
+	struct remote_key *key;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	key = l_queue_remove_if(rmt->app_keys, match_key,
+						L_UINT_TO_PTR(app_idx));
+	l_free(key);
+
+	return mesh_db_node_app_key_del(addr, app_idx);
+}
+
+bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
+								bool save)
+{
+	struct remote_node *rmt;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
 		return false;
 
-	return l_queue_remove(rmt->app_keys, L_UINT_TO_PTR(app_idx));
+	key = l_queue_find(rmt->app_keys, match_key,
+						L_UINT_TO_PTR(app_idx));
+	key->updated = update;
+
+	if (save)
+		return mesh_db_node_app_key_update(addr, app_idx, update);
+	else
+		return true;
+}
+
+void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx)
+{
+	struct remote_node *rmt;
+	struct remote_key *key;
+	const struct l_queue_entry *l;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return;
+
+	if (!remote_update_net_key(addr, net_idx, false, true))
+		return;
+
+	l = l_queue_get_entries(rmt->app_keys);
+
+	for (; l; l = l->next) {
+		key = l->data;
+
+		if (net_idx != keys_get_bound_key(key->idx))
+			continue;
+
+		key->updated = false;
+
+		mesh_db_node_app_key_update(addr, key->idx, false);
+	}
+
 }
 
 uint16_t remote_get_subnet_idx(uint16_t addr)
 {
 	struct remote_node *rmt;
-	uint32_t net_idx;
+	struct remote_key *key;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 
 	if (!rmt || l_queue_isempty(rmt->net_keys))
 		return NET_IDX_INVALID;
 
-	net_idx = L_PTR_TO_UINT(l_queue_peek_head(rmt->net_keys));
+	key = l_queue_peek_head(rmt->net_keys);
 
-	return (uint16_t) net_idx;
+	return key->idx;
 }
 
-static void print_key(void *key, void *user_data)
+static void print_key(void *data, void *user_data)
 {
-	uint16_t idx = L_PTR_TO_UINT(key);
+	struct remote_key *key = data;
 
-	bt_shell_printf("%u (0x%3.3x), ", idx, idx);
+	bt_shell_printf("%u (0x%3.3x) %s, ", key->idx, key->idx,
+						key->updated ? ", updated":"");
 }
 
 static void print_model(void *model, void *user_data)
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 8ecb097ae..74747689a 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -16,10 +16,15 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 void remote_add_rejected_address(uint16_t addr, uint32_t iv_index, bool save);
 void remote_clear_rejected_addresses(uint32_t iv_index);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
-bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
+bool remote_add_net_key(uint16_t addr, uint16_t net_idx, bool save);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
-bool remote_add_app_key(uint16_t addr, uint16_t app_idx);
+bool remote_update_net_key(uint16_t addr, uint16_t net_idx, bool update,
+								bool save);
+bool remote_add_app_key(uint16_t addr, uint16_t app_idx, bool save);
 bool remote_del_app_key(uint16_t addr, uint16_t app_idx);
+bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
+								bool save);
+void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx);
 uint16_t remote_get_subnet_idx(uint16_t addr);
 void remote_print_node(uint16_t addr);
 void remote_print_all(void);
-- 
2.31.1

