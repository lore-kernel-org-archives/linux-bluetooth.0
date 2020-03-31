Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6532C2D0E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A278A20781
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="pvAOtOmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgCaMJS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:09:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35787 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaMJS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id t16so16241448lfl.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4B5VJsRWUQWe+MqSeLE19KvaIR1tuis2QGTSiG34LdM=;
        b=pvAOtOmQl2HcprsXjyvr3ei4oEn58ditrnZEsVe/LXX1oWGIbR2vkN2gDGLYjlbdM1
         ND/5CvBAJwO/6+LdjpMs3xNhJe5xIj1iRT+4IVHYYygeyensHkwtx/A3IArxKhPAex7S
         mIJzvCufUIY02Bbr5SfSKyjlPC4C17vfk1RBrwRxa3DD7wyjS/YT+OF7hbIP14ludX0x
         1vWHAehlOTOqrEyGrIDJ3o1TIY2GeEap5QyFar6E1LXlv0FPrXto6Uo8wXYWvs6pQN3u
         xLxWaJW4c9c6EF+PzH7EdIH5MGC7qWrQeRdnHZ0wsIOVxqNG1o/uJEEFOjXLqPv3gYMp
         FVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=4B5VJsRWUQWe+MqSeLE19KvaIR1tuis2QGTSiG34LdM=;
        b=MuZq/PLQaSCaefr66Ys2s9nzcKwMRZCwUAEwV/HdnNAQFY9rZd/RyCiXyLbsEswBuA
         xS5Qi7gTfyU+tOXtUM2EYEcfvV0cqFmoEP4vHmjQJGcIYHB5+JxAj64HLdjj6+WG2Hw6
         6Czyfecm8ZmarFVVZrUgqiFkrBnewe3rlPaGeSyAArml6mbBEq8jat8Bz0OABIwDK0w/
         C0/NLfgVzSxXaSHPFqkD7DZo01hPGqjquJt09FQU179yWCpEIxEDP2HK1C2cdzAcmRxn
         fXFhxOhjbRexYqH0dfIs97N6ZNhL9kS5GArk17T60zQRdy8XGJE7FEAvWEROYGPV5HCg
         BzJQ==
X-Gm-Message-State: AGi0PuZggdLQrbrAEuC5aMTs1QWL43S3FlK0Lu3nNbJZOhQC46/+rwom
        CAkm0sBm7E5XJ0+z3kBX0pS7+s9ZpLY=
X-Google-Smtp-Source: APiQypKUwQM/fPHKbQDD4hu/HFlxpWqAucp4Ji9BMd4iZsazZMzslpzSAHfWVUGCdbehWQSQd56MfQ==
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr11362305lff.89.1585656555854;
        Tue, 31 Mar 2020 05:09:15 -0700 (PDT)
Received: from pfierek1997.silvair.lan (174.60.citypartner.pl. [195.210.60.174])
        by smtp.gmail.com with ESMTPSA id i190sm9828620lfi.7.2020.03.31.05.09.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:09:15 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] mesh: Remove unused argument from 'mesh_net_transport_send' function
Date:   Tue, 31 Mar 2020 14:09:06 +0200
Message-Id: <20200331120908.23215-2-przemyslaw.fierek@silvair.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
References: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/friend.c | 16 ++++++++--------
 mesh/net.c    | 14 +++++++-------
 mesh/net.h    |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/mesh/friend.c b/mesh/friend.c
index 5f5f6f823..6d26de15b 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -97,7 +97,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
 	n += 2;
 	seq = mesh_net_next_seq_num(neg->net);
 	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
