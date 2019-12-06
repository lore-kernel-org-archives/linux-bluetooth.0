Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C264C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39607206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 20:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFU5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:57:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:41334 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfLFU5x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Dec 2019 15:57:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 12:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="219502262"
Received: from ingas-nuc1.sea.intel.com ([10.255.83.133])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 12:57:52 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] mesh: Initialize net modes based on node configuration
Date:   Fri,  6 Dec 2019 12:57:49 -0800
Message-Id: <20191206205749.12918-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206205749.12918-1-inga.stotland@intel.com>
References: <20191206205749.12918-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This correctly initializes net settings related to node features
based on node configuration: either defaults in the case of
a newly node created/provisioned/imported node or the configured
values read from stored existing node.
---
 mesh/mesh-defs.h |  2 ++
 mesh/net.c       | 15 ++-------------
 mesh/node.c      | 45 +++++++++++++++++++++++++++------------------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 8f28fc89b..9353d7351 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -109,6 +109,8 @@
 #define APP_IDX_DEV_REMOTE	0x6fff
 #define APP_IDX_DEV_LOCAL	0x7fff
 
+#define DEFAULT_SEQUENCE_NUMBER 0x000000
+
 #define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
 #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
 					((x) < VIRTUAL_ADDRESS_LOW))
diff --git a/mesh/net.c b/mesh/net.c
index 17dbf2ec2..f662d8a91 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -679,20 +679,9 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net = l_new(struct mesh_net, 1);
 
 	net->node = node;
-	net->pkt_id = 0;
-	net->bea_id = 0;
-
-	net->beacon_enable = true;
-	net->proxy_enable = false;
-	net->relay.enable = false;
-
-	net->seq_num = 0x000000;
-	net->src_addr = 0x0000;
-	net->default_ttl = 0x7f;
-
-	net->provisioner = false;
+	net->seq_num = DEFAULT_SEQUENCE_NUMBER;
+	net->default_ttl = TTL_MASK;
 
-	net->test_mode = false;
 	memset(&net->prov_caps, 0, sizeof(net->prov_caps));
 	net->prov_caps.algorithms = 1;
 
diff --git a/mesh/node.c b/mesh/node.c
index edf6fce37..f8acc78c3 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -57,7 +57,6 @@
 #define DEFAULT_LOCATION 0x0000
 
 #define DEFAULT_CRPL 10
-#define DEFAULT_SEQUENCE_NUMBER 0
 
 enum request_type {
 	REQUEST_TYPE_JOIN,
@@ -219,6 +218,7 @@ static int compare_model_id(const void *a, const void *b, void *user_data)
 	return 0;
 }
 
+
 struct mesh_node *node_find_by_addr(uint16_t addr)
 {
 	if (!IS_UNICAST(addr))
@@ -486,12 +486,34 @@ static bool init_storage_dir(struct mesh_node *node)
 	return true;
 }
 
+static void update_net_settings(struct mesh_node *node)
+{
+	uint8_t mode;
+
+	mode = node->proxy;
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_proxy_mode(node->net, mode == MESH_MODE_ENABLED);
+
+	mode = node->friend;
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
+}
+
 static bool init_from_storage(struct mesh_config_node *db_node,
 			const uint8_t uuid[16], struct mesh_config *cfg,
 			void *user_data)
 {
 	unsigned int num_ele;
-	uint8_t mode;
+
 	struct mesh_node *node = node_new(uuid);
 
 	if (!nodes)
@@ -554,22 +576,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	mesh_net_set_seq_num(node->net, node->seq_number);
 	mesh_net_set_default_ttl(node->net, node->ttl);
 
-	mode = node->proxy;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_proxy_mode(node->net, mode == MESH_MODE_ENABLED);
-
-	mode = node->friend;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_friend_mode(node->net, mode == MESH_MODE_ENABLED);
-
-	mode = node->relay.mode;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_relay_mode(node->net, mode == MESH_MODE_ENABLED,
-					node->relay.cnt, node->relay.interval);
-
-	mode = node->beacon;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_beacon_mode(node->net, mode == MESH_MODE_ENABLED);
+	update_net_settings(node);
 
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
@@ -1383,6 +1390,8 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 			return false;
 	}
 
+	update_net_settings(node);
+
 	mesh_config_save(node->cfg, true, NULL, NULL);
 
 	/* Initialize configuration server model */
-- 
2.21.0

