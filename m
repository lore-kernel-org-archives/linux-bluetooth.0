Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E151C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0483320838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHLTDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:03:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:7248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgHLTDT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 15:03:19 -0400
IronPort-SDR: xiFcWE0lHd+xYdGqEbn5TJPFULxUYdXZmZqV1Ng7xueaLnav29dqs6279TlyJISC/As/n/iEy4
 EF2BNpXgYduQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141885366"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="141885366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 12:03:18 -0700
IronPort-SDR: 5zmocYRBpVxRPPJJOx4wq4wTO2vnEA+HtzanBpcTTwi9pNkLpBvHZP/QM7SFeK3P0sHG1PDE+D
 qz73AgfLYUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="295161208"
Received: from vsriva1-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.229.126])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2020 12:03:18 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Fix model ID prior to calling mesh config functions
Date:   Wed, 12 Aug 2020 12:03:16 -0700
Message-Id: <20200812190317.102140-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Model IDs for SIG defined models need to be stripped off SIG_VENDOR
value used for internal housekeeping prior to calling functions
that save new model state in node configuration.

Also, remove duplicate statements for model lookup in node config.
---
 mesh/mesh-config-json.c |  7 +------
 mesh/model.c            | 12 ++++++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index a40f92c01..086d618b1 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -169,11 +169,6 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	size_t len;
 	char buf[9];
 
-	if (!vendor)
-		snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
-	else
-		snprintf(buf, 9, "%8.8x", mod_id);
-
 	if (!json_object_object_get_ex(jnode, "elements", &jelements))
 		return NULL;
 
@@ -189,7 +184,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 		return NULL;
 
 	if (!vendor) {
-		snprintf(buf, 5, "%4.4x", mod_id);
+		snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
 		len = 4;
 	} else {
 		snprintf(buf, 9, "%8.8x", mod_id);
diff --git a/mesh/model.c b/mesh/model.c
index 23afb93a8..136edb194 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -628,6 +628,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind)
 {
 	struct mesh_model *mod;
+	bool vendor;
 	int ele_idx = node_get_element_idx(node, addr);
 
 	if (ele_idx < 0)
@@ -651,11 +652,15 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (unbind ^ has_binding(mod->bindings, app_idx))
 		return MESH_STATUS_SUCCESS;
 
+	vendor = IS_VENDOR(id);
+	id = vendor ? id : MODEL_ID(id);
+
 	if (unbind) {
 		model_unbind_idx(node, ele_idx, mod, app_idx);
+
 		if (!mesh_config_model_binding_del(node_config_get(node),
-							addr, IS_VENDOR(id),
-							id, app_idx))
+							addr, vendor, id,
+								app_idx))
 			return MESH_STATUS_STORAGE_FAIL;
 
 		l_debug("Unbind key %4.4x to model %8.8x", app_idx, mod->id);
@@ -666,13 +671,12 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return MESH_STATUS_INSUFF_RESOURCES;
 
 	if (!mesh_config_model_binding_add(node_config_get(node), addr,
-						IS_VENDOR(id), id, app_idx))
+						vendor, id, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	model_bind_idx(node, ele_idx, mod, app_idx);
 
 	return MESH_STATUS_SUCCESS;
-
 }
 
 static struct mesh_virtual *add_virtual(const uint8_t *v)
-- 
2.26.2

