Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95756C5B578
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745BB2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 23:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfF1XBr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:01:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:53752 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfF1XBp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 19:01:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 16:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="314271659"
Received: from ingas-nuc1.sea.intel.com ([10.252.196.161])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 16:01:45 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4 v3] mesh: Fix and clean up model publication code
Date:   Fri, 28 Jun 2019 16:01:41 -0700
Message-Id: <20190628230142.16367-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628230142.16367-1-inga.stotland@intel.com>
References: <20190628230142.16367-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds proper checks for model publication removal:
the publication is not virtual and the publication address is set to zero,
i.e., UNASSIGNED_ADDRESS.
Also removes double memory allocation for model publication and
miscellaneous redundancies.
---
 mesh/model.c | 62 ++++++++++++++++++++++------------------------------
 mesh/model.h |  2 +-
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 30932cff2..751384b7e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -593,7 +593,7 @@ static struct mesh_virtual *add_virtual(const uint8_t *v)
 	return virt;
 }
 
-static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
+static int set_pub(struct mesh_model *mod, const uint8_t *pub_addr,
 			uint16_t idx, bool cred_flag, uint8_t ttl,
 			uint8_t period, uint8_t retransmit, bool b_virt,
 			uint16_t *dst)
@@ -605,11 +605,11 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 		if (b_virt)
 			*dst = 0;
 		else
-			*dst = l_get_le16(mod_addr);
+			*dst = l_get_le16(pub_addr);
 	}
 
 	if (b_virt) {
-		virt = add_virtual(mod_addr);
+		virt = add_virtual(pub_addr);
 		if (!virt)
 			return MESH_STATUS_STORAGE_FAIL;
 
@@ -634,28 +634,18 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 		grp = virt->addr;
 		mod->pub->addr = virt->id;
 	} else {
-		grp = l_get_le16(mod_addr);
+		grp = l_get_le16(pub_addr);
 		mod->pub->addr = grp;
 	}
 
 	if (dst)
 		*dst = grp;
 
-	if (IS_UNASSIGNED(grp) && mod->pub) {
-		l_free(mod->pub);
-		mod->pub = NULL;
-		/* Remove publication if Pub Addr is 0x0000 */
-	} else {
-
-		if (!mod->pub)
-			mod->pub = l_new(struct mesh_model_pub, 1);
-
-		mod->pub->credential = cred_flag;
-		mod->pub->idx = idx;
-		mod->pub->ttl = ttl;
-		mod->pub->period = period;
-		mod->pub->retransmit = retransmit;
-	}
+	mod->pub->credential = cred_flag;
+	mod->pub->idx = idx;
+	mod->pub->ttl = ttl;
+	mod->pub->period = period;
+	mod->pub->retransmit = retransmit;
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -985,7 +975,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 }
 
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
+			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst)
 {
@@ -1002,28 +992,28 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!appkey_have_key(node_get_net(node), idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
-	status = set_pub(mod, mod_addr, idx, cred_flag, ttl, period, retransmit,
-								b_virt, dst);
-
-	if (status != MESH_STATUS_SUCCESS)
-		return status;
-
 	/*
 	 * If the publication address is set to unassigned address value,
 	 * remove the publication
 	 */
-	if (IS_UNASSIGNED(*dst))
+	if (!b_virt && IS_UNASSIGNED(l_get_le16(pub_addr))) {
 		remove_pub(node, mod);
-
-	/* Internal model, call registered callbacks */
-	if (mod->cbs && mod->cbs->pub) {
-		mod->cbs->pub(mod->pub);
 		return MESH_STATUS_SUCCESS;
 	}
 
-	/* External model */
-	config_update_model_pub_period(node, mod->ele_idx, id,
+	status = set_pub(mod, pub_addr, idx, cred_flag, ttl, period, retransmit,
+								b_virt, dst);
+
+	if (status != MESH_STATUS_SUCCESS)
+		return status;
+
+	if (!mod->cbs)
+		/* External model */
+		config_update_model_pub_period(node, mod->ele_idx, id,
 						pub_period_to_ms(period));
+	else
+		/* Internal model, call registered callbacks */
+		mod->cbs->pub(mod->pub);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -1373,6 +1363,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	struct mesh_db_model *db_mod = data;
 	struct mesh_model *mod;
 	struct mesh_net *net;
+	struct mesh_db_pub *pub = db_mod->pub;
 	uint32_t i;
 
 	if (db_mod->num_bindings > MAX_BINDINGS) {
@@ -1409,8 +1400,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	}
 
 	/* Add publication if present */
-	if (db_mod->pub) {
-		struct mesh_db_pub *pub = db_mod->pub;
+	if (pub && (pub->virt || !(IS_UNASSIGNED(pub->addr)))) {
 		uint8_t mod_addr[2];
 		uint8_t *pub_addr;
 		uint8_t retransmit = (pub->count << 5) +
@@ -1418,7 +1408,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 
 		/* Add publication */
 		l_put_le16(pub->addr, &mod_addr);
-		pub_addr = pub->virt ? pub->virt_addr : (uint8_t *) &mod_addr;
+		pub_addr = pub->virt ? pub->virt_addr : mod_addr;
 
 		if (set_pub(mod, pub_addr, pub->idx, pub->credential, pub->ttl,
 			pub->period, retransmit, pub->virt, NULL) !=
diff --git a/mesh/model.h b/mesh/model.h
index f0f97ee0b..a6951293f 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -95,7 +95,7 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
 				uint16_t addr, uint32_t mod_id, int *status);
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
+			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool b_virt, uint16_t *dst);
 
-- 
2.21.0

