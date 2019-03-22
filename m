Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE660C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 02:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B730C213F2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 02:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCVC0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:26:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:32849 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfCVC0M (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 22:26:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 19:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,255,1549958400"; 
   d="scan'208";a="154032353"
Received: from ingas-nuc1.sea.intel.com ([10.254.17.2])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 19:26:12 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix adding model app key binding
Date:   Thu, 21 Mar 2019 19:26:10 -0700
Message-Id: <20190322022610.5047-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the situation when a new app key binding is being
added to a model and the list of bindings does not exist yet.
If the list does not exist, it is created and the binding is
added to it.

Also, remove unnecessary memory alloc check when model subscriptions
are added.
---
 mesh/model.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 80c30edba..a632d80e1 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -522,6 +522,9 @@ static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
 static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 								uint16_t idx)
 {
+	if (!mod->bindings)
+		mod->bindings = l_queue_new();
+
 	l_queue_push_tail(mod->bindings, L_UINT_TO_PTR(idx));
 
 	l_debug("Add %4.4x to model %8.8x", idx, mod->id);
@@ -689,8 +692,6 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 
 	if (!mod->subs)
 		mod->subs = l_queue_new();
-	if (!mod->subs)
-		return MESH_STATUS_STORAGE_FAIL;
 
 	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp)))
 		/* Group already exists */
-- 
2.17.2

