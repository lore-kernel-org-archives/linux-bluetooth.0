Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CDC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5F2173B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEHVuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 17:50:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:39553 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfEHVuM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 17:50:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 14:50:11 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.251.29.44])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2019 14:50:11 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1 v2] mesh: Add CreateNetwork method() implementation
Date:   Wed,  8 May 2019 14:50:08 -0700
Message-Id: <20190508215008.32403-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190508215008.32403-1-inga.stotland@intel.com>
References: <20190508215008.32403-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements CreateNetwork() method on org.bluez.mesh.Network1
interface. Invoking this method generates a self-provisioned
local node associated with a brand new mesh network. This new
network is bare bones: only one network key is defined. The new node
assumes the role of mesh network manager and will be able to use
soon to be implemented methods of org.bluez.mesh.Management1 interface
to provision remote nodes into its network and to add/update/remove
network and application keys.
---
 mesh/mesh.c |  70 ++++++++++++++++-
 mesh/node.c | 218 ++++++++++++++++++++++++++++++++++------------------
 mesh/node.h |   8 +-
 3 files changed, 218 insertions(+), 78 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 4d65f266a..5e0bbb009 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -112,7 +112,7 @@ static void start_io(uint16_t index)
 
 	l_debug("Started mesh (io %p) on hci %u", mesh.io, index);
 
-	node_attach_io(io);
+	node_attach_io_all(io);
 }
 
 /* Used for any outbound traffic that doesn't have Friendship Constraints */
@@ -491,7 +491,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 	path = join_pending->app_path;
 
 	if (status == PROV_ERR_SUCCESS &&
-	    !node_add_pending_local(join_pending->node, info, mesh.io))
+	    !node_add_pending_local(join_pending->node, info))
 		status = PROV_ERR_UNEXPECTED_ERR;
 
 	if (status != PROV_ERR_SUCCESS) {
@@ -499,6 +499,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 		return false;
 	}
 
+	node_attach_io(join_pending->node, mesh.io);
 	token = node_get_token(join_pending->node);
 
 	msg = l_dbus_message_new_method_call(dbus, owner, path,
@@ -701,6 +702,69 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static void create_network_ready_cb(void *user_data, int status,
+							struct mesh_node *node)
+{
+	struct l_dbus_message *reply;
+	struct l_dbus_message *pending_msg;
+	const uint8_t *token;
+
+	pending_msg = l_queue_find(pending_queue, simple_match, user_data);
+	if (!pending_msg)
+		return;
+
+	if (status != MESH_ERROR_NONE) {
+		reply = dbus_error(pending_msg, status, NULL);
+		goto done;
+	}
+
+	node_attach_io(node, mesh.io);
+
+	reply = l_dbus_message_new_method_return(pending_msg);
+	token = node_get_token(node);
+
+	l_debug();
+	l_dbus_message_set_arguments(reply, "t", l_get_be64(token));
+
+done:
+	l_dbus_send(dbus_get_bus(), reply);
+	l_queue_remove(pending_queue, pending_msg);
+}
+
+static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *app_path, *sender;
+	struct l_dbus_message_iter iter_uuid;
+	struct l_dbus_message *pending_msg;
+	uint8_t *uuid;
+	uint32_t n;
+
+	l_debug("Create network request");
+
+	if (!l_dbus_message_get_arguments(msg, "oay", &app_path,
+								&iter_uuid))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
+								|| n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device UUID");
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	node_create(app_path, sender, uuid, create_network_ready_cb,
+								pending_msg);
+
+	return NULL;
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -714,6 +778,8 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
+	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
+					"t", "oay", "token", "app", "uuid");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
diff --git a/mesh/node.c b/mesh/node.c
index 5904b116c..8b8642fea 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -49,6 +49,11 @@
 #define MESH_NODE_PATH_PREFIX "/node"
 #define MESH_ELEMENT_PATH_PREFIX "/ele"
 
+/* Default values for a new locally created node */
+#define DEFAULT_NEW_UNICAST 0x0001
+#define DEFAULT_IV_INDEX 0x0000
+#define DEFAULT_PRIMARY_NET_INDEX 0x0000
+
 /* Default element location: unknown */
 #define DEFAULT_LOCATION 0x0000
 
@@ -57,6 +62,7 @@
 
 #define REQUEST_TYPE_JOIN 0
 #define REQUEST_TYPE_ATTACH 1
+#define REQUEST_TYPE_CREATE 2
 
 struct node_element {
 	char *path;
@@ -378,6 +384,7 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 		return false;
 
 	node->num_ele = num_ele;
+
 	if (num_ele != 0 && !add_elements(node, db_node))
 		return false;
 
@@ -981,8 +988,14 @@ static void attach_io(void *a, void *b)
 		mesh_net_attach(node->net, io);
 }
 
