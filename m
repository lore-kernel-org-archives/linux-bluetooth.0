Return-Path: <SRS0=/BwN=SY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFEC10F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B301720859
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Apr 2019 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfDVPZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:25:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:54228 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfDVPZ5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Apr 2019 11:25:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 08:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="166831812"
Received: from ingas-nuc1.sea.intel.com ([10.251.133.14])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2019 08:25:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix structure memeber initialization
Date:   Mon, 22 Apr 2019 08:25:55 -0700
Message-Id: <20190422152555.5072-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes incorrectly reversed assignment of "friend" value in
convert_node_to_storage()
---
 mesh/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index e7016ce75..157991dad 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1297,7 +1297,7 @@ static void convert_node_to_storage(struct mesh_node *node,
 
 	memcpy(db_node->uuid, node->dev_uuid, 16);
 
-	node->friend = db_node->modes.friend;
+	db_node->modes.friend = node->friend;
 	db_node->modes.relay.state = node->relay.mode;
 	db_node->modes.relay.cnt = node->relay.cnt;
 	db_node->modes.relay.interval = node->relay.interval;
-- 
2.17.2

