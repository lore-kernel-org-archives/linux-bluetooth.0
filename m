Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABEBC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096B20820
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 02:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbfIFC6P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:58:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:50396 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfIFC6P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 22:58:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 19:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="383113379"
Received: from ingas-nuc1.sea.intel.com ([10.254.107.68])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2019 19:58:14 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Handle messages sent to a fixed group address
Date:   Thu,  5 Sep 2019 19:58:13 -0700
Message-Id: <20190906025813.5519-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This handles the case when an inbound message is addressed to
a fixed group, i.e., all-proxies, all-frineds, all-relays and
all-nodes. The message is delivered to a primary element only,
and, with the exception of all-nodes case, if the corresponding
feature is enabled on the node.
---
 mesh/model.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index 8f3d67ecf..a78f2bec7 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -311,7 +311,7 @@ static void forward_model(void *a, void *b)
 		return;
 
 	dst = fwd->dst;
-	if (dst == fwd->unicast || IS_ALL_NODES(dst))
+	if (dst == fwd->unicast || dst >= PROXIES_ADDRESS)
 		fwd->has_dst = true;
 	else if (fwd->virt) {
 		virt = l_queue_find(mod->virtuals, simple_match, fwd->virt);
@@ -886,8 +886,30 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	if (!num_ele || IS_UNASSIGNED(addr))
 		goto done;
 
+	/*
+	 * In case of fixed group  addresses check if the
+	 * corresponding mode is enabled.
+	 */
+	if (dst == PROXIES_ADDRESS &&
+			(node_proxy_mode_get(node) != MESH_MODE_ENABLED))
+		goto done;
+
+	if (dst == FRIENDS_ADDRESS &&
+			(node_friend_mode_get(node) != MESH_MODE_ENABLED))
+		goto done;
+
+	if (dst == RELAYS_ADDRESS) {
+		uint8_t cnt;
+		uint16_t interval;
+
+		if (node_relay_mode_get(node, &cnt, &interval) !=
+							MESH_MODE_ENABLED)
+			goto done;
+	}
+
 	is_subscription = !(IS_UNICAST(dst));
 
+
 	for (i = 0; i < num_ele; i++) {
 		struct l_queue *models;
 
@@ -927,6 +949,14 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		/* If the message was to unicast address, we are done */
 		if (!is_subscription && ele_idx == i)
 			break;
+
+		/*
+		 * For the fixed group addresses, i.e., all-proxies,
+		 * all-friends, all-relayes, all-nodes, the message is delivered
+		 * to a primary element only.
+		 */
+		if (dst >= PROXIES_ADDRESS)
+			break;
 	}
 
 done:
-- 
2.21.0

