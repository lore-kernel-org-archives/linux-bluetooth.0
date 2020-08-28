Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F2C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A36020936
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgH1UEm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:04:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:35423 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1UEk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 16:04:40 -0400
IronPort-SDR: MXRM1HxNzt2jlapkcnWQXX7ODTRbDQcTT4jqmrcFNBGTbJkkx+kQMr7ySgoB4zW+EWzNhg34rM
 pqAHoEXy49Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136799288"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="136799288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:04:30 -0700
IronPort-SDR: eYyBL7er4G4WYJlpixS1TOWwRHpDhdzSWif4O0aVCmYTAZ5c1cbP3RgpSY3RWMHn+pVlu7Dv3Q
 i0reR4MjUexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300345429"
Received: from rbuaba-mobl2.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.83.122])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2020 13:04:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Move RPL check from model to net layer
Date:   Fri, 28 Aug 2020 13:04:27 -0700
Message-Id: <20200828200427.18753-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828200427.18753-1-inga.stotland@intel.com>
References: <20200828200427.18753-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check whether an incoming message has an RPL entry prior to
handing it over to model layer for processing. If present in RPL
or the RPL queue is full, ignore the incoming message.

If the incoming message is processed successfully, add the message
as a new RPL entry.
---
 mesh/model.c |  18 ++---
 mesh/model.h |   6 +-
 mesh/net.c   | 184 +++++++++++++++++++++++++++------------------------
 mesh/net.h   |   4 --
 4 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 7bbc9cca7..ed2a75215 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -862,9 +862,9 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-			uint32_t seq, uint32_t iv_index,
-			uint16_t net_idx, uint16_t src, uint16_t dst,
-			uint8_t key_aid, const uint8_t *data, uint16_t size)
+			uint32_t iv_index, uint16_t net_idx, uint16_t src,
+			uint16_t dst, uint8_t key_aid, const uint8_t *data,
+								uint16_t size)
 {
 	uint8_t *clear_text;
 	struct mod_forward forward = {
@@ -877,7 +877,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	struct mesh_net *net = node_get_net(node);
 	uint8_t num_ele;
 	int decrypt_idx, i, ele_idx;
-	uint16_t addr, crpl;
+	uint16_t addr;
 	struct mesh_virtual *decrypt_virt = NULL;
 	bool result = false;
 	bool is_subscription;
@@ -892,12 +892,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		/* Unicast and not addressed to us */
 		return false;
 
-	/* Don't process if already in RPL */
-	crpl = node_get_crpl(node);
-
-	if (net_msg_check_replay_cache(net, src, crpl, seq, iv_index))
-		return false;
-
 	clear_text = l_malloc(size);
 	forward.data = clear_text;
 
@@ -988,10 +982,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			break;
 	}
 
-	/* If message has been handled by us, add to RPL */
-	if (result)
-		net_msg_add_replay_cache(net, src, seq, iv_index);
-
 done:
 	l_free(clear_text);
 
diff --git a/mesh/model.h b/mesh/model.h
index fe0648d04..2eec761a0 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -117,9 +117,9 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 			bool segmented, uint16_t len, const void *data);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
-			uint16_t src, uint16_t dst, uint8_t key_aid,
-			const uint8_t *data, uint16_t size);
+			uint32_t iv_index, uint16_t net_idx, uint16_t src,
+			uint16_t dst, uint8_t key_aid, const uint8_t *data,
+								uint16_t size);
 void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
 				struct l_queue *models, uint16_t app_idx);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
diff --git a/mesh/net.c b/mesh/net.c
index 83647d6ad..6c7311732 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1621,6 +1621,91 @@ static void outseg_to(struct l_timeout *seg_timeout, void *user_data)
 					sar->seqZero, sar->last_nak);
 }
 
