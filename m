Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086D8C74A44
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE8020C01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfGNXXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 19:23:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:39738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfGNXXX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 16:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="168805626"
Received: from rreichel-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.24.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 16:23:22 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 01/10 v3] mesh: Move network config setup from storage.c to node.c
Date:   Sun, 14 Jul 2019 16:23:11 -0700
Message-Id: <20190714232320.20921-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit moves initialization of configuration parameters
for node->net when the local node state is restored from stored
configuration. Old location: storage.c, new locaiton node.c.
---
 mesh/node.c    | 28 ++++++++++++++++++++++++++++
 mesh/storage.c | 39 ---------------------------------------
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 27235ef34..dc9781482 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -376,6 +376,7 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 {
 	struct mesh_db_node *db_node = data;
 	unsigned int num_ele;
+	uint8_t mode;
 
 	node->comp = l_new(struct node_composition, 1);
 	node->comp->cid = db_node->cid;
@@ -408,6 +409,33 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 
 	node->primary = db_node->unicast;
 
+	mesh_net_set_seq_num(node->net, node->seq_number);
+	mesh_net_set_default_ttl(node->net, node->ttl);
+
+	mode = node->proxy;
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_proxy_mode(node->net, mode == MESH_MODE_ENABLED);
+
+	mode = node->lpn;
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_friend_mode(node->net, mode == MESH_MODE_ENABLED);
+
+	mode = node->relay.mode;
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_relay_mode(node->net, mode == MESH_MODE_ENABLED,
+					node->relay.cnt, node->relay.interval);
+
+	mode = node->beacon;
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_beacon_mode(node->net, mode == MESH_MODE_ENABLED);
+
+	if (!IS_UNASSIGNED(node->primary) &&
+		!mesh_net_register_unicast(node->net, node->primary, num_ele))
+		return false;
+
+	if (node->uuid)
+		mesh_net_id_uuid_set(node->net, node->uuid);
+
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
 
diff --git a/mesh/storage.c b/mesh/storage.c
index 0f2b77fde..2b7804242 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -56,51 +56,12 @@ static const char *storage_dir;
 static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
 	struct mesh_node *node = user_data;
-	struct mesh_net *net;
-	uint32_t seq_number;
-	uint8_t ttl, mode, cnt, num_ele;
-	uint16_t unicast, interval;
-	uint8_t *uuid;
 
 	if (!node_init_from_storage(node, db_node)) {
 		node_remove(node);
 		return false;
 	}
 
-	net = node_get_net(node);
-	seq_number = node_get_sequence_number(node);
-	mesh_net_set_seq_num(net, seq_number);
-	ttl = node_default_ttl_get(node);
-	mesh_net_set_default_ttl(net, ttl);
-
-	mode = node_proxy_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_proxy_mode(net, mode == MESH_MODE_ENABLED);
-
-	mode = node_friend_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_friend_mode(net, mode == MESH_MODE_ENABLED);
-
-	mode = node_relay_mode_get(node, &cnt, &interval);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_relay_mode(net, mode == MESH_MODE_ENABLED, cnt,
-								interval);
-
-	mode = node_beacon_mode_get(node);
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_beacon_mode(net, mode == MESH_MODE_ENABLED);
-
-	unicast = db_node->unicast;
-	num_ele = node_get_num_elements(node);
-
-	if (!IS_UNASSIGNED(unicast) &&
-		!mesh_net_register_unicast(net, unicast, num_ele))
-		return false;
-
-	uuid = node_uuid_get(node);
-	if (uuid)
-		mesh_net_id_uuid_set(net, uuid);
-
 	return true;
 }
 
-- 
2.21.0

