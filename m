Return-Path: <SRS0=oW7/=7N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E47C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 04:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10332070B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 May 2020 04:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgEaEl4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 May 2020 00:41:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:17964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaEl4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 May 2020 00:41:56 -0400
IronPort-SDR: JS/ICv7LH+kirTb3PZv9dhO9Jif4jNQJmQyEeBDCCwyn/7UNoNiReVIgZ7jqUoAO0xcrljPdev
 KA1nl/TKzcXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 21:41:53 -0700
IronPort-SDR: HzGmUVL0mbSrZiyLJmDt3Vi6vCTf62H5DH84xfGhP+Bkgjy2zZo1K/cLxABW06XEqfznruXy4w
 ZOGRBE9bVz7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,455,1583222400"; 
   d="scan'208";a="377087080"
Received: from rfcheney-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.68.158])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2020 21:41:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 4/5] mesh: Clean up style in net.c
Date:   Sat, 30 May 2020 21:41:27 -0700
Message-Id: <20200531044128.16734-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531044128.16734-1-inga.stotland@intel.com>
References: <20200531044128.16734-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/net.c | 253 +++++++++++++++++++++--------------------------------
 1 file changed, 100 insertions(+), 153 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 08544ad61..af891e5a9 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -520,7 +520,8 @@ uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
 
-	/* Cap out-of-range seq_num max value to +1. Out of range
+	/*
+	 * Cap out-of-range seq_num max value to +1. Out of range
 	 * seq_nums will not be sent as they would violate spec.
 	 * This condition signals a runaway seq_num condition, and
 	 * the node must wait for a completed IV Index update procedure
@@ -539,9 +540,7 @@ static struct mesh_sar *mesh_sar_new(size_t len)
 	struct mesh_sar *sar;
 
 	sar = l_malloc(size);
-
 	memset(sar, 0, size);
-
 	return sar;
 }
 
@@ -1372,20 +1371,18 @@ enqueue:
 			void *old = l_queue_remove_if(frnd->pkt_cache,
 							match_ack, rx);
 
-			if (old) {
-				if (old_head == old) {
-					/*
-					 * If we are discarding head for any
-					 * reason, reset FRND SEQ
-					 */
-					frnd->u.active.last =
-							frnd->u.active.seq;
-				}
-
-				l_free(old);
-			} else
+			if (!old)
 				break;
 
+			if (old_head == old)
+				/*
+				 * If we are discarding head for any
+				 * reason, reset FRND SEQ
+				 */
+				frnd->u.active.last = frnd->u.active.seq;
+
+			l_free(old);
+
 		} while (true);
 	}
 
@@ -1465,6 +1462,7 @@ static bool friend_packet_queue(struct mesh_net *net,
 			data += 12;
 			hdr += (1 << SEGO_HDR_SHIFT);
 		}
+
 		frnd_msg->u.s12[seg_max].seq = seq;
 		frnd_msg->cnt_in = seg_max;
 		frnd_msg->last_len = size % 12;
@@ -1488,6 +1486,7 @@ static bool friend_packet_queue(struct mesh_net *net,
 			memcpy(frnd_msg->u.one[0].data, data, size);
 			frnd_msg->last_len = size;
 		}
+
 		frnd_msg->u.one[0].hdr = hdr;
 		frnd_msg->u.one[0].seq = seq;
 	}
@@ -1640,7 +1639,6 @@ static void inmsg_to(struct l_timeout *msg_timeout, void *user_data)
 		return;
 
 	sar->msg_timeout = NULL;
-
 	mesh_sar_free(sar);
 }
 
@@ -2034,10 +2032,8 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		send_net_ack(net, sar_in, expected);
 
 		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
-				sar_in->remote, dst,
-				key_aid, true, szmic,
-				sar_in->seqZero,
-				sar_in->buf, sar_in->len);
+				sar_in->remote, dst, key_aid, true, szmic,
+				sar_in->seqZero, sar_in->buf, sar_in->len);
 
 		/* Kill Inter-Seg timeout */
 		l_timeout_remove(sar_in->seg_timeout);
@@ -2080,12 +2076,8 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 		uint32_t hdr = opcode << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl - 1;
 