+static bool match_replay_cache(const void *a, const void *b)
+{
+	const struct mesh_rpl *rpe = a;
+	uint16_t src = L_PTR_TO_UINT(b);
+
+	return src == rpe->src;
+}
+
+static bool clean_old_iv_index(void *a, void *b)
+{
+	struct mesh_rpl *rpe = a;
+	uint32_t iv_index = L_PTR_TO_UINT(b);
+
+	if (iv_index < 2)
+		return false;
+
+	if (rpe->iv_index < iv_index - 1) {
+		l_free(rpe);
+		return true;
+	}
+
+	return false;
+}
+
+static bool msg_check_replay_cache(struct mesh_net *net, uint16_t src,
+				uint16_t crpl, uint32_t seq, uint32_t iv_index)
+{
+	struct mesh_rpl *rpe;
+
+	/* If anything missing reject this message by returning true */
+	if (!net || !net->node)
+		return true;
+
+	rpe = l_queue_find(net->replay_cache, match_replay_cache,
+						L_UINT_TO_PTR(src));
+
+	if (rpe) {
+		if (iv_index > rpe->iv_index)
+			return false;
+
+		/* Return true if (iv_index | seq) too low */
+		if (iv_index < rpe->iv_index || seq <= rpe->seq) {
+			l_debug("Ignoring replayed packet");
+			return true;
+		}
+	} else if (l_queue_length(net->replay_cache) >= crpl) {
+		/* SRC not in Replay Cache... see if there is space for it */
+
+		int ret = l_queue_foreach_remove(net->replay_cache,
+				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
+
+		/* Return true if no space could be freed */
+		if (!ret) {
+			l_debug("Replay cache full");
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void msg_add_replay_cache(struct mesh_net *net, uint16_t src,
+						uint32_t seq, uint32_t iv_index)
+{
+	struct mesh_rpl *rpe;
+
+	if (!net || !net->replay_cache)
+		return;
+
+	rpe = l_queue_remove_if(net->replay_cache, match_replay_cache,
+						L_UINT_TO_PTR(src));
+
+	if (!rpe) {
+		rpe = l_new(struct mesh_rpl, 1);
+		rpe->src = src;
+	}
+
+	rpe->seq = seq;
+	rpe->iv_index = iv_index;
+	rpl_put_entry(net->node, src, iv_index, seq);
+
+	/* Optimize so that most recent conversations stay earliest in cache */
+	l_queue_push_head(net->replay_cache, rpe);
+}
+
 static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 					uint8_t ttl, uint32_t seq,
 					uint16_t net_idx,
@@ -1630,6 +1715,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 					const uint8_t *data, uint16_t size)
 {
 	uint32_t seqAuth = seq_auth(seq, seqZero);
+	uint16_t crpl;
 
 	/* Sanity check seqAuth */
 	if (seqAuth > seq)
@@ -1671,8 +1757,19 @@ not_for_friend:
 	if (dst == PROXIES_ADDRESS && !net->proxy_enable)
 		return false;
 
-	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index, net_idx,
-						src, dst, key_aid, data, size);
+	/* Don't process if already in RPL */
+	crpl = node_get_crpl(net->node);
+
+	if (msg_check_replay_cache(net, src, crpl, seq, iv_index))
+		return false;
+
+	if (!mesh_model_rx(net->node, szmic, seqAuth, iv_index, net_idx, src,
+						dst, key_aid, data, size))
+		return false;
+
+	/* If message has been handled by us, add to RPL */
+	msg_add_replay_cache(net, src, seq, iv_index);
+	return true;
 }
 
 static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
@@ -3448,89 +3545,6 @@ uint32_t mesh_net_get_instant(struct mesh_net *net)
 	return net->instant;
 }
 
-static bool match_replay_cache(const void *a, const void *b)
-{
-	const struct mesh_rpl *rpe = a;
-	uint16_t src = L_PTR_TO_UINT(b);
-
-	return src == rpe->src;
-}
-
-static bool clean_old_iv_index(void *a, void *b)
-{
-	struct mesh_rpl *rpe = a;
-	uint32_t iv_index = L_PTR_TO_UINT(b);
-
-	if (iv_index < 2)
-		return false;
-
-	if (rpe->iv_index < iv_index - 1) {
-		l_free(rpe);
-		return true;
-	}
-
-	return false;
-}
-
-bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
-				uint16_t crpl, uint32_t seq, uint32_t iv_index)
-{
-	struct mesh_rpl *rpe;
-
-	/* If anything missing reject this message by returning true */
-	if (!net || !net->node)
-		return true;
-
-	rpe = l_queue_find(net->replay_cache, match_replay_cache,
-						L_UINT_TO_PTR(src));
-
-	if (rpe) {
-		if (iv_index > rpe->iv_index)
-			return false;
-
-		/* Return true if (iv_index | seq) too low */
-		if (iv_index < rpe->iv_index || seq <= rpe->seq) {
-			l_debug("Ignoring replayed packet");
-			return true;
-		}
-	} else if (l_queue_length(net->replay_cache) >= crpl) {
-		/* SRC not in Replay Cache... see if there is space for it */
-
-		int ret = l_queue_foreach_remove(net->replay_cache,
-				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
-
-		/* Return true if no space could be freed */
-		if (!ret)
-			return true;
-	}
-
-	return false;
-}
-
-void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
-							uint32_t iv_index)
-{
-	struct mesh_rpl *rpe;
-
-	if (!net || !net->replay_cache)
-		return;
-
-	rpe = l_queue_remove_if(net->replay_cache, match_replay_cache,
-						L_UINT_TO_PTR(src));
-
-	if (!rpe) {
-		rpe = l_new(struct mesh_rpl, 1);
-		rpe->src = src;
-	}
-
-	rpe->seq = seq;
-	rpe->iv_index = iv_index;
-	rpl_put_entry(net->node, src, iv_index, seq);
-
-	/* Optimize so that most recent conversations stay earliest in cache */
-	l_queue_push_head(net->replay_cache, rpe);
-}
-
 static void hb_sub_timeout_func(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
diff --git a/mesh/net.h b/mesh/net.h
index 725054ce6..7bec6d0fc 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -354,8 +354,4 @@ void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
 uint32_t mesh_net_get_instant(struct mesh_net *net);
 struct l_queue *mesh_net_get_friends(struct mesh_net *net);
 struct l_queue *mesh_net_get_negotiations(struct mesh_net *net);
-bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
-				uint16_t crpl, uint32_t seq, uint32_t iv_index);
-void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
-							uint32_t iv_index);
 bool mesh_net_load_rpl(struct mesh_net *net);
-- 
2.26.2

