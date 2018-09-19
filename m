Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        inga.stotland@intel.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Refactor friend.c and net.c for central key DB
Date: Wed, 19 Sep 2018 13:40:05 -0700
Message-Id: <20180919204005.19267-3-brian.gix@intel.com>
In-Reply-To: <20180919204005.19267-1-brian.gix@intel.com>
References: <20180919204005.19267-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To enable multiple local nodes and friendships to
coexist, and minimize redundant encryption processing
---
 mesh/friend.c    | 188 +++++++++-------------
 mesh/friend.h    |   2 +-
 mesh/net.c       | 476 +++++++++++++++----------------------------------------
 mesh/net.h       |  14 +-
 mesh/provision.c |   5 +-
 5 files changed, 212 insertions(+), 473 deletions(-)

diff --git a/mesh/friend.c b/mesh/friend.c
index 5a4088ef1..9ce499463 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -29,6 +29,7 @@
 #include "mesh/mesh-defs.h"
 
 #include "mesh/mesh.h"
+#include "mesh/net_keys.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/crypto.h"
@@ -56,7 +57,7 @@ static uint8_t frnd_sublist_size = FRND_SUB_LIST_SIZE;
 struct frnd_negotiation {
 	struct l_timeout	*timeout;
 	struct mesh_net		*net;
-	struct mesh_key_set	key_set;
+	uint32_t		key_id;
 	uint32_t		poll_timeout;
 	uint16_t		low_power_node;
 	uint16_t		old_relay;
@@ -79,7 +80,7 @@ static void response_timeout(struct l_timeout *timeout, void *user_data)
 	/* LPN did not choose us */
 	l_info("Did not win negotiation for %4.4x", neg->low_power_node);
 
-	mesh_net_remove_keyset(neg->net, &neg->key_set);
+	net_key_unref(neg->key_id);
 	l_queue_remove(frnd_negotiations, neg);
 	l_timeout_remove(timeout);
 	l_free(neg);
@@ -89,8 +90,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 {
 	struct frnd_negotiation *neg = user_data;
 	uint16_t net_idx = mesh_net_get_primary_idx(neg->net);
-	uint8_t key[16];
-	uint8_t p[9] = { 1 };
+	uint32_t key_id;
 	uint8_t msg[8];
 	uint16_t n = 0;
 	bool res;
@@ -98,27 +98,17 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(timeout);
 
 	/* Create key Set for this offer */
-	l_put_be16(neg->low_power_node, p + 1);
-	l_put_be16(mesh_net_get_address(neg->net), p + 3);
-	l_put_be16(neg->lp_cnt, p + 5);
-	l_put_be16(counter, p + 7);
-	res = mesh_net_get_key(neg->net, false, net_idx, key);
+	res = mesh_net_get_key(neg->net, false, net_idx, &key_id);
 	if (!res)
 		goto cleanup;
 
-	print_packet("Friend Key P =", p, 9);
-	res = mesh_crypto_k2(key, p, sizeof(p), &neg->key_set.nid,
-			neg->key_set.enc_key, neg->key_set.privacy_key);
-	if (!res)
+	neg->key_id = net_key_frnd_add(key_id, neg->low_power_node,
+						mesh_net_get_address(neg->net),
+						neg->lp_cnt, counter);
+	if (!neg->key_id)
 		goto cleanup;
 
-	print_packet("NID =", &neg->key_set.nid, 1);
-	print_packet("ENC_KEY =", neg->key_set.enc_key, 16);
-	print_packet("PRIV_KEY =", neg->key_set.privacy_key, 16);
-
 	neg->fn_cnt = counter++;
-	neg->key_set.frnd = true;
-	mesh_net_add_keyset(neg->net, &neg->key_set);
 
 	msg[n++] = NET_OP_FRND_OFFER;
 	msg[n++] = frnd_relay_window;
@@ -128,7 +118,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	l_put_be16(neg->fn_cnt, msg + n);
 	n += 2;
 	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
-	mesh_net_transport_send(neg->net, NULL, true,
+	mesh_net_transport_send(neg->net, 0, true,
 			mesh_net_get_iv_index(neg->net), 0,
 			0, 0, neg->low_power_node,
 			msg, n);
@@ -142,7 +132,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	return;
 
 cleanup:
-	mesh_net_remove_keyset(neg->net, &neg->key_set);
+	net_key_unref(neg->key_id);
 	l_queue_remove(frnd_negotiations, neg);
 	l_free(neg);
 }
@@ -357,7 +347,7 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 
 	l_put_be16(lpn, msg + 1);
 	l_put_be16(lpnCounter, msg + 3);
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), DEFAULT_TTL,
 			0, 0, src,
 			msg, sizeof(msg));
@@ -372,7 +362,7 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
 
 	l_put_be16(neg->low_power_node, msg + 1);
 	l_put_be16(neg->lp_cnt, msg + 3);
-	mesh_net_transport_send(neg->net, NULL, false,
+	mesh_net_transport_send(neg->net, 0, false,
 			mesh_net_get_iv_index(neg->net), DEFAULT_TTL,
 			0, 0, neg->old_relay,
 			msg, sizeof(msg));
@@ -422,7 +412,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 					pkt->iv_index);
 
 			pkt->u.one[0].sent = true;
