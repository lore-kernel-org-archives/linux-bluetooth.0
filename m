Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E112C6369E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 21:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B7E21D91
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLBVMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 16:12:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:9068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgLBVMl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 16:12:41 -0500
IronPort-SDR: L1F//j1v1vWDKX8FxH1gNERjCiAOyikmZeHP8AMjkoVCo9NdQ3VqxwQpsFIZI6yc1nhos0LfVr
 KW1qUpbBMh4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173186303"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173186303"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:11:57 -0800
IronPort-SDR: 64fy4yOhYolfE2hb+jmY4ooTij8r15dyzcb0TI7qGpKV8OTY/eHFl8NuXF8JcRizRkvARjbzlE
 AU+RsMtGEgkw==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550216040"
Received: from kmwatson-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.153.10])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 13:11:57 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Zero out config node struct before initializing
Date:   Wed,  2 Dec 2020 13:11:51 -0800
Message-Id: <20201202211151.148651-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This memsets all the fields of mesh_db_node to zero prior to intializing
some fields in mesh_config_node struct and creating a brand new node
configuration. Just a precaution against having uninitialized items.
---
 mesh/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 35293e0f0..4bc11309b 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -856,6 +856,8 @@ static void convert_node_to_storage(struct mesh_node *node,
 {
 	const struct l_queue_entry *entry;
 
+	memset(db_node, 0, sizeof(struct mesh_config_node));
+
 	db_node->cid = node->comp.cid;
 	db_node->pid = node->comp.pid;
 	db_node->vid = node->comp.vid;
-- 
2.26.2

