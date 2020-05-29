Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CE42100A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2Gm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 02:42:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:53719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2Gm4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 02:42:56 -0400
IronPort-SDR: WwRy1heHUCuggB1g4vfUDTIAjzcfpFjPSUIK8v0RvKOcxK3mnsptmC36Vrkt+MEKocooZk2pCi
 ChF9uq/MIe+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:37:54 -0700
IronPort-SDR: 6hDcuX6jfwjN5v1uJKyC/2VESp5RMbJ9whDa1SODTnuaYvOWiQY7dwAfXSNZZVThBA/rZ20Ocz
 KXXt6Vc5Lv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="257260596"
Received: from dmikkels-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.187])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 23:37:53 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/5] mesh: Debug output clean up
Date:   Thu, 28 May 2020 23:37:47 -0700
Message-Id: <20200529063750.186278-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063750.186278-1-inga.stotland@intel.com>
References: <20200529063750.186278-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes l_info() to l_debug() for recurring cases and
removes some excessive debug output.
---
 mesh/manager.c         |   6 +-
 mesh/mesh-io-generic.c |   3 +-
 mesh/model.c           |  28 +-------
 mesh/net.c             | 150 ++++++++++++++---------------------------
 mesh/pb-adv.c          |   7 +-
 mesh/prov-initiator.c  |   2 +-
 6 files changed, 58 insertions(+), 138 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index a7383e4d5..2be471088 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -219,7 +219,7 @@ static void add_start(void *user_data, int err)
 {
 	struct l_dbus_message *reply;
 
-	l_info("Start callback");
+	l_debug("Start callback");
 
 	if (err == MESH_ERROR_NONE)
 		reply = l_dbus_message_new_method_return(add_pending->msg);
@@ -270,8 +270,8 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	add_pending->agent = node_get_agent(node);
 
 	if (!node_is_provisioner(node) || (add_pending->agent == NULL)) {
-		l_info("Provisioner: %d", node_is_provisioner(node));
-		l_info("Agent: %p", add_pending->agent);
+		l_debug("Provisioner: %d", node_is_provisioner(node));
+		l_debug("Agent: %p", add_pending->agent);
 		reply = dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
 							"Missing Interfaces");
 		goto fail;
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 3ad130567..7a4008bd9 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -173,7 +173,7 @@ static void event_callback(const void *buf, uint8_t size, void *user_data)
 		break;
 
 	default:
-		l_info("Other Meta Evt - %d", event);
+		l_debug("Other Meta Evt - %d", event);
 	}
 }
 
@@ -804,7 +804,6 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 	if (!cb || !filter || !len)
 		return false;
 
-	l_info("%s %2.2x", __func__, filter[0]);
 	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter, filter);
 
 	l_free(rx_reg);
diff --git a/mesh/model.c b/mesh/model.c
index 945583324..dc6f28eb8 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -514,15 +514,8 @@ static void cmplt(uint16_t remote, uint8_t status,
 {
 	struct timeval tx_end;
 
-	if (status)
-		l_debug("Tx-->%4.4x (%d octets) Failed (%d)",
-				remote, size, status);
-	else
-		l_debug("Tx-->%4.4x (%d octets) Succeeded", remote, size);
-
-	/* print_packet("Sent Data", data, size); */
-
 	gettimeofday(&tx_end, NULL);
+
 	if (tx_end.tv_sec == tx_start.tv_sec) {
 		l_debug("Duration 0.%6.6lu seconds",
 				tx_end.tv_usec - tx_start.tv_usec);
@@ -580,22 +573,18 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		net_idx = appkey_net_idx(node_get_net(node), app_idx);
 	}
 
-	l_debug("(%x) %p", app_idx, key);
-	l_debug("net_idx %x", net_idx);
-
 	out = l_malloc(out_len);
 
 	iv_index = mesh_net_get_iv_index(net);
 
 	seq_num = mesh_net_next_seq_num(net);
+
 	if (!mesh_crypto_payload_encrypt(label, msg, out, msg_len, src, dst,
 				key_aid, seq_num, iv_index, szmic, key)) {
 		l_error("Failed to Encrypt Payload");
 		goto done;
 	}
 
-	/* print_packet("Encrypted with", key, 16); */
-
 	ret = mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
 					ttl, seq_num, iv_index, segmented,
 					szmic, out, out_len, cmplt, NULL);
@@ -647,8 +636,6 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 
 	l_queue_push_tail(mod->bindings, L_UINT_TO_PTR(idx));
 
-	l_debug("Add %4.4x to model %8.8x", idx, mod->id);
-
 	if (!mod->cbs)
 		/* External model */
 		config_update_model_bindings(node, mod);
@@ -781,7 +768,6 @@ static int add_virt_sub(struct mesh_net *net, struct mesh_model *mod,
 
 		l_queue_push_head(mod->virtuals, virt);
 		mesh_net_dst_reg(net, virt->addr);
-		l_debug("Added virtual sub addr %4.4x", virt->addr);
 	}
 
 	if (dst)
@@ -809,7 +795,6 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 
 		l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
 		mesh_net_dst_reg(net, grp);
-		l_debug("Added group subscription %4.4x", grp);
 	}
 
 	return MESH_STATUS_SUCCESS;
