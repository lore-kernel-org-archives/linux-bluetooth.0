Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6497C742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E42208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfGKXAg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:52146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfGKXAg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516249"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:35 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 5/9] mesh: Expose resources needed by Management1 interface
Date:   Thu, 11 Jul 2019 15:59:48 -0700
Message-Id: <20190711225952.1599-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 42 ++++++++++++++++++++++++++++++++----------
 mesh/node.h |  3 +++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 1f781cfe9..27235ef34 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -80,7 +80,8 @@ struct mesh_node {
 	struct l_queue *elements;
 	char *app_path;
 	char *owner;
-	char *path;
+	char *obj_path;
+	struct mesh_agent *agent;
 	void *jconfig;
 	char *node_path;
 	uint32_t disc_watch;
@@ -242,14 +243,14 @@ static void free_node_dbus_resources(struct mesh_node *node)
 	l_free(node->app_path);
 	node->app_path = NULL;
 
-	if (node->path) {
-		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
+	if (node->obj_path) {
+		l_dbus_object_remove_interface(dbus_get_bus(), node->obj_path,
 							MESH_NODE_INTERFACE);
 
-		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
+		l_dbus_object_remove_interface(dbus_get_bus(), node->obj_path,
 						MESH_MANAGEMENT_INTERFACE);
-		l_free(node->path);
-		node->path = NULL;
+		l_free(node->obj_path);
+		node->obj_path = NULL;
 	}
 }
 
@@ -441,6 +442,11 @@ void node_cleanup_all(void)
 	l_dbus_unregister_interface(dbus_get_bus(), MESH_MANAGEMENT_INTERFACE);
 }
 
+bool node_is_provisioner(struct mesh_node *node)
+{
+	return node->provisioner;
+}
+
 bool node_is_provisioned(struct mesh_node *node)
 {
 	return (!IS_UNASSIGNED(node->primary));
@@ -1026,14 +1032,14 @@ static bool register_node_object(struct mesh_node *node)
 	if (!hex2str(node->uuid, sizeof(node->uuid), uuid, sizeof(uuid)))
 		return false;
 
-	node->path = l_strdup_printf(BLUEZ_MESH_PATH MESH_NODE_PATH_PREFIX
+	node->obj_path = l_strdup_printf(BLUEZ_MESH_PATH MESH_NODE_PATH_PREFIX
 								"%s", uuid);
 
-	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
+	if (!l_dbus_object_add_interface(dbus_get_bus(), node->obj_path,
 						MESH_NODE_INTERFACE, node))
 		return false;
 
-	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
+	if (!l_dbus_object_add_interface(dbus_get_bus(), node->obj_path,
 					MESH_MANAGEMENT_INTERFACE, node))
 		return false;
 
@@ -1509,6 +1515,9 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 								&properties);
 				if (!agent)
 					goto fail;
+
+				node->agent = agent;
+
 			} else if (!strcmp(MESH_PROVISIONER_INTERFACE,
 								interface)) {
 				node->provisioner = true;
@@ -1736,7 +1745,7 @@ void node_build_attach_reply(struct mesh_node *node,
 	builder = l_dbus_message_builder_new(reply);
 
 	/* Node object path */
-	l_dbus_message_builder_append_basic(builder, 'o', node->path);
+	l_dbus_message_builder_append_basic(builder, 'o', node->obj_path);
 
 	/* Array of element configurations "a*/
 	l_dbus_message_builder_enter_array(builder, "(ya(qa{sv}))");
@@ -2007,7 +2016,20 @@ char *node_path_get(struct mesh_node *node)
 	return node->node_path;
 }
 
+const char *node_get_app_path(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+
+	return node->app_path;
+}
+
 struct mesh_net *node_get_net(struct mesh_node *node)
 {
 	return node->net;
 }
+
+struct mesh_agent *node_get_agent(struct mesh_node *node)
+{
+	return node->agent;
+}
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..d69887ed1 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -42,6 +42,7 @@ struct mesh_net *node_get_net(struct mesh_node *node);
 struct mesh_node *node_find_by_addr(uint16_t addr);
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
 struct mesh_node *node_find_by_token(uint64_t token);
+bool node_is_provisioner(struct mesh_node *node);
 bool node_is_provisioned(struct mesh_node *node);
 bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
 				uint16_t net_idx, uint16_t idx);
@@ -82,6 +83,7 @@ uint8_t node_friend_mode_get(struct mesh_node *node);
 uint32_t node_seq_cache(struct mesh_node *node);
 const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx);
 const char *node_get_owner(struct mesh_node *node);
+const char *node_get_app_path(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node, void *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
@@ -99,3 +101,4 @@ void node_jconfig_set(struct mesh_node *node, void *jconfig);
 void *node_jconfig_get(struct mesh_node *node);
 void node_path_set(struct mesh_node *node, char *path);
 char *node_path_get(struct mesh_node *node);
+struct mesh_agent *node_get_agent(struct mesh_node *node);
-- 
2.14.5

