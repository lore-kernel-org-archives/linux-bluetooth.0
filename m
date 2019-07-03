Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B678C5B578
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE200218A6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfGCXCr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:02:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:54332 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfGCXCr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 19:02:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="362784662"
Received: from ingas-nuc1.sea.intel.com ([10.254.86.21])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2019 16:02:45 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix clean up of node's DBUS assosiated resources
Date:   Wed,  3 Jul 2019 16:02:44 -0700
Message-Id: <20190703230244.20229-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This consolidates multiple places where node's object paths,
interfaces, etc. are de-allocated, into one routine:
free_node_dbus_resources().
This also addresses memory leaks assosiated with inconsistent freeing
of object path strings.
---
 mesh/node.c | 66 +++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index adc2aa93e..67e0dd014 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -226,34 +226,46 @@ static void element_free(void *data)
 	l_free(element);
 }
 
-static void free_node_resources(void *data)
+static void free_node_dbus_resources(struct mesh_node *node)
 {
-	struct mesh_node *node = data;
+	if (!node)
+		return;
 
-	/* Unregister io callbacks */
-	if (node->net)
-		mesh_net_detach(node->net);
-	mesh_net_free(node->net);
+	if (node->disc_watch) {
+		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
+		node->disc_watch = 0;
+	}
 
-	l_queue_destroy(node->elements, element_free);
-	l_free(node->comp);
-	l_free(node->app_path);
+	l_queue_foreach(node->elements, free_element_path, NULL);
 	l_free(node->owner);
-	l_free(node->node_path);
-
-	if (node->disc_watch)
-		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
+	node->owner = NULL;
+	l_free(node->app_path);
+	node->app_path = NULL;
 
 	if (node->path) {
 		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
 							MESH_NODE_INTERFACE);
 
 		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
-					       MESH_MANAGEMENT_INTERFACE);
+						MESH_MANAGEMENT_INTERFACE);
+		l_free(node->path);
+		node->path = NULL;
 	}
+}
 
-	l_free(node->path);
+static void free_node_resources(void *data)
+{
+	struct mesh_node *node = data;
 
+	/* Unregister io callbacks */
+	if (node->net)
+		mesh_net_detach(node->net);
+	mesh_net_free(node->net);
+
+	l_queue_destroy(node->elements, element_free);
+	l_free(node->comp);
+
+	free_node_dbus_resources(node);
 	l_free(node);
 }
 
@@ -1033,24 +1045,9 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	l_info("App %s disconnected (%u)", node->owner, node->disc_watch);
 
 	node->disc_watch = 0;
-
-	l_queue_foreach(node->elements, free_element_path, NULL);
-
-	l_free(node->owner);
-	node->owner = NULL;
-
-	if (node->path) {
-		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
-							MESH_NODE_INTERFACE);
-
-		l_dbus_object_remove_interface(dbus_get_bus(), node->path,
-						MESH_MANAGEMENT_INTERFACE);
-		l_free(node->app_path);
-		node->app_path = NULL;
-	}
+	free_node_dbus_resources(node);
 }
 
-
 static bool validate_model_property(struct node_element *ele,
 					struct l_dbus_message_iter *property,
 					uint8_t *num_models, bool vendor)
@@ -1611,14 +1608,9 @@ fail:
 		/* Handle failed Attach request */
 		node_ready_func_t cb = req->cb;
 
-		l_queue_foreach(node->elements, free_element_path, NULL);
-		l_free(node->app_path);
-		node->app_path = NULL;
+		free_node_dbus_resources(node);
 
-		l_free(node->owner);
-		node->owner = NULL;
 		cb(req->user_data, MESH_ERROR_FAILED, node);
-
 	} else {
 		/* Handle failed Join and Create requests */
 		if (node)
-- 
2.21.0