-			mesh_net_ack_send(net, &frnd->key_set,
+			mesh_net_ack_send(net, frnd->net_key_cur,
 					pkt->iv_index, pkt->ttl,
 					pkt->u.one[0].seq, pkt->src, pkt->dst,
 					rly, seqZero,
@@ -438,7 +428,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 					pkt->u.one[0].data, pkt->last_len);
 
 			pkt->u.one[0].sent = true;
-			mesh_net_transport_send(net, &frnd->key_set, false,
+			mesh_net_transport_send(net, frnd->net_key_cur, false,
 					pkt->iv_index, pkt->ttl,
 					pkt->u.one[0].seq, pkt->src, pkt->dst,
 					pkt->u.one[0].data, pkt->last_len);
@@ -458,7 +448,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 		print_packet("Frnd-Msg", pkt->u.s12[pkt->cnt_out].data, len);
 
 		pkt->u.s12[pkt->cnt_out].sent = true;
-		mesh_net_send_seg(net, &frnd->key_set,
+		mesh_net_send_seg(net, frnd->net_key_cur,
 				pkt->iv_index,
 				pkt->ttl,
 				pkt->u.s12[pkt->cnt_out].seq,
@@ -470,16 +460,16 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 	return;
 
 update:
-	// No More Data -- send Update message with md = false
+	/* No More Data -- send Update message with md = false */
 	net_seq = mesh_net_get_seq_num(net);
 	l_info("Fwd FRND UPDATE %6.6x with MD == 0", net_seq);
 
 	frnd->last = frnd->seq;
 	mesh_net_get_snb_state(net, upd + 1, &iv_index);
 	l_put_be32(iv_index, upd + 2);
-	upd[6] = false; // Queue is Empty
+	upd[6] = false; /* Queue is Empty */
 	print_packet("Update", upd, sizeof(upd));
-	mesh_net_transport_send(net, &frnd->key_set, false,
+	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->dst,
 			upd, sizeof(upd));
@@ -512,7 +502,8 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 					friend_poll_timeout, frnd, NULL);
 
 		l_timeout_remove(neg->timeout);
-		mesh_net_remove_keyset(neg->net, &neg->key_set);
+		net_key_unref(neg->key_id);
+		neg->key_id = 0;
 
 		if (neg->old_relay == 0 ||
 				neg->old_relay == mesh_net_get_address(net)) {
@@ -522,7 +513,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 			neg->clearing = true;
 			l_put_be16(neg->low_power_node, msg + 1);
 			l_put_be16(neg->lp_cnt, msg + 3);
-			mesh_net_transport_send(net, NULL, false,
+			mesh_net_transport_send(net, 0, false,
 					mesh_net_get_iv_index(net), DEFAULT_TTL,
 					0, 0, neg->old_relay,
 					msg, sizeof(msg));
@@ -630,7 +621,7 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, &frnd->key_set, false,
+	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->dst,
 			msg, sizeof(msg));
@@ -668,7 +659,7 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, &frnd->key_set, false,
+	mesh_net_transport_send(net, frnd->net_key_cur, false,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->dst,
 			msg, sizeof(msg));
@@ -695,8 +686,8 @@ static uint16_t fn_cnt, cnt = 0xffff;
 static uint32_t poll_period_ms;
 static struct l_timeout *poll_retry_to;
 static struct l_timeout *poll_period_to;
-static struct mesh_key_set lpn_set;
-static struct mesh_key_set new_lpn_set;
+static uint32_t lpn_key_id;
+static uint32_t new_lpn_id;
 
 void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
 			uint8_t cache, uint8_t sub_list_size,
@@ -763,13 +754,13 @@ void frnd_poll_cancel(struct mesh_net *net)
 
 void frnd_poll(struct mesh_net *net, bool retry)
 {
-	struct mesh_key_set *key_set = &lpn_set;
+	uint32_t key_id = lpn_key_id;
 	uint32_t net_seq;
 	uint8_t msg[2] = { NET_OP_FRND_POLL };
 	bool seq = mesh_net_get_frnd_seq(net);
 
 	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_set.nid != 0xff) {
+	if (new_lpn_id) {
 		uint8_t phase;
 		uint16_t net_idx = mesh_net_get_primary_idx(net);
 		uint8_t status =
@@ -777,7 +768,7 @@ void frnd_poll(struct mesh_net *net, bool retry)
 
 		if (status == MESH_STATUS_SUCCESS &&
 				phase == KEY_REFRESH_PHASE_TWO)
-			key_set = &new_lpn_set;
+			key_id = new_lpn_id;
 	}
 
 	if (!retry) {
@@ -789,8 +780,9 @@ void frnd_poll(struct mesh_net *net, bool retry)
 		l_timeout_remove(poll_period_to);
 		poll_period_to = NULL;
 		frnd_poll_cancel(net);
-		mesh_net_remove_keyset(net, &lpn_set);
-		mesh_net_remove_keyset(net, &new_lpn_set);
+		net_key_unref(lpn_key_id);
+		net_key_unref(new_lpn_id);
+		new_lpn_id = lpn_key_id = 0;
 		mesh_net_set_friend(net, 0);
 		return;
 	}
@@ -801,7 +793,7 @@ void frnd_poll(struct mesh_net *net, bool retry)
 	l_info("TX-FRIEND POLL %d", seq);
 	msg[1] = seq;
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, key_set, true,
+	mesh_net_transport_send(net, key_id, true,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, mesh_net_get_friend(net),
 			msg, sizeof(msg));
@@ -828,8 +820,7 @@ static void req_timeout(struct l_timeout *timeout, void *user_data)
 	struct mesh_net *net = user_data;
 	struct frnd_offers *best;
 	struct frnd_offers *offer = l_queue_pop_head(offers);
-	uint8_t p[9] = { 1 };
-	uint8_t key[16];
+	uint32_t key_id = 0;
 	bool res;
 
 	l_timeout_remove(timeout);
@@ -860,8 +851,9 @@ static void req_timeout(struct l_timeout *timeout, void *user_data)
 		offer = l_queue_pop_head(offers);
 	}
 
-	mesh_net_remove_keyset(net, &lpn_set);
-	mesh_net_remove_keyset(net, &new_lpn_set);
+	net_key_unref(lpn_key_id);
+	net_key_unref(new_lpn_id);
+	new_lpn_id = lpn_key_id = 0;
 	if (mesh_net_get_friend(net)) {
 		l_free(best);
 		return;
@@ -871,41 +863,24 @@ static void req_timeout(struct l_timeout *timeout, void *user_data)
 	}
 
 	fn_cnt = best->fn_cnt;
-	l_put_be16(mesh_net_get_address(net), p + 1);
-	l_put_be16(best->src, p + 3);
-	l_put_be16(cnt, p + 5);
-	l_put_be16(best->fn_cnt, p + 7);
-	print_packet("Friend Key P =", p, 9);
-	res = mesh_net_get_key(net, false, mesh_net_get_primary_idx(net), key);
+	res = mesh_net_get_key(net, false, mesh_net_get_primary_idx(net),
+								&key_id);
 	if (!res)
 		return;
 
-	res = mesh_crypto_k2(key, p, sizeof(p), &lpn_set.nid,
-			lpn_set.enc_key, lpn_set.privacy_key);
-	if (!res)
+	lpn_key_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
+						best->src, cnt, best->fn_cnt);
+	if (!lpn_key_id)
 		return;
 
-	print_packet("Cur-NID", &lpn_set.nid, 1);
-	print_packet("Cur-ENC_KEY", lpn_set.enc_key, 16);
-	print_packet("Cur-PRIV_KEY", lpn_set.privacy_key, 16);
-
-	mesh_net_add_keyset(net, &lpn_set);
+	res = mesh_net_get_key(net, true, mesh_net_get_primary_idx(net),
+								&key_id);
 
-	res = mesh_net_get_key(net, true, mesh_net_get_primary_idx(net), key);
-
-	if (res)
-		res = mesh_crypto_k2(key, p, sizeof(p), &new_lpn_set.nid,
-			new_lpn_set.enc_key, new_lpn_set.privacy_key);
-	if (!res) {
-		new_lpn_set.nid = 0xff;
+	if (!res)
 		goto old_keys_only;
-	}
 
-	print_packet("New-NID", &new_lpn_set.nid, 1);
-	print_packet("New-ENC_KEY", new_lpn_set.enc_key, 16);
-	print_packet("New-PRIV_KEY", new_lpn_set.privacy_key, 16);
-
-	mesh_net_add_keyset(net, &new_lpn_set);
+	new_lpn_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
+						best->src, cnt, best->fn_cnt);
 
 old_keys_only:
 
@@ -935,11 +910,11 @@ void frnd_clear(struct mesh_net *net)
 	l_put_be16(cnt, msg + n);
 	n += 2;
 
-	mesh_net_remove_keyset(net, &lpn_set);
-	mesh_net_remove_keyset(net, &new_lpn_set);
+	net_key_unref(lpn_key_id);
+	net_key_unref(new_lpn_id);
 	mesh_net_set_friend(net, 0);
 
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, frnd_addr,
 			msg, n);
@@ -967,7 +942,7 @@ void frnd_request_friend(struct mesh_net *net, uint8_t cache,
 	l_put_be16(cnt + 1, msg + n);	// Next counter
 	n += 2;
 	print_packet("Tx-NET_OP_FRND_REQUEST", msg, n);
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, FRIENDS_ADDRESS,
 			msg, n);
@@ -979,13 +954,13 @@ void frnd_request_friend(struct mesh_net *net, uint8_t cache,
 static uint8_t trans_id;
 void frnd_sub_add(struct mesh_net *net, uint32_t parms[7])
 {
-	struct mesh_key_set *key_set = &lpn_set;
+	uint32_t key_id = lpn_key_id;
 	uint32_t net_seq;
 	uint8_t msg[15] = { NET_OP_PROXY_SUB_ADD };
 	uint8_t i, n = 1;
 
 	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_set.nid != 0xff) {
+	if (new_lpn_id) {
 		uint8_t phase;
 		uint16_t net_idx = mesh_net_get_primary_idx(net);
 		uint8_t status = mesh_net_key_refresh_phase_get(net,
@@ -993,7 +968,7 @@ void frnd_sub_add(struct mesh_net *net, uint32_t parms[7])
 
 		if (status == MESH_STATUS_SUCCESS &&
 				phase == KEY_REFRESH_PHASE_TWO)
-			key_set = &new_lpn_set;
+			key_id = new_lpn_id;
 	}
 
 	msg[n++] = ++trans_id;
@@ -1007,7 +982,7 @@ void frnd_sub_add(struct mesh_net *net, uint32_t parms[7])
 
 	net_seq = mesh_net_get_seq_num(net);
 	print_packet("Friend Sub Add", msg, n);
-	mesh_net_transport_send(net, key_set, false,
+	mesh_net_transport_send(net, key_id, false,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, mesh_net_get_friend(net),
 			msg, n);
@@ -1016,13 +991,13 @@ void frnd_sub_add(struct mesh_net *net, uint32_t parms[7])
 
 void frnd_sub_del(struct mesh_net *net, uint32_t parms[7])
 {
-	struct mesh_key_set *key_set = &lpn_set;
+	uint32_t key_id = lpn_key_id;
 	uint32_t net_seq;
 	uint8_t msg[15] = { NET_OP_PROXY_SUB_REMOVE };
 	uint8_t i, n = 1;
 
 	/* Check if we are in Phase 2 of Key Refresh */
-	if (new_lpn_set.nid != 0xff) {
+	if (new_lpn_id) {
 		uint8_t phase;
 		uint16_t net_idx = mesh_net_get_primary_idx(net);
 		uint8_t status = mesh_net_key_refresh_phase_get(net,
@@ -1030,7 +1005,7 @@ void frnd_sub_del(struct mesh_net *net, uint32_t parms[7])
 
 		if (status == MESH_STATUS_SUCCESS &&
 				phase == KEY_REFRESH_PHASE_TWO)
-			key_set = &new_lpn_set;
+			key_id = new_lpn_id;
 	}
 
 	msg[n++] = ++trans_id;
@@ -1044,7 +1019,7 @@ void frnd_sub_del(struct mesh_net *net, uint32_t parms[7])
 
 	net_seq = mesh_net_get_seq_num(net);
 	print_packet("Friend Sub Del", msg, n);
-	mesh_net_transport_send(net, key_set, false,
+	mesh_net_transport_send(net, key_id, false,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, mesh_net_get_friend(net),
 			msg, n);
@@ -1054,46 +1029,29 @@ void frnd_sub_del(struct mesh_net *net, uint32_t parms[7])
 void frnd_key_refresh(struct mesh_net *net, uint8_t phase)
 {
 	uint16_t net_idx = mesh_net_get_primary_idx(net);
-	uint8_t p[9] = { 1 };
-	uint8_t key[16];
+	uint32_t key_id;
 
 	switch (phase) {
 	default:
 	case 0:
 	case 3:
-		if (new_lpn_set.nid != 0xff) {
-			l_info("LPN Retiring KeySet %2.2x", lpn_set.nid);
-			lpn_set = new_lpn_set;
-			new_lpn_set.nid = 0xff;
-			mesh_net_remove_keyset(net, &new_lpn_set);
+		if (new_lpn_id) {
+			l_info("LPN Retiring KeySet %d", lpn_key_id);
+			net_key_unref(lpn_key_id);
+			lpn_key_id = new_lpn_id;
 		}
 		return;
 
 	case 1:
-		mesh_net_remove_keyset(net, &new_lpn_set);
-		if (!mesh_net_get_key(net, true, net_idx, key)) {
-			new_lpn_set.nid = 0xff;
-			return;
-		}
-
-		l_put_be16(mesh_net_get_address(net), p + 1);
-		l_put_be16(mesh_net_get_friend(net), p + 3);
-		l_put_be16(cnt, p + 5);
-		l_put_be16(fn_cnt, p + 7);
-		print_packet("Friend Key P =", p, 9);
-
-		if (!mesh_crypto_k2(key, p, sizeof(p), &new_lpn_set.nid,
-					new_lpn_set.enc_key,
-					new_lpn_set.privacy_key)) {
-			new_lpn_set.nid = 0xff;
+		net_key_unref(new_lpn_id);
+		if (!mesh_net_get_key(net, true, net_idx, &key_id)) {
+			new_lpn_id = 0;
 			return;
 		}
 
-		print_packet("New-NID", &new_lpn_set.nid, 1);
-		print_packet("New-ENC_KEY", new_lpn_set.enc_key, 16);
-		print_packet("New-PRIV_KEY", new_lpn_set.privacy_key, 16);
-
-		mesh_net_add_keyset(net, &new_lpn_set);
+		new_lpn_id = net_key_frnd_add(key_id, mesh_net_get_address(net),
+						mesh_net_get_friend(net),
+						cnt, fn_cnt);
 		return;
 
 	case 2:
@@ -1102,7 +1060,7 @@ void frnd_key_refresh(struct mesh_net *net, uint8_t phase)
 	}
 }
 
-struct mesh_key_set *frnd_get_key(struct mesh_net *net)
+uint32_t frnd_get_key(struct mesh_net *net)
 {
 	uint8_t idx = mesh_net_get_primary_idx(net);
 	uint8_t phase = 0;
@@ -1110,7 +1068,7 @@ struct mesh_key_set *frnd_get_key(struct mesh_net *net)
 	mesh_net_key_refresh_phase_get(net, idx, &phase);
 
 	if (phase == 2)
-		return &new_lpn_set;
+		return new_lpn_id;
 	else
-		return &lpn_set;
+		return lpn_key_id;
 }
diff --git a/mesh/friend.h b/mesh/friend.h
index 1fa6ec92a..7ab5dea2e 100644
--- a/mesh/friend.h
+++ b/mesh/friend.h
@@ -54,4 +54,4 @@ void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
 			uint8_t cache, uint8_t sub_list_size,
 			int8_t r_rssi, int8_t l_rssi, uint16_t fn_cnt);
 void frnd_key_refresh(struct mesh_net *net, uint8_t phase);
-struct mesh_key_set *frnd_get_key(struct mesh_net *net);
+uint32_t frnd_get_key(struct mesh_net *net);
diff --git a/mesh/net.c b/mesh/net.c
index fb17e639d..444d383e4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -31,6 +31,7 @@
 
 #include "mesh/display.h"
 #include "mesh/crypto.h"
+#include "mesh/net_keys.h"
 #include "mesh/mesh.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
@@ -64,8 +65,6 @@
 #define DEFAULT_TRANSMIT_COUNT		1
 #define DEFAULT_TRANSMIT_INTERVAL	100
 
-#define BEACON_TYPE_SNB		0x01
-
 #define BEACON_INTERVAL_MIN	10
 #define BEACON_INTERVAL_MAX	600
 
@@ -103,9 +102,9 @@ struct mesh_beacon {
 struct mesh_subnet {
 	struct mesh_net *net;
 	uint16_t idx;
-	struct net_key *tx;
-	struct net_key current;
-	struct net_key updated;
+	uint32_t net_key_tx;
+	uint32_t net_key_cur;
+	uint32_t net_key_upd;
 	struct mesh_beacon snb;
 	uint8_t key_refresh;
 	uint8_t kr_phase;
@@ -166,7 +165,6 @@ struct mesh_net {
 	struct l_queue *friends;
 	struct l_queue *destinations;
 	struct l_queue *fast_cache;
-	struct l_queue *key_sets;
 
 	uint8_t prov_priv_key[32];
 
@@ -267,22 +265,13 @@ static bool match_key_index(const void *a, const void *b)
 	return subnet->idx == idx;
 }
 
-static bool match_key_set(const void *a, const void *b)
+static bool match_key_id(const void *a, const void *b)
 {
 	const struct mesh_subnet *subnet = a;
-	const struct mesh_key_set *key_set = b;
+	uint32_t key_id = L_PTR_TO_UINT(b);
 
-	return (key_set == &subnet->current.key_set) ||
-					(key_set == &subnet->updated.key_set);
-}
-
-static bool match_network_id(const void *a, const void *b)
-{
-	const struct mesh_subnet *subnet = a;
-	const uint8_t *network_id = b;
-
-	return ((memcmp(subnet->current.network_id, network_id, 8) == 0) ||
-		(memcmp(subnet->updated.network_id, network_id, 8) == 0));
+	return (key_id == subnet->net_key_cur) ||
+					(key_id == subnet->net_key_upd);
 }
 
 static void idle_mesh_heartbeat_send(void *net)
@@ -333,29 +322,17 @@ static void free_friend_internals(struct mesh_friend *frnd)
 
 	frnd->pkt_cache = NULL;
 	frnd->grp_list = NULL;
-	mesh_net_remove_keyset(frnd->net, &frnd->key_set);
-	mesh_net_remove_keyset(frnd->net, &frnd->new_key_set);
+	net_key_unref(frnd->net_key_cur);
+	net_key_unref(frnd->net_key_upd);
 }
 
 static void frnd_kr_phase1(void *a, void *b)
 {
 	struct mesh_friend *frnd = a;
-	const uint8_t *key = b;
-	uint8_t p[9] = {0x01};
-
-	l_put_be16(frnd->dst, p + 1);
-	l_put_be16(frnd->net->src_addr, p + 3);
-	l_put_be16(frnd->lp_cnt, p + 5);
-	l_put_be16(frnd->fn_cnt, p + 7);
+	uint32_t key_id = L_PTR_TO_UINT(b);
 
-	mesh_crypto_k2(key, p, sizeof(p), &frnd->new_key_set.nid,
-				frnd->new_key_set.enc_key,
-				frnd->new_key_set.privacy_key);
-
-	mesh_net_add_keyset(frnd->net, &frnd->new_key_set);
-	l_info("Add New KeySet %2.2x for %4.4x",
-					frnd->new_key_set.nid, frnd->dst);
-	l_info("Outgoing with %2.2x", frnd->key_set.nid);
+	frnd->net_key_upd = net_key_frnd_add(key_id, frnd->dst,
+			frnd->net->src_addr, frnd->lp_cnt, frnd->fn_cnt);
 }
 
 static void frnd_kr_phase2(void *a, void *b)
@@ -369,20 +346,19 @@ static void frnd_kr_phase2(void *a, void *b)
 	 * receives it's first Poll using the new keys (?)
 	 */
 
-	l_info("Use Both KeySet %2.2x && %2.2x for %4.4x",
-			frnd->key_set.nid, frnd->new_key_set.nid, frnd->dst);
+	l_info("Use Both KeySet %d && %d for %4.4x",
+			frnd->net_key_cur, frnd->net_key_upd, frnd->dst);
 }
 
 static void frnd_kr_phase3(void *a, void *b)
 {
 	struct mesh_friend *frnd = a;
-	struct mesh_net *net = b;
 
-	l_info("Replace KeySet %2.2x with %2.2x for %4.4x",
-			frnd->key_set.nid, frnd->new_key_set.nid, frnd->dst);
-	frnd->key_set = frnd->new_key_set;
-	mesh_net_remove_keyset(net, &frnd->new_key_set);
-	frnd->new_key_set.nid = 0xff;
+	l_info("Replace KeySet %d with %d for %4.4x",
+			frnd->net_key_cur, frnd->net_key_upd, frnd->dst);
+	net_key_unref(frnd->net_key_cur);
+	frnd->net_key_cur = frnd->net_key_upd;
+	frnd->net_key_upd = 0;
 }
 
 /* TODO: add net key idx? For now, use primary net key */
@@ -392,7 +368,6 @@ struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
 					uint16_t fn_cnt, uint16_t lp_cnt)
 {
 	struct mesh_subnet *subnet;
-	uint8_t p[9] = {0x01};
 	struct mesh_friend *frnd = l_queue_find(net->friends,
 					match_by_friend, L_UINT_TO_PTR(dst));
 
@@ -416,33 +391,21 @@ struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
 	frnd->poll_timeout = fpt;
 	frnd->ele_cnt = ele_cnt;
 	frnd->pkt_cache = l_queue_new();
-	frnd->new_key_set.nid = NET_NID_INVALID;
-
-	l_put_be16(dst, p + 1);
-	l_put_be16(net->src_addr, p + 3);
-	l_put_be16(lp_cnt, p + 5);
-	l_put_be16(fn_cnt, p + 7);
+	frnd->net_key_upd = 0;
 
 	subnet = get_primary_subnet(net);
 	/* TODO: the primary key must be present, do we need to add check?. */
 
-	mesh_crypto_k2(subnet->current.key, p, sizeof(p),
-				&frnd->key_set.nid,
-				frnd->key_set.enc_key,
-				frnd->key_set.privacy_key);
-
-	frnd->key_set.frnd = true;
-	mesh_net_add_keyset(net, &frnd->key_set);
+	frnd->net_key_cur = net_key_frnd_add(subnet->net_key_cur,
+							dst, net->src_addr,
+							lp_cnt, fn_cnt);
 
-	if (subnet->updated.key_set.nid == NET_NID_INVALID)
+	if (!subnet->net_key_upd)
 		return frnd;
 
-	mesh_crypto_k2(subnet->updated.key, p, sizeof(p),
-				&frnd->new_key_set.nid,
-				frnd->new_key_set.enc_key,
-				frnd->new_key_set.privacy_key);
-	frnd->new_key_set.frnd = true;
-	mesh_net_add_keyset(net, &frnd->new_key_set);
+	frnd->net_key_upd = net_key_frnd_add(subnet->net_key_upd,
+							dst, net->src_addr,
+							lp_cnt, fn_cnt);
 
 	return frnd;
 }
@@ -465,26 +428,6 @@ bool mesh_friend_clear(struct mesh_net *net, struct mesh_friend *frnd)
 	return removed;
 }
 
-bool mesh_net_add_keyset(struct mesh_net *net, struct mesh_key_set *key_set)
-{
-	if (!net)
-		return false;
-
-	l_info("Add KEY_SET %2.2x (%d) %p",
-					key_set->nid, key_set->frnd, key_set);
-	return l_queue_push_tail(net->key_sets, key_set);
-}
-
-bool mesh_net_remove_keyset(struct mesh_net *net, struct mesh_key_set *key_set)
-{
-	if (!net || !net->key_sets)
-		return false;
-
-	l_info("DEL KEY_SET %2.2x (%d) %p",
-					key_set->nid, key_set->frnd, key_set);
-	return l_queue_remove(net->key_sets, key_set);
-}
-
 void mesh_friend_sub_add(struct mesh_net *net, uint16_t lpn, uint8_t ele_cnt,
 							uint8_t grp_cnt,
 							const uint8_t *list)
@@ -593,6 +536,15 @@ static void mesh_msg_free(void *data)
 	l_free(msg);
 }
 
+static void subnet_free(void *data)
+{
+	struct mesh_subnet *subnet = data;
+
+	net_key_unref(subnet->net_key_cur);
+	net_key_unref(subnet->net_key_upd);
+	l_free(subnet);
+}
+
 static void lpn_process_beacon(void *user_data, const void *data, uint8_t size,
 								int8_t rssi);
 
@@ -606,70 +558,17 @@ static struct mesh_subnet *subnet_new(struct mesh_net *net, uint16_t idx)
 
 	subnet->net = net;
 	subnet->idx = idx;
-	subnet->tx = &subnet->current;
-	subnet->updated.key_set.nid = NET_NID_INVALID;
 	subnet->snb.beacon[0] = MESH_AD_TYPE_BEACON;
 	return subnet;
 }
 
-static bool create_keys(struct mesh_net *net, struct net_key *keys,
-			const uint8_t *net_key)
-{
-	uint8_t nid[1];
-	uint8_t enc_key[16];
-	uint8_t privacy_key[16];
-	uint8_t network_id[8];
-	uint8_t p[] = {0};
-
-	if (!mesh_crypto_k2(net_key, p, sizeof(p),
-				nid, enc_key, privacy_key))
-		return false;
-
-	if (!mesh_crypto_k3(net_key, network_id))
-		return false;
-
-	if (!mesh_crypto_nkbk(net_key, keys->beacon_key))
-		return false;
-
-	keys->key_set.frnd = false;
-	keys->key_set.nid = nid[0];
-	memcpy(keys->key_set.enc_key, enc_key, 16);
-	memcpy(keys->key_set.privacy_key, privacy_key, 16);
-	memcpy(keys->network_id, network_id, 8);
-	memcpy(keys->key, net_key, 16);
-	return true;
-}
-
 static bool create_secure_beacon(struct mesh_net *net,
 					struct mesh_subnet *subnet,
-					uint8_t *beacon_data, uint8_t size)
+					uint8_t *beacon_data)
 {
-	uint64_t cmac;
-
-	if (size < 22)
-		return false;
-
-	beacon_data[0] = BEACON_TYPE_SNB;
-	beacon_data[1] = 0;
-
-	if (subnet->key_refresh)
-		beacon_data[1] |= 0x01;
-
-	if (iv_is_updating(net))
-		beacon_data[1] |= 0x02;
-
-	memcpy(beacon_data + 2, subnet->tx->network_id, 8);
-	l_put_be32(net->iv_index, beacon_data + 10);
-
-	if (!mesh_crypto_beacon_cmac(subnet->tx->beacon_key,
-					subnet->tx->network_id,
-					net->iv_index, subnet->key_refresh,
-					iv_is_updating(net), &cmac))
-		return false;
-
-	l_put_be64(cmac, beacon_data + 14);
-
-	return true;
+	return net_key_snb_compose(subnet->net_key_tx, net->iv_index,
+				!!subnet->key_refresh, iv_is_updating(net),
+								beacon_data);
 }
 
 static void send_network_beacon(struct mesh_subnet *subnet,
@@ -778,7 +677,6 @@ struct mesh_net *mesh_net_new(uint16_t index)
 	net->tx_interval = DEFAULT_TRANSMIT_INTERVAL;
 
 	net->subnets = l_queue_new();
-	net->key_sets = l_queue_new();
 	net->fast_cache = l_queue_new();
 	net->msg_cache = l_queue_new();
 	net->sar_in = l_queue_new();
@@ -811,11 +709,7 @@ void mesh_net_unref(struct mesh_net *net)
 	if (__sync_sub_and_fetch(&net->ref_count, 1))
 		return;
 
-	/* key_sets are not allocated to this queue. Only Borrowed */
-	l_queue_destroy(net->key_sets, NULL);
-	net->key_sets = NULL;
-
-	l_queue_destroy(net->subnets, l_free);
+	l_queue_destroy(net->subnets, subnet_free);
 	l_queue_destroy(net->fast_cache, mesh_msg_free);
 	l_queue_destroy(net->msg_cache, mesh_msg_free);
 	l_queue_destroy(net->sar_in, mesh_sar_free);
@@ -1071,12 +965,11 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	if (idx == net->heartbeat.pub_net_idx)
 		net->heartbeat.pub_dst = UNASSIGNED_ADDRESS;
 
-	mesh_net_remove_keyset(net, &subnet->current.key_set);
-	mesh_net_remove_keyset(net, &subnet->updated.key_set);
-
 	/* TODO: cancel beacon_enable on this subnet */
 
 	l_queue_remove(net->subnets, subnet);
+	subnet_free(subnet);
+
 	if (!storage_local_net_key_del(net, idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
@@ -1104,32 +997,33 @@ int mesh_net_add_key(struct mesh_net *net, bool update, uint16_t idx,
 			return MESH_STATUS_CANNOT_UPDATE;
 	}
 
-	if (subnet)
-		return memcmp(subnet->current.key, value, 16) ?
-			MESH_STATUS_IDX_ALREADY_STORED : MESH_STATUS_SUCCESS;
+	if (subnet) {
+		if (net_key_confirm(subnet->net_key_cur, value))
+			return MESH_STATUS_SUCCESS;
+		else
+			return MESH_STATUS_IDX_ALREADY_STORED;
+	}
 
 	subnet = subnet_new(net, idx);
 	if (!subnet)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!create_keys(net, &subnet->current, value) ||
-			!mesh_net_add_keyset(net, &subnet->current.key_set)) {
+	subnet->net_key_tx = subnet->net_key_cur = net_key_add(value);
+	if (!subnet->net_key_cur) {
 		l_free(subnet);
 		return MESH_STATUS_INSUFF_RESOURCES;
 	}
 
-	if (!create_secure_beacon(net, subnet, &subnet->snb.beacon[1], 22) ||
+	if (!create_secure_beacon(net, subnet, subnet->snb.beacon + 1) ||
 				!l_queue_push_tail(net->subnets, subnet)) {
-		mesh_net_remove_keyset(net, &subnet->current.key_set);
-		l_free(subnet);
+		subnet_free(subnet);
 		return MESH_STATUS_INSUFF_RESOURCES;
 	}
 
 	if (!storage_local_net_key_add(net, idx, value,
 					KEY_REFRESH_PHASE_NONE)) {
 		l_queue_remove(net->subnets, subnet);
-		mesh_net_remove_keyset(net, &subnet->current.key_set);
-		l_free(subnet);
+		subnet_free(subnet);
 		return MESH_STATUS_STORAGE_FAIL;
 	}
 
@@ -1171,7 +1065,7 @@ void mesh_net_get_snb_state(struct mesh_net *net, uint8_t *flags,
 }
 
 bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
-							uint8_t key_buf[16])
+							uint32_t *key_id)
 {
 	struct mesh_subnet *subnet;
 
@@ -1184,14 +1078,14 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
 		return false;
 
 	if (!new_key) {
-		memcpy(key_buf, subnet->current.key, 16);
+		*key_id = subnet->net_key_cur;
 		return true;
 	}
 
-	if (subnet->updated.key_set.nid == NET_NID_INVALID)
+	if (!subnet->net_key_upd)
 		return false;
 
-	memcpy(key_buf, subnet->updated.key, 16);
+	*key_id = subnet->net_key_upd;
 	return true;
 }
 
@@ -1673,7 +1567,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 		friend_ack_rxed(net, mesh_net_get_iv_index(net),
 				mesh_net_next_seq_num(net), 0, dst, msg);
 	} else {
-		mesh_net_transport_send(net, NULL, false,
+		mesh_net_transport_send(net, 0, false,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
 				0, 0, dst, msg, sizeof(msg));
 	}
@@ -1712,7 +1606,7 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 		return;
 	}
 
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
 				0, src, dst, msg, sizeof(msg));
 }
@@ -2319,7 +2213,7 @@ static bool ctl_received(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	}
 
 	if (n) {
-		mesh_net_transport_send(net, NULL, false,
+		mesh_net_transport_send(net, 0, false,
 				mesh_net_get_iv_index(net), rsp_ttl,
 				0, dst & 0x8000 ? 0 : dst, src,
 				msg, n);
@@ -2355,73 +2249,6 @@ static void *check_fast_cache(struct mesh_net *net, uint64_t hash)
 	return new_hash;
 }
 
-static bool match_keyset(const void *a, const void *b)
-{
-	const struct mesh_friend *frnd = a;
-	const struct mesh_key_set *key_set = b;
-
-	return (key_set == &frnd->key_set) || (key_set == &frnd->new_key_set);
-}
-
-static void try_decode(void *a, void *b)
-{
-	struct mesh_key_set *key_set = a;
-	struct net_decode *decode = b;
-	uint8_t tmp[29];
-	bool status;
-
-	if (decode->key_set || key_set->nid != decode->nid)
-		return;
-
-	status = mesh_crypto_packet_decode(decode->packet, decode->size,
-					decode->proxy, tmp, decode->iv_index,
-					key_set->enc_key, key_set->privacy_key);
-
-	if (!status)
-		return;
-
-	memcpy(decode->packet, tmp, decode->size);
-	decode->key_set = key_set;
-	if (key_set->frnd)
-		decode->frnd = l_queue_find(decode->net->friends,
-						match_keyset, key_set);
-	else
-		decode->frnd = NULL;
-}
-
-static struct mesh_key_set *net_packet_decode(struct mesh_net *net,
-				uint32_t iv_index, uint8_t nid,
-				struct mesh_friend **frnd,
-				bool proxy,
-				uint8_t *packet, uint8_t size)
-{
-	struct net_decode decode = {
-		.net = net,
-		.key_set = NULL,
-		.nid = nid,
-		.iv_index = iv_index,
-		.packet = packet,
-		.size = size,
-		.proxy = proxy,
-	};
-
-	l_queue_foreach(net->key_sets, try_decode, &decode);
-
-	if (decode.key_set != NULL) {
-		*frnd = decode.frnd;
-		return decode.key_set;
-	}
-	return NULL;
-}
-
-static bool match_key_nid(const void *a, const void *b)
-{
-	const struct mesh_key_set *key_set = a;
-	uint8_t nid = L_PTR_TO_UINT(b);
-
-	return key_set->nid == nid;
-}
-
 static bool match_by_dst(const void *a, const void *b)
 {
 	const struct mesh_destination *dest = a;
@@ -2469,30 +2296,23 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 	struct mesh_net *net = user_data;
 	uint32_t iv_index;
 	uint8_t iv_flag;
-	uint8_t nid;
 	const uint8_t *msg = data;
+	uint8_t *out;
+	size_t out_size;
 	uint8_t app_msg_len;
 	uint8_t net_ttl, net_key_id, net_segO, net_segN, net_opcode;
 	uint32_t net_seq, cache_cookie;
 	uint16_t net_src, net_dst, net_seqZero;
 	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
-	struct mesh_friend *net_frnd;
+	struct mesh_friend *net_frnd = NULL;
 	bool drop = false;
 	uint64_t hash, *isNew = NULL;
-	struct mesh_key_set *keys;
-
-	nid = msg[0] & 0x7f;
-
-	/* Ignore unrecognized NIDs */
-	if (!(l_queue_find(net->key_sets, match_key_nid, L_UINT_TO_PTR(nid)))) {
-		/* print_packet("Nope", data, size); */
-		return;
-	}
+	uint32_t key_id;
 
 	iv_flag = msg[0] >> 7;
 	iv_index = net->iv_index;
-	l_debug("%s iv_index %d NID: %2.2x", __func__, iv_index, nid);
+	l_debug("%s iv_index %d NID: %2.2x", __func__, iv_index, msg[0] & 0x7f);
 
 	if (sizeof(uint16_t) <= sizeof(void *)) {
 		/* Add in additional cache to allow us to
@@ -2520,9 +2340,9 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 	if (!drop)
 		print_packet("RX: Network [enc] :", data, size);
 
-	keys = net_packet_decode(net, iv_index, nid, &net_frnd, false,
-							packet + 2, size);
-	if (keys == NULL) {
+	key_id = net_key_decrypt(iv_index, packet + 2, size, &out, &out_size);
+
+	if (!key_id) {
 		l_debug("Failed to decode packet");
 		/* Remove fast-cache-hash */
 		l_queue_remove(net->fast_cache, isNew);
@@ -2530,6 +2350,8 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 		return;
 	}
 
+	memcpy(packet + 2, out, out_size);
+
 	if (!drop)
 		print_packet("RX: Network [clr] :", packet + 2, size);
 
@@ -2552,7 +2374,8 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 	if (net->friend_addr) {
 		struct mesh_subnet *subnet;
 
-		subnet = l_queue_find(net->subnets, match_key_set, keys);
+		subnet = l_queue_find(net->subnets, match_key_id,
+							L_UINT_TO_PTR(key_id));
 		if (subnet)
 			return;
 
@@ -2675,8 +2498,7 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 
 	packet[2 + 1] = (packet[2 + 1] & ~TTL_MASK) | (net_ttl - 1);
 
-	if (!mesh_crypto_packet_encode(packet + 2, size, keys->enc_key,
-					iv_index, keys->privacy_key)) {
+	if (!net_key_encrypt(key_id, iv_index, packet + 2, size)) {
 		l_error("Failed to encode relay packet");
 		return;
 	}
@@ -2709,8 +2531,7 @@ static void set_network_beacon(void *a, void *b)
 	struct mesh_net *net = b;
 	uint8_t beacon_data[22];
 
-	if (!create_secure_beacon(net, subnet, beacon_data,
-							sizeof(beacon_data)))
+	if (!create_secure_beacon(net, subnet, beacon_data))
 		return;
 
 	if (memcmp(&subnet->snb.beacon[1], beacon_data,
@@ -2889,10 +2710,9 @@ static void process_beacon(void *user_data, const void *data,
 	struct mesh_net *net = user_data;
 	const uint8_t *buf = data;
 	uint32_t iv_index;
-	uint64_t cmac;
 	bool iv_update, rxed_iv_update, rxed_key_refresh;
 	struct mesh_subnet *subnet;
-	struct net_key *keys;
+	uint32_t key_id;
 	bool kr_transition = false;
 
 	if (size != 22 || buf[0] != 0x01)
@@ -2914,8 +2734,10 @@ static void process_beacon(void *user_data, const void *data,
 			iv_update = true;
 	}
 
-	subnet = l_queue_find(net->subnets, match_network_id, buf + 2);
-	if (!subnet)
+	key_id = net_key_network_id(buf + 2);
+	subnet = l_queue_find(net->subnets, match_key_id,
+						L_UINT_TO_PTR(key_id));
+	if (!subnet || !key_id)
 		return;
 
 	/* Check if Key Refresh flag value is different from
@@ -2929,14 +2751,13 @@ static void process_beacon(void *user_data, const void *data,
 	 */
 	if (net->provisioner)
 		kr_transition = false;
-	else if (subnet->updated.key_set.nid == NET_NID_INVALID)
+	else if (!subnet->net_key_upd)
 		kr_transition = false;
 	/* If beacon's key refresh bit is not set and the beacon is encoded
 	 * with the "new" network key, this signals transition from
 	 * key refresh procedure to normal operation
 	 */
-	else if (!rxed_key_refresh &&
-			!memcmp(subnet->updated.network_id, buf + 2, 8))
+	else if (!rxed_key_refresh && subnet->net_key_upd == key_id)
 		kr_transition = true;
 
 	if ((net->iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
@@ -2952,26 +2773,16 @@ static void process_beacon(void *user_data, const void *data,
 	}
 
 	if (!rxed_key_refresh && !subnet->key_refresh && !kr_transition)
-		keys = &subnet->current;
-	else if (subnet->updated.key_set.nid != NET_NID_INVALID)
-		keys = &subnet->updated;
+		key_id = subnet->net_key_cur;
+	else if (subnet->net_key_upd)
+		key_id = subnet->net_key_upd;
 	else
 		return;
 
-	if (memcmp(keys->network_id, buf + 2, 8))
-		return;
-
-	/* Any behavioral changes must pass CMAC test */
-	if (!mesh_crypto_beacon_cmac(keys->beacon_key, keys->network_id,
-						iv_index, rxed_key_refresh,
-						rxed_iv_update, &cmac)) {
-		l_error("mesh_crypto_beacon_cmac failed");
-		return;
-	}
-
-	if (cmac != l_get_be64(buf + 14)) {
-		l_error("cmac compare failed %16.16lx != %16.16lx",
-						cmac, l_get_be64(buf + 14));
+	if (!net_key_snb_check(key_id, iv_index, rxed_key_refresh,
+						rxed_iv_update,
+						l_get_be64(buf + 14))) {
+		l_error("mesh_crypto_beacon verify failed");
 		return;
 	}
 
@@ -3033,7 +2844,7 @@ static void lpn_process_beacon(void *user_data, const void *data,
 	/* If the local node is a provisioner or there are no new keys,
 	 * ignore KR beacon setting
 	 */
-	if (subnet->updated.key_set.nid == NET_NID_INVALID)
+	if (!subnet->net_key_upd)
 		kr_transition = false;
 
 	if ((net->iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
@@ -3181,7 +2992,7 @@ void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr)
 	l_put_be16(addr, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, 0, msg, n);
 }
@@ -3194,7 +3005,7 @@ void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr)
 	l_put_be16(addr, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, NULL, false,
+	mesh_net_transport_send(net, 0, false,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, 0, msg, n);
 }
@@ -3304,7 +3115,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	uint8_t packet_len;
 	uint8_t segN = SEG_MAX(msg->len);
 	uint16_t seg_off = SEG_OFF(segO);
-	struct mesh_key_set *key_set = NULL;
+	uint32_t key_id = 0;
 	uint32_t seq_num = mesh_net_next_seq_num(net);
 
 	if (segN) {
@@ -3341,26 +3152,19 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	print_packet("Clr-Net Tx", packet + 1, packet_len);
 
 	if (msg->frnd_cred && net->friend_addr)
-		key_set = frnd_get_key(net);
+		key_id = frnd_get_key(net);
 
-	if (key_set == NULL) {
+	if (!key_id) {
 		struct mesh_subnet *subnet = get_primary_subnet(net);
 
-		key_set = &subnet->tx->key_set;
+		key_id = subnet->net_key_tx;
 	}
 
-	if (!mesh_crypto_packet_encode(packet + 1, packet_len, key_set->enc_key,
-					msg->iv_index, key_set->privacy_key)) {
+	if (!net_key_encrypt(key_id, msg->iv_index, packet + 1, packet_len)) {
 		l_error("Failed to encode packet");
 		return false;
 	}
 
-	print_packet("Step 3", packet + 1, packet_len);
-	if (!mesh_crypto_packet_label(packet + 1, packet_len,
-				msg->iv_index, key_set->nid)) {
-		l_error("Failed to label packet");
-		return false;
-	}
 	/* print_packet("Step 4", packet + 1, packet_len); */
 
 	{
@@ -3381,7 +3185,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	return true;
 }
 
-void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 				uint32_t iv_index,
 				uint8_t ttl,
 				uint32_t seq,
@@ -3393,7 +3197,7 @@ void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
 	uint8_t packet[30];
 	uint8_t packet_len;
 	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & true);
-	uint8_t key_id = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
+	uint8_t app_key_id = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
 	bool szmic = !!((hdr >> SZMIC_HDR_SHIFT) & true);
 	uint16_t seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) & SEQ_ZERO_MASK;
 	uint8_t segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
@@ -3409,7 +3213,7 @@ void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
 				seq,
 				src, dst,
 				0,
-				segmented, key_id,
+				segmented, app_key_id,
 				szmic, false, seqZero,
 				segO, segN,
 				seg, seg_len,
@@ -3418,18 +3222,11 @@ void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
 		return;
 	}
 
-	if (!mesh_crypto_packet_encode(packet + 1, packet_len, key_set->enc_key,
-					iv_index, key_set->privacy_key)) {
+	if (!net_key_encrypt(net_key_id, iv_index, packet + 1, packet_len)) {
 		l_error("Failed to encode packet");
 		return;
 	}
 
-	/* print_packet("Step 3", packet + 0, packet_len); */
-	if (!mesh_crypto_packet_label(packet + 1, packet_len, iv_index,
-							key_set->nid)) {
-		l_error("Failed to label packet");
-		return;
-	}
 	/* print_packet("Step 4", packet + 1, packet_len); */
 
 	send_msg_pkt(net, packet, packet_len + 1);
@@ -3557,7 +3354,7 @@ void mesh_net_app_send_cancel(struct mesh_net *net, unsigned int id)
 }
 
 /* TODO: add net key index */
-void mesh_net_ack_send(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index,
 				uint8_t ttl,
 				uint32_t seq,
@@ -3589,25 +3386,17 @@ void mesh_net_ack_send(struct mesh_net *net, struct mesh_key_set *key_set,
 		return;
 	}
 
-	if (key_set == NULL) {
+	if (!key_id) {
 		struct mesh_subnet *subnet = get_primary_subnet(net);
 
-		key_set = &subnet->tx->key_set;
+		key_id = subnet->net_key_tx;
 	}
 
-	if (!mesh_crypto_packet_encode(pkt + 1, pkt_len, key_set->enc_key,
-				iv_index, key_set->privacy_key)) {
+	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
 		l_error("Failed to encode packet");
 		return;
 	}
 
-	/* print_packet("Step 3", pkt, pkt_len); */
-	if (!mesh_crypto_packet_label(pkt + 1, pkt_len,
-				iv_index, key_set->nid)) {
-		l_error("Failed to label packet");
-		return;
-	}
-
 	/* print_packet("Step 4", pkt, pkt_len); */
 	send_msg_pkt(net, pkt, pkt_len + 1);
 
@@ -3619,7 +3408,7 @@ void mesh_net_ack_send(struct mesh_net *net, struct mesh_key_set *key_set,
 }
 
 /* TODO: add net key index */
-void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				bool fast, uint32_t iv_index, uint8_t ttl,
 				uint32_t seq, uint16_t src, uint16_t dst,
 				const uint8_t *msg, uint16_t msg_len)
@@ -3646,7 +3435,7 @@ void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
 		return;
 
 	/* Enqueue for Friend if forwardable and from us */
-	if (!(key_set) && src >= net->src_addr && src <= net->last_addr) {
+	if (!key_id && src >= net->src_addr && src <= net->last_addr) {
 		uint32_t hdr = msg[0] << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl;
 
@@ -3662,17 +3451,17 @@ void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
 
 	/* Deliver to Local entities if applicable */
 	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr) {
-		result = ctl_received(net, !!(key_set),
+		result = ctl_received(net, !!(key_id),
 					iv_index, ttl,
 					mesh_net_next_seq_num(net),
 					src, dst,
 					msg[0], 0, msg + 1, msg_len - 1);
 	}
 
-	if (key_set == NULL) {
+	if (!key_id) {
 		struct mesh_subnet *subnet = get_primary_subnet(net);
 
-		key_set = &subnet->tx->key_set;
+		key_id = subnet->net_key_tx;
 		use_seq = mesh_net_next_seq_num(net);
 
 		if (result || (dst >= net->src_addr && dst <= net->last_addr))
@@ -3692,16 +3481,8 @@ void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
 
 	/* print_packet("Step 2", pkt + 1, pkt_len); */
 
-	if (!mesh_crypto_packet_encode(pkt + 1, pkt_len, key_set->enc_key,
-					iv_index, key_set->privacy_key)) {
-		l_error("Failed to encode pkt");
-		return;
-	}
-
-	/* print_packet("Step 3", pkt + 1, pkt_len); */
-	if (!mesh_crypto_packet_label(pkt, pkt_len, iv_index,
-							key_set->nid)) {
-		l_error("Failed to label pkt");
+	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
+		l_error("Failed to encode packet");
 		return;
 	}
 
@@ -3787,15 +3568,15 @@ int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t idx,
 	if (!subnet)
 		return MESH_STATUS_CANNOT_UPDATE;
 
-	if (subnet->updated.key_set.nid != NET_NID_INVALID)
+	if (subnet->net_key_upd) {
+		net_key_unref(subnet->net_key_upd);
 		l_info("Warning: overwriting new keys");
+	}
 
 	/* Preserve starting data */
-	subnet->updated = subnet->current;
+	subnet->net_key_upd = net_key_add(value);
 
-	/* Generate new keys */
-	if (!create_keys(net, &subnet->updated, value)) {
-		subnet->updated.key_set.nid = NET_NID_INVALID;
+	if (!subnet->net_key_upd) {
 		l_error("Failed to start key refresh phase one");
 		return MESH_STATUS_CANNOT_UPDATE;
 	}
@@ -3805,11 +3586,11 @@ int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t idx,
 		frnd_key_refresh(net, 1);
 	else
 		/* If we are a Friend-Node, generate all our new keys */
-		l_queue_foreach(net->friends, frnd_kr_phase1, (void *)value);
+		l_queue_foreach(net->friends, frnd_kr_phase1,
+					L_UINT_TO_PTR(subnet->net_key_upd));
 
-	l_info("key refresh phase 1: NID 0x%2x", subnet->updated.key_set.nid);
+	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
 
-	mesh_net_add_keyset(net, &subnet->updated.key_set);
 	subnet->kr_phase = KEY_REFRESH_PHASE_ONE;
 
 	return MESH_STATUS_SUCCESS;
@@ -3825,12 +3606,12 @@ int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
 
-	if (!subnet || subnet->updated.key_set.nid == NET_NID_INVALID)
+	if (!subnet || !subnet->net_key_upd)
 		return MESH_STATUS_INVALID_NETKEY;
 
 	l_info("Key refresh procedure phase 2: start using new net TX keys");
 	subnet->key_refresh = 1;
-	subnet->tx = &subnet->updated;
+	subnet->net_key_tx = subnet->net_key_upd;
 	/* TODO: Provisioner may need to stay in phase three until
 	 * it hears beacons from all the nodes
 	 */
@@ -3855,7 +3636,7 @@ int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
 
-	if (!subnet || subnet->updated.key_set.nid == NET_NID_INVALID)
+	if (!subnet || !subnet->net_key_upd)
 		return MESH_STATUS_INVALID_NETKEY;
 
 	if (subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
@@ -3864,10 +3645,9 @@ int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	l_info("Key refresh phase 3: use new keys only, discard old ones");
 
 	/* Switch to using new keys, discard old ones */
-	subnet->current = subnet->updated;
-	subnet->tx = &subnet->current;
-	subnet->updated.key_set.nid = NET_NID_INVALID;
-	mesh_net_remove_keyset(net, &subnet->updated.key_set);
+	net_key_unref(subnet->net_key_cur);
+	subnet->net_key_tx = subnet->net_key_cur = subnet->net_key_upd;
+	subnet->net_key_upd = 0;
 	subnet->key_refresh = 0;
 	subnet->kr_phase = KEY_REFRESH_PHASE_NONE;
 	set_network_beacon(subnet, net);
@@ -3915,7 +3695,7 @@ void mesh_net_heartbeat_send(struct mesh_net *net)
 	l_put_be16(hb->features, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, NULL, false, mesh_net_get_iv_index(net),
+	mesh_net_transport_send(net, 0, false, mesh_net_get_iv_index(net),
 				hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
 }
 
diff --git a/mesh/net.h b/mesh/net.h
index e48380314..b8eb0699d 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -183,12 +183,12 @@ struct mesh_friend {
 	uint16_t *grp_list;
 	uint32_t poll_timeout;
 	uint32_t last_hdr;
+	uint32_t net_key_cur;
+	uint32_t net_key_upd;
 	uint16_t dst; /* Primary Element unicast addr */
 	uint16_t fn_cnt;
 	uint16_t lp_cnt;
 	int16_t grp_cnt;
-	struct mesh_key_set key_set;
-	struct mesh_key_set new_key_set;
 	uint8_t ele_cnt;
 	uint8_t frd;
 	uint8_t frw;
@@ -283,8 +283,6 @@ bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable, uint8_t cnt,
 							uint8_t interval);
 bool mesh_net_set_friend_mode(struct mesh_net *net, bool enable);
-bool mesh_net_add_keyset(struct mesh_net *net, struct mesh_key_set *key_set);
-bool mesh_net_remove_keyset(struct mesh_net *net, struct mesh_key_set *key_set);
 int mesh_net_del_key(struct mesh_net *net, uint16_t net_idx);
 int mesh_net_add_key(struct mesh_net *net, bool update,
 					uint16_t net_idx, const void *key);
@@ -292,13 +290,13 @@ uint32_t mesh_net_get_iv_index(struct mesh_net *net);
 void mesh_net_get_snb_state(struct mesh_net *net,
 					uint8_t *flags, uint32_t *iv_index);
 bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
-							uint8_t key[16]);
+							uint32_t *key_id);
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
 struct mesh_io *mesh_net_detach(struct mesh_net *net);
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
 bool mesh_net_flush(struct mesh_net *net);
-void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				bool fast, uint32_t iv_index, uint8_t ttl,
 				uint32_t seq, uint16_t src, uint16_t dst,
 				const uint8_t *msg, uint16_t msg_len);
@@ -310,7 +308,7 @@ unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
 				mesh_net_status_func_t status_func,
 				void *user_data);
 void mesh_net_app_send_cancel(struct mesh_net *net, unsigned int id);
-void mesh_net_ack_send(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
 				uint16_t seqZero, uint32_t ack_flags);
@@ -346,7 +344,7 @@ int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t net_idx,
 							const uint8_t *key);
 int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t net_idx);
 int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t net_idx);
-void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
+void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, uint32_t hdr,
 				const void *seg, uint16_t seg_len);
diff --git a/mesh/provision.c b/mesh/provision.c
index c7cb5f160..17422ce0a 100644
--- a/mesh/provision.c
+++ b/mesh/provision.c
@@ -39,6 +39,7 @@
 #include "src/shared/ecc.h"
 
 #include "mesh/display.h"
+#include "mesh/net_keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/prov.h"
@@ -286,6 +287,7 @@ static void send_prov_data(struct mesh_prov *prov)
 	struct mesh_net_prov_caps *caps = mesh_net_prov_caps_get(net);
 	uint64_t mic;
 	uint32_t iv_index;
+	uint32_t net_key_id;
 	uint8_t snb_flags;
 	uint16_t net_idx = mesh_prov_get_idx(prov);
 	uint8_t prov_data[1 + 16 + 2 + 1 + 4 + 2 + sizeof(mic)] = { PROV_DATA };
@@ -296,7 +298,8 @@ static void send_prov_data(struct mesh_prov *prov)
 	prov_expected = PROV_COMPLETE;
 	mesh_net_get_snb_state(net, &snb_flags, &iv_index);
 
-	mesh_net_get_key(net, !!(snb_flags & 0x01), net_idx, prov_data + 1);
+	mesh_net_get_key(net, !!(snb_flags & 0x01), net_idx, &net_key_id);
+	net_key_retrieve(net_key_id, prov_data + 1);
 	l_put_be16(net_idx, prov_data + 1 + 16);
 	l_put_u8(snb_flags, prov_data + 1 + 16 + 2);
 	l_put_be32(iv_index, prov_data + 1 + 16 + 2 + 1);
-- 
2.14.4
