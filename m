Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46CCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCB4207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgEVAfJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:55685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgEVAfH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:07 -0400
IronPort-SDR: RxXhIiFTyG6G9bf5g7aK3WPyqBIpLvqFru8S7ZBubr5SEVF2I9a+lJyxCVtcKwNt+XaDG0DVXv
 PfujLG0mPxuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:06 -0700
IronPort-SDR: EYicuOQtC9ljuV98SNBvHLoVb+OP5pAx7/HEPLNp9GPAYAeiBImE561VStKzaXg5aT2DAAXnP5
 maCwTWocXP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961693"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:06 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 08/10] mesh: Clean up Attach() method call
Date:   Thu, 21 May 2020 17:34:59 -0700
Message-Id: <20200522003501.106165-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This consolidates error return form one place: off a callback
with unsuccessful status.
---
 mesh/mesh.c | 29 ++++++++---------------------
 mesh/node.c | 14 +++++++-------
 mesh/node.h |  2 +-
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index e5b36cd94..c68436caa 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -617,24 +617,17 @@ static void attach_ready_cb(void *user_data, int status, struct mesh_node *node)
 	struct l_dbus_message *reply;
 	struct l_dbus_message *pending_msg;
 
-	pending_msg = l_queue_find(pending_queue, simple_match, user_data);
+	pending_msg = l_queue_remove_if(pending_queue, simple_match, user_data);
 	if (!pending_msg)
 		return;
 
-	if (status != MESH_ERROR_NONE) {
-		const char *desc = (status == MESH_ERROR_NOT_FOUND) ?
-				"Node match not found" : "Attach failed";
-		reply = dbus_error(pending_msg, status, desc);
-		goto done;
-	}
-
-	reply = l_dbus_message_new_method_return(pending_msg);
+	if (status == MESH_ERROR_NONE) {
+		reply = l_dbus_message_new_method_return(pending_msg);
+		node_build_attach_reply(node, reply);
+	} else
+		reply = dbus_error(pending_msg, status, "Attach failed");
 
-	node_build_attach_reply(node, reply);
-
-done:
 	l_dbus_send(dbus_get_bus(), reply);
-	l_queue_remove(pending_queue, pending_msg);
 }
 
 static struct l_dbus_message *attach_call(struct l_dbus *dbus,
@@ -644,7 +637,6 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	uint64_t token;
 	const char *app_path, *sender;
 	struct l_dbus_message *pending_msg;
-	int status;
 
 	l_debug("Attach");
 
@@ -656,14 +648,9 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	pending_msg = l_dbus_message_ref(msg);
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	status = node_attach(app_path, sender, token, attach_ready_cb,
-								pending_msg);
-	if (status == MESH_ERROR_NONE)
-		return NULL;
+	node_attach(app_path, sender, token, attach_ready_cb, pending_msg);
 
-	l_queue_remove(pending_queue, pending_msg);
-
-	return dbus_error(msg, status, NULL);
+	return NULL;
 }
 
 static struct l_dbus_message *leave_call(struct l_dbus *dbus,
diff --git a/mesh/node.c b/mesh/node.c
index 9ba5ad877..dd28dfd77 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1634,20 +1634,23 @@ fail:
 }
 
 /* Establish relationship between application and mesh node */
-int node_attach(const char *app_root, const char *sender, uint64_t token,
+void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req;
 	struct mesh_node *node;
 
 	node = l_queue_find(nodes, match_token, (void *) &token);
-	if (!node)
-		return MESH_ERROR_NOT_FOUND;
+	if (!node) {
+		cb(user_data, MESH_ERROR_NOT_FOUND, NULL);
+		return;
+	}
 
 	/* Check if the node is already in use */
 	if (node->owner) {
 		l_warn("The node is already in use");
-		return MESH_ERROR_ALREADY_EXISTS;
+		cb(user_data, MESH_ERROR_ALREADY_EXISTS, NULL);
+		return;
 	}
 
 	req = l_new(struct managed_obj_request, 1);
@@ -1668,11 +1671,8 @@ int node_attach(const char *app_root, const char *sender, uint64_t token,
 					"GetManagedObjects", NULL,
 					get_managed_objects_cb,
 					req, l_free);
-	return MESH_ERROR_NONE;
-
 }
 
-
 /* Create a temporary pre-provisioned node */
 void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb)
diff --git a/mesh/node.h b/mesh/node.h
index ca5d60b6b..290681e28 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -81,7 +81,7 @@ const char *node_get_app_path(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node, void *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
-int node_attach(const char *app_root, const char *sender, uint64_t token,
+void node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
-- 
2.26.2

