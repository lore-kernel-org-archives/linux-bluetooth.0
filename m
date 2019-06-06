Return-Path: <SRS0=rXBD=UF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E4C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A326420717
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 01:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFFBSi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:18:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:54825 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfFFBSi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jun 2019 21:18:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:18:37 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.251.155.118])
  by orsmga003.jf.intel.com with ESMTP; 05 Jun 2019 18:18:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Clean up style
Date:   Wed,  5 Jun 2019 18:18:32 -0700
Message-Id: <20190606011832.18801-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606011832.18801-1-inga.stotland@intel.com>
References: <20190606011832.18801-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This cleans up some stylistic issues. Plus, don't check the return
value of l_new(): if memory allocation fails, the execution stops.
---
 mesh/model.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 90bb62db8..f29ad9af2 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -158,9 +158,7 @@ static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
 
 	model = l_queue_find(models, match_model_id, L_UINT_TO_PTR(id));
 
-	if (status)
-		*status = (model) ? MESH_STATUS_SUCCESS :
-						MESH_STATUS_INVALID_MODEL;
+	*status = (model) ? MESH_STATUS_SUCCESS : MESH_STATUS_INVALID_MODEL;
 
 	return model;
 }
@@ -605,10 +603,8 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 			*dst = l_get_le16(mod_addr);
 	}
 
-	if (b_virt) {
-		if (!mesh_crypto_virtual_addr(mod_addr, &grp))
-			return MESH_STATUS_STORAGE_FAIL;
-	}
+	if (b_virt && !mesh_crypto_virtual_addr(mod_addr, &grp))
+		return MESH_STATUS_STORAGE_FAIL;
 
 	/* If old publication was Virtual, remove it */
 	if (mod->pub && mod->pub->addr >= VIRTUAL_BASE) {
@@ -621,6 +617,7 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 	}
 
 	mod->pub = l_new(struct mesh_model_pub, 1);
+
 	if (b_virt) {
 		virt = l_queue_find(mesh_virtuals, find_virt_by_addr, mod_addr);
 		if (!virt) {
@@ -632,6 +629,7 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 		} else {
 			grp = virt->ota;
 		}
+
 		virt->ref_cnt++;
 		l_queue_push_head(mod->virtuals, virt);
 		mod->pub->addr = virt->id;
@@ -648,10 +646,9 @@ static int set_pub(struct mesh_model *mod, const uint8_t *mod_addr,
 		mod->pub = NULL;
 		/* Remove publication if Pub Addr is 0x0000 */
 	} else {
+
 		if (!mod->pub)
 			mod->pub = l_new(struct mesh_model_pub, 1);
-		if (!mod->pub)
-			return MESH_STATUS_STORAGE_FAIL;
 
 		mod->pub->credential = cred_flag;
 		mod->pub->idx = idx;
@@ -679,11 +676,13 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 			virt->id = virt_id_next++;
 			virt->ota = grp;
 			memcpy(virt->addr, group, sizeof(virt->addr));
+
 			if (!l_queue_push_head(mesh_virtuals, virt))
 				return MESH_STATUS_STORAGE_FAIL;
 		} else {
 			grp = virt->ota;
 		}
+
 		virt->ref_cnt++;
 		l_queue_push_head(mod->virtuals, virt);
 	} else {
@@ -1125,11 +1124,12 @@ bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
 					void *user_data)
 {
 	struct mesh_model *mod;
+	int status;
 
 	/* Internal models are always SIG models */
 	mod_id = VENDOR_ID_MASK | mod_id;
 
-	mod = get_model(node, ele_idx, mod_id, NULL);
+	mod = get_model(node, ele_idx, mod_id, &status);
 	if (!mod)
 		return false;
 
@@ -1206,6 +1206,7 @@ int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 			buf += 3;
 			n += 3;
 		}
+
 		i++;
 	}
 
@@ -1318,6 +1319,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 		struct mesh_net *net = node_get_net(node);
 
 		entry = l_queue_get_entries(subs);
+
 		for (; entry; entry = entry->next)
 			mesh_net_dst_unreg(net,
 					(uint16_t) L_PTR_TO_UINT(entry->data));
@@ -1376,6 +1378,7 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 		return fail;
 
 	entry = l_queue_get_entries(mod->subs);
+
 	for (; entry; entry = entry->next)
 		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
 
@@ -1548,8 +1551,6 @@ void mesh_model_add_virtual(struct mesh_node *node, const uint8_t *v)
 	}
 
 	virt = l_new(struct mesh_virtual, 1);
-	if (!virt)
-		return;
 
 	if (!mesh_crypto_virtual_addr(v, &virt->ota)) {
 		l_free(virt);
-- 
2.21.0