-/* Register callbacks for io */
-void node_attach_io(struct mesh_io *io)
+/* Register callback for the node's io */
+void node_attach_io(struct mesh_node *node, struct mesh_io *io)
+{
+	attach_io(node, io);
+}
+
+/* Register callbacks for all nodes io */
+void node_attach_io_all(struct mesh_io *io)
 {
 	l_queue_foreach(nodes, attach_io, io);
 }
@@ -1354,6 +1367,60 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	return true;
 }
 
+static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
+				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
+				uint16_t net_key_idx, uint8_t net_key[16])
+{
+	node->net = mesh_net_new(node);
+
+	if (!nodes)
+		nodes = l_queue_new();
+
+	l_queue_push_tail(nodes, node);
+
+	if (!storage_set_iv_index(node->net, iv_idx, ivu))
+		return false;
+
+	mesh_net_set_iv_index(node->net, iv_idx, ivu);
+
+	if (!mesh_db_write_uint16_hex(node->jconfig, "unicastAddress",
+								unicast))
+		return false;
+
+	l_getrandom(node->token, sizeof(node->token));
+	if (!mesh_db_write_token(node->jconfig, node->token))
+		return false;
+
+	memcpy(node->dev_key, dev_key, 16);
+	if (!mesh_db_write_device_key(node->jconfig, dev_key))
+		return false;
+
+	node->primary = unicast;
+	mesh_net_register_unicast(node->net, unicast, node->num_ele);
+
+	if (mesh_net_add_key(node->net, net_key_idx, net_key) !=
+							MESH_STATUS_SUCCESS)
+		return false;
+
+	if (kr) {
+		/* Duplicate net key, if the key refresh is on */
+		if (mesh_net_update_key(node->net, net_key_idx, net_key) !=
+							MESH_STATUS_SUCCESS)
+			return false;
+
+		if (!mesh_db_net_key_set_phase(node->jconfig, net_key_idx,
+							KEY_REFRESH_PHASE_TWO))
+			return false;
+	}
+
+	storage_save_config(node, true, NULL, NULL);
+
+	/* Initialize configuration server model */
+	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
+
+	return true;
+}
+
 static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 {
 	struct l_dbus_message_iter objects, interfaces;
@@ -1365,6 +1432,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	bool is_new;
 	uint8_t num_ele;
 
+	is_new = (req->type != REQUEST_TYPE_ATTACH);
+
 	if (l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
 		goto fail;
@@ -1375,8 +1444,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	is_new = (req->type != REQUEST_TYPE_ATTACH);
-
 	if (is_new) {
 		node = l_new(struct mesh_node, 1);
 		node->elements = l_queue_new();
@@ -1445,7 +1512,22 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
-	if (req->type == REQUEST_TYPE_JOIN) {
+	if (req->type == REQUEST_TYPE_ATTACH) {
+		node_ready_func_t cb = req->cb;
+
+		if (num_ele != node->num_ele)
+			goto fail;
+
+		if (register_node_object(node)) {
+			struct l_dbus *bus = dbus_get_bus();
+
+			node->disc_watch = l_dbus_add_disconnect_watch(bus,
+					node->owner, app_disc_cb, node, NULL);
+			cb(req->user_data, MESH_ERROR_NONE, node);
+		} else
+			goto fail;
+
+	} else if (req->type == REQUEST_TYPE_JOIN) {
 		node_join_ready_func_t cb = req->cb;
 
 		if (!agent) {
@@ -1453,6 +1535,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 						MESH_PROVISION_AGENT_INTERFACE);
 			goto fail;
 		}
+
 		node->num_ele = num_ele;
 		set_defaults(node);
 		memcpy(node->uuid, req->data, 16);
@@ -1461,20 +1544,30 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 			goto fail;
 
 		cb(node, agent);
+
 	} else {
+		/* Callback for create node request */
 		node_ready_func_t cb = req->cb;
+		uint8_t dev_key[16];
+		uint8_t net_key[16];
 
-		if (num_ele != node->num_ele)
+		node->num_ele = num_ele;
+		set_defaults(node);
+		memcpy(node->uuid, req->data, 16);
+
+		if (!create_node_config(node))
 			goto fail;
 
-		if (register_node_object(node)) {
-			struct l_dbus *bus = dbus_get_bus();
+		/* Generate device and primary network keys */
+		l_getrandom(dev_key, sizeof(dev_key));
+		l_getrandom(net_key, sizeof(net_key));
 
-			node->disc_watch = l_dbus_add_disconnect_watch(bus,
-					node->owner, app_disc_cb, node, NULL);
-			cb(req->user_data, MESH_ERROR_NONE, node);
-		} else
+		if (!add_local_node(node, DEFAULT_NEW_UNICAST, false, false,
+					DEFAULT_IV_INDEX, dev_key,
+					DEFAULT_PRIMARY_NET_INDEX, net_key))
 			goto fail;
+
+		cb(req->user_data, MESH_ERROR_NONE, node);
 	}
 
 	return;
@@ -1482,15 +1575,8 @@ fail:
 	if (agent)
 		mesh_agent_remove(agent);
 
-	if (is_new && node)
-		free_node_resources(node);
-
-	if (req->type == REQUEST_TYPE_JOIN) {
-		node_join_ready_func_t cb = req->cb;
-
-		cb(NULL, NULL);
-
-	} else {
+	if (!is_new) {
+		/* Handle failed Attach request */
 		node_ready_func_t cb = req->cb;
 
 		l_queue_foreach(node->elements, free_element_path, NULL);
@@ -1500,6 +1586,21 @@ fail:
 		l_free(node->owner);
 		node->owner = NULL;
 		cb(req->user_data, MESH_ERROR_FAILED, node);
+
+	} else {
+		/* Handle failed Join and Create requests */
+		if (node)
+			free_node_resources(node);
+
+		if (req->type == REQUEST_TYPE_JOIN) {
+			node_join_ready_func_t cb = req->cb;
+
+			cb(NULL, NULL);
+		} else {
+			node_ready_func_t cb = req->cb;
+
+			cb(req->user_data, MESH_ERROR_FAILED, NULL);
+		}
 	}
 }
 
@@ -1559,6 +1660,26 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
+					node_ready_func_t cb, void *user_data)
+{
+	struct managed_obj_request *req;
+
+	l_debug("");
+
+	req = l_new(struct managed_obj_request, 1);
+	req->data = (void *) uuid;
+	req->cb = cb;
+	req->user_data = user_data;
+	req->type = REQUEST_TYPE_CREATE;
+
+	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+					L_DBUS_INTERFACE_OBJECT_MANAGER,
+					"GetManagedObjects", NULL,
+					get_managed_objects_cb,
+					req, l_free);
+}
+
 static void build_element_config(void *a, void *b)
 {
 	struct node_element *ele = a;
@@ -1790,63 +1911,14 @@ const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx)
 	return ele->path;
 }
 