@@ -929,6 +914,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 
 	/* Don't process if already in RPL */
 	crpl = node_get_crpl(node);
+
 	if (net_msg_check_replay_cache(net, src, crpl, seq, iv_index))
 		return false;
 
@@ -1064,8 +1050,6 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	bool result;
 	int status;
 
-	/* print_packet("Mod Tx", msg, msg_len); */
-
 	if (!net || msg_len > 380)
 		return MESH_ERROR_INVALID_ARGS;
 
@@ -1092,8 +1076,6 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	if (mod->pub->virt)
 		label = mod->pub->virt->label;
 
-	l_debug("publish dst=%x", mod->pub->addr);
-
 	net_idx = appkey_net_idx(net, mod->pub->idx);
 
 	result = msg_send(node, mod->pub->credential != 0, src,
@@ -1108,8 +1090,6 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len)
 {
-	/* print_packet("Mod Tx", msg, msg_len); */
-
 	/* If SRC is 0, use the Primary Element */
 	if (src == 0)
 		src = node_get_primary(node);
@@ -1279,14 +1259,12 @@ void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 int mesh_model_binding_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx)
 {
-	l_debug("0x%x, 0x%x, %d", addr, id, app_idx);
 	return update_binding(node, addr, id, app_idx, true);
 }
 
 int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx)
 {
-	l_debug("0x%x, 0x%x, %d", addr, id, app_idx);
 	return update_binding(node, addr, id, app_idx, false);
 }
 
