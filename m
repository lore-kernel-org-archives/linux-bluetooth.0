Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C92072F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFJRL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:11:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:8724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgFJRL1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:11:27 -0400
IronPort-SDR: k+5nyZ/qX5bvELHShrO1V6SCJAyTWisXINItqEzpVAikT70cwbgHcou2NXGNodgv9q8ICVQTvr
 mSLP2AI1R64w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:11:26 -0700
IronPort-SDR: Ezk+q8plssWNUv/u0qTTBUjHnpBD2fdzZvjYeWU9n0EPTBItXMHx0V28wE60pGqCdza8A853OJ
 R+m8W0oweJQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="259340103"
Received: from unknown (HELO ingas-nuc1.sea.intel.com) ([10.254.72.48])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2020 10:11:26 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave() & Attach()
Date:   Wed, 10 Jun 2020 10:11:21 -0700
Message-Id: <20200610171121.46910-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171121.46910-1-inga.stotland@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces the following behavior change for those methods
on Network interface that specify node token as an input parameter

Leave() method:
If Leave method is called for a node that is being processed as a result
of a Create, Import, Join or Attach method calls in progress, node removal
is not allowed and org.bluez.mesh.Error.Busy error is returned.

Attach() method:
If Attach method is called for a node that is being processed as a result
of a Create, Import or Join method calls in progress, node attachment
is not allowed and org.bluez.mesh.Error.Busy error is returned.
---
 doc/mesh-api.txt |  3 +++
 mesh/mesh.c      | 10 +++++++++-
 mesh/node.c      | 21 +++++++++++++++++++++
 mesh/node.h      |  1 +
 test/test-mesh   |  2 --
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index e85f0bf52..4bef6174c 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -116,6 +116,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound,
 			org.bluez.mesh.Error.AlreadyExists,
+			org.bluez.mesh.Error.Busy,
 			org.bluez.mesh.Error.Failed
 
 	void Leave(uint64 token)
@@ -126,6 +127,8 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
+			org.bluez.mesh.Error.Busy
 
 	void CreateNetwork(object app_root, array{byte}[16] uuid)
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index a5935c216..c8767ee7a 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -655,13 +655,21 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	uint64_t token;
+	struct mesh_node *node;
 
 	l_debug("Leave");
 
 	if (!l_dbus_message_get_arguments(msg, "t", &token))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	node_remove(node_find_by_token(token));
+	node = node_find_by_token(token);
+	if (!node)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
+
+	if (node_is_busy(node))
+		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
+
+	node_remove(node);
 
 	return l_dbus_message_new_method_return(msg);
 }
diff --git a/mesh/node.c b/mesh/node.c
index 7ec06437b..567f2e6db 100644
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
@@ -598,6 +599,11 @@ bool node_is_provisioner(struct mesh_node *node)
 	return node->provisioner;
 }
 
+bool node_is_busy(struct mesh_node *node)
+{
+	return node->busy;
+}
+
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx)
 {
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
@@ -1654,6 +1665,12 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
 		return;
 	}
 
+	/* Check if there is a pending request associated with this node */
+	if (node->busy) {
+		cb(user_data, MESH_ERROR_BUSY, NULL);
+		return;
+	}
+
 	/* Check if the node is already in use */
 	if (node->owner) {
 		l_warn("The node is already in use");
@@ -1674,6 +1691,8 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
 	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
+	node->busy = true;
+
 	send_managed_objects_request(sender, app_root, req);
 }
 
@@ -2347,6 +2366,8 @@ void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io)
 	free_node_dbus_resources(node);
 	mesh_agent_remove(node->agent);
 
+	node->busy = false;
+
 	/* Register callback for the node's io */
 	attach_io(node, io);
 }
diff --git a/mesh/node.h b/mesh/node.h
index e26d410c8..b8b2b1b49 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -39,6 +39,7 @@ struct mesh_node *node_find_by_addr(uint16_t addr);
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
 struct mesh_node *node_find_by_token(uint64_t token);
 bool node_is_provisioner(struct mesh_node *node);
+bool node_is_busy(struct mesh_node *node);
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx);
 uint16_t node_get_primary(struct mesh_node *node);
diff --git a/test/test-mesh b/test/test-mesh
index 38f0c0a74..7c8a25482 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -412,8 +412,6 @@ class Application(dbus.service.Object):
 
 		token = value
 		have_token = True
-		if attached == False:
-			attach(token)
 
 	@dbus.service.method(MESH_APPLICATION_IFACE,
 					in_signature="s", out_signature="")
-- 
2.26.2

