Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56CC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CED021852
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGCUxn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:53:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:8865 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfGCUxn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 16:53:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="166087470"
Received: from ingas-nuc1.sea.intel.com ([10.254.86.21])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2019 13:53:43 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Fix checks when restoring internal model state
Date:   Wed,  3 Jul 2019 13:53:41 -0700
Message-Id: <20190703205341.11065-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes incorrect conditional checks in restore_model_state()
which could lead to dereferencing a NULL pointer.

Wrong: if (l_queue_isempty(mod->bindings) || !mod->cbs->bind) ...
Fixed: if (!l_queue_isempty(mod->bindings) && cbs->bind) ...
---
 mesh/model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index a2b3e5c18..e4a7ba94e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1077,7 +1077,7 @@ static void restore_model_state(struct mesh_model *mod)
 	if (!cbs)
 		return;
 
-	if (l_queue_isempty(mod->bindings) || !mod->cbs->bind) {
+	if (!l_queue_isempty(mod->bindings) && cbs->bind) {
 		for (b = l_queue_get_entries(mod->bindings); b; b = b->next) {
 			if (cbs->bind(L_PTR_TO_UINT(b->data), ACTION_ADD) !=
 							MESH_STATUS_SUCCESS)
-- 
2.21.0

