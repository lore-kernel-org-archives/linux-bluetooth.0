Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB918C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987C420838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLTDV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:03:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:7248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgHLTDT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 15:03:19 -0400
IronPort-SDR: 4hNE40jw6QyNOteiIJKrIFCH2ZT2NeSweAdVNAyBhbUDi4MyUzrGLRyG/GEraA7y5VZDF+Sni+
 uKkfhjjTYP3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141885369"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="141885369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 12:03:19 -0700
IronPort-SDR: vf0iPNKsKqaJT5Cu8JQZg+nFMQARb4+we36Bh5bjIp2PkPyKvIT+VcOO1AV1u6Y+IlHgYlhk7K
 S8LOWtFKYI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="295161216"
Received: from vsriva1-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.229.126])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2020 12:03:19 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Make mesh config model binding API consistent
Date:   Wed, 12 Aug 2020 12:03:17 -0700
Message-Id: <20200812190317.102140-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200812190317.102140-1-inga.stotland@intel.com>
References: <20200812190317.102140-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the order of function arguments in
mesh_config_model_binding_add() and mesh_config_model_binding_del()
to make them consistent with the rest of mesh_config_model... APIs
---
 mesh/mesh-config-json.c | 4 ++--
 mesh/mesh-config.h      | 4 ++--
 mesh/model.c            | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 086d618b1..a145388d6 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -837,7 +837,7 @@ bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 }
 
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
-						bool vendor, uint32_t mod_id,
+						uint32_t mod_id, bool vendor,
 							uint16_t app_idx)
 {
 	json_object *jnode, *jmodel, *jstring, *jarray = NULL;
@@ -882,7 +882,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 }
 
 bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
-						bool vendor, uint32_t mod_id,
+						uint32_t mod_id, bool vendor,
 							uint16_t app_idx)
 {
 	json_object *jnode, *jmodel, *jarray;
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index f15f3f376..50a55d51e 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -152,10 +152,10 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 						uint8_t *data, uint16_t size);
 bool mesh_config_comp_page_mv(struct mesh_config *cfg, uint8_t old, uint8_t nw);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
-						bool vendor, uint32_t mod_id,
+						uint32_t mod_id, bool vendor,
 							uint16_t app_idx);
 bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
-						bool vendor, uint32_t mod_id,
+						uint32_t mod_id, bool vendor,
 							uint16_t app_idx);
 bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
diff --git a/mesh/model.c b/mesh/model.c
index 136edb194..961391f13 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -659,7 +659,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		model_unbind_idx(node, ele_idx, mod, app_idx);
 
 		if (!mesh_config_model_binding_del(node_config_get(node),
-							addr, vendor, id,
+							addr, id, vendor,
 								app_idx))
 			return MESH_STATUS_STORAGE_FAIL;
 
@@ -671,7 +671,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return MESH_STATUS_INSUFF_RESOURCES;
 
 	if (!mesh_config_model_binding_add(node_config_get(node), addr,
-						vendor, id, app_idx))
+							id, vendor, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	model_bind_idx(node, ele_idx, mod, app_idx);
-- 
2.26.2

