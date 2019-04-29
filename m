Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F430C004C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53488215EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfD2TpP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:45:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:27052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbfD2TpO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 15:45:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 12:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="144648069"
Received: from ingas-nuc1.sea.intel.com ([10.252.200.123])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2019 12:45:13 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] mesh: Unify processing of GetManagedObjects result
Date:   Mon, 29 Apr 2019 12:45:09 -0700
Message-Id: <20190429194509.3378-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429194509.3378-1-inga.stotland@intel.com>
References: <20190429194509.3378-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This combines processing of results obtained from GetManagedObjects
request for both Attach() and Join() methods
---
 mesh/mesh-defs.h |   2 +
 mesh/node.c      | 362 +++++++++++++++++++++++------------------------
 2 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index c30041e4a..131b3502c 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -75,6 +75,8 @@
 #define VENDOR_ID_MASK		0xffff0000
 
 #define MAX_KEY_IDX		0x0fff
+#define MAX_MODEL_COUNT		0xff
+#define MAX_ELE_COUNT		0xff
 
 #define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
 #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
diff --git a/mesh/node.c b/mesh/node.c
index 0c2fc7262..774d03d45 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -54,6 +54,9 @@
 #define DEFAULT_CRPL 10
 #define DEFAULT_SEQUENCE_NUMBER 0
 
