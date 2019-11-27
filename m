Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82299C43215
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F242075C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfK0Vj5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:39:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:15294 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfK0Vj5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 16:39:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 13:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="207008664"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.135.67])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2019 13:39:55 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 2/2] mesh: Friendship clean-up and rewrite
Date:   Wed, 27 Nov 2019 13:39:39 -0800
Message-Id: <20191127213939.4526-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127213939.4526-1-brian.gix@intel.com>
References: <20191127213939.4526-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendship support re-written such that it can now support multiple
nodes (on multiple mesh networks) as friends to remote Low Power Nodes
(LPNs).  Validated to properly respond to Friend Requests when enabled,
and a hard coded Friend Queue size of 32 (FRND_CACHE_MAX).
---
 mesh/crypto.c |   4 +-
 mesh/friend.c | 610 ++++++++------------------------------------------
 mesh/friend.h |   7 +-
 mesh/net.c    | 305 ++++++++++++-------------
 mesh/net.h    |  31 ++-
 mesh/node.c   |   2 +-
 6 files changed, 263 insertions(+), 696 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 15ee6739d..8ea906ac9 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -699,7 +699,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	uint16_t this_dst;
 	bool is_segmented;
 
-	if (packet_len < 14)
+	if (packet_len < 10)
 		return false;
 
 	this_dst = l_get_be16(packet + 7);
@@ -730,7 +730,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 		uint8_t this_opcode = packet[9] & OPCODE_MASK;
 
 		if (cookie)
-			*cookie = l_get_be32(packet + 9);
+			*cookie = l_get_be32(packet + 2) ^ packet[6];
 
 		if (opcode)
 			*opcode = this_opcode;
diff --git a/mesh/friend.c b/mesh/friend.c
index da2772870..5f5f6f823 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -43,48 +43,32 @@
 
 /* Absolute maximum time to wait for LPN to choose us. */
 #define RESPONSE_POLL_DELAY	1300		/* 1.300  s */
-
 static uint8_t frnd_relay_window = FRND_RELAY_WINDOW;
 static uint8_t frnd_cache_size = FRND_CACHE_SIZE;
 static uint8_t frnd_sublist_size = FRND_SUB_LIST_SIZE;
-
-struct frnd_negotiation {
-	struct l_timeout	*timeout;
-	struct mesh_net		*net;
-	uint32_t		key_id;
-	uint32_t		poll_timeout;
-	uint16_t		low_power_node;
-	uint16_t		old_relay;
-	uint8_t			num_ele;
-	uint8_t			lp_cnt;
-	uint8_t			fn_cnt;
-	uint8_t			wrfrw;
-	uint8_t			receive_delay;
-	int8_t			rssi;
-	bool			clearing;
-};
-
-static struct l_queue *frnd_negotiations;
 static uint16_t counter;
