Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E4C10F0B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 04:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266792184B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 04:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfDREde (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:33:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:41340 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfDREde (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 00:33:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 21:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; 
   d="scan'208";a="141627815"
Received: from ingas-nuc1.sea.intel.com ([10.252.198.132])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2019 21:33:33 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix the cleanup of failed Join call
Date:   Wed, 17 Apr 2019 21:33:32 -0700
Message-Id: <20190418043332.19126-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the accidental swap of conditional checks: on failure,
remove agent info if agent is registered and remove temporary node,
if one has been created.
---
 mesh/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index dae9a4b79..5431a9e9c 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1474,10 +1474,10 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 	return;
 fail:
 	if (agent)
-		free_node_resources(node);
+		mesh_agent_remove(agent);
 
 	if (node)
-		mesh_agent_remove(agent);
+		free_node_resources(node);
 
 	req->cb(NULL, NULL);
 }
-- 
2.17.2