+#define REQUEST_TYPE_JOIN 0
+#define REQUEST_TYPE_ATTACH 1
+
 struct node_element {
 	char *path;
 	struct l_queue *models;
@@ -100,15 +103,11 @@ struct mesh_node {
 	uint8_t beacon;
 };
 
-struct attach_obj_request {
-	node_ready_func_t cb;
-	struct mesh_node *node;
+struct managed_obj_request {
+	void *data;
+	void *cb;
 	void *user_data;
-};
-
-struct join_obj_request {
-	node_join_ready_func_t cb;
-	const uint8_t *uuid;
+	uint8_t type;
 };
 
 static struct l_queue *nodes;
@@ -1003,6 +1002,7 @@ void node_attach_io(struct mesh_io *io)
 	l_queue_foreach(nodes, attach_io, io);
 }
 
+/* Register node object with D-Bus */
 static bool register_node_object(struct mesh_node *node)
 {
 	node->path = l_malloc(strlen(MESH_NODE_PATH_PREFIX) + 5);
@@ -1078,7 +1078,6 @@ static bool validate_model_property(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
 								&mod_id)) {
 			struct mesh_model *mod;
-
 			mod = l_queue_find(ele->models, match_model_id,
 				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
 			if (!mod)
@@ -1132,7 +1131,7 @@ static void get_models_from_properties(struct node_element *ele,
 
 static bool get_element_properties(struct mesh_node *node, const char *path,
 					struct l_dbus_message_iter *properties,
-								bool create_new)
+								bool is_new)
 {
 	struct node_element *ele;
 	const char *key;
@@ -1156,7 +1155,7 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 		return false;
 	}
 
-	if (!create_new) {
+	if (!is_new) {
 		/* Validate composition: check the element index */
 		ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(idx));
@@ -1180,14 +1179,14 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 			l_dbus_message_iter_get_variant(&var, "q", &loc);
 
 			/* Validate composition: location match */
-			if (!create_new && (ele->location != loc))
+			if (!is_new && (ele->location != loc))
 				return false;
 
 			ele->location = loc;
 
 		} else if (!strcmp(key, "Models")) {
 
-			if (create_new)
+			if (is_new)
 				get_models_from_properties(ele, &var, false);
 			else if (!validate_model_property(ele, &var, &mod_cnt,
 									false))
@@ -1195,15 +1194,16 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 
 		} else if (!strcmp(key, "VendorModels")) {
 
-			if (create_new)
+			if (is_new)
 				get_models_from_properties(ele, &var, true);
 			else if (!validate_model_property(ele, &var,
 							&vendor_cnt, true))
 				return false;
+
 		}
 	}
 
-	if (create_new) {
+	if (is_new) {
 		l_queue_push_tail(node->elements, ele);
 	} else {
 		/* Account for internal Configuration Server model */
@@ -1220,139 +1220,6 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
-static void get_managed_objects_attach_cb(struct l_dbus_message *msg,
-								void *user_data)
-{
-	struct l_dbus_message_iter objects, interfaces;
-	struct attach_obj_request *req = user_data;
-	struct mesh_node *node = req->node;
-	const char *path;
-	uint8_t num_ele;
-
-	if (l_dbus_message_is_error(msg)) {
-		l_error("Failed to get app's dbus objects");
-		goto fail;
-	}
-
-	if (!l_dbus_message_get_arguments(msg, "a{oa{sa{sv}}}", &objects)) {
-		l_error("Failed to parse app's dbus objects");
-		goto fail;
-	}
-
-	num_ele = 0;
-
-	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
-		struct l_dbus_message_iter properties;
-		const char *interface;
-
-		while (l_dbus_message_iter_next_entry(&interfaces, &interface,
-								&properties)) {
-			if (strcmp(MESH_ELEMENT_INTERFACE, interface))
-				continue;
-
-			if (!get_element_properties(node, path, &properties,
-									false))
-				goto fail;
-
-			num_ele++;
-		}
-	}
-
-	/*
-	 * Check that the number of element objects matches the expected number
-	 * of elements on the node
-	 */
-	if (num_ele != node->num_ele)
-		goto fail;
-
-	/* Register node object with D-Bus */
-	register_node_object(node);
-
-	if (node->path) {
-		struct l_dbus *bus = dbus_get_bus();
-
-		node->disc_watch = l_dbus_add_disconnect_watch(bus, node->owner,
-						app_disc_cb, node, NULL);
-		req->cb(req->user_data, MESH_ERROR_NONE, node);
-
-		return;
-	}
-fail:
-	req->cb(req->user_data, MESH_ERROR_FAILED, NULL);
-
-	l_queue_foreach(node->elements, free_element_path, NULL);
-	l_free(node->app_path);
-	node->app_path = NULL;
-
-	l_free(node->owner);
-	node->owner = NULL;
-}
-
-/* Establish relationship between application and mesh node */
-int node_attach(const char *app_path, const char *sender, uint64_t token,
-				node_ready_func_t cb, void *user_data)
-{
-	struct attach_obj_request *req;
-	struct mesh_node *node;
-
-	node = l_queue_find(nodes, match_token, (void *) &token);
-	if (!node)
-		return MESH_ERROR_NOT_FOUND;
-
-	/* Check if the node is already in use */
-	if (node->owner) {
-		l_warn("The node is already in use");
-		return MESH_ERROR_ALREADY_EXISTS;
-	}
-
-	node->app_path = l_strdup(app_path);
-	node->owner = l_strdup(sender);
-
-	req = l_new(struct attach_obj_request, 1);
-	req->node = node;
-	req->cb = cb;
-	req->user_data = user_data;
-
-	l_dbus_method_call(dbus_get_bus(), sender, app_path,
-					L_DBUS_INTERFACE_OBJECT_MANAGER,
-					"GetManagedObjects", NULL,
-					get_managed_objects_attach_cb,
-					req, l_free);
-	return MESH_ERROR_NONE;
-
-}
-
-static bool get_app_properties(struct mesh_node *node, const char *path,
-					struct l_dbus_message_iter *properties)
-{
-	const char *key;
-	struct l_dbus_message_iter variant;
-
-	l_debug("path %s", path);
-
-	if (!node->comp)
-		node->comp = l_new(struct node_composition, 1);
-
-	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
-
-		if (!strcmp(key, "CompanyID")) {
-			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->cid))
-				return false;
-		} else if (!strcmp(key, "ProductID")) {
-			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->pid))
-				return false;
-		} else if (!strcmp(key, "VersionID")) {
-			if (!l_dbus_message_iter_get_variant(&variant, "q",
-							&node->comp->vid))
-				return false;
-		}
-	}
-
-	return true;
-}
-
 static void convert_node_to_storage(struct mesh_node *node,
 						struct mesh_db_node *db_node)
 {
@@ -1451,14 +1318,66 @@ static void set_defaults(struct mesh_node *node)
 	add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
 }
 
