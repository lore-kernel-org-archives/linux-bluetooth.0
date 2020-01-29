Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB06C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2E2071E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgA2RR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:17:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:29275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgA2RR6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 12:17:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 09:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="314907870"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.84.27])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 09:17:56 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Re-arrange replay protection check and add
Date:   Wed, 29 Jan 2020 09:17:50 -0800
Message-Id: <20200129171750.6456-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Re-arranged for efficientcy. Replay Protection was set up as an atomic
check-and-add operation. Now we check the message early so we can
discard it without taking further action, and only add it to the RPL
once fully verified that it was authorized and addressed to us.
---
 mesh/model.c | 23 +++++++++----------
 mesh/net.c   | 62 ++++++++++++++++++++++++++--------------------------
 mesh/net.h   |  7 +++---
 3 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 92a00496c..574b6621a 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -964,10 +964,12 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		/* Unicast and not addressed to us */
 		return false;
 
-	clear_text = l_malloc(size);
-	if (!clear_text)
+	/* Don't process if already in RPL */
+	crpl = node_get_crpl(node);
+	if (net_msg_check_replay_cache(net, src, crpl, seq, iv_index))
 		return false;
 
+	clear_text = l_malloc(size);
 	forward.data = clear_text;
 
 	/*
@@ -995,16 +997,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		goto done;
 	}
 
-	/* print_packet("Clr Rx (pre-cache-check)", clear_text, size - 4); */
-
-	crpl = node_get_crpl(node);
-
-	if (net_msg_in_replay_cache(net, (uint16_t) decrypt_idx, src,
-				crpl, seq, iv_index)) {
-		result = true;
-		goto done;
-	}
-
 	print_packet("Clr Rx", clear_text, size - (szmict ? 8 : 4));
 
 	forward.virt = decrypt_virt;
@@ -1073,7 +1065,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		 * Either the message has been processed internally or
 		 * has been passed on to an external model.
 		 */
-		result = forward.has_dst | forward.done;
+		result |= forward.has_dst | forward.done;
 
 		/* If the message was to unicast address, we are done */
 		if (!is_subscription && ele_idx == i)
@@ -1088,8 +1080,13 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			break;
 	}
 
+	/* If this message handlable by us, add to RPL */
+	if (result)
+		net_msg_add_replay_cache(net, src, seq, iv_index);
+
 done:
 	l_free(clear_text);
+
 	return result;
 }
 
diff --git a/mesh/net.c b/mesh/net.c
index 19f3b87b7..d85df63da 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3759,9 +3759,8 @@ static bool clean_old_iv_index(void *a, void *b)
 	return false;
 }
 
-bool net_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
-				uint16_t src, uint16_t crpl, uint32_t seq,
-				uint32_t iv_index)
+bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
+				uint16_t crpl, uint32_t seq, uint32_t iv_index)
 {
 	struct mesh_rpl *rpe;
 
@@ -3782,49 +3781,50 @@ bool net_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
 						L_UINT_TO_PTR(src));
 
 	if (rpe) {
-		if (iv_index > rpe->iv_index) {
-			rpe->seq = seq;
-			rpe->iv_index = iv_index;
-			rpl_put_entry(net->node, src, iv_index, seq);
+		if (iv_index > rpe->iv_index)
 			return false;
-		}
-
-		if (seq < rpe->seq) {
-			l_debug("Ignoring packet with lower sequence number");
-			return true;
-		}
 
-		if (seq == rpe->seq) {
-			l_debug("Message already processed (duplicate)");
+		/* return true if (iv_index | seq) too low */
+		if (iv_index < rpe->iv_index || seq <= rpe->seq) {
+			l_debug("Ignoring replayed packet");
 			return true;
 		}
-
-		rpe->seq = seq;
-
-		rpl_put_entry(net->node, src, iv_index, seq);
-
-		return false;
 	}
 
-	l_debug("New Entry for %4.4x", src);
-
-	/* Replay Cache is fixed sized */
-	if (l_queue_length(net->replay_cache) >= crpl) {
+	/* SRC not in Replay Cache... see if there is space for it */
+	else if (l_queue_length(net->replay_cache) >= crpl) {
 		int ret = l_queue_foreach_remove(net->replay_cache,
 				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
 
+		/* Return true if no space could be freed */
 		if (!ret)
 			return true;
 	}
 
-	if (!rpl_put_entry(net->node, src, iv_index, seq))
-		return true;
+	return false;
+}
+
+void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
+							uint32_t iv_index)
+{
+	struct mesh_rpl *rpe;
+
+	if (!net || !net->node || !net->replay_cache)
+		return;
+
+	rpe = l_queue_remove_if(net->replay_cache, match_replay_cache,
+						L_UINT_TO_PTR(src));
+
+	if (!rpe) {
+		l_debug("New Entry for %4.4x", src);
+		rpe = l_new(struct mesh_rpl, 1);
+		rpe->seq = src;
+	}
 
-	rpe = l_new(struct mesh_rpl, 1);
-	rpe->src = src;
 	rpe->seq = seq;
 	rpe->iv_index = iv_index;
-	l_queue_push_head(net->replay_cache, rpe);
+	rpl_put_entry(net->node, src, iv_index, seq);
 
-	return false;
+	/* Optimize so that most recent conversations stay earliest in cache */
+	l_queue_push_head(net->replay_cache, rpe);
 }
diff --git a/mesh/net.h b/mesh/net.h
index ff0a9bb2b..6fedd69d7 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -379,6 +379,7 @@ void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
 uint32_t mesh_net_get_instant(struct mesh_net *net);
 struct l_queue *mesh_net_get_friends(struct mesh_net *net);
 struct l_queue *mesh_net_get_negotiations(struct mesh_net *net);
-bool net_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
-				uint16_t src, uint16_t crpl, uint32_t seq,
-				uint32_t iv_index);
+bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
+				uint16_t crpl, uint32_t seq, uint32_t iv_index);
+void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
+							uint32_t iv_index);
-- 
2.21.1

