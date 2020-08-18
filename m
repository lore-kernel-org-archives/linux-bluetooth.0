Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F3DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F7E20738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHRWWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:22:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:11540 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgHRWWL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:22:11 -0400
IronPort-SDR: aMZj5JUY3UsC/2JfIlu8ibibpx9T+ayS7VtzfdlNiu7zXs7k6arY0bbvP6ey0XzeXUzTc7O8SS
 SS1QH/IAqt1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152634886"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152634886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 15:22:10 -0700
IronPort-SDR: AiLF9XTtW+fawC+lhHeGYU2SJTHh3Ocy8weAUQD4AO9JTxWgmfCJBLul3D9uZRB2DcYn6yTEaD
 9Bv9UQC3a8sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="336764509"
Received: from ypeng18-mobl.ger.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.230.245])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2020 15:22:10 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Check for enabled modes when dst is fixed address
Date:   Tue, 18 Aug 2020 15:22:08 -0700
Message-Id: <20200818222208.50938-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818222208.50938-1-inga.stotland@intel.com>
References: <20200818222208.50938-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the check for incoming messages addressed to fixed addresses,
e.g. RELAY, PROXY, FRIEND. If the corresponding feature is not enabled,
the message is not processed.
---
 mesh/model.c | 21 ---------------------
 mesh/net.c   |  9 +++++++++
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 961391f13..b44e2f669 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -937,27 +937,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	if (!num_ele || IS_UNASSIGNED(addr))
 		goto done;
 
-	/*
-	 * In case of fixed group  addresses check if the
-	 * corresponding mode is enabled.
-	 */
-	if (dst == PROXIES_ADDRESS &&
-			(node_proxy_mode_get(node) != MESH_MODE_ENABLED))
-		goto done;
-
-	if (dst == FRIENDS_ADDRESS &&
-			(node_friend_mode_get(node) != MESH_MODE_ENABLED))
-		goto done;
-
-	if (dst == RELAYS_ADDRESS) {
-		uint8_t cnt;
-		uint16_t interval;
-
-		if (node_relay_mode_get(node, &cnt, &interval) !=
-							MESH_MODE_ENABLED)
-			goto done;
-	}
-
 	is_subscription = !(IS_UNICAST(dst));
 
 	for (i = 0; i < num_ele; i++) {
diff --git a/mesh/net.c b/mesh/net.c
index 26440b02d..115a76944 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1658,6 +1658,15 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	}
 
 not_for_friend:
+	if (dst == FRIENDS_ADDRESS && !net->friend_enable)
+		return false;
+
+	if (dst == RELAYS_ADDRESS && !net->relay.enable)
+		return false;
+
+	if (dst == PROXIES_ADDRESS && !net->proxy_enable)
+		return false;
+
 	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index, net_idx,
 						src, dst, key_aid, data, size);
 }
-- 
2.26.2