+static struct l_queue *retired_lpns;
 
 static void response_timeout(struct l_timeout *timeout, void *user_data)
 {
-	struct frnd_negotiation *neg = user_data;
+	struct mesh_friend *neg = user_data;
+	struct l_queue *negotiations = mesh_net_get_negotiations(neg->net);
 
 	/* LPN did not choose us */
-	l_debug("Did not win negotiation for %4.4x", neg->low_power_node);
+	l_debug("Did not win negotiation for %4.4x", neg->lp_addr);
 
-	net_key_unref(neg->key_id);
-	l_queue_remove(frnd_negotiations, neg);
+	net_key_unref(neg->net_key_cur);
+	net_key_unref(neg->net_key_upd);
+	l_queue_remove(negotiations, neg);
 	l_timeout_remove(timeout);
 	l_free(neg);
 }
 
 static void response_delay(struct l_timeout *timeout, void *user_data)
 {
-	struct frnd_negotiation *neg = user_data;
-	uint16_t net_idx = mesh_net_get_primary_idx(neg->net);
-	uint32_t key_id;
+	struct mesh_friend *neg = user_data;
+	uint16_t net_idx = neg->net_idx;
+	uint32_t key_id, seq;
 	uint8_t msg[8];
 	uint16_t n = 0;
 	bool res;
@@ -96,10 +80,10 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	if (!res)
 		goto cleanup;
 
-	neg->key_id = net_key_frnd_add(key_id, neg->low_power_node,
+	neg->net_key_cur = net_key_frnd_add(key_id, neg->lp_addr,
 						mesh_net_get_address(neg->net),
 						neg->lp_cnt, counter);
-	if (!neg->key_id)
+	if (!neg->net_key_cur)
 		goto cleanup;
 
 	neg->fn_cnt = counter++;
@@ -108,13 +92,14 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	msg[n++] = frnd_relay_window;
 	msg[n++] = frnd_cache_size;
 	msg[n++] = frnd_sublist_size;
-	msg[n++] = neg->rssi;
+	msg[n++] = neg->u.negotiate.rssi;
 	l_put_be16(neg->fn_cnt, msg + n);
 	n += 2;
+	seq = mesh_net_next_seq_num(neg->net);
 	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
-	mesh_net_transport_send(neg->net, 0, true,
+	mesh_net_transport_send(neg->net, key_id, true,
 			mesh_net_get_iv_index(neg->net), 0,
-			0, 0, neg->low_power_node,
+			seq, 0, neg->lp_addr,
 			msg, n);
 
 	/* Offer expires in 1.3 seconds, which is the max time for LPN to
@@ -126,8 +111,9 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	return;
 
 cleanup:
-	net_key_unref(neg->key_id);
-	l_queue_remove(frnd_negotiations, neg);
+	net_key_unref(neg->net_key_cur);
+	net_key_unref(neg->net_key_upd);
+	l_queue_remove(mesh_net_get_negotiations(neg->net), neg);
 	l_free(neg);
 }
 
@@ -138,18 +124,10 @@ static uint8_t cache_size(uint8_t power)
 
 static bool match_by_lpn(const void *a, const void *b)
 {
-	const struct frnd_negotiation *neg = a;
+	const struct mesh_friend *neg = a;
 	uint16_t lpn = L_PTR_TO_UINT(b);
 
-	return neg->low_power_node == lpn;
-}
-
-static bool match_by_dst(const void *a, const void *b)
-{
-	const struct mesh_friend *frnd = a;
-	uint16_t dst = L_PTR_TO_UINT(b);
-
-	return frnd->dst == dst;
+	return neg->lp_addr == lpn;
 }
 
 /* Scaling factors in 1/10 ms */
@@ -160,12 +138,13 @@ static const int32_t scaling[] = {
 	15,
 };
 
-void friend_request(struct mesh_net *net, uint16_t src,
+void friend_request(struct mesh_net *net, uint16_t net_idx, uint16_t src,
 		uint8_t minReq, uint8_t delay, uint32_t timeout,
 		uint16_t prev, uint8_t num_ele, uint16_t cntr,
 		int8_t rssi)
 {
-	struct frnd_negotiation *neg;
+	struct l_queue *negotiations = mesh_net_get_negotiations(net);
+	struct mesh_friend *neg;
 	uint8_t rssiScale = (minReq >> 5) & 3;
 	uint8_t winScale = (minReq >> 3) & 3;
 	uint8_t minCache = (minReq >> 0) & 7;
@@ -194,23 +173,21 @@ void friend_request(struct mesh_net *net, uint16_t src,
 	if (cache_size(minCache) > frnd_cache_size)
 		return;
 
-	if (frnd_negotiations == NULL)
-		frnd_negotiations = l_queue_new();
-
 	/* TODO: Check RSSI, and then start Negotiation if appropriate */
 
 	/* We are participating in this Negotiation */
-	neg = l_new(struct frnd_negotiation, 1);
-	l_queue_push_head(frnd_negotiations, neg);
+	neg = l_new(struct mesh_friend, 1);
+	l_queue_push_head(negotiations, neg);
 
 	neg->net = net;
-	neg->low_power_node = src;
+	neg->lp_addr = src;
 	neg->lp_cnt = cntr;
-	neg->rssi = rssi;
+	neg->u.negotiate.rssi = rssi;
 	neg->receive_delay = delay;
 	neg->poll_timeout = timeout;
-	neg->old_relay = prev;
-	neg->num_ele = num_ele;
+	neg->old_friend = prev;
+	neg->ele_cnt = num_ele;
+	neg->net_idx = net_idx;
 
 	/* RSSI (Negative Factor, larger values == less time)
 	 * Scaling factor 0-3 == multiplier of 1.0 - 2.5
@@ -247,12 +224,11 @@ void friend_request(struct mesh_net *net, uint16_t src,
 						response_delay, neg, NULL);
 }
 
-static struct l_queue *retired_lpns;
-
 void friend_clear_confirm(struct mesh_net *net, uint16_t src,
 					uint16_t lpn, uint16_t lpnCounter)
 {
-	struct frnd_negotiation *neg = l_queue_remove_if(frnd_negotiations,
+	struct l_queue *negotiations = mesh_net_get_negotiations(net);
+	struct mesh_friend *neg = l_queue_remove_if(negotiations,
 					match_by_lpn, L_UINT_TO_PTR(lpn));
 
 	l_debug("Friend Clear confirmed %4.4x (cnt %4.4x)", lpn, lpnCounter);
@@ -261,7 +237,7 @@ void friend_clear_confirm(struct mesh_net *net, uint16_t src,
 		return;
 
 	l_timeout_remove(neg->timeout);
-	l_queue_remove(frnd_negotiations, neg);
+	l_queue_remove(negotiations, neg);
 	l_free(neg);
 }
 
@@ -270,7 +246,7 @@ static void friend_poll_timeout(struct l_timeout *timeout, void *user_data)
 	struct mesh_friend *frnd = user_data;
 
 	if (mesh_friend_clear(frnd->net, frnd))
-		l_debug("Friend Poll Timeout %4.4x", frnd->dst);
+		l_debug("Friend Poll Timeout %4.4x", frnd->lp_addr);
 
 	l_timeout_remove(frnd->timeout);
 	frnd->timeout = NULL;
@@ -283,6 +259,7 @@ static void friend_poll_timeout(struct l_timeout *timeout, void *user_data)
 void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 				uint16_t lpnCounter, struct mesh_friend *frnd)
 {
+	struct l_queue *negotiations = mesh_net_get_negotiations(net);
 	uint8_t msg[5] = { NET_OP_FRND_CLEAR_CONFIRM };
 	bool removed = false;
 	uint16_t lpnDelta;
@@ -297,11 +274,10 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 		/* Move friend from Network list to Retired list */
 		removed = mesh_friend_clear(net, frnd);
 		if (removed) {
-			struct mesh_friend *old;
-			struct frnd_negotiation *neg = l_queue_remove_if(
-						frnd_negotiations,
-						match_by_lpn,
-						L_UINT_TO_PTR(frnd->dst));
+			struct mesh_friend *neg, *old;
+
+			neg = l_queue_remove_if(negotiations, match_by_lpn,
+							L_UINT_TO_PTR(lpn));
 
 			/* Cancel any negotiations or clears */
 			if (neg) {
@@ -309,24 +285,23 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 				l_free(neg);
 			}
 
-			/* Create Retired LPN list if needed */
-			if (retired_lpns == NULL)
-				retired_lpns = l_queue_new();
-
 			/* Find any duplicates */
-			old = l_queue_find(retired_lpns, match_by_dst,
-						L_UINT_TO_PTR(lpn));
+			old = l_queue_find(retired_lpns, match_by_lpn,
+							L_UINT_TO_PTR(lpn));
 
 			/* Force time-out of old friendship */
 			if (old)
 				friend_poll_timeout(old->timeout, old);
 
+			if (!retired_lpns)
+				retired_lpns = l_queue_new();
+
 			/* Retire this LPN (keeps timeout running) */
 			l_queue_push_tail(retired_lpns, frnd);
 		}
 	} else {
-		frnd = l_queue_find(retired_lpns, match_by_dst,
-						L_UINT_TO_PTR(lpn));
+		frnd = l_queue_find(retired_lpns, match_by_lpn,
+							L_UINT_TO_PTR(lpn));
 		if (!frnd)
 			return;
 
@@ -349,16 +324,17 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 
 static void clear_retry(struct l_timeout *timeout, void *user_data)
 {
-	struct frnd_negotiation *neg = user_data;
+	struct mesh_friend *neg = user_data;
+	struct l_queue *negotiations = mesh_net_get_negotiations(neg->net);
 	uint8_t msg[5] = { NET_OP_FRND_CLEAR };
 	uint32_t secs = 1 << neg->receive_delay;
 
 
-	l_put_be16(neg->low_power_node, msg + 1);
+	l_put_be16(neg->lp_addr, msg + 1);
 	l_put_be16(neg->lp_cnt, msg + 3);
 	mesh_net_transport_send(neg->net, 0, false,
 			mesh_net_get_iv_index(neg->net), DEFAULT_TTL,
-			0, 0, neg->old_relay,
+			0, 0, neg->old_friend,
 			msg, sizeof(msg));
 
 	if (secs && ((secs << 1) < neg->poll_timeout/10)) {
@@ -369,7 +345,7 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
 	} else {
 		l_debug("FRND_CLR timed out %d", secs);
 		l_timeout_remove(timeout);
-		l_queue_remove(frnd_negotiations, neg);
+		l_queue_remove(negotiations, neg);
 		l_free(neg);
 	}
 }
@@ -458,14 +434,14 @@ update:
 	net_seq = mesh_net_get_seq_num(net);
 	l_debug("Fwd FRND UPDATE %6.6x with MD == 0", net_seq);
 
-	frnd->last = frnd->seq;
+	frnd->u.active.last = frnd->u.active.seq;
 	mesh_net_get_snb_state(net, upd + 1, &iv_index);
 	l_put_be32(iv_index, upd + 2);
 	upd[6] = false; /* Queue is Empty */
 	print_packet("Update", upd, sizeof(upd));
 	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, frnd->dst,
+			net_seq, 0, frnd->lp_addr,
 			upd, sizeof(upd));
 	mesh_net_next_seq_num(net);
 }
@@ -474,20 +450,23 @@ update:
 void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 					struct mesh_friend *frnd)
 {
-	struct frnd_negotiation *neg;
+	struct l_queue *negotiations = mesh_net_get_negotiations(net);
+	struct mesh_friend *neg;
 	struct mesh_friend_msg *pkt;
 	bool md;
 
-	neg = l_queue_find(frnd_negotiations, match_by_lpn, L_UINT_TO_PTR(src));
-	if (neg && !neg->clearing) {
+	l_debug("POLL-RXED");
+	neg = l_queue_find(negotiations, match_by_lpn, L_UINT_TO_PTR(src));
+
+	if (neg && !neg->u.negotiate.clearing) {
 		uint8_t msg[5] = { NET_OP_FRND_CLEAR };
 
-		l_debug("Won negotiation for %4.4x", neg->low_power_node);
+		l_debug("Won negotiation for %4.4x", neg->lp_addr);
 
 		/* This call will clean-up and replace if already friends */
-		frnd = mesh_friend_new(net, src, neg->num_ele,
+		frnd = mesh_friend_new(net, src, neg->ele_cnt,
 						neg->receive_delay,
-						neg->wrfrw,
+						neg->frw,
 						neg->poll_timeout,
 						neg->fn_cnt, neg->lp_cnt);
 
@@ -496,20 +475,21 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 					friend_poll_timeout, frnd, NULL);
 
 		l_timeout_remove(neg->timeout);
-		net_key_unref(neg->key_id);
-		neg->key_id = 0;
+		net_key_unref(neg->net_key_cur);
+		net_key_unref(neg->net_key_upd);
+		neg->net_key_upd = neg->net_key_cur = 0;
 
-		if (neg->old_relay == 0 ||
-				neg->old_relay == mesh_net_get_address(net)) {
-			l_queue_remove(frnd_negotiations, neg);
+		if (neg->old_friend == 0 ||
+				neg->old_friend == mesh_net_get_address(net)) {
+			l_queue_remove(negotiations, neg);
 			l_free(neg);
 		} else {
-			neg->clearing = true;
-			l_put_be16(neg->low_power_node, msg + 1);
+			neg->u.negotiate.clearing = true;
+			l_put_be16(neg->lp_addr, msg + 1);
 			l_put_be16(neg->lp_cnt, msg + 3);
 			mesh_net_transport_send(net, 0, false,
 					mesh_net_get_iv_index(net), DEFAULT_TTL,
-					0, 0, neg->old_relay,
+					0, 0, neg->old_friend,
 					msg, sizeof(msg));
 
 			/* Reuse receive_delay as a shift counter to
@@ -530,7 +510,8 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 	if (!l_queue_length(frnd->pkt_cache))
 		goto update;
 
-	if (frnd->seq != frnd->last && frnd->seq != seq) {
+	if (frnd->u.active.seq != frnd->u.active.last &&
+						frnd->u.active.seq != seq) {
 		pkt = l_queue_peek_head(frnd->pkt_cache);
 		if (pkt->cnt_out < pkt->cnt_in) {
 			pkt->cnt_out++;
@@ -545,8 +526,8 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 	if (!pkt)
 		goto update;
 
-	frnd->seq = seq;
-	frnd->last = !seq;
+	frnd->u.active.seq = seq;
+	frnd->u.active.last = !seq;
 	md = !!(l_queue_length(frnd->pkt_cache) > 1);
 
 	if (pkt->ctl) {
@@ -586,7 +567,7 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 	uint8_t plen = len;
 	uint8_t msg[] = { NET_OP_PROXY_SUB_CONFIRM, 0 };
 
-	if (!frnd || MAX_FRND_GROUPS < frnd->grp_cnt + (len/2))
+	if (!frnd || MAX_FRND_GROUPS < frnd->u.active.grp_cnt + (len/2))
 		return;
 
 	msg[1] = *pkt++;
@@ -599,25 +580,25 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 			return;
 	}
 
-	new_list = l_malloc(frnd->grp_cnt * sizeof(uint16_t) + len);
-	if (frnd->grp_list)
-		memcpy(new_list, frnd->grp_list,
-				frnd->grp_cnt * sizeof(uint16_t));
+	new_list = l_malloc(frnd->u.active.grp_cnt * sizeof(uint16_t) + len);
+	if (frnd->u.active.grp_list)
+		memcpy(new_list, frnd->u.active.grp_list,
+				frnd->u.active.grp_cnt * sizeof(uint16_t));
 
 	while (len >= 2) {
-		new_list[frnd->grp_cnt++] = l_get_be16(pkt);
+		new_list[frnd->u.active.grp_cnt++] = l_get_be16(pkt);
 		pkt += 2;
 		len -= 2;
 	}
 
-	l_free(frnd->grp_list);
-	frnd->grp_list = new_list;
+	l_free(frnd->u.active.grp_list);
+	frnd->u.active.grp_list = new_list;
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
 	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, frnd->dst,
+			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
 	mesh_net_next_seq_num(net);
 }
@@ -638,12 +619,12 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 	while (len >= 2) {
 		uint16_t grp = l_get_be16(pkt);
 
-		for (i = frnd->grp_cnt - 1; i >= 0; i--) {
-			if (frnd->grp_list[i] == grp) {
-				frnd->grp_cnt--;
-				memcpy(&frnd->grp_list[i],
-						&frnd->grp_list[i + 1],
-						(frnd->grp_cnt - i) * 2);
+		for (i = frnd->u.active.grp_cnt - 1; i >= 0; i--) {
+			if (frnd->u.active.grp_list[i] == grp) {
+				frnd->u.active.grp_cnt--;
+				memcpy(&frnd->u.active.grp_list[i],
+					&frnd->u.active.grp_list[i + 1],
+					(frnd->u.active.grp_cnt - i) * 2);
 				break;
 			}
 		}
@@ -655,414 +636,7 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 	net_seq = mesh_net_get_seq_num(net);
 	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, frnd->dst,
+			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
 	mesh_net_next_seq_num(net);
 }
-
-/* Low-Power-Node role */
-struct frnd_offers {
-	uint16_t fn_cnt;
-	uint16_t src;
-	uint8_t window;
-	uint8_t cache;
-	uint8_t sub_list_size;
-	int8_t local_rssi;
-	int8_t remote_rssi;
-};
-
-#define MAX_POLL_RETRIES	5
-static bool quick_pick;
-static uint8_t poll_cnt;
-static struct l_queue *offers;
-static uint16_t old_friend;
-static uint16_t fn_cnt, cnt = 0xffff;
-static uint32_t poll_period_ms;
-static struct l_timeout *poll_retry_to;
-static struct l_timeout *poll_period_to;
-static uint32_t lpn_key_id;
-static uint32_t new_lpn_id;
-
-void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
-			uint8_t cache, uint8_t sub_list_size,
-			int8_t r_rssi, int8_t l_rssi, uint16_t fn_cnt)
-{
-	struct frnd_offers *offer;
-
-	l_debug("RSSI of Offer: %d dbm", l_rssi);
-
-	/* Ignore RFU window value 0 */
-	if (window == 0)
-		return;
-
-	if (mesh_net_get_friend(net))
-		return;
-
-	if (quick_pick) {
-		if (mesh_net_set_friend(net, src)) {
-			old_friend = src;
-			frnd_poll(net, false);
-		}
-		return;
-	}
-
-	offer = l_new(struct frnd_offers, 1);
-	offer->src = src;
-	offer->window = window;
-	offer->cache = cache;
-	offer->sub_list_size = sub_list_size;
-	offer->local_rssi = l_rssi;
-	offer->remote_rssi = r_rssi;
-	offer->fn_cnt = fn_cnt;
-
-	l_queue_push_tail(offers, offer);
-}
-
-static void frnd_poll_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-
-	frnd_poll(net, true);
-}
-
-static void frnd_negotiated_to(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-
-	l_debug("frnd_negotiated_to");
-	if (!mesh_net_get_friend(net)) {
-		l_timeout_remove(poll_period_to);
-		poll_period_to = NULL;
-		return;
-	}
-
-	if (!poll_retry_to)
-		frnd_poll(net, false);
-}
-
-void frnd_poll_cancel(struct mesh_net *net)
-{
-	l_timeout_remove(poll_retry_to);
-	poll_retry_to = NULL;
-}
-
-void frnd_poll(struct mesh_net *net, bool retry)
-{
-	uint32_t key_id = lpn_key_id;
-	uint32_t net_seq;
-	uint8_t msg[2] = { NET_OP_FRND_POLL };
-	bool seq = mesh_net_get_frnd_seq(net);
-
-	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_id) {
-		uint8_t phase;
-		uint16_t net_idx = mesh_net_get_primary_idx(net);
-		uint8_t status =
-			mesh_net_key_refresh_phase_get(net, net_idx, &phase);
-
-		if (status == MESH_STATUS_SUCCESS &&
-				phase == KEY_REFRESH_PHASE_TWO)
-			key_id = new_lpn_id;
-	}
-
-	if (!retry) {
-		poll_cnt = MAX_POLL_RETRIES;
-		seq = !seq;
-		mesh_net_set_frnd_seq(net, seq);
-	} else if (!(poll_cnt--)) {
-		l_debug("Lost Friendship with %4.4x", old_friend);
-		l_timeout_remove(poll_period_to);
-		poll_period_to = NULL;
-		frnd_poll_cancel(net);
-		net_key_unref(lpn_key_id);
-		net_key_unref(new_lpn_id);
-		new_lpn_id = lpn_key_id = 0;
-		mesh_net_set_friend(net, 0);
-		return;
-	}
-
-	if (poll_retry_to)
-		l_timeout_remove(poll_retry_to);
-
-	l_debug("TX-FRIEND POLL %d", seq);
-	msg[1] = seq;
-	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, key_id, true,
-			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, mesh_net_get_friend(net),
-			msg, sizeof(msg));
-	mesh_net_next_seq_num(net);
-	poll_retry_to = l_timeout_create_ms(1000, frnd_poll_timeout, net, NULL);
-
-	/* Reset Poll Period for next "Wake Up" */
-	if (poll_period_to)
-		l_timeout_modify_ms(poll_period_to, poll_period_ms);
-	else
-		poll_period_to = l_timeout_create_ms(poll_period_ms,
-						frnd_negotiated_to, net, NULL);
-}
-
-void frnd_ack_poll(struct mesh_net *net)
-{
-	/* Start new POLL, but only if not already Polling */
-	if (poll_retry_to == NULL)
-		frnd_poll(net, false);
-}
-
-static void req_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct frnd_offers *best;
-	struct frnd_offers *offer = l_queue_pop_head(offers);
-	uint32_t key_id = 0;
-	bool res;
-
-	l_timeout_remove(timeout);
-
-	best = offer;
-	while (offer) {
-		/* Screen out clearly inferior RSSI friends first */
-		if (offer->local_rssi < -40 && offer->remote_rssi < -40) {
-			if (best->local_rssi + 20 < offer->local_rssi ||
-				best->remote_rssi + 20 < offer->remote_rssi) {
-
-				l_free(best);
-				best = offer;
-				offer = l_queue_pop_head(offers);
-				continue;
-			}
-		}
-
-		/* Otherwise use best Windows, with Cache size as tie breaker */
-		if (best->window > offer->window ||
-				(best->window == offer->window &&
-				 best->cache < offer->cache)) {
-			l_free(best);
-			best = offer;
-		} else if (best != offer)
-			l_free(offer);
-
-		offer = l_queue_pop_head(offers);
-	}
-
-	net_key_unref(lpn_key_id);
-	net_key_unref(new_lpn_id);
-	new_lpn_id = lpn_key_id = 0;
-	if (mesh_net_get_friend(net)) {
-		l_free(best);
-		return;
-	} else if (!best) {
-		l_debug("No Offers Received");
-		return;
-	}
-
-	fn_cnt = best->fn_cnt;
-	res = mesh_net_get_key(net, false, mesh_net_get_primary_idx(net),
-								&key_id);
-	if (!res)
-		return;
-
-	lpn_key_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
-						best->src, cnt, best->fn_cnt);
-	if (!lpn_key_id)
-		return;
-
-	res = mesh_net_get_key(net, true, mesh_net_get_primary_idx(net),
-								&key_id);
-
-	if (!res)
-		goto old_keys_only;
-
-	new_lpn_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
-						best->src, cnt, best->fn_cnt);
-
-old_keys_only:
-
-	l_debug("Winning offer %4.4x RSSI: %ddb Window: %dms Cache sz: %d",
-			best->src, best->local_rssi,
-			best->window, best->cache);
-
-	if (mesh_net_set_friend(net, best->src)) {
-		old_friend = best->src;
-		mesh_net_set_frnd_seq(net, true);
-		frnd_poll(net, false);
-	}
-
-	l_free(best);
-}
-
-void frnd_clear(struct mesh_net *net)
-{
-	uint8_t msg[12];
-	uint8_t n = 0;
-	uint16_t frnd_addr = mesh_net_get_friend(net);
-	uint16_t my_addr = mesh_net_get_address(net);
-
-	msg[n++] = NET_OP_FRND_CLEAR;
-	l_put_be16(my_addr, msg + n);
-	n += 2;
-	l_put_be16(cnt, msg + n);
-	n += 2;
-
-	net_key_unref(lpn_key_id);
-	net_key_unref(new_lpn_id);
-	mesh_net_set_friend(net, 0);
-
-	mesh_net_transport_send(net, 0, false,
-			mesh_net_get_iv_index(net), 0,
-			0, 0, frnd_addr,
-			msg, n);
-}
-
-void frnd_request_friend(struct mesh_net *net, uint8_t cache,
-			uint8_t offer_delay, uint8_t delay, uint32_t timeout)
-{
-	uint8_t msg[12];
-	uint8_t n = 0;
-
-	if (offers == NULL)
-		offers = l_queue_new();
-
-	msg[n++] = NET_OP_FRND_REQUEST;
-	msg[n] = cache & 0x07;		/* MinRequirements - Cache */
-	msg[n++] |= (offer_delay & 0x0f) << 3;	/* Offer Delay */
-	poll_period_ms = (timeout * 300) / 4; /* 3/4 of the time in ms */
-	l_put_be32(timeout, msg + n);	/* PollTimeout */
-	msg[n++] = delay;		/* ReceiveDelay */
-	n += 3;
-	l_put_be16(old_friend, msg + n);	/* PreviousAddress */
-	n += 2;
-	msg[n++] = mesh_net_get_num_ele(net);	/* NumElements */
-	l_put_be16(cnt + 1, msg + n);	/* Next counter */
-	n += 2;
-	print_packet("Tx-NET_OP_FRND_REQUEST", msg, n);
-	mesh_net_transport_send(net, 0, false,
-			mesh_net_get_iv_index(net), 0,
-			0, 0, FRIENDS_ADDRESS,
-			msg, n);
-	l_timeout_create_ms(1000, req_timeout, net, NULL); /* 1000 ms */
-	mesh_net_set_friend(net, 0);
-	cnt++;
-}
-
-static uint8_t trans_id;
-void frnd_sub_add(struct mesh_net *net, uint32_t parms[7])
-{
-	uint32_t key_id = lpn_key_id;
-	uint32_t net_seq;
-	uint8_t msg[15] = { NET_OP_PROXY_SUB_ADD };
-	uint8_t i, n = 1;
-
-	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_id) {
-		uint8_t phase;
-		uint16_t net_idx = mesh_net_get_primary_idx(net);
-		uint8_t status = mesh_net_key_refresh_phase_get(net,
-							net_idx, &phase);
-
-		if (status == MESH_STATUS_SUCCESS &&
-				phase == KEY_REFRESH_PHASE_TWO)
-			key_id = new_lpn_id;
-	}
-
-	msg[n++] = ++trans_id;
-	for (i = 0; i < 7; i++) {
-		if (parms[i] < 0x8000 || parms[i] > 0xffff)
-			break;
-
-		l_put_be16(parms[i], msg + n);
-		n += 2;
-	}
-
-	net_seq = mesh_net_get_seq_num(net);
-	print_packet("Friend Sub Add", msg, n);
-	mesh_net_transport_send(net, key_id, false,
-			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, mesh_net_get_friend(net),
-			msg, n);
-	mesh_net_next_seq_num(net);
-}
-
-void frnd_sub_del(struct mesh_net *net, uint32_t parms[7])
-{
-	uint32_t key_id = lpn_key_id;
-	uint32_t net_seq;
-	uint8_t msg[15] = { NET_OP_PROXY_SUB_REMOVE };
-	uint8_t i, n = 1;
-
-	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_id) {
-		uint8_t phase;
-		uint16_t net_idx = mesh_net_get_primary_idx(net);
-		uint8_t status = mesh_net_key_refresh_phase_get(net,
-							net_idx, &phase);
-
-		if (status == MESH_STATUS_SUCCESS &&
-				phase == KEY_REFRESH_PHASE_TWO)
-			key_id = new_lpn_id;
-	}
-
-	msg[n++] = ++trans_id;
-	for (i = 0; i < 7; i++) {
-		if (parms[i] < 0x8000 || parms[i] > 0xffff)
-			break;
-
-		l_put_be16(parms[i], msg + n);
-		n += 2;
-	}
-
-	net_seq = mesh_net_get_seq_num(net);
-	print_packet("Friend Sub Del", msg, n);
-	mesh_net_transport_send(net, key_id, false,
-			mesh_net_get_iv_index(net), 0,
-			net_seq, 0, mesh_net_get_friend(net),
-			msg, n);
-	mesh_net_next_seq_num(net);
-}
-
-void frnd_key_refresh(struct mesh_net *net, uint8_t phase)
-{
-	uint16_t net_idx = mesh_net_get_primary_idx(net);
-	uint32_t key_id;
-
-	switch (phase) {
-	default:
-	case 0:
-	case 3:
-		if (new_lpn_id) {
-			l_debug("LPN Retiring KeySet %d", lpn_key_id);
-			net_key_unref(lpn_key_id);
-			lpn_key_id = new_lpn_id;
-		}
-		return;
-
-	case 1:
-		net_key_unref(new_lpn_id);
-		if (!mesh_net_get_key(net, true, net_idx, &key_id)) {
-			new_lpn_id = 0;
-			return;
-		}
-
-		new_lpn_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
-						mesh_net_get_friend(net),
-						cnt, fn_cnt);
-		return;
-
-	case 2:
-		/* Should we do anything here?  Maybe not */
-		return;
-	}
-}
-
-uint32_t frnd_get_key(struct mesh_net *net)
-{
-	uint8_t idx = mesh_net_get_primary_idx(net);
-	uint8_t phase = 0;
-
-	mesh_net_key_refresh_phase_get(net, idx, &phase);
-
-	if (phase == 2)
-		return new_lpn_id;
-	else
-		return lpn_key_id;
-}
diff --git a/mesh/friend.h b/mesh/friend.h
index 7ab5dea2e..2351dee31 100644
--- a/mesh/friend.h
+++ b/mesh/friend.h
@@ -28,9 +28,10 @@
 
 void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 						struct mesh_friend *frnd);
