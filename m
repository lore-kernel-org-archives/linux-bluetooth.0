Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96EC74A41
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D99520896
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfGNG20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:28:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:30364 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfGNG20 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 02:28:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 23:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,489,1557212400"; 
   d="scan'208";a="318388014"
Received: from ingas-nuc1.sea.intel.com ([10.251.146.93])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 23:28:25 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 10/10 v2] mesh: Rename mesh_config_srv_init() to cfgmod_server_init()
Date:   Sat, 13 Jul 2019 23:28:12 -0700
Message-Id: <20190714062812.31041-11-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714062812.31041-1-inga.stotland@intel.com>
References: <20190714062812.31041-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This renames mesh_config_srv_init() to cfgmod_server_init() to avoid
confusion with mesh_config_..> API and to reflect that the call pertains
to configuration server model.
---
 mesh/cfgmod-server.c | 2 +-
 mesh/cfgmod.h        | 2 +-
 mesh/node.c          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index b256cdd48..71d59fd40 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -1284,7 +1284,7 @@ static const struct mesh_model_ops ops = {
 	.pub = NULL
 };
 
-void mesh_config_srv_init(struct mesh_node *node, uint8_t ele_idx)
+void cfgmod_server_init(struct mesh_node *node, uint8_t ele_idx)
 {
 	l_debug("%2.2x", ele_idx);
 	mesh_model_register(node, ele_idx, CONFIG_SRV_MODEL, &ops, node);
diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index 84fa184e5..da8b5b32b 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -94,4 +94,4 @@
 #define OP_VEND_MODEL_APP_GET			0x804C
 #define OP_VEND_MODEL_APP_LIST			0x804E
 
-void mesh_config_srv_init(struct mesh_node *node, uint8_t ele_idx);
+void cfgmod_server_init(struct mesh_node *node, uint8_t ele_idx);
diff --git a/mesh/node.c b/mesh/node.c
index 0f4569e36..0e95d908b 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -476,7 +476,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 		goto fail;
 
 	/* Initialize configuration server model */
-	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
+	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
 	node->cfg = cfg;
 
@@ -1509,7 +1509,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	mesh_config_save(node->cfg, true, NULL, NULL);
 
 	/* Initialize configuration server model */
-	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
+	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
 	return true;
 }
-- 
2.21.0

