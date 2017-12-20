Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH] mesh: Add subscriptions to node structure and json database
Date: Wed, 20 Dec 2017 08:10:08 -0500
Message-Id: <20171220131008.10640-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

sub-add 0101 c000 1000

              {
                "modelId":"1000",
                "bind":[
                  1
                ],
                "subscribe":[
                  "c000"
                ]
              },
---
 mesh/config-client.c | 27 +++++++++++++++++-----
 mesh/node.c          | 22 ++++++++++++++++++
 mesh/node.h          |  2 ++
 mesh/prov-db.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/prov-db.h       |  2 ++
 5 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index f280441cc..2f8071bd7 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -256,13 +256,28 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
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
+		/* Save subscriptions in node and database */
+		node_add_subscription(node, ele_idx, mod_id, addr);
+		prov_db_add_subscription(node, ele_idx, mod_id, addr);
+		break;
 
 	/* Per Mesh Profile 4.3.2.27 */
 	case OP_CONFIG_MODEL_SUB_LIST:
diff --git a/mesh/node.c b/mesh/node.c
index b682a35f7..e7ec45699 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -776,6 +776,28 @@ bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
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
+					     GUINT_TO_POINTER(addr));
+
+	return true;
+}
+
 uint8_t node_get_default_ttl(struct mesh_node *node)
 {
 	if (!node)
diff --git a/mesh/node.h b/mesh/node.h
index 1fab80a13..b59ff00c2 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -111,6 +111,8 @@ bool node_set_composition(struct mesh_node *node,
 				struct mesh_node_composition *comp);
 bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
 			uint32_t model_id, uint16_t app_idx);
+bool node_add_subscription(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t addr);
 uint8_t node_get_default_ttl(struct mesh_node *node);
 bool node_set_default_ttl(struct mesh_node *node, uint8_t ttl);
 bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index 8a7b47f6e..1cf94e573 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -409,6 +409,34 @@ static json_object* find_configured_model(struct mesh_node *node, int ele_idx,
 	return NULL;
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
 							json_object *jmodels)
 {
@@ -441,9 +469,15 @@ static bool parse_configuration_models(struct mesh_node *node, int ele_idx,
 			model_id += 0xffff0000;
 
 		json_object_object_get_ex(jmodel, "bind", &jarray);
+
 		if (jarray && !parse_bindings(node, ele_idx, model_id, jarray))
 			return false;
 
+		json_object_object_get_ex(jmodel, "subscribe", &jarray);
+
+		if (jarray && !parse_subscriptions(node, ele_idx, model_id, jarray))
+			return false;
+
 		json_object_object_get_ex(jmodel, "publish", &jvalue);
 
 		if (jvalue && !parse_model_pub(node, ele_idx, model_id, jvalue))
@@ -1098,6 +1132,35 @@ bool prov_db_add_binding(struct mesh_node *node, uint8_t ele_idx,
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
+	json_object_object_get_ex(jmodel, "subscribe", &jsubscriptions);
+
+	if (!jsubscriptions) {
+		jsubscriptions = json_object_new_array();
+		json_object_object_add(jmodel, "subscribe", jsubscriptions);
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
2.14.1