-	mesh_net_transport_send(neg->net, key_id, true,
+	mesh_net_transport_send(neg->net, key_id,
 			mesh_net_get_iv_index(neg->net), 0,
 			seq, 0, neg->lp_addr,
 			msg, n);
@@ -316,7 +316,7 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
 
 	l_put_be16(lpn, msg + 1);
 	l_put_be16(lpnCounter, msg + 3);
-	mesh_net_transport_send(net, 0, false,
+	mesh_net_transport_send(net, 0,
 			mesh_net_get_iv_index(net), DEFAULT_TTL,
 			0, 0, src,
 			msg, sizeof(msg));
@@ -332,7 +332,7 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
 
 	l_put_be16(neg->lp_addr, msg + 1);
 	l_put_be16(neg->lp_cnt, msg + 3);
-	mesh_net_transport_send(neg->net, 0, false,
+	mesh_net_transport_send(neg->net, 0,
 			mesh_net_get_iv_index(neg->net), DEFAULT_TTL,
 			0, 0, neg->old_friend,
 			msg, sizeof(msg));
@@ -398,7 +398,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
 					pkt->u.one[0].data, pkt->last_len);
 
 			pkt->u.one[0].sent = true;
-			mesh_net_transport_send(net, frnd->net_key_cur, false,
+			mesh_net_transport_send(net, frnd->net_key_cur,
 					pkt->iv_index, pkt->ttl,
 					pkt->u.one[0].seq, pkt->src, pkt->dst,
 					pkt->u.one[0].data, pkt->last_len);
@@ -439,7 +439,7 @@ update:
 	l_put_be32(iv_index, upd + 2);
 	upd[6] = false; /* Queue is Empty */
 	print_packet("Update", upd, sizeof(upd));
-	mesh_net_transport_send(net, frnd->net_key_cur, false,
+	mesh_net_transport_send(net, frnd->net_key_cur,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			upd, sizeof(upd));
@@ -487,7 +487,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 			neg->u.negotiate.clearing = true;
 			l_put_be16(neg->lp_addr, msg + 1);
 			l_put_be16(neg->lp_cnt, msg + 3);
-			mesh_net_transport_send(net, 0, false,
+			mesh_net_transport_send(net, 0,
 					mesh_net_get_iv_index(net), DEFAULT_TTL,
 					0, 0, neg->old_friend,
 					msg, sizeof(msg));
@@ -596,7 +596,7 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, frnd->net_key_cur, false,
+	mesh_net_transport_send(net, frnd->net_key_cur,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
@@ -634,7 +634,7 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 
 	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
 	net_seq = mesh_net_get_seq_num(net);
-	mesh_net_transport_send(net, frnd->net_key_cur, false,
+	mesh_net_transport_send(net, frnd->net_key_cur,
 			mesh_net_get_iv_index(net), 0,
 			net_seq, 0, frnd->lp_addr,
 			msg, sizeof(msg));
diff --git a/mesh/net.c b/mesh/net.c
index 0343c4c49..11a9d84a3 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1566,7 +1566,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 		friend_ack_rxed(net, mesh_net_get_iv_index(net),
 				mesh_net_next_seq_num(net), 0, dst, msg);
 	} else {
-		mesh_net_transport_send(net, 0, false,
+		mesh_net_transport_send(net, 0,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
 				0, 0, dst, msg, sizeof(msg));
 	}
@@ -1601,7 +1601,7 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 		return;
 	}
 
-	mesh_net_transport_send(net, 0, false,
+	mesh_net_transport_send(net, 0,
 				mesh_net_get_iv_index(net), DEFAULT_TTL,
 				0, src, dst, msg, sizeof(msg));
 }
@@ -2208,7 +2208,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 	}
 
 	if (n) {
-		mesh_net_transport_send(net, 0, false,
+		mesh_net_transport_send(net, 0,
 				mesh_net_get_iv_index(net), rsp_ttl,
 				0, dst & 0x8000 ? 0 : dst, src,
 				msg, n);
@@ -2988,7 +2988,7 @@ void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr)
 	l_put_be16(addr, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, 0, false,
+	mesh_net_transport_send(net, 0,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, 0, msg, n);
 }
@@ -3001,7 +3001,7 @@ void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr)
 	l_put_be16(addr, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, 0, false,
+	mesh_net_transport_send(net, 0,
 			mesh_net_get_iv_index(net), 0,
 			0, 0, 0, msg, n);
 }
@@ -3350,7 +3350,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 
 /* TODO: add net key index */
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
-				bool fast, uint32_t iv_index, uint8_t ttl,
+				uint32_t iv_index, uint8_t ttl,
 				uint32_t seq, uint16_t src, uint16_t dst,
 				const uint8_t *msg, uint16_t msg_len)
 {
@@ -3583,7 +3583,7 @@ void mesh_net_heartbeat_send(struct mesh_net *net)
 	l_put_be16(hb->features, msg + n);
 	n += 2;
 
-	mesh_net_transport_send(net, 0, false, mesh_net_get_iv_index(net),
+	mesh_net_transport_send(net, 0, mesh_net_get_iv_index(net),
 				hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
 }
 
diff --git a/mesh/net.h b/mesh/net.h
index cb90c1d92..57585ceff 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -305,7 +305,7 @@ struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
 bool mesh_net_flush(struct mesh_net *net);
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
-				bool fast, uint32_t iv_index, uint8_t ttl,
+				uint32_t iv_index, uint8_t ttl,
 				uint32_t seq, uint16_t src, uint16_t dst,
 				const uint8_t *msg, uint16_t msg_len);
 
-- 
2.17.1

