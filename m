Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4107C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3211520896
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeLOABo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:01:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:20315 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeLOABn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:01:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="98882883"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2018 16:01:41 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v2 23/30] mesh: Clean-up Comment style
Date:   Fri, 14 Dec 2018 16:01:21 -0800
Message-Id: <20181215000128.928-24-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215000128.928-1-brian.gix@intel.com>
References: <20181215000128.928-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/friend.c | 76 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/mesh/friend.c b/mesh/friend.c
index 9ce499463..d17fde084 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -34,7 +34,7 @@
 #include "mesh/net.h"
 #include "mesh/crypto.h"
 #include "mesh/model.h"
-#include "mesh/display.h"
+#include "mesh/util.h"
 
 #include "mesh/friend.h"
 
@@ -78,7 +78,7 @@ static void response_timeout(struct l_timeout *timeout, void *user_data)
 	struct frnd_negotiation *neg = user_data;
 
 	/* LPN did not choose us */
-	l_info("Did not win negotiation for %4.4x", neg->low_power_node);
+	l_debug("Did not win negotiation for %4.4x", neg->low_power_node);
 
 	net_key_unref(neg->key_id);
 	l_queue_remove(frnd_negotiations, neg);
@@ -177,13 +177,13 @@ void friend_request(struct mesh_net *net, uint16_t src,
 	uint8_t minCache = (minReq >> 0) & 7;
 	int32_t rsp_delay;
 
-	l_info("RSSI of Request: %d dbm", rssi);
-	l_info("Delay: %d ms", delay);
-	l_info("Poll Timeout of Request: %d ms", timeout * 100);
-	l_info("Previous Friend: %4.4x", prev);
-	l_info("Num Elem: %2.2x", num_ele);
-	l_info("Cache Requested: %d", cache_size(minCache));
-	l_info("Cache to offer: %d", frnd_cache_size);
+	l_debug("RSSI of Request: %d dbm", rssi);
+	l_debug("Delay: %d ms", delay);
+	l_debug("Poll Timeout of Request: %d ms", timeout * 100);
+	l_debug("Previous Friend: %4.4x", prev);
+	l_debug("Num Elem: %2.2x", num_ele);
+	l_debug("Cache Requested: %d", cache_size(minCache));
+	l_debug("Cache to offer: %d", frnd_cache_size);
 
 	/* Determine our own suitability before
 	 * deciding to participate in negotiation
@@ -224,7 +224,7 @@ void friend_request(struct mesh_net *net, uint16_t src,
 	 * of 1, bit zero and additional 0.5
 	 */
 	rsp_delay = -(rssi * scaling[rssiScale]);
-	l_info("RSSI Factor: %d ms", rsp_delay / 10);
+	l_debug("RSSI Factor: %d ms", rsp_delay / 10);
 
 	/* Relay Window (Positive Factor, larger values == more time)
 	 * Scaling factor 0-3 == multiplier of 1.0 - 2.5
@@ -232,7 +232,7 @@ void friend_request(struct mesh_net *net, uint16_t src,
 	 * of 1, bit zero and additional 0.5
 	 */
 	rsp_delay += frnd_relay_window * scaling[winScale];
-	l_info("Win Size Factor: %d ms",
+	l_debug("Win Size Factor: %d ms",
 			(frnd_relay_window * scaling[winScale]) / 10);
 
 	/* Normalize to ms */
@@ -244,7 +244,7 @@ void friend_request(struct mesh_net *net, uint16_t src,
 	else if (rsp_delay > MAX_RESP_DELAY)
 		rsp_delay = MAX_RESP_DELAY;
 
-	l_info("Total Response Delay: %d ms", rsp_delay);
+	l_debug("Total Response Delay: %d ms", rsp_delay);
 
 	/* Add in 100ms delay before start of "Offer Period" */
 	rsp_delay += RESPONSE_DELAY;
@@ -261,7 +261,7 @@ void friend_clear_confirm(struct mesh_net *net, uint16_t src,
 	struct frnd_negotiation *neg = l_queue_remove_if(frnd_negotiations,
 					match_by_lpn, L_UINT_TO_PTR(lpn));
 
-	l_info("Friend Clear confirmed %4.4x (cnt %4.4x)", lpn, lpnCounter);
+	l_debug("Friend Clear confirmed %4.4x (cnt %4.4x)", lpn, lpnCounter);
 
 	if (!neg)
 		return;
@@ -276,7 +276,7 @@ static void friend_poll_timeout(struct l_timeout *timeout, void *user_data)
 	struct mesh_friend *frnd = user_data;
 
 	if (mesh_friend_clear(frnd->net, frnd))
-		l_info("Friend Poll Timeout %4.4x", frnd->dst);
+		l_debug("Friend Poll Timeout %4.4x", frnd->dst);
 
 	l_timeout_remove(frnd->timeout);
 	frnd->timeout = NULL;
@@ -343,7 +343,7 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 			return;
 	}
 
-	l_info("Friend Cleared %4.4x (%4.4x)", lpn, lpnCounter);
+	l_debug("Friend Cleared %4.4x (%4.4x)", lpn, lpnCounter);
 
 	l_put_be16(lpn, msg + 1);
 	l_put_be16(lpnCounter, msg + 3);
@@ -369,11 +369,11 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
 
 	if (secs && ((secs << 1) < neg->poll_timeout/10)) {
 		neg->receive_delay++;
-		l_info("Try FRND_CLR again in %d seconds (total timeout %d)",
+		l_debug("Try FRND_CLR again in %d seconds (total timeout %d)",
 						secs, neg->poll_timeout/10);
 		l_timeout_modify(neg->timeout, secs);
 	} else {
-		l_info("FRND_CLR timed out %d", secs);
+		l_debug("FRND_CLR timed out %d", secs);
 		l_timeout_remove(timeout);
 		l_queue_remove(frnd_negotiations, neg);
 		l_free(neg);
@@ -407,7 +407,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 
 			seqZero &= SEQ_ZERO_MASK;
 
-			l_info("Fwd ACK pkt %6.6x-%8.8x",
+			l_debug("Fwd ACK pkt %6.6x-%8.8x",
 					pkt->u.one[0].seq,
 					pkt->iv_index);
 
@@ -420,7 +420,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 
 
 		} else {
-			l_info("Fwd CTL pkt %6.6x-%8.8x",
+			l_debug("Fwd CTL pkt %6.6x-%8.8x",
 					pkt->u.one[0].seq,
 					pkt->iv_index);
 
@@ -442,7 +442,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 		else
 			len = pkt->last_len;
 
-		l_info("Fwd FRND pkt %6.6x",
+		l_debug("Fwd FRND pkt %6.6x",
 				pkt->u.s12[pkt->cnt_out].seq);
 
 		print_packet("Frnd-Msg", pkt->u.s12[pkt->cnt_out].data, len);
@@ -462,7 +462,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 update:
 	/* No More Data -- send Update message with md = false */
 	net_seq = mesh_net_get_seq_num(net);
-	l_info("Fwd FRND UPDATE %6.6x with MD == 0", net_seq);
+	l_debug("Fwd FRND UPDATE %6.6x with MD == 0", net_seq);
 
 	frnd->last = frnd->seq;
 	mesh_net_get_snb_state(net, upd + 1, &iv_index);
@@ -488,7 +488,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 	if (neg && !neg->clearing) {
 		uint8_t msg[5] = { NET_OP_FRND_CLEAR };
 
-		l_info("Won negotiation for %4.4x", neg->low_power_node);
+		l_debug("Won negotiation for %4.4x", neg->low_power_node);
 
 		/* This call will clean-up and replace if already friends */
 		frnd = mesh_friend_new(net, src, neg->num_ele,
@@ -695,7 +695,7 @@ void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
 {
 	struct frnd_offers *offer;
 
-	l_info("RSSI of Offer: %d dbm", l_rssi);
+	l_debug("RSSI of Offer: %d dbm", l_rssi);
 
 	/* Ignore RFU window value 0 */
 	if (window == 0)
@@ -735,7 +735,7 @@ static void frnd_negotiated_to(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
 
-	l_info("frnd_negotiated_to");
+	l_debug("frnd_negotiated_to");
 	if (!mesh_net_get_friend(net)) {
 		l_timeout_remove(poll_period_to);
 		poll_period_to = NULL;
@@ -776,7 +776,7 @@ void frnd_poll(struct mesh_net *net, bool retry)
 		seq = !seq;
 		mesh_net_set_frnd_seq(net, seq);
 	} else if (!(poll_cnt--)) {
-		l_info("Lost Friendship with %4.4x", old_friend);
+		l_debug("Lost Friendship with %4.4x", old_friend);
 		l_timeout_remove(poll_period_to);
 		poll_period_to = NULL;
 		frnd_poll_cancel(net);
@@ -790,7 +790,7 @@ void frnd_poll(struct mesh_net *net, bool retry)
 	if (poll_retry_to)
 		l_timeout_remove(poll_retry_to);
 
-	l_info("TX-FRIEND POLL %d", seq);
+	l_debug("TX-FRIEND POLL %d", seq);
 	msg[1] = seq;
 	net_seq = mesh_net_get_seq_num(net);
 	mesh_net_transport_send(net, key_id, true,
@@ -858,7 +858,7 @@ static void req_timeout(struct l_timeout *timeout, void *user_data)
 		l_free(best);
 		return;
 	} else if (!best) {
-		l_info("No Offers Received");
+		l_debug("No Offers Received");
 		return;
 	}
 
@@ -884,7 +884,7 @@ static void req_timeout(struct l_timeout *timeout, void *user_data)
 
 old_keys_only:
 
-	l_info("Winning offer %4.4x RSSI: %ddb Window: %dms Cache sz: %d",
+	l_debug("Winning offer %4.4x RSSI: %ddb Window: %dms Cache sz: %d",
 			best->src, best->local_rssi,
 			best->window, best->cache);
 
@@ -930,23 +930,23 @@ void frnd_request_friend(struct mesh_net *net, uint8_t cache,
 		offers = l_queue_new();
 
 	msg[n++] = NET_OP_FRND_REQUEST;
-	msg[n] = cache & 0x07;		// MinRequirements - Cache
-	msg[n++] |= (offer_delay & 0x0f) << 3;	// Offer Delay
-	poll_period_ms = (timeout * 300) / 4; // 3/4 of the time in ms
-	l_put_be32(timeout, msg + n);	// PollTimeout
-	msg[n++] = delay;		// ReceiveDelay
+	msg[n] = cache & 0x07;		/* MinRequirements - Cache */
+	msg[n++] |= (offer_delay & 0x0f) << 3;	/* Offer Delay */
+	poll_period_ms = (timeout * 300) / 4; /* 3/4 of the time in ms */
+	l_put_be32(timeout, msg + n);	/* PollTimeout */
+	msg[n++] = delay;		/* ReceiveDelay */
 	n += 3;
-	l_put_be16(old_friend, msg + n);	// PreviousAddress
+	l_put_be16(old_friend, msg + n);	/* PreviousAddress */
 	n += 2;
-	msg[n++] = mesh_net_get_num_ele(net);	// NumElements
-	l_put_be16(cnt + 1, msg + n);	// Next counter
+	msg[n++] = mesh_net_get_num_ele(net);	/* NumElements */
+	l_put_be16(cnt + 1, msg + n);	/* Next counter */
 	n += 2;
 	print_packet("Tx-NET_OP_FRND_REQUEST", msg, n);
 	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, FRIENDS_ADDRESS,
 			msg, n);
-	l_timeout_create_ms(1000, req_timeout, net, NULL); // 1000 ms
+	l_timeout_create_ms(1000, req_timeout, net, NULL); /* 1000 ms */
 	mesh_net_set_friend(net, 0);
 	cnt++;
 }
@@ -1036,7 +1036,7 @@ void frnd_key_refresh(struct mesh_net *net, uint8_t phase)
 	case 0:
 	case 3:
 		if (new_lpn_id) {
-			l_info("LPN Retiring KeySet %d", lpn_key_id);
+			l_debug("LPN Retiring KeySet %d", lpn_key_id);
 			net_key_unref(lpn_key_id);
 			lpn_key_id = new_lpn_id;
 		}
-- 
2.14.5