-void friend_request(struct mesh_net *net, uint16_t src, uint8_t minReq,
-			uint8_t delay, uint32_t timeout, uint16_t prev,
-			uint8_t num_elements, uint16_t cntr, int8_t rssi);
+void friend_request(struct mesh_net *net, uint16_t net_idx, uint16_t src,
+			uint8_t minReq, uint8_t delay, uint32_t timeout,
+			uint16_t prev, uint8_t num_elements, uint16_t cntr,
+			int8_t rssi);
 void friend_clear_confirm(struct mesh_net *net, uint16_t src, uint16_t lpn,
 							uint16_t lpnCounter);
 void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
diff --git a/mesh/net.c b/mesh/net.c
index 0283a782c..439316e4a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -157,6 +157,7 @@ struct mesh_net {
 	struct l_queue *sar_out;
 	struct l_queue *frnd_msgs;
 	struct l_queue *friends;
+	struct l_queue *negotiations;
 	struct l_queue *destinations;
 
 	uint8_t prov_priv_key[32];
@@ -291,6 +292,15 @@ static bool match_key_id(const void *a, const void *b)
 					(key_id == subnet->net_key_upd);
 }
 
+static bool match_friend_key_id(const void *a, const void *b)
+{
+	const struct mesh_friend *friend = a;
+	uint32_t key_id = L_PTR_TO_UINT(b);
+
+	return (key_id == friend->net_key_cur) ||
+					(key_id == friend->net_key_upd);
+}
+
 static void idle_mesh_heartbeat_send(void *net)
 {
 	mesh_net_heartbeat_send(net);
@@ -326,7 +336,7 @@ static bool match_by_friend(const void *a, const void *b)
 	const struct mesh_friend *frnd = a;
 	uint16_t dst = L_PTR_TO_UINT(b);
 
-	return frnd->dst == dst;
+	return frnd->lp_addr == dst;
 }
 
 static void free_friend_internals(struct mesh_friend *frnd)
