Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A608CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 14:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiBCOjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiBCOi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 09:38:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A9C061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 06:38:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i34so6486333lfv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ag8PoNJdytatePpwe0+Hk8DTOcnWfgstvA3VVG/WQPk=;
        b=eDqY7tMmN9QAPXRAPWXBdwLQ7ypsBAS8a4MEfTKoI9cMJCqYY1zWSmpg6LTL+gzbkO
         Yj54Oc1VVDgJcvPWlcuFj7T3O3U9/qq1jEPq+F6apju4sOXdoMxeSumBZ+W7SK9KdbPX
         7yeWo3n5lZVlPJ1J22DC5qcyQD6xQ3nzgVLjIiJO29BqwNSauUuruSfRXrNhvZ83CT0v
         WqqGYQJ/lNJvutJTJE+yW5TK6KerRQPLEYUQ61WMQLpH3iY1kB8sthN3W7bvhfIWSQKF
         aCFklRjzJGGEuLrLgtyqdmoQH83PZWyvqF4Or7Cf8QM3xEljNB3g1F+3XQtWNLwruEky
         mJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ag8PoNJdytatePpwe0+Hk8DTOcnWfgstvA3VVG/WQPk=;
        b=ZdAiHJZdXWuYvKs/WwrYWmJb1rOHUSRIjOo8zFUHlTyxTQ+Y867PrOtZpC8jPI1F+o
         tmR3R0VVpWxVmDtcCSzKMliNyqcm9s8yVacTHYnd+TR5LRj401jwFqUQcl44E3iGOdZB
         00w0ujsS5kPvZQcrMwjbHpJK6AX+0YzauR+Y3YB+YDkCixcrYO74PF58g+zbCietu/sj
         OYNUHGRzSDbKRZNpb8IDOxgxAr28DEqGNqwgPP8h2D//We4mtXxHzfapqtuv0ur62OQR
         hJgNe0XxrXF3w4tJXUMe9ovl8KNfiPnKif0jZR4b7hHlT5VlFhVb45m03eiFSLiHbuLq
         Rqbw==
X-Gm-Message-State: AOAM531hPdgfxYXvxSF08tcGSY0NEng1PMotG2YUevGwu1kTPI+omt1F
        bBPezfVHywQQrY4J/7pe4YPDkgGh78cjDA2g
X-Google-Smtp-Source: ABdhPJzX4D2ltNoV7k4LBZp4RkP9Bow4QF2L++hGfkReq8EQGg9o7Lx4uzv3YC7fRkGknPApysCDSA==
X-Received: by 2002:ac2:456c:: with SMTP id k12mr28170537lfm.234.1643899137144;
        Thu, 03 Feb 2022 06:38:57 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m17sm5082448lfc.130.2022.02.03.06.38.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:38:56 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Make key_aid and net_key_id naming consistent
Date:   Thu,  3 Feb 2022 15:38:49 +0100
Message-Id: <20220203143849.746696-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- key_aid refers to application key AID
- net_key_id refers to unique, internal id of the network key, used in
  net-keys.h

Also, remove unused mesh_frnd_pkt struct.
---
 mesh/appkey.h |   2 +-
 mesh/friend.c |   8 ++--
 mesh/net.c    | 111 +++++++++++++++++++++++++-------------------------
 mesh/net.h    |  37 +++--------------
 4 files changed, 67 insertions(+), 91 deletions(-)

diff --git a/mesh/appkey.h b/mesh/appkey.h
index 6688d87fb..0cb6e3b56 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -18,7 +18,7 @@ bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 void appkey_key_free(void *data);
 void appkey_finalize(struct mesh_net *net, uint16_t net_idx);
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
-							uint8_t *key_id);
+							uint8_t *key_aid);
 int appkey_get_key_idx(struct mesh_app_key *app_key,
 				const uint8_t **key, uint8_t *key_aid,
 				const uint8_t **new_key, uint8_t *new_key_aid);
