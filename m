Return-Path: <SRS0=2pC7=4Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF41C10F25
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 23:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A70620665
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 23:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCGXVL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Mar 2020 18:21:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:56551 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgCGXVL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Mar 2020 18:21:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 15:21:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,527,1574150400"; 
   d="scan'208";a="353060114"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.114.199])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2020 15:21:09 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Allow short messages to be segmented
Date:   Sat,  7 Mar 2020 15:21:03 -0800
Message-Id: <20200307232103.3445-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For add reliability, it is legal to send short messages as "single
segment" segmented messages, which require transport layer
acknowledgement. This feature is intended for heavy usage in the future
so I am adding it now.

Further, to support this functionality, an additional queue has been
added to allow multiple SAR messages to the same DST to be queued and
sent serially.
---
 mesh/cfgmod-server.c    | 14 +++----
 mesh/model.c            | 12 +++---
 mesh/model.h            |  2 +-
 mesh/net.c              | 88 ++++++++++++++++++++++++++++-------------
 mesh/net.h              |  6 ++-
 mesh/node.c             |  8 ++--
 unit/test-mesh-crypto.c |  4 +-
 7 files changed, 84 insertions(+), 50 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a1f682765..35b9b0af0 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -67,7 +67,7 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 	}
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-								msg, n);
+								false, msg, n);
 }
 
 static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
@@ -211,8 +211,8 @@ static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
-							DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
+								false, msg, n);
 }
 
 static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
@@ -272,7 +272,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
 	*msg_status = (uint8_t) status;
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-									msg, n);
+								false, msg, n);
 	return true;
 }
 
@@ -450,7 +450,7 @@ static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
 	n += 2;
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-									msg, n);
+								false, msg, n);
 }
 
 static void model_app_list(struct mesh_node *node, uint16_t net_idx,
@@ -505,7 +505,7 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 	if (result >= 0) {
 		*status = result;
 		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
-							DEFAULT_TTL, msg, n);
+						DEFAULT_TTL, false, msg, n);
 	}
 
 	l_free(msg);
@@ -1234,7 +1234,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
 		mesh_model_send(node, dst, src,
-				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
+				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL, false,
 				long_msg ? long_msg : msg, n);
 	}
 	l_free(long_msg);
diff --git a/mesh/model.c b/mesh/model.c
index d11c95ab9..945583324 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -540,7 +540,7 @@ static void cmplt(uint16_t remote, uint8_t status,
 
 static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		uint32_t dst, uint16_t app_idx, uint16_t net_idx,
-		uint8_t *label, uint8_t ttl,
+		uint8_t *label, uint8_t ttl, bool segmented,
 		const void *msg, uint16_t msg_len)
 {
 	uint8_t dev_key[16];
@@ -597,8 +597,8 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 	/* print_packet("Encrypted with", key, 16); */
 
 	ret = mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
-					ttl, seq_num, iv_index, szmic, out,
-					out_len, cmplt, NULL);
+					ttl, seq_num, iv_index, segmented,
+					szmic, out, out_len, cmplt, NULL);
 done:
 	l_free(out);
 	return ret;
@@ -1098,14 +1098,14 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 
 	result = msg_send(node, mod->pub->credential != 0, src,
 				mod->pub->addr, mod->pub->idx, net_idx,
-				label, ttl, msg, msg_len);
+				label, ttl, false, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 }
 
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
-					uint8_t ttl,
+					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len)
 {
 	/* print_packet("Mod Tx", msg, msg_len); */
@@ -1120,7 +1120,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 		return false;
 
 	return msg_send(node, false, src, dst, app_idx, net_idx,
-						NULL, ttl, msg, msg_len);
+					NULL, ttl, segmented, msg, msg_len);
 }
 
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
diff --git a/mesh/model.h b/mesh/model.h
index 153ab9bfd..f8e0f9d37 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -95,7 +95,7 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
-					uint8_t ttl,
+					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len);
 int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
 				uint8_t ttl, const void *msg, uint16_t msg_len);
