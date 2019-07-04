Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A100C0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233992189E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 17:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfGDRgI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:36:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:9590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfGDRgI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 13:36:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 10:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="247988735"
Received: from amruthas-mobl2.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.89.41])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2019 10:36:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Fix segmentation fault when removing a node
Date:   Thu,  4 Jul 2019 10:36:06 -0700
Message-Id: <20190704173606.21793-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a segmentation fault introduced by earlier changes.
Segmentation fault was used by accessing a queu that has been
destroyed, but the corresponding pointer hasn't been set to NULL.
---
 mesh/node.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index ad94d885c..8e9da8988 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -260,12 +260,16 @@ static void free_node_resources(void *data)
 	/* Unregister io callbacks */
 	if (node->net)
 		mesh_net_detach(node->net);
+
 	mesh_net_free(node->net);
+	node->net = NULL;
 
 	l_queue_destroy(node->elements, element_free);
-	l_free(node->comp);
+	node->elements = NULL;
 
 	free_node_dbus_resources(node);
+
+	l_free(node->comp);
 	l_free(node);
 }
 
-- 
2.21.0