-		if (friend_packet_queue(net, iv_index,
-					true, frnd_ttl,
-					seq,
-					src, dst,
-					hdr,
-					pkt, len))
+		if (friend_packet_queue(net, iv_index, true, frnd_ttl, seq,
+						src, dst, hdr, pkt, len))
 			return true;
 	}
 
@@ -2103,10 +2095,8 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 			return false;
 
 		print_packet("Rx-NET_OP_FRND_POLL", pkt, len);
-		friend_poll(net, src, !!(pkt[0]),
-				l_queue_find(net->friends,
-						match_by_friend,
-						L_UINT_TO_PTR(src)));
+		friend_poll(net, src, !!(pkt[0]), l_queue_find(net->friends,
+					match_by_friend, L_UINT_TO_PTR(src)));
 		break;
 
 	case NET_OP_FRND_REQUEST:
@@ -2142,8 +2132,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 
 		print_packet("Rx-NET_OP_FRND_CLEAR", pkt, len);
 		friend_clear(net, src, l_get_be16(pkt), l_get_be16(pkt + 2),
-				l_queue_find(net->friends,
-					match_by_friend,
+				l_queue_find(net->friends, match_by_friend,
 					L_UINT_TO_PTR(l_get_be16(pkt))));
 		l_debug("Remaining Friends: %d", l_queue_length(net->friends));
 		break;
@@ -2163,9 +2152,8 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 			return false;
 
 		print_packet("Rx-NET_OP_PROXY_SUB_REMOVE", pkt, len);
-		friend_sub_del(net, l_queue_find(net->friends,
-					match_by_friend, L_UINT_TO_PTR(src)),
-				pkt, len);
+		friend_sub_del(net, l_queue_find(net->friends, match_by_friend,
+						L_UINT_TO_PTR(src)), pkt, len);
 		break;
 
 	case NET_OP_PROXY_SUB_CONFIRM:
@@ -2199,12 +2187,10 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 		break;
 	}
 
-	if (n) {
-		mesh_net_transport_send(net, 0, 0,
-				mesh_net_get_iv_index(net), rsp_ttl,
-				0, dst & 0x8000 ? 0 : dst, src,
-				msg, n);
-	}
+	if (n)
+		mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
+					rsp_ttl, 0, dst & 0x8000 ? 0 : dst,
+					src, msg, n);
 
 	return true;
 }
