Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B1C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B997720781
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IF6VUKAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgCaMJV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:09:21 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46643 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaMJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:21 -0400
Received: by mail-lf1-f45.google.com with SMTP id q5so17059897lfb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gW9scRCQt3echZK/7jHFNMXLTq0XzcM1Tl1QpKVGFbo=;
        b=IF6VUKAbmfFYto44ejkk26gS+CoEirUKvOpKAf3suuLA25BeOATk/uo0AERDZdHN4X
         shBegzm453MuzKX0apMMqJjiFc3+QwW3KOAMvheR1kxzifMspmBsR+kJf7papvvCKti9
         g+V41GLkWXlM+55UFHic9lzTqLTk5Kh9JL4Xa3VMjFUHk+RpvzpOGKY4EMpRhDMdsFVc
         /obQC4jtKfr5Nk18YeMjPbtD2olaRFtdsSHc0gVTBInUlDHpRTk+BxRpmEVEkuxExPCg
         Jk8oHvE56E9a25Yg2AQfGUuY4omOTnLW8Ur6aeygZ7iPwABodrBlYr2bixq+1dotgsrw
         KM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gW9scRCQt3echZK/7jHFNMXLTq0XzcM1Tl1QpKVGFbo=;
        b=D8kE4iyhO7IYs+IB9vEN2/QjkEiTUZq4bubdZdiUGgD4DK3HPozQywSFO28oiPD8IY
         fopkczU8p8QxydPu1trM8w4DOyw80TcbB9xGLjd+nVWIpFd5jW3m4WbrWiDHXftsJvqZ
         MjRv2msWda7jDNIPj6D72pEoVqGjJ1g8p9ny2g8to991wVyRH7gtJLmvLeBL9Egau3f4
         U0A9vnp2Nju/Qh9rANsFyLlTqZfD0ZUrW+3ZMfnJ2r5zr5nAj7sJquCj0pVaQThSbeHn
         BxrHGvma++aAvbLZnSyzhx3ShKgIDyaSh8rkz98yjENWoPcwXboZS0dGKEREAEykQ6Pm
         7ZOg==
X-Gm-Message-State: AGi0PuZxQ0cfC6HjrV0B9fJDQnjllod77CskyLr78cJYn6kYekmzMGMv
        U6slJSgtYUysv09fl/p/hwA8Rt/GlJU=
X-Google-Smtp-Source: APiQypL4ftjsunKV5Yr9Gm/zq4nHCfMJA2IdYTurLsAPRL0Rh8wcC2jIIKT9RdDPm6phhXJa+rtydg==
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr11376289lfb.116.1585656557197;
        Tue, 31 Mar 2020 05:09:17 -0700 (PDT)
Received: from pfierek1997.silvair.lan (174.60.citypartner.pl. [195.210.60.174])
        by smtp.gmail.com with ESMTPSA id i190sm9828620lfi.7.2020.03.31.05.09.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:09:16 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] mesh: Add net key index to send_seg()
Date:   Tue, 31 Mar 2020 14:09:08 +0200
Message-Id: <20200331120908.23215-4-przemyslaw.fierek@silvair.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
References: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds net key index to send_seg(). This fixes problem with
using invalid network key to encrypt application messages.
---
 mesh/friend.c | 16 ++++++++--------
 mesh/net.c    | 50 ++++++++++++++++++++++++++++++--------------------
 mesh/net.h    |  7 ++++---
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/mesh/friend.c b/mesh/friend.c
index 6d26de15b..d27da9592 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -97,7 +97,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	n += 2;
 	seq = mesh_net_next_seq_num(neg->net);
 	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
