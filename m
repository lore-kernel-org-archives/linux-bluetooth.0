Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 3/3] mesh: meshctl: Add support for subscriptions in node and database
Date: Mon, 11 Dec 2017 14:58:39 +0000
Message-Id: <20171211145839.19573-4-sbrown@cortland.com>
In-Reply-To: <20171211145839.19573-1-sbrown@cortland.com>
References: <20171211145839.19573-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

This populates the GList in the mesh_models structure and
updates the json database.

Add a function to return the device UUID.

Add device UUID to database for possible future restoring
of a nodes configuration.
---
 mesh/config-client.c | 27 ++++++++++++++++-----
 mesh/node.c          | 32 +++++++++++++++++++++++++
 mesh/node.h          |  3 +++
 mesh/prov-db.c       | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/prov-db.h       |  2 ++
 5 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 35ccbff45..b48fe6a9e 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -255,13 +255,28 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Subscr Addr:\t%4.4x\n", get_le16(data + 3));
-		bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 5));
-		break;
+		ele_addr = get_le16(data + 1);
+		addr = get_le16(data + 3);
+		ele_idx = ele_addr - node_get_primary(node);
 
-		/* TODO */
-		/* Save subscription info in database */
+		if (len == 7) {
+			mod_id = get_le16(data + 5);
+			bt_shell_printf("ModelId %4.4x\n", mod_id);
+			mod_id = 0xffff0000 | mod_id;
+		} else {
+			mod_id = get_le16(data + 7);
+			bt_shell_printf("ModelId %4.4x %4.4x\n", get_le16(data + 5),
+									mod_id);
+			mod_id = get_le16(data + 5) << 16 | mod_id;
+		}
+
+		bt_shell_printf("Element Addr:\t%4.4x\n", ele_addr);
+		bt_shell_printf("Subscr Addr:\t%4.4x\n", addr);
+
+		/* Save subscriptions in node  and database */
+		node_add_subscription(node, ele_idx, mod_id, addr);
+		prov_db_add_subscription(node, ele_idx, mod_id, addr);
+		break;
 
 	/* Per Mesh Profile 4.3.2.27 */
 	case OP_CONFIG_MODEL_SUB_LIST:
diff --git a/mesh/node.c b/mesh/node.c
index b682a35f7..40b353fa3 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -349,6 +349,14 @@ uint8_t *node_get_device_key(struct mesh_node *node)
 		return node->dev_key;
 }
 
+uint8_t *node_get_device_uuid(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->dev_uuid;
+}
+
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele)
 {
 	node->num_ele = num_ele;
@@ -758,6 +766,7 @@ bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
 	GList *l;
 
 	model = get_model(node, ele_idx, model_id);
+
 	if(!model)
 		return false;
 
@@ -776,6 +785,29 @@ bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
 	return true;
 }
 
+bool node_add_subscription(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t addr)
+{
+	struct mesh_model *model;
+	GList *l;
+
+	model = get_model(node, ele_idx, model_id);
+
+	if(!model)
+		return false;
+
+	l = g_list_find(model->subscriptions, GUINT_TO_POINTER(addr));
+
+	if (l)
+		return false;
+
+	model->subscriptions = g_list_append(model->subscriptions,
+
+					GUINT_TO_POINTER(addr));
+
+	return true;
+}
+
 uint8_t node_get_default_ttl(struct mesh_node *node)
 {
 	if (!node)
diff --git a/mesh/node.h b/mesh/node.h
index 1fab80a13..69b3bdf94 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -86,6 +86,7 @@ uint16_t node_get_primary(struct mesh_node *node);
 uint16_t node_get_primary_net_idx(struct mesh_node *node);
 void node_set_device_key(struct mesh_node *node, uint8_t *key);
 uint8_t *node_get_device_key(struct mesh_node *node);
+uint8_t *node_get_device_uuid(struct mesh_node *node);
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
 uint8_t node_get_num_elements(struct mesh_node *node);
 bool node_parse_composition(struct mesh_node *node, uint8_t *buf, uint16_t len);
@@ -111,6 +112,8 @@ bool node_set_composition(struct mesh_node *node,
 				struct mesh_node_composition *comp);
 bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
 			uint32_t model_id, uint16_t app_idx);