@@ -334,13 +344,15 @@ static void free_friend_internals(struct mesh_friend *frnd)
 	if (frnd->pkt_cache)
 		l_queue_destroy(frnd->pkt_cache, l_free);
 
-	if (frnd->grp_list)
-		l_free(frnd->grp_list);
-
+	l_free(frnd->u.active.grp_list);
+	frnd->u.active.grp_list = NULL;
 	frnd->pkt_cache = NULL;
-	frnd->grp_list = NULL;
+
 	net_key_unref(frnd->net_key_cur);
 	net_key_unref(frnd->net_key_upd);
+	frnd->net_key_cur = 0;
+	frnd->net_key_upd = 0;
+
 }
 
 static void frnd_kr_phase1(void *a, void *b)
@@ -348,7 +360,7 @@ static void frnd_kr_phase1(void *a, void *b)
 	struct mesh_friend *frnd = a;
 	uint32_t key_id = L_PTR_TO_UINT(b);
 
-	frnd->net_key_upd = net_key_frnd_add(key_id, frnd->dst,
+	frnd->net_key_upd = net_key_frnd_add(key_id, frnd->lp_addr,
 			frnd->net->src_addr, frnd->lp_cnt, frnd->fn_cnt);
 }
 
@@ -364,7 +376,7 @@ static void frnd_kr_phase2(void *a, void *b)
 	 */
 
 	l_info("Use Both KeySet %d && %d for %4.4x",
-			frnd->net_key_cur, frnd->net_key_upd, frnd->dst);
+			frnd->net_key_cur, frnd->net_key_upd, frnd->lp_addr);
 }
 
 static void frnd_kr_phase3(void *a, void *b)