@@ -2335,17 +2321,12 @@ static enum _relay_advice packet_received(void *user_data,
 
 	print_packet("RX: Network [clr] :", packet + 2, size);
 
-	if (!mesh_crypto_packet_parse(packet + 2, size,
-					&net_ctl, &net_ttl,
-					&net_seq,
-					&net_src, &net_dst,
-					&cache_cookie,
-					&net_opcode,
-					&net_segmented,
-					&net_key_id,
-					&net_szmic, &net_relay, &net_seqZero,
-					&net_segO, &net_segN,
-					&msg, &app_msg_len)) {
+	if (!mesh_crypto_packet_parse(packet + 2, size, &net_ctl, &net_ttl,
+					&net_seq, &net_src, &net_dst,
+					&cache_cookie, &net_opcode,
+					&net_segmented, &net_key_id, &net_szmic,
+					&net_relay, &net_seqZero, &net_segO,
+					&net_segN, &msg, &app_msg_len)) {
 		l_error("Failed to parse packet content");
 		return RELAY_NONE;
 	}
@@ -2360,8 +2341,10 @@ static enum _relay_advice packet_received(void *user_data,
 	if (is_us(net, net_src, true))
 		return RELAY_NONE;
 
-	/* As a Relay, suppress repeats of last N packets that pass through */
-	/* The "cache_cookie" should be unique part of App message */
+	/*
+	 * As a Relay, suppress repeats of last N packets that pass through
+	 * The "cache_cookie" should be unique part of App message.
+	 */
 	if (msg_in_cache(net, net_src, net_seq, cache_cookie))
 		return RELAY_NONE;
 
@@ -2388,57 +2371,48 @@ static enum _relay_advice packet_received(void *user_data,
 				/* If this is an ACK to our friend queue-only */
 				if (is_lpn_friend(net, net_dst))
 					friend_ack_rxed(net, iv_index, net_seq,
-							net_src, net_dst,
-							msg);
+							net_src, net_dst, msg);
 				else
 					ack_received(net, false,
 							net_src, net_dst,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
-				ctl_received(net, key_id,
-						iv_index,
-						net_ttl, net_seq, net_src,
-						net_dst, net_opcode, rssi,
-						msg, app_msg_len);
+				ctl_received(net, key_id, iv_index, net_ttl,
+						net_seq, net_src, net_dst,
+						net_opcode, rssi, msg,
+								app_msg_len);
 			}
 		} else if (net_segmented) {
-			/* If we accept SAR packets to non-Unicast, then
+			/*
+			 * If we accept SAR packets to non-Unicast, then
 			 * Friend Sar at least needs to be Unicast Only
 			 */
 			if (is_lpn_friend(net, net_dst) &&
 							!(net_dst & 0x8000)) {
-				/* Check TTL >= 2 before accepting segments
+				/*
+				 * Check TTL >= 2 before accepting segments
 				 * for Friends
 				 */
 				if (net_ttl >= 2) {
-					friend_seg_rxed(net, iv_index,
-						net_ttl, net_seq,
-						net_src, net_dst,
+					friend_seg_rxed(net, iv_index, net_ttl,
+						net_seq, net_src, net_dst,
 						l_get_be32(packet + 2 + 9),
 						msg, app_msg_len);
 				}
 			} else {
 				seg_rxed(net, NULL, iv_index, net_ttl,
-						net_seq, net_idx,
-						net_src, net_dst,
-						net_key_id,
-						net_szmic, net_seqZero,
-						net_segO, net_segN,
+						net_seq, net_idx, net_src,
+						net_dst, net_key_id, net_szmic,
+						net_seqZero, net_segO, net_segN,
 						msg, app_msg_len);
 			}
 
 		} else {
-			msg_rxed(net, NULL,
-						iv_index,
-						net_ttl,
-						net_seq,
-						net_idx,
-						net_src, net_dst,
-						net_key_id,
-						false, false,
-						net_seq & SEQ_ZERO_MASK,
-						msg, app_msg_len);
+			msg_rxed(net, NULL, iv_index, net_ttl, net_seq, net_idx,
+					net_src, net_dst, net_key_id, false,
+					false, net_seq & SEQ_ZERO_MASK, msg,
+					app_msg_len);
 		}
 
 		/* If this is one of our Unicast addresses, disallow relay */
@@ -2495,8 +2469,8 @@ static void net_rx(void *net_ptr, void *user_data)
 		rssi = data->info->rssi;
 	}
 
-	relay_advice = packet_received(net, key_id, iv_index,
-							out, out_size, rssi);
+	relay_advice = packet_received(net, key_id, iv_index, out, out_size,
+									rssi);
 	if (relay_advice > data->relay_advice) {
 		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
@@ -2560,6 +2534,7 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 		l_debug("iv_upd_state = IV_UPD_NORMAL_HOLD");
 		net->iv_upd_state = IV_UPD_NORMAL_HOLD;
 		l_timeout_modify(net->iv_update_timeout, IV_IDX_UPD_MIN);
+
 		if (net->iv_update)
 			mesh_net_set_seq_num(net, 0);
 
@@ -2578,10 +2553,12 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 		net->iv_update_timeout = NULL;
 		l_debug("iv_upd_state = IV_UPD_NORMAL");
 		net->iv_upd_state = IV_UPD_NORMAL;
+
 		if (net->iv_update)
 			mesh_net_set_seq_num(net, 0);
 
 		net->iv_update = false;
+
 		if (net->seq_num > IV_UPDATE_SEQ_TRIGGER)
 			mesh_net_iv_index_update(net);
 		break;
@@ -2605,7 +2582,8 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	l_debug("Key refresh procedure phase 2: start using new net TX keys");
 	subnet->key_refresh = 1;
 	subnet->net_key_tx = subnet->net_key_upd;
-	/* TODO: Provisioner may need to stay in phase three until
+	/*
+	 * TODO: Provisioner may need to stay in phase three until
 	 * it hears beacons from all the nodes
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
@@ -2686,7 +2664,8 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 			if (iv_index == net->iv_index && !net->iv_update)
 				return;
 
-			/* Other devices will be accepting old or new iv_index,
+			/*
+			 * Other devices will be accepting old or new iv_index,
 			 * but we don't know how far through update they are.
 			 * Starting permissive state will allow us maximum
 			 * (96 hours) to resync
@@ -2694,7 +2673,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 			l_debug("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
 			net->iv_update_timeout = l_timeout_create(
-				IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
+					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
 		} else {
 			l_debug("iv_upd_state = IV_UPD_NORMAL");
 			net->iv_upd_state = IV_UPD_NORMAL;
@@ -2771,8 +2750,8 @@ static void process_beacon(void *net_ptr, void *user_data)
 	 * Ignore the beacon if it doesn't change anything, unless we're
 	 * doing IV Recovery
 	 */
-	if (net->iv_upd_state == IV_UPD_INIT ||
-				ivi != net->iv_index || ivu != net->iv_update)
+	if (net->iv_upd_state == IV_UPD_INIT || ivi != net->iv_index ||
+							ivu != net->iv_update)
 		update_iv_ivu_state(net, ivi, ivu);
 
 	if (kr != local_kr)
@@ -2879,6 +2858,7 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	if (phase == KEY_REFRESH_PHASE_TWO) {
 		subnet->key_refresh = 1;
 		subnet->net_key_tx = subnet->net_key_upd;
+
 		if (net->beacon_enable) {
 			/* Switch beaconing key */
 			net_key_beacon_disable(subnet->net_key_cur);
@@ -2958,6 +2938,7 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 
 	l_debug("iv_upd_state = IV_UPD_UPDATING");
 	mesh_net_flush_msg_queues(net);
+
 	if (!mesh_config_write_iv_index(node_config_get(net->node),
 						net->iv_index + 1, true))
 		return false;
@@ -3077,7 +3058,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 		return false;
 
 	if (!net_key_encrypt(subnet->net_key_tx, msg->iv_index, packet + 1,
-							     packet_len)) {
+								packet_len)) {
 		l_error("Failed to encode packet");
 		return false;
 	}
@@ -3090,12 +3071,9 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 }
 
 void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
-				uint32_t iv_index,
-				uint8_t ttl,
-				uint32_t seq,
-				uint16_t src, uint16_t dst,
-				uint32_t hdr,
-				const void *seg, uint16_t seg_len)
+			uint32_t iv_index, uint8_t ttl, uint32_t seq,
+			uint16_t src, uint16_t dst, uint32_t hdr,
+			const void *seg, uint16_t seg_len)
 {
 	uint8_t packet[30];
 	uint8_t packet_len;
@@ -3112,15 +3090,10 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_debug("SEQ0: %6.6x", seq);
 	l_debug("segO: %d", segO);
 
-	if (!mesh_crypto_packet_build(false, ttl,
-				seq,
-				src, dst,
-				0,
-				segmented, app_key_id,
-				szmic, false, seqZero,
-				segO, segN,
-				seg, seg_len,
-				packet + 1, &packet_len)) {
+	if (!mesh_crypto_packet_build(false, ttl, seq, src, dst, 0,
+					segmented, app_key_id, szmic, false,
+					seqZero, segO, segN, seg, seg_len,
+					packet + 1, &packet_len)) {
 		l_error("Failed to build packet");
 		return;
 	}
@@ -3166,12 +3139,8 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	segmented |= !!(seg_max);
 
 	/* First enqueue to any Friends and internal models */
-	result = msg_rxed(net, false, iv_index, ttl,
-				seq,
-				net_idx,
-				src, dst,
-				key_aid, segmented,
-				szmic, seq & SEQ_ZERO_MASK,
+	result = msg_rxed(net, false, iv_index, ttl, seq, net_idx, src, dst,
+				key_aid, segmented, szmic, seq & SEQ_ZERO_MASK,
 				msg, msg_len);
 
 	/*
@@ -3203,7 +3172,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 		payload->id = ++net->sar_id_next;
 
 		/* Single thread SAR messages to same Unicast DST */
-		if (NULL != l_queue_find(net->sar_out, match_sar_remote,
+		if (l_queue_find(net->sar_out, match_sar_remote,
 							L_UINT_TO_PTR(dst))) {
 			/* Delay sending Outbound SAR unless prior
 			 * SAR to same DST has completed */
@@ -3242,13 +3211,9 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	return result;
 }
 
-void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
-				uint32_t iv_index,
-				uint8_t ttl,
-				uint32_t seq,
-				uint16_t src, uint16_t dst,
-				bool rly, uint16_t seqZero,
-				uint32_t ack_flags)
+void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id, uint32_t iv_index,
+			uint8_t ttl, uint32_t seq, uint16_t src, uint16_t dst,
+			bool rly, uint16_t seqZero, uint32_t ack_flags)
 {
 	uint32_t hdr;
 	uint8_t data[7];
@@ -3260,18 +3225,13 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 	hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
 	l_put_be32(hdr, data);
 	l_put_be32(ack_flags, data + 3);
-	if (!mesh_crypto_packet_build(true, ttl,
-					seq,
-					src, dst,
-					NET_OP_SEG_ACKNOWLEDGE,
-					false, /* Not Segmented */
-					0,	/* No Key ID associated */
-					false, rly, seqZero,
-					0, 0,	/* no segO or segN */
-					data + 1, 6,
-					pkt + 1, &pkt_len)) {
+
+	/* Not Segmented, no Key ID associated, no segO or segN */
+	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst,
+					NET_OP_SEG_ACKNOWLEDGE, false, 0, false,
+					rly, seqZero, 0, 0, data + 1, 6,
+					pkt + 1, &pkt_len))
 		return;
-	}
 
 	if (!key_id) {
 		struct mesh_subnet *subnet = get_primary_subnet(net);
@@ -3323,24 +3283,17 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 		uint32_t hdr = msg[0] << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl;
 
-		if (friend_packet_queue(net, iv_index,
-					true, frnd_ttl,
-					mesh_net_next_seq_num(net),
-					src, dst,
-					hdr,
-					msg + 1, msg_len - 1)) {
+		if (friend_packet_queue(net, iv_index, true, frnd_ttl,
+					mesh_net_next_seq_num(net), src, dst,
+					hdr, msg + 1, msg_len - 1))
 			return;
-		}
 	}
 
 	/* Deliver to Local entities if applicable */
-	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr) {
-		result = ctl_received(net, key_id,
-					iv_index, ttl,
-					mesh_net_next_seq_num(net),
-					src, dst,
+	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr)
+		result = ctl_received(net, key_id, iv_index, ttl,
+					mesh_net_next_seq_num(net), src, dst,
 					msg[0], 0, msg + 1, msg_len - 1);
-	}
 
 	if (!key_id) {
 		struct mesh_subnet *subnet = l_queue_find(net->subnets,
@@ -3355,15 +3308,9 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 			return;
 	}
 
-	if (!mesh_crypto_packet_build(true, ttl,
-				use_seq,
-				src, dst,
-				msg[0],
-				false, 0,
-				false, false, 0,
-				0, 0,
-				msg + 1, msg_len - 1,
-				pkt + 1, &pkt_len))
+	if (!mesh_crypto_packet_build(true, ttl, use_seq, src, dst, msg[0],
+				false, 0, false, false, 0, 0, 0, msg + 1,
+				msg_len - 1, pkt + 1, &pkt_len))
 		return;
 
 	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
@@ -3517,7 +3464,7 @@ void mesh_net_heartbeat_send(struct mesh_net *net)
 	n += 2;
 
 	mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
-				hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
+					hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
 }
 
 void mesh_net_heartbeat_init(struct mesh_net *net)
@@ -3575,7 +3522,7 @@ uint16_t mesh_net_get_primary_idx(struct mesh_net *net)
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr)
 {
 	struct mesh_friend *frnd = l_queue_find(net->friends, match_by_friend,
-						L_UINT_TO_PTR(addr));
+							L_UINT_TO_PTR(addr));
 
 	if (!frnd)
 		return 0;
-- 
2.26.2