diff --git a/mesh/net.c b/mesh/net.c
index f104be0f9..f9e7bce4c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -307,7 +307,7 @@ static void trigger_heartbeat(struct mesh_net *net, uint16_t feature,
 {
 	struct mesh_net_heartbeat *hb = &net->heartbeat;
 
-	l_info("%s: %4.4x --> %d", __func__, feature, in_use);
+	l_debug("%s: %4.4x --> %d", __func__, feature, in_use);
 	if (in_use) {
 		if (net->heartbeat.features & feature)
 			return; /* no change */
@@ -371,7 +371,7 @@ static void frnd_kr_phase2(void *a, void *b)
 	 * receives it's first Poll using the new keys (?)
 	 */
 
-	l_info("Use Both KeySet %d && %d for %4.4x",
+	l_debug("Use Both KeySet %d && %d for %4.4x",
 			frnd->net_key_cur, frnd->net_key_upd, frnd->lp_addr);
 }
 
@@ -379,7 +379,7 @@ static void frnd_kr_phase3(void *a, void *b)
 {
 	struct mesh_friend *frnd = a;
 
-	l_info("Replace KeySet %d with %d for %4.4x",
+	l_debug("Replace KeySet %d with %d for %4.4x",
 			frnd->net_key_cur, frnd->net_key_upd, frnd->lp_addr);
 	net_key_unref(frnd->net_key_cur);
 	frnd->net_key_cur = frnd->net_key_upd;
@@ -627,10 +627,6 @@ static void queue_friend_update(struct mesh_net *net)
 		update.u.one[0].data[1] = flags;
 		l_put_be32(net->iv_index, update.u.one[0].data + 2);
 		update.u.one[0].data[6] = 0x01; /* More Data */
-		/* print_packet("Frnd-Beacon-SRC",
-		 *			beacon_data, sizeof(beacon_data));
-		 */
-		/* print_packet("Frnd-Update", update.u.one[0].data, 6); */
 
 		l_queue_foreach(net->friends, enqueue_update, &update);
 	}
@@ -1570,7 +1566,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 	l_put_be32(hdr, msg);
 	l_put_be32(flags, msg + 3);
 
-	l_info("Send Friend ACK to Segs: %8.8x", flags);
+	l_debug("Send Friend ACK to Segs: %8.8x", flags);
 
 	if (is_lpn_friend(net, dst)) {
 		/* If we are acking our LPN Friend, queue, don't send */
@@ -1603,7 +1599,7 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 
 	l_put_be32(hdr, msg);
 	l_put_be32(flags, msg + 3);
-	l_info("Send%s ACK to Segs: %8.8x", sar->frnd ? " Friend" : "", flags);
+	l_debug("Send%s ACK to Segs: %8.8x", sar->frnd ? " Friend" : "", flags);
 
 	if (is_lpn_friend(net, dst)) {
 		/* If we are acking our LPN Friend, queue, don't send */
@@ -1629,7 +1625,7 @@ static void inseg_to(struct l_timeout *seg_timeout, void *user_data)
 		return;
 
 	/* Send NAK */
-	l_info("Timeout %p %3.3x", sar, sar->app_idx);
+	l_debug("Timeout %p %3.3x", sar, sar->app_idx);
 	send_net_ack(net, sar, sar->flags);
 
 	sar->seg_timeout = l_timeout_create(SEG_TO, inseg_to, net, NULL);
@@ -1647,7 +1643,6 @@ static void inmsg_to(struct l_timeout *msg_timeout, void *user_data)
 
 	sar->msg_timeout = NULL;
 
-	/* print_packet("Incoming SAR Timeout", sar->buf, sar->len); */
 	mesh_sar_free(sar);
 }
 
@@ -1668,7 +1663,6 @@ static void outmsg_to(struct l_timeout *msg_timeout, void *user_data)
 				sar->buf, sar->len - 4,
 				sar->user_data);
 
-	/* print_packet("Outgoing SAR Timeout", sar->buf, sar->len); */
 	mesh_sar_free(sar);
 }
 
@@ -1698,13 +1692,13 @@ static void ack_received(struct mesh_net *net, bool timeout,
 	uint32_t ack_copy = ack_flag;
 	uint16_t i;
 
-	l_info("ACK Rxed (%x) (to:%d): %8.8x", seq0, timeout, ack_flag);
+	l_debug("ACK Rxed (%x) (to:%d): %8.8x", seq0, timeout, ack_flag);
 
 	outgoing = l_queue_find(net->sar_out, match_sar_seq0,
 							L_UINT_TO_PTR(seq0));
 
 	if (!outgoing) {
-		l_info("Not Found: %4.4x", seq0);
+		l_debug("Not Found: %4.4x", seq0);
 		return;
 	}
 
@@ -1743,7 +1737,7 @@ static void ack_received(struct mesh_net *net, bool timeout,
 
 		ack_copy |= seg_flag;
 
-		l_info("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
+		l_debug("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
 				i, net, outgoing->remote, outgoing->app_idx);
 
 		send_seg(net, outgoing, i);
@@ -1918,12 +1912,12 @@ static void friend_seg_rxed(struct mesh_net *net,
 	if (segN == segO)
 		frnd_msg->last_len = size;
 
-	l_info("RXed Seg %d, Flags %8.8x (cnt: %d)",
+	l_debug("RXed Seg %d, Flags %8.8x (cnt: %d)",
 						segO, frnd_msg->flags, cnt);
 
 	/* In reality, if one of these is true, then *both* must be true */
 	if ((cnt == segN) || (frnd_msg->flags == expected)) {
-		l_info("Full ACK");
+		l_debug("Full ACK");
 		send_frnd_ack(net, dst, src, hdr, frnd_msg->flags);
 
 		if (frnd_msg->ttl > 1) {
@@ -1943,7 +1937,7 @@ static void friend_seg_rxed(struct mesh_net *net,
 
 	/* Always ACK if this is the largest outstanding segment */
 	if ((largest & frnd_msg->flags) == largest) {
-		l_info("Partial ACK");
+		l_debug("Partial ACK");
 		send_frnd_ack(net, dst, src, hdr, frnd_msg->flags);
 	}
 
@@ -1997,7 +1991,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	expected = 0xffffffff >> (31 - segN);
 
 	if (sar_in) {
-		l_info("RXed (old: %04x %06x size:%d) %d of %d",
+		l_debug("RXed (old: %04x %06x size:%d) %d of %d",
 					seqZero, seq, size, segO, segN);
 		/* Sanity Check--> certain things must match */
 		if (SEG_MAX(true, sar_in->len) != segN ||
@@ -2012,7 +2006,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	} else {
 		uint16_t len = MAX_SEG_TO_LEN(segN);
 
-		l_info("RXed (new: %04x %06x size: %d len: %d) %d of %d",
+		l_debug("RXed (new: %04x %06x size: %d len: %d) %d of %d",
 				seqZero, seq, size, len, segO, segN);
 		l_debug("Queue Size: %d", l_queue_length(net->sar_in));
 		sar_in = mesh_sar_new(len);
@@ -2031,7 +2025,6 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		l_debug("First Seg %4.4x", sar_in->flags);
 		l_queue_push_head(net->sar_in, sar_in);
 	}
-	/* print_packet("Seg", data, size); */
 
 	seg_off = segO * MAX_SEG_LEN;
 	memcpy(sar_in->buf + seg_off, data, size);
@@ -2044,8 +2037,6 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	sar_in->flags |= this_seg_flag;
 	sar_in->ttl = ttl;
 
-	l_debug("Have Frags %4.4x", sar_in->flags);
-
 	/* Msg length only definitive on last segment */
 	if (segO == segN)
 		sar_in->len = segN * MAX_SEG_LEN + size;
@@ -2166,7 +2157,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 				l_queue_find(net->friends,
 					match_by_friend,
 					L_UINT_TO_PTR(l_get_be16(pkt))));
-		l_info("Remaining Friends: %d", l_queue_length(net->friends));
+		l_debug("Remaining Friends: %d", l_queue_length(net->friends));
 		break;
 
 	case NET_OP_PROXY_SUB_ADD:
@@ -2212,7 +2203,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 			if (net->heartbeat.sub_max_hops < hops)
 				net->heartbeat.sub_max_hops = hops;
 
-			l_info("HB: cnt:%4.4x min:%2.2x max:%2.2x",
+			l_debug("HB: cnt:%4.4x min:%2.2x max:%2.2x",
 					net->heartbeat.sub_count,
 					net->heartbeat.sub_min_hops,
 					net->heartbeat.sub_max_hops);
@@ -2381,8 +2372,6 @@ static enum _relay_advice packet_received(void *user_data,
 	if (is_us(net, net_src, true))
 		return RELAY_NONE;
 
-	l_debug("check %08x", cache_cookie);
-
 	/* As a Relay, suppress repeats of last N packets that pass through */
 	/* The "cache_cookie" should be unique part of App message */
 	if (msg_in_cache(net, net_src, net_seq, cache_cookie))
@@ -2394,7 +2383,7 @@ static enum _relay_advice packet_received(void *user_data,
 	if (is_us(net, net_dst, false) ||
 			(net_ctl && net_opcode == NET_OP_HEARTBEAT)) {
 
-		l_info("RX: App 0x%04x -> 0x%04x : TTL 0x%02x : SEQ 0x%06x",
+		l_debug("RX: App 0x%04x -> 0x%04x : TTL 0x%02x : SEQ 0x%06x",
 					net_src, net_dst, net_ttl, net_seq);
 
 		if (net_ctl) {
@@ -2404,7 +2393,6 @@ static enum _relay_advice packet_received(void *user_data,
 				if (net_dst & 0x8000)
 					return RELAY_NONE;
 
-				/* print_packet("Got ACK", msg, app_msg_len); */
 				/* Pedantic check for correct size */
 				if (app_msg_len != 7)
 					return RELAY_NONE;
@@ -2576,7 +2564,7 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 	case IV_UPD_UPDATING:
 		if (l_queue_length(net->sar_out) ||
 					l_queue_length(net->sar_queue)) {
-			l_info("don't leave IV Update until sar_out empty");
+			l_debug("don't leave IV Update until sar_out empty");
 			l_timeout_modify(net->iv_update_timeout, 10);
 			break;
 		}
@@ -2626,7 +2614,7 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	if (!subnet || !subnet->net_key_upd)
 		return MESH_STATUS_INVALID_NETKEY;
 
-	l_info("Key refresh procedure phase 2: start using new net TX keys");
+	l_debug("Key refresh procedure phase 2: start using new net TX keys");
 	subnet->key_refresh = 1;
 	subnet->net_key_tx = subnet->net_key_upd;
 	/* TODO: Provisioner may need to stay in phase three until
@@ -2659,7 +2647,7 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	if (subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
 		return MESH_STATUS_SUCCESS;
 
-	l_info("Key refresh phase 3: use new keys only, discard old ones");
+	l_debug("Key refresh phase 3: use new keys only, discard old ones");
 
 	/* Switch to using new keys, discard old ones */
 	net_key_unref(subnet->net_key_cur);
@@ -2715,12 +2703,12 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 			 * Starting permissive state will allow us maximum
 			 * (96 hours) to resync
 			 */
-			l_info("iv_upd_state = IV_UPD_UPDATING");
+			l_debug("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
 			net->iv_update_timeout = l_timeout_create(
 				IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
 		} else {
-			l_info("iv_upd_state = IV_UPD_NORMAL");
+			l_debug("iv_upd_state = IV_UPD_NORMAL");
 			net->iv_upd_state = IV_UPD_NORMAL;
 		}
 	} else if (ivu) {
@@ -2736,7 +2724,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 			return;
 
 		if (!net->iv_update) {
-			l_info("iv_upd_state = IV_UPD_UPDATING");
+			l_debug("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
 			net->iv_update_timeout = l_timeout_create(
 					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
@@ -2937,7 +2925,6 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 		if (!fast_cache)
 			fast_cache = l_queue_new();
 
-		l_info("Register io cb");
 		mesh_io_register_recv_cb(io, snb, sizeof(snb),
 							beacon_recv, NULL);
 		mesh_io_register_recv_cb(io, pkt, sizeof(pkt),
@@ -2981,7 +2968,7 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 	if (net->iv_upd_state != IV_UPD_NORMAL)
 		return false;
 
-	l_info("iv_upd_state = IV_UPD_UPDATING");
+	l_debug("iv_upd_state = IV_UPD_UPDATING");
 	mesh_net_flush_msg_queues(net);
 	if (!mesh_config_write_iv_index(node_config_get(net->node),
 						net->iv_index + 1, true))
@@ -3082,23 +3069,18 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 		mesh_net_iv_index_update(net);
 
 	l_debug("segN %d segment %d seg_off %d", segN, segO, seg_off);
-	/* print_packet("Sending", msg->buf + seg_off, seg_len); */
-	{
-		/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
-
-		if (!mesh_crypto_packet_build(false, msg->ttl,
-					seq_num,
-					msg->src, msg->remote,
-					0,
-					msg->segmented, msg->key_aid,
-					msg->szmic, false, msg->seqZero,
-					segO, segN,
+
+	/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
+	if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
+					msg->remote, 0, msg->segmented,
+					msg->key_aid, msg->szmic, false,
+					msg->seqZero, segO, segN,
 					msg->buf + seg_off, seg_len,
 					packet + 1, &packet_len)) {
-			l_error("Failed to build packet");
-			return false;
-		}
+		l_error("Failed to build packet");
+		return false;
 	}
+
 	print_packet("Clr-Net Tx", packet + 1, packet_len);
 
 	subnet = l_queue_find(net->subnets, match_key_index,
@@ -3112,20 +3094,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 		return false;
 	}
 
-	/* print_packet("Step 4", packet + 1, packet_len); */
-
-	{
-		char *str;
-
-		send_msg_pkt(net, packet, packet_len + 1);
-
-		str = l_util_hexstring(packet + 1, packet_len);
-		l_info("TX: Network %04x -> %04x : %s (%u) : TTL %d : SEQ %06x",
-				msg->src, msg->remote, str,
-				packet_len, msg->ttl,
-				msg->frnd ? msg->seqAuth + segO : seq_num);
-		l_free(str);
-	}
+	send_msg_pkt(net, packet, packet_len + 1);
 
 	msg->last_seg = segO;
 
@@ -3140,7 +3109,6 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 				uint32_t hdr,
 				const void *seg, uint16_t seg_len)
 {
-	char *str;
 	uint8_t packet[30];
 	uint8_t packet_len;
 	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & true);
@@ -3174,14 +3142,12 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
-	/* print_packet("Step 4", packet + 1, packet_len); */
-
 	send_msg_pkt(net, packet, packet_len + 1);
 
-	str = l_util_hexstring(packet + 1, packet_len);
-	l_info("TX: Friend Seg-%d %04x -> %04x : %s (%u) : TTL %d : SEQ %06x",
-			segO, src, dst, str, packet_len, ttl, seq);
-	l_free(str);
+	l_debug("TX: Friend Seg-%d %04x -> %04x : len %u) : TTL %d : SEQ %06x",
+					segO, src, dst, packet_len, ttl, seq);
+
+	print_packet("TX: Friend", packet + 1, packet_len);
 }
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
@@ -3222,7 +3188,8 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				szmic, seq & SEQ_ZERO_MASK,
 				msg, msg_len);
 
-	/* If addressed to a unicast address and successfully enqueued,
+	/*
+	 * If addressed to a unicast address and successfully enqueued,
 	 * or delivered to one of our Unicast addresses we are done
 	 */
 	if ((result && IS_UNICAST(dst)) || src == dst ||
@@ -3243,6 +3210,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->iv_index = mesh_net_get_iv_index(net);
 	payload->seqAuth = seq;
 	payload->segmented = segmented;
+
 	if (segmented) {
 		payload->flags = 0xffffffff >> (31 - seg_max);
 		payload->seqZero = seq & SEQ_ZERO_MASK;
@@ -3256,13 +3224,14 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 			/* Delay sending Outbound SAR unless prior
 			 * SAR to same DST has completed */
 
-			l_info("OB-Queued SeqZero: %4.4x", payload->seqZero);
+			l_debug("OB-Queued SeqZero: %4.4x", payload->seqZero);
 			l_queue_push_tail(net->sar_queue, payload);
 			return true;
 		}
 	}
 
 	result = true;
+
 	if (!IS_UNICAST(dst) && segmented) {
 		int i;
 
@@ -3303,7 +3272,6 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 	uint8_t data[7];
 	uint8_t pkt_len;
 	uint8_t pkt[30];
-	char *str;
 
 	hdr = NET_OP_SEG_ACKNOWLEDGE << OPCODE_HDR_SHIFT;
 	hdr |= rly << RELAY_HDR_SHIFT;
@@ -3334,14 +3302,11 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 		return;
 	}
 
-	/* print_packet("Step 4", pkt, pkt_len); */
 	send_msg_pkt(net, pkt, pkt_len + 1);
 
-	str = l_util_hexstring(pkt + 1, pkt_len);
-	l_info("TX: Friend ACK %04x -> %04x : %s (%u) : TTL %d : SEQ %06x",
-			src, dst, str, pkt_len,
-			ttl, seq);
-	l_free(str);
+	l_debug("TX: Friend ACK %04x -> %04x : len %u : TTL %d : SEQ %06x",
+					src, dst, pkt_len, ttl, seq);
+	print_packet("TX: Friend ACK", pkt + 1, pkt_len);
 }
 
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
@@ -3419,26 +3384,13 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				pkt + 1, &pkt_len))
 		return;
 
-	/* print_packet("Step 2", pkt + 1, pkt_len); */
-
 	if (!net_key_encrypt(key_id, iv_index, pkt + 1, pkt_len)) {
 		l_error("Failed to encode packet");
 		return;
 	}
 
-	/* print_packet("Step 4", pkt + 1, pkt_len); */
-
-	if (dst != 0) {
-		char *str;
-
+	if (dst != 0)
 		send_msg_pkt(net, pkt, pkt_len + 1);
-
-		str = l_util_hexstring(pkt + 1, pkt_len);
-		l_info("TX: Network %04x -> %04x : %s (%u) : TTL %d : SEQ %06x",
-				src, dst, str, pkt_len,
-				ttl, use_seq);
-		l_free(str);
-	}
 }
 
 uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
@@ -3524,7 +3476,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 
 	if (subnet->net_key_upd) {
 		net_key_unref(subnet->net_key_upd);
-		l_info("Warning: overwriting new keys");
+		l_debug("Warning: overwriting new keys");
 	}
 
 	/* Preserve starting data */
@@ -3539,7 +3491,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 	l_queue_foreach(net->friends, frnd_kr_phase1,
 					L_UINT_TO_PTR(subnet->net_key_upd));
 
-	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
+	l_debug("key refresh phase 1: Key ID %d", subnet->net_key_upd);
 
 	if (!mesh_config_net_key_update(node_config_get(net->node), idx, value))
 		return MESH_STATUS_STORAGE_FAIL;
@@ -3812,9 +3764,6 @@ bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
 		rpl_get_list(net->node, net->replay_cache);
 	}
 
-	l_debug("Test Replay src: %4.4x seq: %6.6x iv: %8.8x",
-						src, seq, iv_index);
-
 	rpe = l_queue_find(net->replay_cache, match_replay_cache,
 						L_UINT_TO_PTR(src));
 
@@ -3854,7 +3803,6 @@ void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
 						L_UINT_TO_PTR(src));
 
 	if (!rpe) {
-		l_debug("New Entry for %4.4x", src);
 		rpe = l_new(struct mesh_rpl, 1);
 		rpe->src = src;
 	}
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index c1316ed1b..ae5b81391 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -157,8 +157,6 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 		init_size = size;
 	}
 
-	/* print_packet("FULL-TX", data, size); */
-
 	l_debug("Sending %u fragments for %u octets", max_seg + 1, size);
 
 	buf[6] = max_seg << 2;
@@ -168,7 +166,6 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 
 	l_debug("max_seg: %2.2x", max_seg);
 	l_debug("size: %2.2x, CRC: %2.2x", size, buf[9]);
-	/* print_packet("PB-TX", buf + 1, init_size + 9); */
 
 	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
 							buf, init_size + 10);
@@ -186,8 +183,6 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 		buf[6] = (i << 2) | 0x02;
 		memcpy(buf + 7, data + consumed, seg_size);
 
-		/* print_packet("PB-TX", buf + 1, seg_size + 6); */
-
 		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
 							buf, seg_size + 7);
 
@@ -225,7 +220,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 
 	mesh_send_cancel(filter, sizeof(filter));
 
-	l_info("TX timeout");
+	l_debug("TX timeout");
 	cb = session->close_cb;
 	user_data = session->user_data;
 	cb(user_data, 1);
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 4ef31e95d..4de4df62d 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -770,7 +770,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		break;
 
 	case PROV_COMPLETE: /* Complete */
-		l_info("Provisioning Complete");
+		l_debug("Provisioning Complete");
 		prov->state = INT_PROV_IDLE;
 		int_prov_close(prov, PROV_ERR_SUCCESS);
 		break;
-- 
2.26.2