-static void get_managed_objects_join_cb(struct l_dbus_message *msg,
-								void *user_data)
+static bool get_app_properties(struct mesh_node *node, const char *path,
+					struct l_dbus_message_iter *properties,
+								bool is_new)
+{
+	const char *key;
+	struct l_dbus_message_iter variant;
+	uint16_t value;
+
+	l_debug("path %s", path);
+
+	if (is_new)
+		node->comp = l_new(struct node_composition, 1);
+
+	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
+
+		if (!strcmp(key, "CompanyID")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "q",
+									&value))
+				return false;
+
+			if (!is_new && node->comp->cid != value)
+				return false;
+
+			node->comp->cid = value;
+
+		} else if (!strcmp(key, "ProductID")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "q",
+									&value))
+				return false;
+
+			if (!is_new && node->comp->pid != value)
+				return false;
+
+			node->comp->pid = value;
+
+		} else if (!strcmp(key, "VersionID")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "q",
+									&value))
+				return false;
+
+			if (!is_new && node->comp->vid != value)
+				return false;
+
+			node->comp->vid = value;
+		}
+	}
+
+	return true;
+}
+
+static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 {
 	struct l_dbus_message_iter objects, interfaces;
-	struct join_obj_request *req = user_data;
+	struct managed_obj_request *req = user_data;
 	const char *path;
 	struct mesh_node *node = NULL;
 	void *agent = NULL;
+	bool have_app = false;
+	bool is_new;
+	uint8_t num_ele;
 
 	if (l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
@@ -1470,8 +1389,16 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 		goto fail;
 	}
 
-	node = l_new(struct mesh_node, 1);
-	node->elements = l_queue_new();
+	is_new = (req->type != REQUEST_TYPE_ATTACH);
+
+	if (is_new) {
+		node = l_new(struct mesh_node, 1);
+		node->elements = l_queue_new();
+	} else {
+		node = req->data;
+	}
+
+	num_ele = 0;
 
 	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
 		struct l_dbus_message_iter properties;
@@ -1482,26 +1409,27 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 			bool res;
 
 			if (!strcmp(MESH_ELEMENT_INTERFACE, interface)) {
+
+				if (num_ele == MAX_ELE_COUNT)
+					goto fail;
+
 				res = get_element_properties(node, path,
-							&properties, true);
+							&properties, is_new);
 				if (!res)
 					goto fail;
 
-				node->num_ele++;
-				continue;
-
-			}
+				num_ele++;
 
-			if (!strcmp(MESH_APPLICATION_INTERFACE, interface)) {
+			} else if (!strcmp(MESH_APPLICATION_INTERFACE,
+								interface)) {
 				res = get_app_properties(node, path,
-								&properties);
+							&properties, is_new);
 				if (!res)
 					goto fail;
 
-				continue;
-			}
+				have_app = true;
 
-			if (!strcmp(MESH_PROVISION_AGENT_INTERFACE,
+			} else if (!strcmp(MESH_PROVISION_AGENT_INTERFACE,
 								interface)) {
 				const char *sender;
 
@@ -1514,18 +1442,12 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 		}
 	}
 
