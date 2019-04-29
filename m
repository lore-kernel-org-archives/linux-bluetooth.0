Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD5C43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ABF215EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfD2TpN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:45:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:27048 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2TpN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 15:45:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 12:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="144648063"
Received: from ingas-nuc1.sea.intel.com ([10.252.200.123])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2019 12:45:12 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Clean up processing of Attach() method
Date:   Mon, 29 Apr 2019 12:45:07 -0700
Message-Id: <20190429194509.3378-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429194509.3378-1-inga.stotland@intel.com>
References: <20190429194509.3378-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the prototype for the callback function of
Attach() method call: remove unused node_path argument and make the
callback more generalized and re-usable for other method calls.
---
 mesh/mesh.c | 69 ++++++++++++++++++++---------------------------------
 mesh/node.c | 19 +++++++--------
 mesh/node.h |  9 +++----
 3 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index e7eef0473..a084f9200 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -76,12 +76,6 @@ struct join_data{
 	uint8_t *uuid;
 };
 
-struct attach_data {
-	uint64_t token;
-	struct l_dbus_message *msg;
-	const char *app;
-};
-
 static struct bt_mesh mesh;
 static struct l_queue *controllers;
 static struct mgmt *mgmt_mesh;
@@ -90,8 +84,8 @@ static bool initialized;
 /* We allow only one outstanding Join request */
 static struct join_data *join_pending;
 
-/* Pending Attach requests */
-static struct l_queue *attach_queue;
+/* Pending method requests */
+static struct l_queue *pending_queue;
 
 static bool simple_match(const void *a, const void *b)
 {
@@ -341,14 +335,13 @@ bool mesh_init(uint16_t index, const char *config_dir)
 	return true;
 }
 
-static void attach_exit(void *data)
+static void pending_request_exit(void *data)
 {
 	struct l_dbus_message *reply;
-	struct attach_data *pending = data;
+	struct l_dbus_message *msg = data;
 
-	reply = dbus_error(pending->msg, MESH_ERROR_FAILED, "Failed. Exiting");
+	reply = dbus_error(msg, MESH_ERROR_FAILED, "Failed. Exiting");
 	l_dbus_send(dbus_get_bus(), reply);
-	l_free(pending);
 }
 
 static void free_pending_join_call(bool failed)
@@ -388,7 +381,7 @@ void mesh_cleanup(void)
 		free_pending_join_call(true);
 	}
 
-	l_queue_destroy(attach_queue, attach_exit);
+	l_queue_destroy(pending_queue, pending_request_exit);
 	node_cleanup_all();
 	mesh_model_cleanup();
 
@@ -628,38 +621,29 @@ done:
 	return reply;
 }
 
