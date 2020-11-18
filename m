Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57BC5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43227246A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKRT4I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:56:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:13507 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKRT4I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 14:56:08 -0500
IronPort-SDR: +r35S/HI0wVJeviWfe/DLi0PIUkicx580dMkgOw7lB7blCbiacLF52M/4lEKmuiqxlBMWmasgW
 vPUMncmKBA5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158948744"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="158948744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 11:56:08 -0800
IronPort-SDR: n8Y+mORac1lAG+K9sr6LJ3+l1CT4CTt18JzkMLXPSpxAClU+H+BJprA4lGSl1gkN3HOahM8w2C
 VwdMPANrsOgw==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="359628079"
Received: from sthakkar-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.4.203])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 11:56:07 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, sbrown@ewol.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix regression error in HB subscription set
Date:   Wed, 18 Nov 2020 11:56:00 -0800
Message-Id: <20201118195600.30267-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a regression introduced in commit c77bb848a9fb
("mesh: Refactor heartbeat pub/sub"):
Heartbeat subscription should be enabled unless either source or
destination are unassigned addresses or period log is zero.

Also, decrement ref count on group destination address if period log
is zer since the subscription is not supposed to be processed.
---
 mesh/net.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 9e0ea860f..b24cdba77 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3582,16 +3582,21 @@ int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
 		sub->max_hops = 0;
 
 	} else if (!period_log && src == sub->src && dst == sub->dst) {
+		if (IS_GROUP(sub->dst))
+			mesh_net_dst_unreg(net, sub->dst);
+
 		/* Preserve collected data, but disable */
 		sub->enabled = false;
 		sub->period = 0;
 
-	} else if (sub->dst != dst) {
-		if (IS_GROUP(sub->dst))
-			mesh_net_dst_unreg(net, sub->dst);
+	} else {
+		if (sub->dst != dst) {
+			if (IS_GROUP(sub->dst))
+				mesh_net_dst_unreg(net, sub->dst);
 
-		if (IS_GROUP(dst))
-			mesh_net_dst_reg(net, dst);
+			if (IS_GROUP(dst))
+				mesh_net_dst_reg(net, dst);
+		}
 
 		sub->enabled = !!period_log;
 		sub->src = src;
-- 
2.26.2

