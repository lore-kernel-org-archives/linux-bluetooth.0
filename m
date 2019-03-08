Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56960C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5542081B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCHW4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:56:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:41032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfCHW4k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:56:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="281069792"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2019 14:56:39 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Set node ID for a newly provisioned node
Date:   Fri,  8 Mar 2019 14:56:34 -0800
Message-Id: <20190308225634.20351-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a new node is created after successful provisioning, a 4-digit
hex node id needs to be generated and preserved.
---
 mesh/storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mesh/storage.c b/mesh/storage.c
index fe3102fba..e84c2c933 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -546,6 +546,8 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	if (num_tries == 10)
 		l_error("Failed to generate unique node ID");
 
+	node_id_set(node, node_id);
+
 	snprintf(name_buf, PATH_MAX, "%s/%04x", storage_dir, node_id);
 
 	/* Create a new directory and node.json file */
-- 
2.17.2

