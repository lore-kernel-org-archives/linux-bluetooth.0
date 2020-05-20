Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4797C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C70A206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 15:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETPgB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 11:36:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:33642 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgETPgB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 11:36:01 -0400
IronPort-SDR: D8GrsD+/FAS8QrRszQNrYwGcIUnEzzK3YJl0rITx9DR11Tbv1DIIbo0rA3BjfyqtcRHEFpBgJB
 GkJoMAlX3+rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 08:36:00 -0700
IronPort-SDR: /zcSv6fGfKPVzwpra0ki8mdROVG3LqkqOEo+h/YnCb4BM1YWTcj3sSboZqIn890v0fRu+4HYK9
 xG1CKG7b28cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="253642451"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.66.90])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2020 08:36:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: Fix double-free
Date:   Wed, 20 May 2020 08:35:51 -0700
Message-Id: <20200520153551.832644-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixing a prior memory leak created a double-free error when destroying
the NVM sorage of a node. We have two situations where we want to
discard a nodes dytnamic memory:

1. When the node is being deleted at runtime.  This causes release of
   both dynamic memory and NVM storage.

2. During shutdown, we release dynamic memory only.

This patch ensures that after node deletion releases dynamic memory,
the pointers to it are cleared, avoiding a second free attempt.
---
 mesh/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index 2b4b3a563..03f4d342b 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -352,8 +352,10 @@ void node_remove(struct mesh_node *node)
 
 	l_queue_remove(nodes, node);
 
-	if (node->cfg)
+	if (node->cfg) {
 		mesh_config_destroy(node->cfg);
+		node->cfg = NULL;
+	}
 
 	free_node_resources(node);
 }
-- 
2.25.4