diff --git a/mesh/friend.c b/mesh/friend.c
index 1e67704b8..6c63032ac 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -59,7 +59,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_friend *neg = user_data;
 	uint16_t net_idx = neg->net_idx;
-	uint32_t key_id, seq;
+	uint32_t net_key_id, seq;
 	uint8_t msg[8];
 	uint16_t n = 0;
 	bool res;
@@ -67,11 +67,11 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(timeout);
 
 	/* Create key Set for this offer */
-	res = mesh_net_get_key(neg->net, false, net_idx, &key_id);
+	res = mesh_net_get_key(neg->net, false, net_idx, &net_key_id);
 	if (!res)
 		goto cleanup;
 
-	neg->net_key_cur = net_key_frnd_add(key_id, neg->lp_addr,
+	neg->net_key_cur = net_key_frnd_add(net_key_id, neg->lp_addr,
 						mesh_net_get_address(neg->net),
 						neg->lp_cnt, counter);
 	if (!neg->net_key_cur)
@@ -88,7 +88,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	n += 2;
 	seq = mesh_net_next_seq_num(neg->net);
 	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
-	mesh_net_transport_send(neg->net, key_id, 0,
+	mesh_net_transport_send(neg->net, net_key_id, 0,
 			mesh_net_get_iv_index(neg->net), 0,
 			seq, 0, neg->lp_addr,
 			msg, n);
diff --git a/mesh/net.c b/mesh/net.c
index aa220f762..b659349f0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -195,7 +195,7 @@ struct net_queue_data {
 	uint8_t *out;
 	size_t out_size;
 	enum _relay_advice relay_advice;
-	uint32_t key_id;
+	uint32_t net_key_id;
 	uint32_t iv_index;
 	uint16_t len;
 	bool seen;
@@ -210,7 +210,7 @@ struct oneshot_tx {
 };
 
 struct net_beacon_data {
-	uint32_t key_id;
+	uint32_t net_key_id;
 	uint32_t ivi;
 	bool ivu;
 	bool kr;
@@ -238,19 +238,19 @@ static bool match_key_index(const void *a, const void *b)
 static bool match_key_id(const void *a, const void *b)
 {
 	const struct mesh_subnet *subnet = a;
-	uint32_t key_id = L_PTR_TO_UINT(b);
+	uint32_t net_key_id = L_PTR_TO_UINT(b);
 
-	return (key_id == subnet->net_key_cur) ||
-					(key_id == subnet->net_key_upd);
+	return (net_key_id == subnet->net_key_cur) ||
+					(net_key_id == subnet->net_key_upd);
 }
 
 static bool match_friend_key_id(const void *a, const void *b)
 {
 	const struct mesh_friend *friend = a;
-	uint32_t key_id = L_PTR_TO_UINT(b);
+	uint32_t net_key_id = L_PTR_TO_UINT(b);
 
-	return (key_id == friend->net_key_cur) ||
-					(key_id == friend->net_key_upd);
+	return (net_key_id == friend->net_key_cur) ||
+					(net_key_id == friend->net_key_upd);
 }
 
 static void send_hb_publication(void *data)
@@ -322,9 +322,9 @@ static void free_friend_internals(struct mesh_friend *frnd)
 static void frnd_kr_phase1(void *a, void *b)
 {
 	struct mesh_friend *frnd = a;
-	uint32_t key_id = L_PTR_TO_UINT(b);
+	uint32_t net_key_id = L_PTR_TO_UINT(b);
 
-	frnd->net_key_upd = net_key_frnd_add(key_id, frnd->lp_addr,
+	frnd->net_key_upd = net_key_frnd_add(net_key_id, frnd->lp_addr,
 			frnd->net->src_addr, frnd->lp_cnt, frnd->fn_cnt);
 }
 
@@ -918,7 +918,7 @@ void mesh_net_get_snb_state(struct mesh_net *net, uint8_t *flags,
 }
 
 bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
-							uint32_t *key_id)
+							uint32_t *net_key_id)
 {
 	struct mesh_subnet *subnet;
 
@@ -931,14 +931,14 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
 		return false;
 
 	if (!new_key) {
-		*key_id = subnet->net_key_cur;
+		*net_key_id = subnet->net_key_cur;
 		return true;
 	}
 
 	if (!subnet->net_key_upd)
 		return false;
 
-	*key_id = subnet->net_key_upd;
+	*net_key_id = subnet->net_key_upd;
 	return true;
 }
 
@@ -1764,7 +1764,7 @@ not_for_friend:
 	return true;
 }
 
-static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
+static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t net_key_id)
 {
 	struct mesh_subnet *subnet;
 	struct mesh_friend *friend;
@@ -1773,19 +1773,19 @@ static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
 		return NET_IDX_INVALID;
 
 	subnet = l_queue_find(net->subnets, match_key_id,
-						L_UINT_TO_PTR(key_id));
+						L_UINT_TO_PTR(net_key_id));
 
 	if (subnet)
 		return subnet->idx;
 
 	friend = l_queue_find(net->friends, match_friend_key_id,
-						L_UINT_TO_PTR(key_id));
+						L_UINT_TO_PTR(net_key_id));
 
 	if (friend)
 		return friend->net_idx;
 
 	friend = l_queue_find(net->negotiations, match_friend_key_id,
-						L_UINT_TO_PTR(key_id));
+						L_UINT_TO_PTR(net_key_id));
 
 	if (friend)
 		return friend->net_idx;