diff --git a/mesh/net.c b/mesh/net.c
index d3325e073..c89f55a9e 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -139,6 +139,7 @@ struct mesh_net {
 	struct l_queue *replay_cache;
 	struct l_queue *sar_in;
 	struct l_queue *sar_out;
+	struct l_queue *sar_queue;
 	struct l_queue *frnd_msgs;
 	struct l_queue *friends;
 	struct l_queue *negotiations;
@@ -182,6 +183,7 @@ struct mesh_sar {
 	uint16_t remote;
 	uint16_t len;
 	bool szmic;
+	bool segmented;
 	bool frnd;
 	bool frnd_cred;
 	uint8_t ttl;
@@ -662,6 +664,7 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->msg_cache = l_queue_new();
 	net->sar_in = l_queue_new();
 	net->sar_out = l_queue_new();
+	net->sar_queue = l_queue_new();
 	net->frnd_msgs = l_queue_new();
 	net->destinations = l_queue_new();
 	net->app_keys = l_queue_new();
@@ -687,6 +690,7 @@ void mesh_net_free(struct mesh_net *net)
 	l_queue_destroy(net->replay_cache, l_free);
 	l_queue_destroy(net->sar_in, mesh_sar_free);
 	l_queue_destroy(net->sar_out, mesh_sar_free);
+	l_queue_destroy(net->sar_queue, mesh_sar_free);
 	l_queue_destroy(net->frnd_msgs, l_free);
 	l_queue_destroy(net->friends, mesh_friend_free);
 	l_queue_destroy(net->negotiations, mesh_friend_free);
@@ -1657,6 +1661,21 @@ static void outmsg_to(struct l_timeout *msg_timeout, void *user_data)
 }
 
 static void outseg_to(struct l_timeout *seg_timeout, void *user_data);
+
+static void send_queued_sar(struct mesh_net *net, uint16_t dst)
+{
+	struct mesh_sar *sar = l_queue_remove_if(net->sar_queue,
+			match_sar_remote, L_UINT_TO_PTR(dst));
+
+	if (!sar) return;
+
+	/* Out to current outgoing, and immediate expire Seg TO */
+	l_queue_push_head(net->sar_out, sar);
+	sar->seg_timeout = NULL;
+	sar->msg_timeout = l_timeout_create(MSG_TO, outmsg_to, net, NULL);
+	outseg_to(NULL, net);
+}
+
 static void ack_received(struct mesh_net *net, bool timeout,
 				uint16_t src, uint16_t dst,
 				uint16_t seq0, uint32_t ack_flag)
@@ -1692,6 +1711,7 @@ static void ack_received(struct mesh_net *net, bool timeout,
 					outgoing->len - 4, outgoing->user_data);
 
 		l_queue_remove(net->sar_out, outgoing);
+		send_queued_sar(net, outgoing->remote);
 		mesh_sar_free(outgoing);
 
 		return;
@@ -1701,10 +1721,10 @@ static void ack_received(struct mesh_net *net, bool timeout,
 
 	ack_copy &= outgoing->flags;
 
-	for (i = 0; i <= SEG_MAX(outgoing->len); i++, seg_flag <<= 1) {
+	for (i = 0; i <= SEG_MAX(true, outgoing->len); i++, seg_flag <<= 1) {
 		if (seg_flag & ack_flag) {
 			l_debug("Skipping Seg %d of %d",
-					i, SEG_MAX(outgoing->len));
+					i, SEG_MAX(true, outgoing->len));
 			continue;
 		}
 
@@ -1741,7 +1761,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 					uint8_t ttl, uint32_t seq,
 					uint16_t net_idx,
 					uint16_t src, uint16_t dst,
-					uint8_t key_aid,
+					uint8_t key_aid, bool segmented,
 					bool szmic, uint16_t seqZero,
 					const uint8_t *data, uint16_t size)
 {
@@ -1768,7 +1788,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 			hdr |= true << SEG_HDR_SHIFT;
 			hdr |= szmic << SZMIC_HDR_SHIFT;
 			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
-			hdr |= SEG_MAX(size) << SEGN_HDR_SHIFT;
+			hdr |= SEG_MAX(true, size) << SEGN_HDR_SHIFT;
 		}
 
 		if (friend_packet_queue(net, iv_index, false, frnd_ttl,
@@ -1967,7 +1987,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		l_info("RXed (old: %04x %06x size:%d) %d of %d",
 					seqZero, seq, size, segO, segN);
 		/* Sanity Check--> certain things must match */
-		if (SEG_MAX(sar_in->len) != segN ||
+		if (SEG_MAX(true, sar_in->len) != segN ||
 				sar_in->key_aid != key_aid)
 			return false;
 
@@ -2022,8 +2042,8 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 
 		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
 				sar_in->remote, dst,
-				key_aid,
-				szmic, sar_in->seqZero,
+				key_aid, true, szmic,
+				sar_in->seqZero,
 				sar_in->buf, sar_in->len);
 
 		/* Kill Inter-Seg timeout */
@@ -2426,7 +2446,8 @@ static enum _relay_advice packet_received(void *user_data,
 						net_idx,
 						net_src, net_dst,
 						net_key_id,
-						false, net_seq & SEQ_ZERO_MASK,
+						false, false,
+						net_seq & SEQ_ZERO_MASK,
 						msg, app_msg_len);
 		}
 
@@ -2539,7 +2560,8 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 
 	switch (net->iv_upd_state) {
 	case IV_UPD_UPDATING:
-		if (l_queue_length(net->sar_out)) {
+		if (l_queue_length(net->sar_out) ||
+					l_queue_length(net->sar_queue)) {
 			l_info("don't leave IV Update until sar_out empty");
 			l_timeout_modify(net->iv_update_timeout, 10);
 			break;
@@ -3043,12 +3065,12 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	uint8_t gatt_data[30];
 	uint8_t *packet = gatt_data;
 	uint8_t packet_len;
-	uint8_t segN = SEG_MAX(msg->len);
+	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
 	uint16_t seg_off = SEG_OFF(segO);
 	uint32_t key_id = 0;
 	uint32_t seq_num;
 
-	if (segN) {
+	if (msg->segmented) {
 		/* Send each segment on unique seq_num */
 		seq_num = mesh_net_next_seq_num(net);
 
@@ -3075,7 +3097,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 					seq_num,
 					msg->src, msg->remote,
 					0,
-					segN ? true : false, msg->key_aid,
+					msg->segmented, msg->key_aid,
 					msg->szmic, false, msg->seqZero,
 					segO, segN,
 					msg->buf + seg_off, seg_len,
@@ -3169,7 +3191,8 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_aid, uint16_t net_idx,
 				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool szmic, const void *msg, uint16_t msg_len,
+				bool segmented, bool szmic,
+				const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data)
 {
@@ -3189,14 +3212,16 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	if (ttl == DEFAULT_TTL)
 		ttl = net->default_ttl;
 
-	seg_max = SEG_MAX(msg_len);
+	segmented |= szmic;
+	seg_max = SEG_MAX(segmented, msg_len);
+	segmented |= !!(seg_max);
 
 	/* First enqueue to any Friends and internal models */
 	result = msg_rxed(net, false, iv_index, ttl,
 				seq,
 				net_idx,
 				src, dst,
-				key_aid,
+				key_aid, segmented,
 				szmic, seq & SEQ_ZERO_MASK,
 				msg, msg_len);
 
@@ -3207,13 +3232,6 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 			(dst >= net->src_addr && dst <= net->last_addr))
 		return true;
 
-	/* If Segmented, Cancel any OB segmented message to same DST */
-	if (seg_max) {
-		payload = l_queue_remove_if(net->sar_out, match_sar_remote,
-							L_UINT_TO_PTR(dst));
-		mesh_sar_free(payload);
-	}
-
 	/* Setup OTA Network send */
 	payload = mesh_sar_new(msg_len);
 	memcpy(payload->buf, msg, msg_len);
@@ -3224,16 +3242,30 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->szmic = szmic;
 	payload->frnd_cred = frnd_cred;
 	payload->key_aid = key_aid;
-	if (seg_max) {
+	payload->iv_index = mesh_net_get_iv_index(net);
+	payload->seqAuth = seq;
+	payload->segmented = segmented;
+	if (segmented) {
 		payload->flags = 0xffffffff >> (31 - seg_max);
 		payload->seqZero = seq & SEQ_ZERO_MASK;
-	}
+		payload->status_func = status_func;
+		payload->user_data = user_data;
+		payload->id = ++net->sar_id_next;
 
-	payload->iv_index = mesh_net_get_iv_index(net);
-	payload->seqAuth = seq;
+		/* Single thread SAR messages to same Unicast DST */
+		if (NULL != l_queue_find(net->sar_out, match_sar_remote,
+							L_UINT_TO_PTR(dst))) {
+			/* Delay sending Outbound SAR unless prior
+			 * SAR to same DST has completed */
+
+			l_info("OB-Queued SeqZero: %4.4x", payload->seqZero);
+			l_queue_push_tail(net->sar_queue, payload);
+			return true;
+		}
+	}
 
 	result = true;
-	if (!IS_UNICAST(dst) && seg_max) {
+	if (!IS_UNICAST(dst) && segmented) {
 		int i;
 
 		for (i = 0; i < 4; i++) {
@@ -3246,7 +3278,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	}
 
 	/* Reliable: Cache; Unreliable: Flush*/
-	if (result && seg_max && IS_UNICAST(dst)) {
+	if (result && segmented && IS_UNICAST(dst)) {
 		l_queue_push_head(net->sar_out, payload);
 		payload->seg_timeout =
 			l_timeout_create(SEG_TO, outseg_to, net, NULL);
diff --git a/mesh/net.h b/mesh/net.h
index 6fedd69d7..cb90c1d92 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -40,8 +40,9 @@ struct mesh_node;
 
 #define MAX_UNSEG_LEN	15 /* msg_len == 11 + sizeof(MIC) */
 #define MAX_SEG_LEN	12 /* UnSeg length - 3 octets overhead */
-#define SEG_MAX(len)	(((len) <= MAX_UNSEG_LEN) ? 0 : \
+#define SEG_MAX(seg, len) ((!seg && len <= MAX_UNSEG_LEN) ? 0 : \
 						(((len) - 1) / MAX_SEG_LEN))
+
 #define SEG_OFF(seg)	((seg) * MAX_SEG_LEN)
 #define MAX_SEG_TO_LEN(seg)	((seg) ? SEG_OFF((seg) + 1) : MAX_UNSEG_LEN)
 
@@ -311,7 +312,8 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_id, uint16_t net_idx,
 				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool szmic, const void *msg, uint16_t msg_len,
+				bool segmented, bool szmic,
+				const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data);
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
diff --git a/mesh/node.c b/mesh/node.c
index d4be070fa..1b7dea736 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1830,7 +1830,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 						"Invalid key_index");
 
-	if (!mesh_model_send(node, src, dst, app_idx, 0, DEFAULT_TTL,
+	if (!mesh_model_send(node, src, dst, app_idx, 0, DEFAULT_TTL, false,
 								data, len))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
@@ -1879,7 +1879,7 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 
 	app_idx = remote ? APP_IDX_DEV_REMOTE : APP_IDX_DEV_LOCAL;
 	if (!mesh_model_send(node, src, dst, app_idx, net_idx, DEFAULT_TTL,
-								data, len))
+							true, data, len))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1937,7 +1937,7 @@ static struct l_dbus_message *add_netkey_call(struct l_dbus *dbus,
 	l_put_le16(sub_idx, &data[2]);
 
 	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
-							DEFAULT_TTL, data, 20))
+						DEFAULT_TTL, false, data, 20))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -2003,7 +2003,7 @@ static struct l_dbus_message *add_appkey_call(struct l_dbus *dbus,
 	data[3] = app_idx >> 4;
 
 	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
-							DEFAULT_TTL, data, 20))
+						DEFAULT_TTL, false, data, 20))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 32c46a54e..0043b0b10 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -1017,7 +1017,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		app_msg = l_util_from_hexstring(keys->app_msg, &app_msg_len);
 
 		if (keys->szmic) {
-			seg_max = SEG_MAX(app_msg_len + 8);
+			seg_max = SEG_MAX(keys->segmented, app_msg_len + 8);
 			enc_msg = l_malloc(app_msg_len + 8);
 			mesh_crypto_application_encrypt(key_aid, keys->app_seq,
 					keys->net_src, keys->net_dst,
@@ -1028,7 +1028,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					enc_msg, &app_mic64, sizeof(app_mic64));
 			l_put_be64(app_mic64, enc_msg + app_msg_len);
 		} else {
-			seg_max = SEG_MAX(app_msg_len + 4);
+			seg_max = SEG_MAX(keys->segmented, app_msg_len + 4);
 			enc_msg = l_malloc(app_msg_len + 4);
 			mesh_crypto_application_encrypt(key_aid, keys->app_seq,
 					keys->net_src, keys->net_dst,
-- 
2.21.1