+bool node_add_subscription(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t addr);
 uint8_t node_get_default_ttl(struct mesh_node *node);
 bool node_set_default_ttl(struct mesh_node *node, uint8_t ttl);
 bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index 04803a5c8..ea0d45af0 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -371,6 +371,34 @@ static bool parse_bindings(struct mesh_node *node, int ele_idx,
 	return true;
 }
 
+static bool parse_subscriptions(struct mesh_node *node, int ele_idx,
+				uint32_t model_id, json_object *jsubscriptions)
+
+{
+	int cnt;
+	int i;
+
+	cnt = json_object_array_length(jsubscriptions);
+
+	for (i = 0; i < cnt; ++i) {
+		int key_idx;
+		json_object *jvalue;
+
+		jvalue = json_object_array_get_idx(jsubscriptions, i);
+		if (!jvalue)
+			return true;
+
+		key_idx = json_object_get_int(jvalue);
+		if (!CHECK_KEY_IDX_RANGE(key_idx))
+			return false;
+
+		if (!node_add_subscription(node, ele_idx, model_id, key_idx))
+			return false;
+	}
+
+	return true;
+}
+
 static bool parse_configuration_models(struct mesh_node *node, int ele_idx,
 		json_object *jmodels, uint32_t target_id, json_object **jtarget)
 {
@@ -411,9 +439,15 @@ static bool parse_configuration_models(struct mesh_node *node, int ele_idx,
 		}
 
 		json_object_object_get_ex(jmodel, "bind", &jarray);
+
 		if (jarray && !parse_bindings(node, ele_idx, model_id, jarray))
 			return false;
 
+		json_object_object_get_ex(jmodel, "subscription", &jarray);
+
+		if (jarray && !parse_subscriptions(node, ele_idx, model_id, jarray))
+			return false;
+
 		json_object_object_get_ex(jmodel, "publish", &jvalue);
 
 		if (jvalue && !parse_model_pub(node, ele_idx, model_id, jvalue))
@@ -1068,6 +1102,35 @@ bool prov_db_add_binding(struct mesh_node *node, uint8_t ele_idx,
 	return true;
 }
 
+bool prov_db_add_subscription(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t addr)
+{
+	json_object *jmain;
+	json_object *jmodel;
+	json_object *jsubscriptions = NULL;
+	bool local = (node == node_get_local_node());
+
+	jmodel = get_jmodel_obj(node, ele_idx, model_id, &jmain);
+
+	if (!jmodel)
+		return false;
+
+	json_object_object_get_ex(jmodel, "subscription", &jsubscriptions);
+
+	if (!jsubscriptions) {
+		jsubscriptions = json_object_new_array();
+		json_object_object_add(jmodel, "subscription", jsubscriptions);
+	}
+
+	put_uint16_array_entry(jsubscriptions, addr);
+
+	prov_file_write(jmain, local);
+
+	json_object_put(jmain);
+
+	return true;
+}
+
 bool prov_db_node_set_model_pub(struct mesh_node *node, uint8_t ele_idx,
 							uint32_t model_id,
 						struct mesh_publication *pub)
@@ -1139,6 +1202,9 @@ bool prov_db_add_new_node(struct mesh_node *node)
 	/* Device key */
 	add_key(jnode, "deviceKey", node_get_device_key(node));
 
+	/* Device key */
+	add_key(jnode, "deviceUUID", node_get_device_uuid(node));
+
 	/* Net key */
 	jconfig = json_object_new_object();
 	add_node_idxs(jconfig, "netKeys", node_get_net_keys(node));
diff --git a/mesh/prov-db.h b/mesh/prov-db.h
index b1e4c629c..a49b45cbd 100644
--- a/mesh/prov-db.h
+++ b/mesh/prov-db.h
@@ -30,6 +30,8 @@ bool prov_db_add_node_composition(struct mesh_node *node, uint8_t *data,
 bool prov_db_node_keys(struct mesh_node *node, GList *idxs, const char *desc);
 bool prov_db_add_binding(struct mesh_node *node, uint8_t ele_idx,
 			uint32_t model_id, uint16_t app_idx);
+bool prov_db_add_subscription(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t addr);
 bool prov_db_node_set_ttl(struct mesh_node *node, uint8_t ttl);
 bool prov_db_node_set_iv_seq(struct mesh_node *node, uint32_t iv, uint32_t seq);
 bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov);
-- 
2.11.0