-	if (!node->comp){
+	if (!have_app) {
 		l_error("Interface %s not found", MESH_APPLICATION_INTERFACE);
 		goto fail;
 	}
 
-	if (!agent) {
-		l_error("Interface %s not found",
-						MESH_PROVISION_AGENT_INTERFACE);
-		goto fail;
-	}
-
-	if (!node->num_ele) {
+	if (num_ele == 0) {
 		l_error("Interface %s not found", MESH_ELEMENT_INTERFACE);
 		goto fail;
 	}
@@ -1537,41 +1459,117 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 		goto fail;
 	}
 
-	set_defaults(node);
-	memcpy(node->dev_uuid, req->uuid, 16);
+	if (req->type == REQUEST_TYPE_JOIN) {
+		node_join_ready_func_t cb = req->cb;
 
-	if (!create_node_config(node))
-		goto fail;
+		if (!agent) {
+			l_error("Interface %s not found",
+						MESH_PROVISION_AGENT_INTERFACE);
+			goto fail;
+		}
+		node->num_ele = num_ele;
+		set_defaults(node);
+		memcpy(node->dev_uuid, req->data, 16);
+
+		if (!create_node_config(node))
+			goto fail;
+
+		cb(node, agent);
+	} else {
+		node_ready_func_t cb = req->cb;
+
+		if (num_ele != node->num_ele)
+			goto fail;
+
+		if (register_node_object(node)) {
+			struct l_dbus *bus = dbus_get_bus();
 
-	req->cb(node, agent);
+			node->disc_watch = l_dbus_add_disconnect_watch(bus,
+					node->owner, app_disc_cb, node, NULL);
+			cb(req->user_data, MESH_ERROR_NONE, node);
+		} else
+			goto fail;
+	}
 
 	return;
 fail:
 	if (agent)
 		mesh_agent_remove(agent);
 
-	if (node)
+	if (is_new && node)
 		free_node_resources(node);
 
-	req->cb(NULL, NULL);
+	if (req->type == REQUEST_TYPE_JOIN) {
+		node_join_ready_func_t cb = req->cb;
+
+		cb(NULL, NULL);
+
+	} else {
+		node_ready_func_t cb = req->cb;
+
+		l_queue_foreach(node->elements, free_element_path, NULL);
+		l_free(node->app_path);
+		node->app_path = NULL;
+
+		l_free(node->owner);
+		node->owner = NULL;
+		cb(req->user_data, MESH_ERROR_FAILED, node);
+	}
+}
+
+/* Establish relationship between application and mesh node */
+int node_attach(const char *app_path, const char *sender, uint64_t token,
+					node_ready_func_t cb, void *user_data)
+{
+	struct managed_obj_request *req;
+	struct mesh_node *node;
+
+	node = l_queue_find(nodes, match_token, (void *) &token);
+	if (!node)
+		return MESH_ERROR_NOT_FOUND;
+
+	/* Check if the node is already in use */
+	if (node->owner) {
+		l_warn("The node is already in use");
+		return MESH_ERROR_ALREADY_EXISTS;
+	}
+
+	node->app_path = l_strdup(app_path);
+	node->owner = l_strdup(sender);
+
+	req = l_new(struct managed_obj_request, 1);
+	req->data = node;
+	req->cb = cb;
+	req->user_data = user_data;
+	req->type = REQUEST_TYPE_ATTACH;
+
+	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+					L_DBUS_INTERFACE_OBJECT_MANAGER,
+					"GetManagedObjects", NULL,
+					get_managed_objects_cb,
+					req, l_free);
+	return MESH_ERROR_NONE;
+
 }
 
+
 /* Create a temporary pre-provisioned node */
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb)
 {
-	struct join_obj_request *req;
+	struct managed_obj_request *req;
 
 	l_debug("");
 
-	req = l_new(struct join_obj_request, 1);
-	req->uuid = uuid;
+	req = l_new(struct managed_obj_request, 1);
+	req->data = (void *) uuid;
 	req->cb = cb;
+	req->type = REQUEST_TYPE_JOIN;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
 					"GetManagedObjects", NULL,
-					get_managed_objects_join_cb,
+					get_managed_objects_cb,
 					req, l_free);
 }
 
-- 
2.17.2