-bool node_add_pending_local(struct mesh_node *node, void *prov_node_info,
-							struct mesh_io *io)
+bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
 {
 	struct mesh_prov_node_info *info = prov_node_info;
 	bool kr = !!(info->flags & PROV_FLAG_KR);
 	bool ivu = !!(info->flags & PROV_FLAG_IVU);
 
-	node->net = mesh_net_new(node);
-
-	if (!nodes)
-		nodes = l_queue_new();
-
-	l_queue_push_tail(nodes, node);
-
-	if (!storage_set_iv_index(node->net, info->iv_index, ivu))
-		return false;
-
-	mesh_net_set_iv_index(node->net, info->iv_index, ivu);
-
-	if (!mesh_db_write_uint16_hex(node->jconfig, "unicastAddress",
-								info->unicast))
-		return false;
-
-	node->primary = info->unicast;
-	mesh_net_register_unicast(node->net, info->unicast, node->num_ele);
-
-	l_getrandom(node->token, sizeof(node->token));
-	if (!mesh_db_write_token(node->jconfig, node->token))
-		return false;
-
-	memcpy(node->dev_key, info->device_key, 16);
-	if (!mesh_db_write_device_key(node->jconfig, info->device_key))
-		return false;
-
-	if (mesh_net_add_key(node->net, info->net_index, info->net_key) !=
-							MESH_STATUS_SUCCESS)
-		return false;
-
-	if (kr) {
-		/* Duplicate net key, if the key refresh is on */
-		if (mesh_net_update_key(node->net, info->net_index,
-				info->net_key) != MESH_STATUS_SUCCESS)
-			return false;
-
-		if (!mesh_db_net_key_set_phase(node->jconfig, info->net_index,
-							KEY_REFRESH_PHASE_TWO))
-			return false;
-	}
-
-	storage_save_config(node, true, NULL, NULL);
-
-	/* Initialize configuration server model */
-	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
-
-	mesh_net_attach(node->net, io);
-
-	return true;
+	return add_local_node(node, info->unicast, kr, ivu, info->iv_index,
+			info->device_key, info->net_index, info->net_key);
 }
 
 void node_jconfig_set(struct mesh_node *node, void *jconfig)
diff --git a/mesh/node.h b/mesh/node.h
index 1be4de1da..74ac5981a 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -82,13 +82,15 @@ uint8_t node_friend_mode_get(struct mesh_node *node);
 uint32_t node_seq_cache(struct mesh_node *node);
 const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx);
 const char *node_get_owner(struct mesh_node *node);
-bool node_add_pending_local(struct mesh_node *node, void *info,
-							struct mesh_io *io);
-void node_attach_io(struct mesh_io *io);
+bool node_add_pending_local(struct mesh_node *node, void *info);
+void node_attach_io_all(struct mesh_io *io);
+void node_attach_io(struct mesh_node *node, struct mesh_io *io);
 int node_attach(const char *app_path, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
+void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
+					node_ready_func_t cb, void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.17.2

