Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD99C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 20:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2AA20897
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 20:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH1UEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:04:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:35423 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgH1UE3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 16:04:29 -0400
IronPort-SDR: vzfp+r6dZ7oHVoeLKFMrc7Uf9M0Vc4eV8APpZQ2RMeh0Ru5ThPQFC8VTz/yV/tFqGPNQBtf+h9
 om2wiA7g49rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136799285"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="136799285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:04:29 -0700
IronPort-SDR: vM/oqMEDzpPg24FWZfdvt3FTecPhIhN385LJV8l9F0IJpbJW0evTq/Luxd3EKcv3QLi4z6XQ5N
 ZjtQDd1fQHwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300345422"
Received: from rbuaba-mobl2.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.83.122])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2020 13:04:29 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Initialize RPL when creating or loading a node
Date:   Fri, 28 Aug 2020 13:04:26 -0700
Message-Id: <20200828200427.18753-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828200427.18753-1-inga.stotland@intel.com>
References: <20200828200427.18753-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When either a new node is created or an existing node is loaded from
storage, initialize RPL storage directory.

Additionally, when an existing node configguration is read from storage,
load saved RPL entries into the corresponding RPL lists.
---
 mesh/net.c  | 14 +++++++-------
 mesh/net.h  |  1 +
 mesh/node.c | 11 +++++++----
 mesh/rpl.c  | 29 ++++++++++++++++++++---------
 mesh/rpl.h  |  3 ++-
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 15d8f1c4b..83647d6ad 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -633,6 +633,7 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->frnd_msgs = l_queue_new();
 	net->destinations = l_queue_new();
 	net->app_keys = l_queue_new();
+	net->replay_cache = l_queue_new();
 
 	if (!nets)
 		nets = l_queue_new();
@@ -2596,7 +2597,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		mesh_config_write_iv_index(cfg, iv_index, ivu);
 
 		/* Cleanup Replay Protection List NVM */
-		rpl_init(net->node, iv_index);
+		rpl_update(net->node, iv_index);
 	}
 
 	node_property_changed(net->node, "IVIndex");
@@ -3480,12 +3481,6 @@ bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
 	if (!net || !net->node)
 		return true;
 
-	if (!net->replay_cache) {
-		net->replay_cache = l_queue_new();
-		rpl_init(net->node, net->iv_index);
-		rpl_get_list(net->node, net->replay_cache);
-	}
-
 	rpe = l_queue_find(net->replay_cache, match_replay_cache,
 						L_UINT_TO_PTR(src));
 
@@ -3688,3 +3683,8 @@ int mesh_net_set_heartbeat_pub(struct mesh_net *net, uint16_t dst,
 	/* TODO: Save to node config */
 	return MESH_STATUS_SUCCESS;
 }
+
+bool mesh_net_load_rpl(struct mesh_net *net)
+{
+	return rpl_get_list(net->node, net->replay_cache);
+}
diff --git a/mesh/net.h b/mesh/net.h
index 253185e42..725054ce6 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -358,3 +358,4 @@ bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
 				uint16_t crpl, uint32_t seq, uint32_t iv_index);
 void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
 							uint32_t iv_index);
+bool mesh_net_load_rpl(struct mesh_net *net);
diff --git a/mesh/node.c b/mesh/node.c
index c564bdb91..f7ac5ff67 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -44,6 +44,7 @@
 #include "mesh/dbus.h"
 #include "mesh/agent.h"
 #include "mesh/manager.h"
+#include "mesh/rpl.h"
 #include "mesh/node.h"
 
 #define MESH_NODE_PATH_PREFIX "/node"
@@ -399,7 +400,8 @@ static bool init_storage_dir(struct mesh_node *node)
 
 	node->storage_dir = l_strdup(dir_name);
 
-	return true;
+	/* Initialize directory for storing RPL info */
+	return rpl_init(node->storage_dir);
 }
 
 static void update_net_settings(struct mesh_node *node)