-static bool match_attach_request(const void *a, const void *b)
-{
-	const struct attach_data *pending = a;
-	const uint64_t *token = b;
-
-	return *token == pending->token;
-}
-
-static void attach_ready_cb(int status, char *node_path, uint64_t token)
+static void attach_ready_cb(void *user_data, int status, struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
-	struct attach_data *pending;
+	struct l_dbus_message *pending_msg;
 
-	pending = l_queue_find(attach_queue, match_attach_request, &token);
-	if (!pending)
+	pending_msg = l_queue_find(pending_queue, simple_match, user_data);
+	if (!pending_msg)
 		return;
 
 	if (status != MESH_ERROR_NONE) {
 		const char *desc = (status == MESH_ERROR_NOT_FOUND) ?
 				"Node match not found" : "Attach failed";
-		reply = dbus_error(pending->msg, status, desc);
+		reply = dbus_error(pending_msg, status, desc);
 		goto done;
 	}
 
-	reply = l_dbus_message_new_method_return(pending->msg);
+	reply = l_dbus_message_new_method_return(pending_msg);
 
-	node_build_attach_reply(reply, token);
+	node_build_attach_reply(node, reply);
 
 done:
 	l_dbus_send(dbus_get_bus(), reply);
-	l_queue_remove(attach_queue, pending);
-	l_free(pending);
+	l_queue_remove(pending_queue, pending_msg);
 }
 
 static struct l_dbus_message *attach_call(struct l_dbus *dbus,
@@ -668,7 +652,8 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 {
 	uint64_t token;
 	const char *app_path, *sender;
-	struct attach_data *pending;
+	struct l_dbus_message *pending_msg;
+	int status;
 
 	l_debug("Attach");
 
@@ -677,22 +662,20 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 
 	sender = l_dbus_message_get_sender(msg);
 
-	if (node_attach(app_path, sender, token, attach_ready_cb) !=
-								MESH_ERROR_NONE)
-		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
-						"Matching node not found");
+	pending_msg = l_dbus_message_ref(msg);
+	if (!pending_queue)
+		pending_queue = l_queue_new();
 
-	pending = l_new(struct attach_data, 1);
+	l_queue_push_tail(pending_queue, pending_msg);
 
-	pending->token = token;
-	pending->msg = l_dbus_message_ref(msg);
+	status = node_attach(app_path, sender, token, attach_ready_cb,
+								pending_msg);
+	if (status == MESH_ERROR_NONE)
+		return NULL;
 
-	if (!attach_queue)
-		attach_queue = l_queue_new();
+	l_queue_remove(pending_queue, pending_msg);
 
-	l_queue_push_tail(attach_queue, pending);
-
-	return NULL;
+	return dbus_error(msg, status, NULL);
 }
 
 static struct l_dbus_message *leave_call(struct l_dbus *dbus,
diff --git a/mesh/node.c b/mesh/node.c
index a6c9332bc..a9eb41e87 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -101,8 +101,9 @@ struct mesh_node {
 };
 
 struct attach_obj_request {
-	node_attach_ready_func_t cb;
+	node_ready_func_t cb;
 	struct mesh_node *node;
+	void *user_data;
 };
 
 struct join_obj_request {
@@ -1077,7 +1078,6 @@ static void get_managed_objects_attach_cb(struct l_dbus_message *msg,
 	struct attach_obj_request *req = user_data;
 	struct mesh_node *node = req->node;
 	const char *path;
-	uint64_t token = l_get_be64(node->token);
 	uint8_t num_ele;
 
 	if (l_dbus_message_is_error(msg)) {
@@ -1124,12 +1124,12 @@ static void get_managed_objects_attach_cb(struct l_dbus_message *msg,
 
 		node->disc_watch = l_dbus_add_disconnect_watch(bus, node->owner,
 						app_disc_cb, node, NULL);
-		req->cb(MESH_ERROR_NONE, node->path, token);
+		req->cb(req->user_data, MESH_ERROR_NONE, node);
 
 		return;
 	}
 fail:
-	req->cb(MESH_ERROR_FAILED, NULL, token);
+	req->cb(req->user_data, MESH_ERROR_FAILED, NULL);
 
 	l_queue_foreach(node->elements, free_element_path, NULL);
 	l_free(node->app_path);
@@ -1141,7 +1141,7 @@ fail:
 
 /* Establish relationship between application and mesh node */
 int node_attach(const char *app_path, const char *sender, uint64_t token,
-						node_attach_ready_func_t cb)
+				node_ready_func_t cb, void *user_data)
 {
 	struct attach_obj_request *req;
 	struct mesh_node *node;
@@ -1162,6 +1162,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	req = l_new(struct attach_obj_request, 1);
 	req->node = node;
 	req->cb = cb;
+	req->user_data = user_data;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
@@ -1531,15 +1532,11 @@ static void build_element_config(void *a, void *b)
 	l_dbus_message_builder_leave_struct(builder);
 }
 
-void node_build_attach_reply(struct l_dbus_message *reply, uint64_t token)
+void node_build_attach_reply(struct mesh_node *node,
+						struct l_dbus_message *reply)
 {
-	struct mesh_node *node;
 	struct l_dbus_message_builder *builder;
 
-	node = l_queue_find(nodes, match_token, &token);
-	if (!node)
-		return;
-
 	builder = l_dbus_message_builder_new(reply);
 
 	/* Node object path */
diff --git a/mesh/node.h b/mesh/node.h
index ebc82ffb8..20b60099e 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -27,8 +27,8 @@ struct mesh_agent;
 #define MIN_SEQ_CACHE		(2*MIN_SEQ_TRIGGER)
 #define MIN_SEQ_CACHE_TIME	(5*60)
 
-typedef void (*node_attach_ready_func_t) (int status, char *node_path,
-								uint64_t token);
+typedef void (*node_ready_func_t) (void *user_data, int status,
+							struct mesh_node *node);
 
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
@@ -86,8 +86,9 @@ bool node_add_pending_local(struct mesh_node *node, void *info,
 							struct mesh_io *io);
 void node_attach_io(struct mesh_io *io);
 int node_attach(const char *app_path, const char *sender, uint64_t token,
-						node_attach_ready_func_t cb);
-void node_build_attach_reply(struct l_dbus_message *reply, uint64_t token);
+					node_ready_func_t cb, void *user_data);
+void node_build_attach_reply(struct mesh_node *node,
+						struct l_dbus_message *reply);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.17.2

