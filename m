Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED172083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgEVAfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:55685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgEVAfF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:05 -0400
IronPort-SDR: zMPzC/YGaQyK6HUPyJLgDje3e3pOk9ADPB9G+J2CJrr6Be92uoeTjj3elda4FrhxPJaXPNwvC8
 AEcpwS5XK8iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:04 -0700
IronPort-SDR: qe5ZUKx4kXsHUOUJIeIBmNmiVNKtzJsiCEosSie3ml4aOoCqK8/HENBnf99dnaQaWTamwTfgth
 13x6Ij9r3kfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961670"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/10] mesh: Add finalization of a newly created node
Date:   Thu, 21 May 2020 17:34:55 -0700
Message-Id: <20200522003501.106165-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a new node is created as a result of successful completion
of either Join() or Create() or Import() methods and has been
confirmed via successful token delivery to the application,
clean up node's D-Bus resources (application path, element paths, etc)
that have been gathered during the initial GetMAnagedObjects() call.
Also, remove the agent instance associaed with the new node.

These resources will be re-populated after the Attach() call
verifies the node's integrity.
---
 mesh/mesh.c |  4 ++--
 mesh/node.c | 39 +++++++++++++++++++++++++--------------
 mesh/node.h |  1 +
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 14ac543e2..8bd7b3978 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -449,7 +449,7 @@ static void prov_join_complete_reply_cb(struct l_dbus_message *message,
 		failed = true;
 
 	if (!failed)
-		node_attach_io(join_pending->node, mesh.io);
+		node_finalize_new_node(join_pending->node, mesh.io);
 
 	free_pending_join_call(failed);
 }
@@ -693,7 +693,7 @@ static void create_join_complete_reply_cb(struct l_dbus_message *message,
 		return;
 	}
 
-	node_attach_io(node, mesh.io);
+	node_finalize_new_node(node, mesh.io);
 }
 
 static void create_node_ready_cb(void *user_data, int status,
diff --git a/mesh/node.c b/mesh/node.c
index 8ad77639e..8cfe1ddc8 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -992,12 +992,6 @@ static void attach_io(void *a, void *b)
 		mesh_net_attach(node->net, io);
 }
 
-/* Register callback for the node's io */
-void node_attach_io(struct mesh_node *node, struct mesh_io *io)
-{
-	attach_io(node, io);
-}
-
 /* Register callbacks for all nodes io */
 void node_attach_io_all(struct mesh_io *io)
 {
@@ -1467,7 +1461,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	const char *path;
 	struct mesh_node *node = req->node;
 	struct node_import *import;
-	void *agent = NULL;
 	bool have_app = false;
 	unsigned int num_ele;
 	struct keyring_net_key net_key;
@@ -1515,13 +1508,11 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 				const char *sender;
 
 				sender = l_dbus_message_get_sender(msg);
-				agent = mesh_agent_create(path, sender,
+				node->agent = mesh_agent_create(path, sender,
 								&properties);
-				if (!agent)
+				if (!node->agent)
 					goto fail;
 
-				node->agent = agent;
-
 			} else if (!strcmp(MESH_PROVISIONER_INTERFACE,
 								interface)) {
 				node->provisioner = true;
@@ -1629,9 +1620,6 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 fail:
-	if (agent)
-		mesh_agent_remove(agent);
-
 	/* Handle failed requests */
 	if (node)
 		node_remove(node);
@@ -2348,3 +2336,26 @@ bool node_load_from_storage(const char *storage_dir)
 {
 	return mesh_config_load_nodes(storage_dir, init_from_storage, NULL);
 }
+
+/*
+ * This is called for a new node that:
+ *         - has been created as a result of successful completion of Join()
+ *           or Create() or Import() methods
+ *     and
+ *         - has been confirmed via successful token delivery to the application
+ *
+ * After a node has been created, the information gathered during initial
+ * GetManagedObjects() call is cleared. The subsequent call to Attach() would
+ * verify node's integrity and re-initialize node's D-Bus resources.
+ */
+void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io)
+{
+	if (!node)
+		return;
+
+	free_node_dbus_resources(node);
+	mesh_agent_remove(node->agent);
+
+	/* Register callback for the node's io */
+	attach_io(node, io);
+}
diff --git a/mesh/node.h b/mesh/node.h
index 38aea138f..3019d316b 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -100,3 +100,4 @@ struct mesh_config *node_config_get(struct mesh_node *node);
 struct mesh_agent *node_get_agent(struct mesh_node *node);
 const char *node_get_storage_dir(struct mesh_node *node);
 bool node_load_from_storage(const char *storage_dir);
+void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io);
-- 
2.26.2

