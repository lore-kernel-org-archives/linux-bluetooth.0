Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7977C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D011206A1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgKJEZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:25:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:30018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKJEZA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 23:25:00 -0500
IronPort-SDR: 0f8+j8lTyb2Ca3Bhddbi2zAg183HxtGkx+jc6nkFgEnXwgC1vgnEDpGHRAeRcZmKpgye1/lL3s
 burzti/RHCSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="156921795"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="156921795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:24:58 -0800
IronPort-SDR: mU4GhWXcxocwWxUI7GnzkxIvAUQ/l37/VYDKP0pDKGuDXsVBfx+VUxC9Ak6x4Kgwn2i6YFdPw7
 wAinwgtgkDEw==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="308244492"
Received: from weidongc-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.212.33.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:24:58 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix memory leak when failing to load a node
Date:   Mon,  9 Nov 2020 20:24:51 -0800
Message-Id: <20201110042451.71288-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a memory leak that may occur on unsuccessful element
initialization from storage.
---
 mesh/node.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 11b0c9442..35293e0f0 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -326,16 +326,13 @@ static bool add_element_from_storage(struct mesh_node *node,
 
 	ele->idx = db_ele->index;
 	ele->location = db_ele->location;
-
-
-	if (!ele->models)
-		ele->models = l_queue_new();
+	ele->models = l_queue_new();
+	l_queue_push_tail(node->elements, ele);
 
 	if (!mesh_model_add_from_storage(node, ele->idx, ele->models,
 							db_ele->models))
 		return false;
 
-	l_queue_push_tail(node->elements, ele);
 	return true;
 }
 
-- 
2.26.2