@@ -372,7 +384,7 @@ static void frnd_kr_phase3(void *a, void *b)
 	struct mesh_friend *frnd = a;
 
 	l_info("Replace KeySet %d with %d for %4.4x",
-			frnd->net_key_cur, frnd->net_key_upd, frnd->dst);
+			frnd->net_key_cur, frnd->net_key_upd, frnd->lp_addr);
 	net_key_unref(frnd->net_key_cur);
 	frnd->net_key_cur = frnd->net_key_upd;
 	frnd->net_key_upd = 0;
@@ -400,7 +412,7 @@ struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
 
 	/* add _k2 */
 	frnd->net = net;
-	frnd->dst = dst;
+	frnd->lp_addr = dst;
 	frnd->frd = frd;
 	frnd->frw = frw;
 	frnd->fn_cnt = fn_cnt;
@@ -420,6 +432,7 @@ struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
 	if (!subnet->net_key_upd)
 		return frnd;
 
+	frnd->net_idx = subnet->idx;
 	frnd->net_key_upd = net_key_frnd_add(subnet->net_key_upd,
 							dst, net->src_addr,
 							lp_cnt, fn_cnt);
@@ -457,17 +470,20 @@ void mesh_friend_sub_add(struct mesh_net *net, uint16_t lpn, uint8_t ele_cnt,
 	if (!frnd)
 		return;
 
-	new_list = l_malloc((grp_cnt + frnd->grp_cnt) * sizeof(uint16_t));
-	grp_list = frnd->grp_list;
+	new_list = l_malloc((grp_cnt +
+				frnd->u.active.grp_cnt) * sizeof(uint16_t));
+	grp_list = frnd->u.active.grp_list;
 
-	if (grp_list && frnd->grp_cnt)
-		memcpy(new_list, grp_list, frnd->grp_cnt * sizeof(uint16_t));
+	if (grp_list && frnd->u.active.grp_cnt)
+		memcpy(new_list, grp_list,
+				frnd->u.active.grp_cnt * sizeof(uint16_t));
 
-	memcpy(&new_list[frnd->grp_cnt], list, grp_cnt * sizeof(uint16_t));
+	memcpy(&new_list[frnd->u.active.grp_cnt], list,
+						grp_cnt * sizeof(uint16_t));
 	l_free(grp_list);
 	frnd->ele_cnt = ele_cnt;
-	frnd->grp_list = new_list;
-	frnd->grp_cnt += grp_cnt;
+	frnd->u.active.grp_list = new_list;
+	frnd->u.active.grp_cnt += grp_cnt;
 }
 
 void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
@@ -483,8 +499,8 @@ void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
 	if (!frnd)
 		return;
 
-	grp_cnt = frnd->grp_cnt;
-	grp_list = frnd->grp_list;
+	grp_cnt = frnd->u.active.grp_cnt;
+	grp_list = frnd->u.active.grp_list;
 
 	while (cnt-- && grp_cnt) {
 		cnt16 -= sizeof(uint16_t);
@@ -498,11 +514,11 @@ void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
 		}
 	}
 
