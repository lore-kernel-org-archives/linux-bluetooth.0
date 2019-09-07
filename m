Return-Path: <SRS0=PJow=XC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2489C43331
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Sep 2019 00:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADDD20854
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Sep 2019 00:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIGARc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:17:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:32989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfIGARb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 20:17:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 17:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="188476220"
Received: from ppan-mobl1.gar.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.251.132.218])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2019 17:17:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Handle messages sent to a fixed group address
Date:   Fri,  6 Sep 2019 17:17:29 -0700
Message-Id: <20190907001729.15839-1-inga.stotland@intel.com>
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
 mesh/mesh-defs.h |  2 ++
 mesh/model.c     | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 1219e4939..885c30d3e 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -118,4 +118,6 @@
 #define IS_GROUP(x)		((((x) >= GROUP_ADDRESS_LOW) && \
 					((x) < FIXED_GROUP_HIGH)) || \
 					((x) == ALL_NODES_ADDRESS))
+
+#define IS_FIXED_GROUP_ADDRESS(x)	((x) == PROXIES_ADDRESS)
 #define IS_ALL_NODES(x)	((x) == ALL_NODES_ADDRESS)
diff --git a/mesh/model.c b/mesh/model.c
index 8f3d67ecf..8fe6378b3 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -311,7 +311,7 @@ static void forward_model(void *a, void *b)
 		return;
 
 	dst = fwd->dst;
-	if (dst == fwd->unicast || IS_ALL_NODES(dst))
+	if (dst == fwd->unicast || IS_FIXED_GROUP_ADDRESS(dst))
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
+		if (IS_FIXED_GROUP_ADDRESS(dst))
+			break;
 	}
 
 done:
-- 
2.21.0