@@ -2029,7 +2029,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	return false;
 }
 
-static bool ctl_received(struct mesh_net *net, uint16_t key_id,
+static bool ctl_received(struct mesh_net *net, uint16_t net_key_id,
 						uint32_t iv_index, uint8_t ttl,
 						uint32_t seq,
 						uint16_t src, uint16_t dst,
@@ -2079,7 +2079,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 			return false;
 
 		print_packet("Rx-NET_OP_FRND_REQUEST", pkt, len);
-		net_idx = key_id_to_net_idx(net, key_id);
+		net_idx = key_id_to_net_idx(net, net_key_id);
 		friend_request(net, net_idx, src, pkt[0], pkt[1],
 				l_get_be32(pkt + 1) & 0xffffff,
 				l_get_be16(pkt + 5), pkt[7],
@@ -2270,13 +2270,13 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 }
 
 static enum _relay_advice packet_received(void *user_data,
-				uint32_t key_id, uint32_t iv_index,
+				uint32_t net_key_id, uint32_t iv_index,
 				const void *data, uint8_t size, int8_t rssi)
 {
 	struct mesh_net *net = user_data;
 	const uint8_t *msg = data;
 	uint8_t app_msg_len;
-	uint8_t net_ttl, net_key_id, net_segO, net_segN, net_opcode;
+	uint8_t net_ttl, key_aid, net_segO, net_segN, net_opcode;
 	uint32_t net_seq, cache_cookie;
 	uint16_t net_src, net_dst, net_seqZero;
 	uint16_t net_idx;
@@ -2285,7 +2285,7 @@ static enum _relay_advice packet_received(void *user_data,
 
 	memcpy(packet + 2, data, size);
 
-	net_idx = key_id_to_net_idx(net, key_id);
+	net_idx = key_id_to_net_idx(net, net_key_id);
 	if (net_idx == NET_IDX_INVALID)
 		return RELAY_NONE;
 
@@ -2294,7 +2294,7 @@ static enum _relay_advice packet_received(void *user_data,
 	if (!mesh_crypto_packet_parse(packet + 2, size, &net_ctl, &net_ttl,
 					&net_seq, &net_src, &net_dst,
 					&cache_cookie, &net_opcode,
-					&net_segmented, &net_key_id, &net_szmic,
+					&net_segmented, &key_aid, &net_szmic,
 					&net_relay, &net_seqZero, &net_segO,
 					&net_segN, &msg, &app_msg_len)) {
 		l_error("Failed to parse packet content");
@@ -2348,7 +2348,7 @@ static enum _relay_advice packet_received(void *user_data,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
-				ctl_received(net, key_id, iv_index, net_ttl,
+				ctl_received(net, key_aid, iv_index, net_ttl,
 						net_seq, net_src, net_dst,
 						net_opcode, rssi, msg,
 								app_msg_len);
@@ -2373,14 +2373,14 @@ static enum _relay_advice packet_received(void *user_data,
 			} else {
 				seg_rxed(net, NULL, iv_index, net_ttl,
 						net_seq, net_idx, net_src,
-						net_dst, net_key_id, net_szmic,
+						net_dst, key_aid, net_szmic,
 						net_seqZero, net_segO, net_segN,
 						msg, app_msg_len);
 			}
 
 		} else {
 			msg_rxed(net, NULL, iv_index, net_ttl, net_seq, net_idx,
-					net_src, net_dst, net_key_id, false,
+					net_src, net_dst, key_aid, false,
 					false, net_seq & SEQ_ZERO_MASK, msg,
 					app_msg_len);
 		}
@@ -2414,7 +2414,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	enum _relay_advice relay_advice;
 	uint8_t *out;
 	size_t out_size;
-	uint32_t key_id;
+	uint32_t net_key_id;
 	int8_t rssi = 0;
 	bool ivi_net = !!(net->iv_index & 1);
 	bool ivi_pkt = !!(data->data[0] & 0x80);
@@ -2422,10 +2422,10 @@ static void net_rx(void *net_ptr, void *user_data)
 	/* if IVI flag differs, use previous IV Index */
 	uint32_t iv_index = net->iv_index - (ivi_pkt ^ ivi_net);
 
-	key_id = net_key_decrypt(iv_index, data->data, data->len,
+	net_key_id = net_key_decrypt(iv_index, data->data, data->len,
 							&out, &out_size);
 
-	if (!key_id)
+	if (!net_key_id)
 		return;
 
 	if (!data->seen) {
@@ -2439,12 +2439,12 @@ static void net_rx(void *net_ptr, void *user_data)
 		rssi = data->info->rssi;
 	}
 
-	relay_advice = packet_received(net, key_id, iv_index, out, out_size,
+	relay_advice = packet_received(net, net_key_id, iv_index, out, out_size,
 									rssi);
 	if (relay_advice > data->relay_advice) {
 		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
-		data->key_id = key_id;
+		data->net_key_id = net_key_id;
 		data->net = net;
 		data->out = out;
 		data->out_size = out_size;
@@ -2482,7 +2482,7 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 
 		net_data.out[1] &=  ~TTL_MASK;
 		net_data.out[1] |= ttl - 1;
-		net_key_encrypt(net_data.key_id, net_data.iv_index,
+		net_key_encrypt(net_data.net_key_id, net_data.iv_index,
 					net_data.out, net_data.out_size);
 		send_relay_pkt(net_data.net, net_data.out, net_data.out_size);
 	}
@@ -2719,7 +2719,7 @@ static void process_beacon(void *net_ptr, void *user_data)
 
 	/* Ignore beacons not in this universe */
 	subnet = l_queue_find(net->subnets, match_key_id,
-					L_UINT_TO_PTR(beacon_data->key_id));
+					L_UINT_TO_PTR(beacon_data->net_key_id));
 
 	if (!subnet)
 		return;
@@ -2741,10 +2741,10 @@ static void process_beacon(void *net_ptr, void *user_data)
 		updated |= update_iv_ivu_state(net, ivi, ivu);
 
 	if (kr != local_kr)
-		updated |= update_kr_state(subnet, kr, beacon_data->key_id);
+		updated |= update_kr_state(subnet, kr, beacon_data->net_key_id);
 
 	if (updated)
-		net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
+		net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
 				!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO),
 								net->iv_update);
 }
@@ -2760,8 +2760,8 @@ static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 		return;
 
 	/* Ignore Network IDs unknown to this daemon */
-	beacon_data.key_id = net_key_network_id(data + 3);
-	if (!beacon_data.key_id)
+	beacon_data.net_key_id = net_key_network_id(data + 3);
+	if (!beacon_data.net_key_id)
 		return;
 
 	/* Get data bits from beacon */
@@ -2770,7 +2770,7 @@ static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 	beacon_data.ivi = l_get_be32(data + 11);
 
 	/* Validate beacon before accepting */
-	if (!net_key_snb_check(beacon_data.key_id, beacon_data.ivi,
+	if (!net_key_snb_check(beacon_data.net_key_id, beacon_data.ivi,
 					beacon_data.kr, beacon_data.ivu,
 					l_get_be64(data + 15))) {
 		l_error("mesh_crypto_beacon verify failed");
@@ -2780,13 +2780,13 @@ static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 	l_queue_foreach(nets, process_beacon, &beacon_data);
 
 	if (beacon_data.processed)
-		net_key_beacon_seen(beacon_data.key_id);
+		net_key_beacon_seen(beacon_data.net_key_id);
 }
 
-void net_local_beacon(uint32_t key_id, uint8_t *beacon)
+void net_local_beacon(uint32_t net_key_id, uint8_t *beacon)
 {
 	struct net_beacon_data beacon_data = {
-		.key_id = key_id,
+		.net_key_id = net_key_id,
 		.ivu = !!(beacon[2] & 0x02),
 		.kr = !!(beacon[2] & 0x01),
 		.ivi = l_get_be32(beacon + 11),
@@ -3062,7 +3062,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t packet[30];
 	uint8_t packet_len;
 	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & true);
-	uint8_t app_key_id = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
+	uint8_t key_aid = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
 	bool szmic = !!((hdr >> SZMIC_HDR_SHIFT) & true);
 	uint16_t seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) & SEQ_ZERO_MASK;
 	uint8_t segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
@@ -3075,7 +3075,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_debug("segO: %d", segO);
 
 	if (!mesh_crypto_packet_build(false, ttl, seq, src, dst, 0,
-					segmented, app_key_id, szmic, false,
+					segmented, key_aid, szmic, false,
 					seqZero, segO, segN, seg, seg_len,
 					packet + 1, &packet_len)) {
 		l_error("Failed to build packet");
@@ -3197,9 +3197,10 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	return result;
 }
 
-void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id, uint32_t iv_index,
-			uint8_t ttl, uint32_t seq, uint16_t src, uint16_t dst,
-			bool rly, uint16_t seqZero, uint32_t ack_flags)
+void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
+			uint32_t iv_index, uint8_t ttl, uint32_t seq,
+			uint16_t src, uint16_t dst, bool rly, uint16_t seqZero,
+			uint32_t ack_flags)
 {
 	uint32_t hdr;
 	uint8_t data[7];
@@ -3219,13 +3220,13 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id, uint32_t iv_index,
 					pkt + 1, &pkt_len))
 		return;
 
-	if (!key_id) {
+	if (!net_key_id) {
 		struct mesh_subnet *subnet = get_primary_subnet(net);
 
-		key_id = subnet->net_key_tx;
+		net_key_id = subnet->net_key_tx;
 	}
 
-	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
+	if (!net_key_encrypt(net_key_id, iv_index, pkt + 1, pkt_len)) {
 		l_error("Failed to encode packet");
 		return;
 	}
@@ -3237,7 +3238,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id, uint32_t iv_index,
 	print_packet("TX: Friend ACK", pkt + 1, pkt_len);
 }
 
-void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
+void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 				uint16_t net_idx, uint32_t iv_index,
 				uint8_t ttl, uint32_t seq, uint16_t src,
 				uint16_t dst, const uint8_t *msg,
@@ -3265,7 +3266,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 		return;
 
 	/* Enqueue for Friend if forwardable and from us */
-	if (!key_id && src >= net->src_addr && src <= net->last_addr) {
+	if (!net_key_id && src >= net->src_addr && src <= net->last_addr) {
 		uint32_t hdr = msg[0] << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl;
 
@@ -3277,17 +3278,17 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 
 	/* Deliver to Local entities if applicable */
 	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr)
-		result = ctl_received(net, key_id, iv_index, ttl,
+		result = ctl_received(net, net_key_id, iv_index, ttl,
 					mesh_net_next_seq_num(net), src, dst,
 					msg[0], 0, msg + 1, msg_len - 1);
 
-	if (!key_id) {
+	if (!net_key_id) {
 		struct mesh_subnet *subnet = l_queue_find(net->subnets,
 				match_key_index, L_UINT_TO_PTR(net_idx));
 		if (!subnet)
 			return;
 
-		key_id = subnet->net_key_tx;
+		net_key_id = subnet->net_key_tx;
 		use_seq = mesh_net_next_seq_num(net);
 
 		if (result || (dst >= net->src_addr && dst <= net->last_addr))
@@ -3299,7 +3300,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				msg_len - 1, pkt + 1, &pkt_len))
 		return;
 
-	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
+	if (!net_key_encrypt(net_key_id, iv_index, pkt + 1, pkt_len)) {
 		l_error("Failed to encode packet");
 		return;
 	}
diff --git a/mesh/net.h b/mesh/net.h
index 465d88909..1c2b5e7c6 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -186,31 +186,6 @@ struct mesh_friend {
 	} u;
 };
 
-struct mesh_frnd_pkt {
-	uint32_t iv_index;
-	uint32_t seq;
-	uint16_t src;
-	uint16_t dst;
-	uint16_t size;
-	uint8_t segN;
-	uint8_t segO;
-	uint8_t ttl;
-	uint8_t tc;
-	bool szmict;
-	union {
-		struct {
-			uint8_t key_id;
-		} m;
-		struct {
-			uint16_t seq0;
-		} a;
-		struct {
-			uint8_t opcode;
-		} c;
-	} u;
-	uint8_t data[];
-};
-
 struct mesh_friend_seg_one {
 	uint32_t hdr;
 	uint32_t seq;
@@ -261,7 +236,7 @@ void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq);
 uint16_t mesh_net_get_address(struct mesh_net *net);
 bool mesh_net_register_unicast(struct mesh_net *net,
 					uint16_t unicast, uint8_t num_ele);
-void net_local_beacon(uint32_t key_id, uint8_t *beacon);
+void net_local_beacon(uint32_t net_key_id, uint8_t *beacon);
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable, uint8_t cnt,
@@ -278,23 +253,23 @@ uint32_t mesh_net_get_iv_index(struct mesh_net *net);
 void mesh_net_get_snb_state(struct mesh_net *net,
 					uint8_t *flags, uint32_t *iv_index);
 bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
-							uint32_t *key_id);
+							uint32_t *net_key_id);
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
 struct mesh_io *mesh_net_detach(struct mesh_net *net);
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
-void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
+void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 				uint16_t net_idx, uint32_t iv_index,
 				uint8_t ttl, uint32_t seq, uint16_t src,
 				uint16_t dst, const uint8_t *msg,
 				uint16_t msg_len);
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
-				uint16_t dst, uint8_t key_id, uint16_t net_idx,
+				uint16_t dst, uint8_t key_aid, uint16_t net_idx,
 				uint8_t ttl, uint8_t cnt, uint16_t interval,
 				uint32_t seq, uint32_t iv_index, bool segmented,
 				bool szmic, const void *msg, uint16_t msg_len);
-void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
+void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
 				uint16_t seqZero, uint32_t ack_flags);
@@ -317,7 +292,7 @@ int mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t net_idx,
 							uint8_t transition);
 int mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t net_idx,
 							uint8_t *phase);
-void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
+void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, uint32_t hdr,
 				const void *seg, uint16_t seg_len);
-- 
2.25.1