@@ -470,6 +472,10 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	mesh_net_set_iv_index(node->net, db_node->iv_index, db_node->iv_update);
 
+	/* Initialize directory for storing keyring and RPL info */
+	if (!init_storage_dir(node) || !mesh_net_load_rpl(node->net))
+		goto fail;
+
 	if (db_node->net_transmit)
 		mesh_net_transmit_params_set(node->net,
 					db_node->net_transmit->count,
@@ -497,9 +503,6 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	node->cfg = cfg;
 
-	/* Initialize directory for storing keyring info */
-	init_storage_dir(node);
-
 	return true;
 fail:
 	node_remove(node);
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 5a667468e..792c52ad6 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -51,7 +51,7 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 	DIR *dir;
 	int fd;
 
-	if (!node || !IS_UNICAST(src))
+	if (!IS_UNICAST(src))
 		return false;
 
 	node_path = node_get_storage_dir(node);
@@ -100,7 +100,7 @@ void rpl_del_entry(struct mesh_node *node, uint16_t src)
 	struct dirent *entry;
 	DIR *dir;
 
-	if (!node || !IS_UNICAST(src))
+	if (!IS_UNICAST(src))
 		return;
 
 	node_path = node_get_storage_dir(node);
@@ -205,12 +205,12 @@ bool rpl_get_list(struct mesh_node *node, struct l_queue *rpl_list)
 	size_t len;
 	DIR *dir;
 
-	if (!node || !rpl_list)
+	if (!rpl_list)
 		return false;
 
 	node_path = node_get_storage_dir(node);
 
-	len = strlen(node_path) + strlen(rpl_dir) + 14;
+	len = strlen(node_path) + strlen(rpl_dir) + 15;
 
 	if (len > PATH_MAX)
 		return false;
@@ -241,7 +241,7 @@ bool rpl_get_list(struct mesh_node *node, struct l_queue *rpl_list)
 	return true;
 }
 
-void rpl_init(struct mesh_node *node, uint32_t cur)
+void rpl_update(struct mesh_node *node, uint32_t cur)
 {
 	uint32_t old = cur - 1;
 	const char *node_path;
@@ -249,12 +249,11 @@ void rpl_init(struct mesh_node *node, uint32_t cur)
 	char path[PATH_MAX];
 	DIR *dir;
 
-	if (!node)
-		return;
-
 	node_path = node_get_storage_dir(node);
+	if (!node_path)
+		return;
 
-	if (strlen(node_path) + strlen(rpl_dir) + 10 >= PATH_MAX)
+	if (strlen(node_path) + strlen(rpl_dir) + 15 >= PATH_MAX)
 		return;
 
 	/* Make sure path exists */
@@ -287,3 +286,15 @@ void rpl_init(struct mesh_node *node, uint32_t cur)
 
 	closedir(dir);
 }
+
+bool rpl_init(const char *node_path)
+{
+	char path[PATH_MAX];
+
+	if (strlen(node_path) + strlen(rpl_dir) + 15 >= PATH_MAX)
+		return false;
+
+	snprintf(path, PATH_MAX, "%s%s", node_path, rpl_dir);
+	mkdir(path, 0755);
+	return true;
+}
diff --git a/mesh/rpl.h b/mesh/rpl.h
index 17d2e3f05..2bbbdc9b9 100644
--- a/mesh/rpl.h
+++ b/mesh/rpl.h
@@ -27,4 +27,5 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 								uint32_t seq);
 void rpl_del_entry(struct mesh_node *node, uint16_t src);
 bool rpl_get_list(struct mesh_node *node, struct l_queue *rpl_list);
-void rpl_init(struct mesh_node *node, uint32_t iv_index);
+void rpl_update(struct mesh_node *node, uint32_t iv_index);
+bool rpl_init(const char *node_path);
-- 
2.26.2

