Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8090C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BE0206DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgHKRS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:18:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:29208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbgHKRS4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 13:18:56 -0400
IronPort-SDR: FTTwAgxCnOHpAmwMo30QWOxkJETx7NmEx0hUjvdGx0FJjBFntMZEY6LBUU0g9lvMJ+QfKcHTKF
 N5/iPvoGq7bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133316706"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133316706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 10:18:56 -0700
IronPort-SDR: fWSOwbyptCKZ1TxnwTe4+YxCJ6GcdyzbB5VEqmPjOv3P/vgKyTqShCyxa8rOE6YACOcAlHvuQt
 e3JK3tZShC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="369010868"
Received: from rajkumar-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.82.230])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2020 10:18:55 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix logic error when saving model subscriptions
Date:   Tue, 11 Aug 2020 10:18:55 -0700
Message-Id: <20200811171855.13189-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes opcode check condition when saving configuration for model
subscriptions: use || instead of && for opcode checking
---
 mesh/cfgmod-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index d31c8d99f..9da981700 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -211,7 +211,7 @@ static bool save_cfg_sub(struct mesh_node *node, uint16_t ele_addr,
 	if (virt)
 		memcpy(db_sub.addr.label, label, 16);
 
-	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
+	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_DELETE ||
 			opcode == OP_CONFIG_MODEL_SUB_DELETE)
 		return mesh_config_model_sub_del(cfg, ele_addr, id, vendor,
 								&db_sub);
-- 
2.26.2

