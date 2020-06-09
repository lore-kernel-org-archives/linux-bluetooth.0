Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB114C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C642078C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 03:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFID7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:59:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:17246 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgFID7O (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 23:59:14 -0400
IronPort-SDR: LaTKe4M8AVWUGmLwnqu+3ZCZdivJpR+xq6wL/tHm7qXO7q6I05APIe5p2rdVPtmzC1lylJlthG
 Eq4c3yfcNkYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 20:59:14 -0700
IronPort-SDR: q/yX/B9Oce2wt5aG3f4KpGdni+3wEcXijQeTrbfyaZ6+yc67ZCMIIpJQzfGwBoRgGGL0P7zJkt
 ym0sOZ7KJ8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="274461156"
Received: from vrsuryad-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.38])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 20:59:14 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] mesh: Add "node is busy" check for Leave() method
Date:   Mon,  8 Jun 2020 20:59:09 -0700
Message-Id: <20200609035909.51061-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609035909.51061-1-inga.stotland@intel.com>
References: <20200609035909.51061-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces the following behavior change for Leave() method:

If Leave method is called for a node that is being processed as a result
of a Create, Import, Join or Attach method calls in progress, node removal
is not allowed and org.bluez.mesh.Error.Busy error is returned.
---
 doc/mesh-api.txt |  2 ++
 mesh/mesh.c      |  5 ++++-
 mesh/node.c      | 19 +++++++++++++++++--
 mesh/node.h      |  2 +-
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index e85f0bf52..b2eadc357 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -126,6 +126,8 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
+			org.bluez.mesh.Error.Busy
 
 	void CreateNetwork(object app_root, array{byte}[16] uuid)
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index a5935c216..0a933ffed 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -655,13 +655,16 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	uint64_t token;
+	int result;
 
 	l_debug("Leave");
 
 	if (!l_dbus_message_get_arguments(msg, "t", &token))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	node_remove(node_find_by_token(token));
+	result = node_remove(node_find_by_token(token));
+	if (result != MESH_ERROR_NONE)
+		return dbus_error(msg, result, NULL);
 
 	return l_dbus_message_new_method_return(msg);
 }
diff --git a/mesh/node.c b/mesh/node.c
index 7ec06437b..a4c60ccb1 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -88,6 +88,7 @@ struct mesh_node {
 	char *storage_dir;
 	uint32_t disc_watch;
 	uint32_t seq_number;
+	bool busy;
 	bool provisioner;
 	uint16_t primary;
 	struct node_composition comp;
@@ -344,16 +345,21 @@ static void free_node_resources(void *data)
  * This function is called to free resources and remove the
  * configuration files for the specified node.
  */
-void node_remove(struct mesh_node *node)
+int node_remove(struct mesh_node *node)
 {
 	if (!node)
-		return;
+		return MESH_ERROR_NOT_FOUND;
+
+	if (node->busy)
+		return MESH_ERROR_BUSY;
 
 	l_queue_remove(nodes, node);
 
 	mesh_config_destroy_nvm(node->cfg);
 
 	free_node_resources(node);
+
+	return MESH_ERROR_NONE;
 }
 
 static bool add_models_from_storage(struct mesh_node *node,
@@ -1352,6 +1358,8 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
+	node->busy = true;
+
 	return true;
 }
 
@@ -1459,6 +1467,9 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	struct keyring_net_key net_key;
 	uint8_t dev_key[16];
 
+	if (req->type == REQUEST_TYPE_ATTACH)
+		req->attach->busy = false;
+
 	if (!msg || l_dbus_message_is_error(msg)) {
 		l_error("Failed to get app's dbus objects");
 		goto fail;
@@ -1674,6 +1685,8 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
 	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
+	node->busy = true;
+
 	send_managed_objects_request(sender, app_root, req);
 }
 
@@ -2347,6 +2360,8 @@ void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io)
 	free_node_dbus_resources(node);
 	mesh_agent_remove(node->agent);
 
+	node->busy = false;
+
 	/* Register callback for the node's io */
 	attach_io(node, io);
 }
diff --git a/mesh/node.h b/mesh/node.h
index e26d410c8..c201670b8 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -30,7 +30,7 @@ typedef void (*node_ready_func_t) (void *user_data, int status,
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
-void node_remove(struct mesh_node *node);
+int node_remove(struct mesh_node *node);
 void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
 uint8_t *node_uuid_get(struct mesh_node *node);
-- 
2.26.2