-	frnd->grp_cnt = grp_cnt;
+	frnd->u.active.grp_cnt = grp_cnt;
 
 	if (!grp_cnt) {
-		l_free(frnd->grp_list);
-		frnd->grp_list = NULL;
+		l_free(frnd->u.active.grp_list);
+		frnd->u.active.grp_list = NULL;
 	}
 }
 
@@ -688,7 +704,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->sar_in = l_queue_new();
 	net->sar_out = l_queue_new();
 	net->frnd_msgs = l_queue_new();
-	net->friends = l_queue_new();
 	net->destinations = l_queue_new();
 	net->app_keys = l_queue_new();
 
@@ -714,6 +729,7 @@ void mesh_net_free(struct mesh_net *net)
 	l_queue_destroy(net->sar_out, mesh_sar_free);
 	l_queue_destroy(net->frnd_msgs, l_free);
 	l_queue_destroy(net->friends, mesh_friend_free);
+	l_queue_destroy(net->negotiations, mesh_friend_free);
 	l_queue_destroy(net->destinations, l_free);
 	l_queue_destroy(net->app_keys, appkey_key_free);
 
@@ -810,11 +826,22 @@ bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable)
 
 bool mesh_net_set_friend_mode(struct mesh_net *net, bool enable)
 {
+	l_debug("mesh_net_set_friend_mode - %d", enable);
+
 	if (!net)
 		return false;
 
-	if (net->friend_enable && !enable)
-		l_queue_clear(net->friends, mesh_friend_free);
+	if (net->friend_enable == enable)
+		return true;
+
+	if (enable) {
+		net->friends = l_queue_new();
+		net->negotiations = l_queue_new();
+	} else {
+		l_queue_destroy(net->friends, mesh_friend_free);
+		l_queue_destroy(net->negotiations, mesh_friend_free);
+		net->friends = net->negotiations = NULL;
+	}
 
 	net->friend_enable = enable;
 	trigger_heartbeat(net, FEATURE_FRIEND, enable);
@@ -1222,14 +1249,14 @@ static bool match_frnd_dst(const void *a, const void *b)
 {
 	const struct mesh_friend *frnd = a;
 	uint16_t dst = L_PTR_TO_UINT(b);
-	int16_t i, grp_cnt = frnd->grp_cnt;
-	uint16_t *grp_list = frnd->grp_list;
+	int16_t i, grp_cnt = frnd->u.active.grp_cnt;
+	uint16_t *grp_list = frnd->u.active.grp_list;
 
 	/*
 	 * Determine if this message is for this friends unicast
 	 * address, and/or one of it's group/virtual addresses
 	 */
-	if (dst >= frnd->dst && dst < (frnd->dst + frnd->ele_cnt))
+	if (dst >= frnd->lp_addr && dst < (frnd->lp_addr + frnd->ele_cnt))
 		return true;
 
 	if (!(dst & 0x8000))
@@ -1243,13 +1270,10 @@ static bool match_frnd_dst(const void *a, const void *b)
 	return false;
 }
 
-static bool is_lpn_friend(struct mesh_net *net, uint16_t addr, bool frnd)
+static bool is_lpn_friend(struct mesh_net *net, uint16_t addr)
 {
 	void *tst;
 
-	if (!frnd)
-		return false;
-
 	tst = l_queue_find(net->friends, match_frnd_dst, L_UINT_TO_PTR(addr));
 
 	return tst != NULL;
@@ -1334,7 +1358,8 @@ static void enqueue_friend_pkt(void *a, void *b)
 	 * Determine if this message is for this friends unicast
 	 * address, and/or one of it's group/virtual addresses
 	 */
-	if (rx->dst >= frnd->dst && (rx->dst - frnd->dst) < frnd->ele_cnt) {
+	if (rx->dst >= frnd->lp_addr && (rx->dst - frnd->lp_addr) <
+							frnd->ele_cnt) {
 		rx->done = true;
 		goto enqueue;
 	}
@@ -1343,8 +1368,8 @@ static void enqueue_friend_pkt(void *a, void *b)
 		return;
 
 	if (!IS_ALL_NODES(rx->dst)) {
-		for (i = 0; i < frnd->grp_cnt; i++) {
-			if (rx->dst == frnd->grp_list[i])
+		for (i = 0; i < frnd->u.active.grp_cnt; i++) {
+			if (rx->dst == frnd->u.active.grp_list[i])
 				goto enqueue;
 		}
 		return;
@@ -1366,7 +1391,8 @@ enqueue:
 					 * If we are discarding head for any
 					 * reason, reset FRND SEQ
 					 */
-					frnd->last = frnd->seq;
+					frnd->u.active.last =
+							frnd->u.active.seq;
 				}
 
 				l_free(old);
@@ -1377,7 +1403,7 @@ enqueue:
 	}
 
 	l_debug("%s for %4.4x from %4.4x ttl: %2.2x (seq: %6.6x) (ctl: %d)",
-			__func__, frnd->dst, rx->src, rx->ttl,
+			__func__, frnd->lp_addr, rx->src, rx->ttl,
 			rx->u.one[0].seq, rx->ctl);
 
 	if (rx->cnt_in) {
@@ -1399,7 +1425,7 @@ enqueue:
 		 */
 		pkt = l_queue_pop_head(frnd->pkt_cache);
 		l_free(pkt);
-		frnd->last = frnd->seq;
+		frnd->u.active.last = frnd->u.active.seq;
 	}
 }
 
@@ -1408,7 +1434,7 @@ static void enqueue_update(void *a, void *b)
 	struct mesh_friend *frnd = a;
 	struct mesh_friend_msg *pkt = b;
 
-	pkt->dst = frnd->dst;
+	pkt->dst = frnd->lp_addr;
 	pkt->done = false;
 	enqueue_friend_pkt(frnd, pkt);
 }
@@ -1553,7 +1579,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 
 	l_info("Send Friend ACK to Segs: %8.8x", flags);
 
-	if (is_lpn_friend(net, dst, true)) {
+	if (is_lpn_friend(net, dst)) {
 		/* If we are acking our LPN Friend, queue, don't send */
 		friend_ack_rxed(net, mesh_net_get_iv_index(net),
 				mesh_net_next_seq_num(net), 0, dst, msg);
@@ -1583,14 +1609,14 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 	hdr = NET_OP_SEG_ACKNOWLEDGE << OPCODE_HDR_SHIFT;
 	hdr |= sar->seqZero << SEQ_ZERO_HDR_SHIFT;
 
-	if (is_lpn_friend(net, src, true))
+	if (is_lpn_friend(net, src))
 		hdr |= true << RELAY_HDR_SHIFT;
 
 	l_put_be32(hdr, msg);
 	l_put_be32(flags, msg + 3);
 	l_info("Send%s ACK to Segs: %8.8x", sar->frnd ? " Friend" : "", flags);
 
-	if (is_lpn_friend(net, dst, true)) {
+	if (is_lpn_friend(net, dst)) {
 		/* If we are acking our LPN Friend, queue, don't send */
 		friend_ack_rxed(net, mesh_net_get_iv_index(net),
 				mesh_net_next_seq_num(net), src, dst, msg);
@@ -1720,23 +1746,6 @@ static void ack_received(struct mesh_net *net, bool timeout,
 	outgoing->seg_timeout = l_timeout_create(SEG_TO, outseg_to, net, NULL);
 }
 
-static void outack_to(struct l_timeout *seg_timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_find(net->sar_out,
-					match_seg_timeout, seg_timeout);
-
-	l_timeout_remove(seg_timeout);
-	if (!sar)
-		return;
-
-	sar->seg_timeout = NULL;
-
-	/* Re-Send missing segments by faking NAK */
-	ack_received(net, true, sar->remote, sar->src,
-				sar->seqZero, sar->last_nak);
-}
-
 static void outseg_to(struct l_timeout *seg_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -1749,16 +1758,9 @@ static void outseg_to(struct l_timeout *seg_timeout, void *user_data)
 
 	sar->seg_timeout = NULL;
 
-	if (net->friend_addr) {
-		/* We are LPN -- Poll for ACK */
-		frnd_ack_poll(net);
-		sar->seg_timeout = l_timeout_create(SEG_TO,
-				outack_to, net, NULL);
-	} else {
-		/* Re-Send missing segments by faking NACK */
-		ack_received(net, true, sar->remote, sar->src,
+	/* Re-Send missing segments by faking NACK */
+	ack_received(net, true, sar->remote, sar->src,
 					sar->seqZero, sar->last_nak);
-	}
 }
 
 static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
@@ -1806,6 +1808,35 @@ not_for_friend:
 					net_idx, src, dst, key_aid, data, size);
 }
 
+static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
+{
+	struct mesh_subnet *subnet;
+	struct mesh_friend *friend;
+
+	if (!net)
+		return NET_IDX_INVALID;
+
+	subnet = l_queue_find(net->subnets, match_key_id,
+						L_UINT_TO_PTR(key_id));
+
+	if (subnet)
+		return subnet->idx;
+
+	friend = l_queue_find(net->friends, match_friend_key_id,
+						L_UINT_TO_PTR(key_id));
+
+	if (friend)
+		return friend->net_idx;
+
+	friend = l_queue_find(net->negotiations, match_friend_key_id,
+						L_UINT_TO_PTR(key_id));
+
+	if (friend)
+		return friend->net_idx;
+	else
+		return NET_IDX_INVALID;
+}
+
 static bool match_frnd_sar_dst(const void *a, const void *b)
 {
 	const struct mesh_friend_msg *frnd_msg = a;
@@ -1835,9 +1866,10 @@ static void friend_seg_rxed(struct mesh_net *net,
 	if (!frnd)
 		return;
 
-	if (frnd->last_hdr == hdr_key) {
+	if (frnd->u.active.last_hdr == hdr_key) {
 		/* We are no longer receiving this msg. Resend final ACK */
-		send_frnd_ack(net, dst, src, frnd->last_hdr, 0xffffffff);
+		send_frnd_ack(net, dst, src, frnd->u.active.last_hdr,
+								0xffffffff);
 		return;
 	}
 
@@ -2051,8 +2083,8 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	return false;
 }
 
-static bool ctl_received(struct mesh_net *net, bool frnd, uint32_t iv_index,
-						uint8_t ttl,
+static bool ctl_received(struct mesh_net *net, uint16_t key_id,
+						uint32_t iv_index, uint8_t ttl,
 						uint32_t seq,
 						uint16_t src, uint16_t dst,
 						uint8_t opcode, int8_t rssi,
@@ -2061,8 +2093,9 @@ static bool ctl_received(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	uint8_t msg[12];
 	uint8_t rsp_ttl = DEFAULT_TTL;
 	uint8_t n = 0;
+	uint16_t net_idx;
 
-	if (!frnd && ttl > 1) {
+	if (ttl > 1) {
 		uint32_t hdr = opcode << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl - 1;
 
@@ -2114,21 +2147,13 @@ static bool ctl_received(struct mesh_net *net, bool frnd, uint32_t iv_index,
 			return false;
 
 		print_packet("Rx-NET_OP_FRND_REQUEST", pkt, len);
-		friend_request(net, src, pkt[0], pkt[1],
+		net_idx = key_id_to_net_idx(net, key_id);
+		friend_request(net, net_idx, src, pkt[0], pkt[1],
 				l_get_be32(pkt + 1) & 0xffffff,
 				l_get_be16(pkt + 5), pkt[7],
 				l_get_be16(pkt + 8), rssi);
 		break;
 
-	case NET_OP_FRND_OFFER:
-		if (len != 6 || ttl)
-			return false;
-
-		print_packet("Rx-NET_OP_FRND_OFFER", pkt, len);
-		frnd_offer(net, src, pkt[0], pkt[1], pkt[2],
-				(int8_t) pkt[3], rssi, l_get_be16(pkt + 4));
-		break;
-
 	case NET_OP_FRND_CLEAR_CONFIRM:
 		if (len != 4)
 			return false;
@@ -2292,22 +2317,6 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
 	mesh_io_send(io, &info, packet, size);
 }
 
-static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
-{
-	struct mesh_subnet *subnet;
-
-	if (!net)
-		return NET_IDX_INVALID;
-
-	subnet = l_queue_find(net->subnets, match_key_id,
-						L_UINT_TO_PTR(key_id));
-
-	if (subnet)
-		return subnet->idx;
-	else
-		return NET_IDX_INVALID;
-}
-
 static enum _relay_advice packet_received(void *user_data,
 				uint32_t key_id, uint32_t iv_index,
 				const void *data, uint8_t size, int8_t rssi)
@@ -2321,7 +2330,6 @@ static enum _relay_advice packet_received(void *user_data,
 	uint16_t net_idx;
 	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
-	struct mesh_friend *net_frnd = NULL;
 
 	memcpy(packet + 2, data, size);
 
@@ -2346,22 +2354,7 @@ static enum _relay_advice packet_received(void *user_data,
 		return RELAY_NONE;
 	}
 
-	/* Ignore incoming packets if we are LPN and frnd bit not set */
-	if (net->friend_addr) {
-		struct mesh_subnet *subnet;
-
-		subnet = l_queue_find(net->subnets, match_key_id,
-							L_UINT_TO_PTR(key_id));
-		if (subnet)
-			return RELAY_NONE;
-
-		/* If the queue is empty, stop polling */
-		if (net_ctl && net_opcode == NET_OP_FRND_UPDATE && !msg[5])
-			frnd_poll_cancel(net);
-		else
-			frnd_poll(net, false);
-
-	} else if (net_dst == 0) {
+	if (net_dst == 0) {
 		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
 						net_dst, net_ctl, net_ttl);
 		return RELAY_NONE;
@@ -2382,7 +2375,6 @@ static enum _relay_advice packet_received(void *user_data,
 			net_src, net_dst, net_ttl, iv_index, net_seq);
 
 	if (is_us(net, net_dst, false) ||
-			is_lpn_friend(net, net_src, !!(net_frnd)) ||
 			(net_ctl && net_opcode == NET_OP_HEARTBEAT)) {
 
 		l_info("RX: App 0x%04x -> 0x%04x : TTL 0x%02x : SEQ 0x%06x",
@@ -2402,7 +2394,7 @@ static enum _relay_advice packet_received(void *user_data,
 					return RELAY_NONE;
 
 				/* If this is an ACK to our friend queue-only */
-				if (is_lpn_friend(net, net_dst, true))
+				if (is_lpn_friend(net, net_dst))
 					friend_ack_rxed(net, iv_index, net_seq,
 							net_src, net_dst,
 							msg);
@@ -2412,7 +2404,8 @@ static enum _relay_advice packet_received(void *user_data,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
-				ctl_received(net, !!(net_frnd), iv_index,
+				ctl_received(net, key_id,
+						iv_index,
 						net_ttl, net_seq, net_src,
 						net_dst, net_opcode, rssi,
 						msg, app_msg_len);
@@ -2421,7 +2414,7 @@ static enum _relay_advice packet_received(void *user_data,
 			/* If we accept SAR packets to non-Unicast, then
 			 * Friend Sar at least needs to be Unicast Only
 			 */
-			if (is_lpn_friend(net, net_dst, true) &&
+			if (is_lpn_friend(net, net_dst) &&
 							!(net_dst & 0x8000)) {
 				/* Check TTL >= 2 before accepting segments
 				 * for Friends
@@ -2434,7 +2427,7 @@ static enum _relay_advice packet_received(void *user_data,
 						msg, app_msg_len);
 				}
 			} else {
-				seg_rxed(net, net_frnd, iv_index, net_ttl,
+				seg_rxed(net, NULL, iv_index, net_ttl,
 						net_seq, net_idx,
 						net_src, net_dst,
 						net_key_id,
@@ -2444,7 +2437,7 @@ static enum _relay_advice packet_received(void *user_data,
 			}
 
 		} else {
-			msg_rxed(net, net_frnd,
+			msg_rxed(net, NULL,
 						iv_index,
 						net_ttl,
 						net_seq,
@@ -2455,16 +2448,13 @@ static enum _relay_advice packet_received(void *user_data,
 						msg, app_msg_len);
 		}
 
-		if (!!(net_frnd))
-			l_info("Ask for more data!");
-
 		/* If this is one of our Unicast addresses, disallow relay */
 		if (IS_UNICAST(net_dst))
 			return RELAY_DISALLOWED;
 	}
 
 	/* If relay not enable, or no more hops allowed */
-	if (!net->relay.enable || net_ttl < 0x02 || net_frnd)
+	if (!net->relay.enable || net_ttl < 0x02)
 		return RELAY_NONE;
 
 	/* Group or Virtual destinations should *always* be relayed */
@@ -2670,10 +2660,7 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
 	set_network_beacon(subnet, net);
 
-	if (net->friend_addr)
-		frnd_key_refresh(net, 2);
-	else
-		l_queue_foreach(net->friends, frnd_kr_phase2, net);
+	l_queue_foreach(net->friends, frnd_kr_phase2, net);
 
 	mesh_config_net_key_set_phase(node_config_get(net->node), idx,
 						KEY_REFRESH_PHASE_TWO);
@@ -2706,10 +2693,7 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	subnet->kr_phase = KEY_REFRESH_PHASE_NONE;
 	set_network_beacon(subnet, net);
 
-	if (net->friend_addr)
-		frnd_key_refresh(net, 3);
-	else
-		l_queue_foreach(net->friends, frnd_kr_phase3, net);
+	l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
 	mesh_config_net_key_set_phase(node_config_get(net->node), idx,
 							KEY_REFRESH_PHASE_NONE);
@@ -3114,14 +3098,6 @@ bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst)
 			l_queue_push_head(net->destinations, dest);
 		else
 			l_queue_push_tail(net->destinations, dest);
-
-		/* If LPN, and Group/Virtual, add to Subscription List */
-		if (net->friend_addr) {
-			/* TODO: Fix this garbage */
-			uint32_t u32_dst[7] = {dst, 0xffffffff};
-
-			frnd_sub_add(net, u32_dst);
-		}
 	}
 
 	dest->dst = dst;
@@ -3144,14 +3120,6 @@ bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst)
 	if (dest->ref_cnt)
 		return true;
 
-	/* TODO: If LPN, and Group/Virtual, remove from Subscription List */
-	if (net->friend_addr) {
-		/* TODO: Fix this garbage */
-		uint32_t u32_dst[7] = {dst, 0xffffffff};
-
-		frnd_sub_del(net, u32_dst);
-	}
-
 	l_queue_remove(net->destinations, dest);
 
 	l_free(dest);
@@ -3170,6 +3138,7 @@ bool mesh_net_flush(struct mesh_net *net)
 /* TODO: add net key index */
 static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 {
+	struct mesh_subnet *subnet;
 	uint8_t seg_len;
 	uint8_t gatt_data[30];
 	uint8_t *packet = gatt_data;
@@ -3212,14 +3181,8 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	}
 	print_packet("Clr-Net Tx", packet + 1, packet_len);
 
-	if (msg->frnd_cred && net->friend_addr)
-		key_id = frnd_get_key(net);
-
-	if (!key_id) {
-		struct mesh_subnet *subnet = get_primary_subnet(net);
-
-		key_id = subnet->net_key_tx;
-	}
+	subnet = get_primary_subnet(net);
+	key_id = subnet->net_key_tx;
 
 	if (!net_key_encrypt(key_id, msg->iv_index, packet + 1, packet_len)) {
 		l_error("Failed to encode packet");
@@ -3494,7 +3457,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 
 	/* Deliver to Local entities if applicable */
 	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr) {
-		result = ctl_received(net, !!(key_id),
+		result = ctl_received(net, key_id,
 					iv_index, ttl,
 					mesh_net_next_seq_num(net),
 					src, dst,
@@ -3638,12 +3601,8 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 		return MESH_STATUS_CANNOT_UPDATE;
 	}
 
-	/* If we are an LPN, generate our keys here */
-	if (net->friend_addr)
-		frnd_key_refresh(net, 1);
-	else
-		/* If we are a Friend-Node, generate all our new keys */
-		l_queue_foreach(net->friends, frnd_kr_phase1,
+	/* If we are a Friend-Node, generate all our new keys */
+	l_queue_foreach(net->friends, frnd_kr_phase1,
 					L_UINT_TO_PTR(subnet->net_key_upd));
 
 	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
@@ -3664,7 +3623,7 @@ uint16_t mesh_net_get_features(struct mesh_net *net)
 		features |= FEATURE_RELAY;
 	if (net->proxy_enable)
 		features |= FEATURE_PROXY;
-	if (!l_queue_isempty(net->friends))
+	if (net->friend_enable)
 		features |= FEATURE_FRIEND;
 	if (net->friend_addr != UNASSIGNED_ADDRESS)
 		features |= FEATURE_LPN;
@@ -3758,6 +3717,22 @@ uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr)
 		return frnd->poll_timeout;
 }
 
+struct l_queue *mesh_net_get_friends(struct mesh_net *net)
+{
+	if (net)
+		return net->friends;
+
+	return NULL;
+}
+
+struct l_queue *mesh_net_get_negotiations(struct mesh_net *net)
+{
+	if (net)
+		return net->negotiations;
+
+	return NULL;
+}
+
 struct mesh_node *mesh_net_node_get(struct mesh_net *net)
 {
 	return  net->node;
diff --git a/mesh/net.h b/mesh/net.h
index 150240ff8..fe4e0b653 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -162,25 +162,40 @@ struct mesh_key_set {
 	uint8_t privacy_key[16];
 };
 
+struct friend_neg {
+	int8_t rssi;
+	bool clearing;
+};
+
+struct friend_act {
+	uint16_t *grp_list;
+	uint32_t last_hdr;
+	int16_t grp_cnt;
+	bool seq;
+	bool last;
+};
+
 struct mesh_friend {
 	struct mesh_net *net;
-	struct l_queue *pkt_cache;
 	struct l_timeout *timeout;
+	struct l_queue *pkt_cache;
 	void *pkt;
-	uint16_t *grp_list;
 	uint32_t poll_timeout;
-	uint32_t last_hdr;
 	uint32_t net_key_cur;
 	uint32_t net_key_upd;
-	uint16_t dst; /* Primary Element unicast addr */
+	uint16_t old_friend;
+	uint16_t net_idx;
+	uint16_t lp_addr;/* dst; * Primary Element unicast addr */
 	uint16_t fn_cnt;
 	uint16_t lp_cnt;
-	int16_t grp_cnt;
+	uint8_t	receive_delay;
 	uint8_t ele_cnt;
 	uint8_t frd;
 	uint8_t frw;
-	bool seq;
-	bool last;
+	union {
+		struct friend_neg negotiate;
+		struct friend_act active;
+	} u;
 };
 
 struct mesh_frnd_pkt {
@@ -360,3 +375,5 @@ void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
 struct mesh_prov *mesh_net_get_prov(struct mesh_net *net);
 void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
 uint32_t mesh_net_get_instant(struct mesh_net *net);
+struct l_queue *mesh_net_get_friends(struct mesh_net *net);
+struct l_queue *mesh_net_get_negotiations(struct mesh_net *net);
diff --git a/mesh/node.c b/mesh/node.c
index b52b9e437..7b4ee0505 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -531,7 +531,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
 		mesh_net_set_proxy_mode(node->net, mode == MESH_MODE_ENABLED);
 
-	mode = node->lpn;
+	mode = node->friend;
 	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
 		mesh_net_set_friend_mode(node->net, mode == MESH_MODE_ENABLED);
 
-- 
2.21.0

