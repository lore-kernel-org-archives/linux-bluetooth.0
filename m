Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC59C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FA12071B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGOPd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:15051 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgGOPd4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:56 -0400
IronPort-SDR: Ew9cDXoe8RIC35gWL4WgkZSouaKRwvKeaRkRxPL8bOep1Jt72xp5YB4zT8E/9NZNjTDws4VguC
 1By4zNBhZkCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="213933017"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="213933017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 08:33:56 -0700
IronPort-SDR: eQNlUEQMvMT1f+o2OMUIG0wx6IhBgNeVLv2KscmeswGVw/K/CO2LO8vHo2kHXD7sWghoyPdzSR
 NqfsoUCCQaPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="324861575"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.11.134])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2020 08:33:55 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: Fix node composition change detection
Date:   Wed, 15 Jul 2020 08:33:43 -0700
Message-Id: <20200715153343.2115695-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a bug that caused disallowed composition changes from being
detected and rejected. The only fields that are allowed to freely change
are CID, PID, VID and CRPL.
---
 mesh/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index c61167bda..9b97aa927 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1579,7 +1579,7 @@ static bool check_req_node(struct managed_obj_request *req)
 		node = req->node;
 
 	node_comp = node_get_comp(node, 0, &node_len);
-	len = node_generate_comp(node, comp, sizeof(comp));
+	len = node_generate_comp(req->node, comp, sizeof(comp));
 
 	/* If no page 0 exists, save it and return */
 	if (req->type != REQUEST_TYPE_ATTACH || !node_len || !node_comp)
-- 
2.25.4

