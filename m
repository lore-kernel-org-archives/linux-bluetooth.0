Return-Path: <SRS0=nb/8=2C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EACCC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C322073B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfLLUAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:00:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:21205 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbfLLUAb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Dec 2019 15:00:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 12:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="211225327"
Received: from ingas-nuc1.sea.intel.com ([10.252.140.195])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2019 12:00:25 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix configuration update when deleting an AppKey
Date:   Thu, 12 Dec 2019 12:00:24 -0800
Message-Id: <20191212200024.2617-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an AppKey is deleted from a node, the configuration update
is sent to the element model only if the model was bound to this
AppKey.
---
 mesh/model.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index acdd94f7b..d998a9caa 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -650,7 +650,7 @@ static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_DELETE);
 
-	if (mod->pub && idx != mod->pub->idx)
+	if (!mod->pub || idx != mod->pub->idx)
 		return;
 
 	/* Remove model publication if the publication key is unbound */
@@ -1319,7 +1319,8 @@ void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 	for (; entry; entry = entry->next) {
 		struct mesh_model *model = entry->data;
 
-		model_unbind_idx(node, model, app_idx);
+		if (has_binding(model->bindings, app_idx))
+			model_unbind_idx(node, model, app_idx);
 	}
 }
 
-- 
2.21.0