-	mesh_net_transport_send(neg->net, key_id,
+	mesh_net_transport_send(neg->net, key_id, 0,
 			mesh_net_get_iv_index(neg->net), 0,
 			seq, 0, neg->lp_addr,
 			msg, n);
@@ -316,7 +316,7 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 
 	l_put_be16(lpn, msg + 1);
 	l_put_be16(lpnCounter, msg + 3);
-	mesh_net_transport_send(net, 0,
+	mesh_net_transport_send(net, 0, 0,
 			mesh_net_get_iv_index(net), DEFAULT_TTL,
 			0, 0, src,
 			msg, sizeof(msg));
@@ -332,7 +332,7 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
 
 	l_put_be16(neg->lp_addr, msg + 1);
 	l_put_be16(neg->lp_cnt, msg + 3);
-	mesh_net_transport_send(neg->net, 0,
+	mesh_net_transport_send(neg->net, 0, 0,
 			mesh_net_get_iv_index(neg->net), DEFAULT_TTL,
 			0, 0, neg->old_friend,
 			msg, sizeof(msg));
@@ -398,7 +398,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 					pkt->u.one[0].data, pkt->last_len);
 
 			pkt->u.one[0].sent = true;
-			mesh_net_transport_send(net, frnd->net_key_cur,
+			mesh_net_transport_send(net, frnd->net_key_cur, 0,
 					pkt->iv_index, pkt->ttl,
 					pkt->u.one[0].seq, pkt->src, pkt->dst,
 					pkt->u.one[0].data, pkt->last_len);
@@ -439,7 +439,7 @@ update:
 	l_put_be32(iv_index, upd + 2);
 	upd[6] = false; /* Queue is Empty */
 	print_packet("Update", upd, sizeof(upd));
-	mesh_net_transport_send(net, frnd->net_key_cur,
+	mesh_net_transport_send(net, frnd->net_key_cur, 0,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			upd, sizeof(upd));
@@ -487,7 +487,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 			neg->u.negotiate.clearing = true;
 			l_put_be16(neg->lp_addr, msg + 1);
 			l_put_be16(neg->lp_cnt, msg + 3);
-			mesh_net_transport_send(net, 0,
+			mesh_net_transport_send(net, 0, 0,
 					mesh_net_get_iv_index(net), DEFAULT_TTL,
 					0, 0, neg->old_friend,
 					msg, sizeof(msg));
@@ -596,7 +596,7 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, frnd->net_key_cur,
+	mesh_net_transport_send(net, frnd->net_key_cur, 0,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
@@ -634,7 +634,7 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, frnd->net_key_cur,
+	mesh_net_transport_send(net, frnd->net_key_cur, 0,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
diff --git a/mesh/net.c b/mesh/net.c
index 5f49034e4..ba9a8caf1 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -179,6 +179,7 @@ struct mesh_sar {
 	uint32_t seqAuth;
 	uint16_t seqZero;
 	uint16_t app_idx;
+	uint16_t net_idx;
 	uint16_t src;
 	uint16_t remote;
 	uint16_t len;
@@ -1528,7 +1529,8 @@ static void friend_ack_rxed(struct mesh_net *net, uint32_t iv_index,
 	l_queue_foreach(net->friends, enqueue_friend_pkt, &frnd_ack);
 }
 
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t seg);
+static bool send_seg(struct mesh_net *net, uint16_t net_idx,
+					struct mesh_sar *msg, uint8_t seg);
 
 static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 						uint32_t hdr, uint32_t flags)
@@ -1566,7 +1568,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 		friend_ack_rxed(net, mesh_net_get_iv_index(net),
 				mesh_net_next_seq_num(net), 0, dst, msg);
 	} else {
-		mesh_net_transport_send(net, 0,
+		mesh_net_transport_send(net, 0, 0,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
 				0, 0, dst, msg, sizeof(msg));
 	}
@@ -1601,9 +1603,10 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 		return;
 	}
 
-	mesh_net_transport_send(net, 0,
+	mesh_net_transport_send(net, 0, sar->net_idx,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
-				0, src, dst, msg, sizeof(msg));
+				0, src, dst, msg,
+				sizeof(msg));
 }
 
 static void inseg_to(struct l_timeout *seg_timeout, void *user_data)
@@ -1734,7 +1737,7 @@ static void ack_received(struct mesh_net *net, bool timeout,
 		l_info("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
 				i, net, outgoing->remote, outgoing->app_idx);
 
-		send_seg(net, outgoing, i);
+		send_seg(net, outgoing->net_idx, outgoing, i);
 	}
 
 	l_timeout_remove(outgoing->seg_timeout);
@@ -2012,6 +2015,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		sar_in->key_aid = key_aid;
 		sar_in->len = len;
 		sar_in->last_seg = 0xff;
+		sar_in->net_idx = net_idx;
 		sar_in->msg_timeout = l_timeout_create(MSG_TO,
 					inmsg_to, net, NULL);
 
@@ -2208,7 +2212,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 	}
 
 	if (n) {
-		mesh_net_transport_send(net, 0,
+		mesh_net_transport_send(net, 0, 0,
 				mesh_net_get_iv_index(net), rsp_ttl,
 				0, dst & 0x8000 ? 0 : dst, src,
 				msg, n);
@@ -3031,8 +3035,8 @@ bool mesh_net_flush(struct mesh_net *net)
 	return true;
 }
 
-/* TODO: add net key index */
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
+static bool send_seg(struct mesh_net *net, uint16_t net_idx,
+					struct mesh_sar *msg, uint8_t segO)
 {
 	struct mesh_subnet *subnet;
 	uint8_t seg_len;
@@ -3041,7 +3045,6 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	uint8_t packet_len;
 	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
 	uint16_t seg_off = SEG_OFF(segO);
-	uint32_t key_id = 0;
 	uint32_t seq_num;
 
 	if (msg->segmented) {
@@ -3082,10 +3085,13 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	}
 	print_packet("Clr-Net Tx", packet + 1, packet_len);
 
-	subnet = get_primary_subnet(net);
-	key_id = subnet->net_key_tx;
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(net_idx));
+	if (!subnet)
+		return false;
 
-	if (!net_key_encrypt(key_id, msg->iv_index, packet + 1, packet_len)) {
+	if (!net_key_encrypt(subnet->net_key_tx, msg->iv_index, packet + 1,
+							     packet_len)) {
 		l_error("Failed to encode packet");
 		return false;
 	}
@@ -3217,6 +3223,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->szmic = szmic;
 	payload->frnd_cred = frnd_cred;
 	payload->key_aid = key_aid;
+	payload->net_idx = net_idx;
 	payload->iv_index = mesh_net_get_iv_index(net);
 	payload->seqAuth = seq;
 	payload->segmented = segmented;
@@ -3245,11 +3252,11 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 
 		for (i = 0; i < 4; i++) {
 			for (seg = 0; seg <= seg_max && result; seg++)
-				result = send_seg(net, payload, seg);
+				result = send_seg(net, net_idx, payload, seg);
 		}
 	} else {
 		for (seg = 0; seg <= seg_max && result; seg++)
-			result = send_seg(net, payload, seg);
+			result = send_seg(net, net_idx, payload, seg);
 	}
 
 	/* Reliable: Cache; Unreliable: Flush*/
@@ -3321,11 +3328,11 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 	l_free(str);
 }
 
-/* TODO: add net key index */
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
-				uint32_t iv_index, uint8_t ttl,
-				uint32_t seq, uint16_t src, uint16_t dst,
-				const uint8_t *msg, uint16_t msg_len)
+				uint16_t net_idx, uint32_t iv_index,
+				uint8_t ttl, uint32_t seq, uint16_t src,
+				uint16_t dst, const uint8_t *msg,
+				uint16_t msg_len)
 {
 	uint32_t use_seq = seq;
 	uint8_t pkt_len;
@@ -3373,7 +3380,10 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 	}
 
 	if (!key_id) {
-		struct mesh_subnet *subnet = get_primary_subnet(net);
+		struct mesh_subnet *subnet = l_queue_find(net->subnets,
+				match_key_index, L_UINT_TO_PTR(net_idx));
+		if (!subnet)
+			return;
 
 		key_id = subnet->net_key_tx;
 		use_seq = mesh_net_next_seq_num(net);
@@ -3556,7 +3566,7 @@ void mesh_net_heartbeat_send(struct mesh_net *net)
 	l_put_be16(hb->features, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, 0, mesh_net_get_iv_index(net),
+	mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
 				hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
 }
 
diff --git a/mesh/net.h b/mesh/net.h
index df4366b59..60396dbe7 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -305,9 +305,10 @@ struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
 bool mesh_net_flush(struct mesh_net *net);
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
-				uint32_t iv_index, uint8_t ttl,
-				uint32_t seq, uint16_t src, uint16_t dst,
-				const uint8_t *msg, uint16_t msg_len);
+				uint16_t net_idx, uint32_t iv_index,
+				uint8_t ttl, uint32_t seq, uint16_t src,
+				uint16_t dst, const uint8_t *msg,
+				uint16_t msg_len);
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_id, uint16_t net_idx,
-- 
2.17.1

