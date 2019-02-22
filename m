Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4EFC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A00D20818
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfBVGcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:32:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:9954 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfBVGcX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 01:32:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 22:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="301674848"
Received: from ingas-nuc1.sea.intel.com ([10.251.136.115])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2019 22:32:21 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/3 v2] mesh: Re-arrange node cleanup functions
Date:   Thu, 21 Feb 2019 22:31:46 -0800
Message-Id: <20190222063148.4995-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190222063148.4995-1-inga.stotland@intel.com>
References: <20190222063148.4995-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename node_free() to node_remove() and consolidate clean up operations.
Change declarations for internally used functions to static.
---
 mesh/mesh.c    | 14 ++++++--------
 mesh/node.c    | 36 ++++++++++++++++++++++++++----------
 mesh/node.h    |  4 ++--
 mesh/storage.c | 12 ++++++------
 4 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index c610582c0..0f3c3c9fd 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -362,10 +362,8 @@ static void free_pending_join_call(bool failed)
 
 	mesh_agent_remove(join_pending->agent);
 
-	if (failed) {
-		storage_remove_node_config(join_pending->node);
-		node_free(join_pending->node);
-	}
+	if (failed)
+		node_remove(join_pending->node);
 
 	l_free(join_pending);
 	join_pending = NULL;
@@ -703,13 +701,13 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
-				"oay", "app", "uuid");
+							"oay", "app", "uuid");
 
 	l_dbus_interface_method(iface, "Cancel", 0, cancel_join_call, "", "");
 
 	l_dbus_interface_method(iface, "Attach", 0, attach_call,
-				"oa(ya(qa{sv}))", "ot", "node", "configuration",
-				"app", "token");
+					"oa(ya(qa{sv}))", "ot", "node",
+					"configuration", "app", "token");
 
 	/* TODO: Implement Leave method */
 }
@@ -720,7 +718,7 @@ bool mesh_dbus_init(struct l_dbus *dbus)
 						setup_network_interface,
 						NULL, false)) {
 		l_info("Unable to register %s interface",
-			       MESH_NETWORK_INTERFACE);
+							MESH_NETWORK_INTERFACE);
 		return false;
 	}
 
diff --git a/mesh/node.c b/mesh/node.c
index c815acf2e..6c5cd9c39 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -133,6 +133,7 @@ static bool match_token(const void *a, const void *b)
 	const struct mesh_node *node = a;
 	const uint64_t *token = b;
 	const uint64_t tmp = l_get_u64(node->dev_key);
+
 	return *token == tmp;
 }
 
@@ -168,6 +169,11 @@ struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
 	return l_queue_find(nodes, match_device_uuid, uuid);
 }
 
+struct mesh_node *node_find_by_token(uint64_t token)
+{
+	return l_queue_find(nodes, match_token, (void *) &token);
+}
+
 uint8_t *node_uuid_get(struct mesh_node *node)
 {
 	if (!node)
@@ -212,7 +218,7 @@ static void free_node_resources(void *data)
 	struct mesh_node *node = data;
 
 	/* Unregister io callbacks */
-	if(node->net)
+	if (node->net)
 		mesh_net_detach(node->net);
 	mesh_net_free(node->net);
 
@@ -221,6 +227,9 @@ static void free_node_resources(void *data)
 	l_free(node->app_path);
 	l_free(node->owner);
 
+	if (node->disc_watch)
+		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
+
 	if (node->path)
 		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
 					MESH_NODE_INTERFACE);
@@ -229,12 +238,20 @@ static void free_node_resources(void *data)
 	l_free(node);
 }
 
-void node_free(struct mesh_node *node)
+/*
+ * This function is called to free resources and remove the
+ * configuration files for the specified node.
+ */
+void node_remove(struct mesh_node *node)
 {
 	if (!node)
 		return;
 
 	l_queue_remove(nodes, node);
+
+	if (node->cfg_file)
+		storage_remove_node_config(node);
+
 	free_node_resources(node);
 }
 
@@ -364,7 +381,7 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 	return true;
 }
 
-void node_cleanup(void *data)
+static void cleanup_node(void *data)
 {
 	struct mesh_node *node = data;
 	struct mesh_net *net = node->net;
@@ -379,15 +396,16 @@ void node_cleanup(void *data)
 			l_info("Saved final config to %s", node->cfg_file);
 	}
 
-	if (node->disc_watch)
-		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
-
 	free_node_resources(node);
 }
 
+/*
+ * This function is called to free resources and write the current
+ * sequence numbers to the configuration file for each known node.
+ */
 void node_cleanup_all(void)
 {
-	l_queue_destroy(nodes, node_cleanup);
+	l_queue_destroy(nodes, cleanup_node);
 	l_dbus_unregister_interface(dbus_get_bus(), MESH_NODE_INTERFACE);
 }
 
@@ -1103,9 +1121,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	struct attach_obj_request *req;
 	struct mesh_node *node;
 
-	l_debug("");
-
-	node = l_queue_find(nodes, match_token, &token);
+	node = l_queue_find(nodes, match_token, (void *) &token);
 	if (!node)
 		return MESH_ERROR_NOT_FOUND;
 
diff --git a/mesh/node.h b/mesh/node.h
index ab09b14b0..ee1d4a600 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -34,13 +34,14 @@ typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
 struct mesh_node *node_new(void);
-void node_free(struct mesh_node *node);
+void node_remove(struct mesh_node *node);
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
 uint8_t *node_uuid_get(struct mesh_node *node);
 struct mesh_net *node_get_net(struct mesh_node *node);
 struct mesh_node *node_find_by_addr(uint16_t addr);
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
+struct mesh_node *node_find_by_token(uint64_t token);
 bool node_is_provisioned(struct mesh_node *node);
 bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
 				uint16_t net_idx, uint16_t idx);
@@ -87,7 +88,6 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 void node_build_attach_reply(struct l_dbus_message *reply, uint64_t token);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 bool node_dbus_init(struct l_dbus *bus);
-void node_cleanup(void *node);
 void node_cleanup_all(void);
 void node_jconfig_set(struct mesh_node *node, void *jconfig);
 void *node_jconfig_get(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 0b0582374..e79037375 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -71,7 +71,7 @@ static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 	uint8_t *uuid;
 
 	if (!node_init_from_storage(node, db_node)) {
-		node_free(node);
+		node_remove(node);
 		return false;
 	}
 
@@ -205,17 +205,17 @@ static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
 
 	node = node_new();
 
-	node_jconfig_set(node, jnode);
-	node_cfg_file_set(node, out_file);
-	node_id_set(node, node_id);
-
 	result = parse_node(node, jnode);
 
 	if (!result) {
 		json_object_put(jnode);
-		node_free(node);
+		node_remove(node);
 	}
 
+	node_jconfig_set(node, jnode);
+	node_cfg_file_set(node, out_file);
+	node_id_set(node, node_id);
+
 done:
 	close(fd);
 	if (str)
-- 
2.17.2

