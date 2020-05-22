Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D92C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797DA207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEVAfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:55683 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgEVAfE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:04 -0400
IronPort-SDR: 5YRl7PJrI5Wm5c4uxsyNQT2dq2h+Rqg9yLddL/MNAOcO1uZeQExGWZSMLov+7iwSJfRW9Q2QBx
 +TY+7o/1QL8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:04 -0700
IronPort-SDR: SFyqf/fHJwtvhvCzbPkQkIHNPYkrrIKp4ZuzqpTxwdOW+5O5VCFZvsusR+MwDLtmxv5ORgmK1/
 +EBhhmiKC+5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961665"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 03/10] mesh: Remove agent when freeing node's dynamic resources
Date:   Thu, 21 May 2020 17:34:54 -0700
Message-Id: <20200522003501.106165-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds clean up of node's agent instance when node's dynamic
resources are freed.
---
 mesh/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/node.c b/mesh/node.c
index d5e07ce7f..8ad77639e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -333,6 +333,7 @@ static void free_node_resources(void *data)
 	/* Free dynamic resources */
 	free_node_dbus_resources(node);
 	l_queue_destroy(node->elements, element_free);
+	mesh_agent_remove(node->agent);
 	mesh_config_release(node->cfg);
 	mesh_net_free(node->net);
 	l_free(node->storage_dir);
-- 
2.26.2

