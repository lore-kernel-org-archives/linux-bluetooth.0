Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19EC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9852082E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="1cbjY7tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0NSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:18:00 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42259 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 09:17:59 -0400
Received: by mail-wr1-f54.google.com with SMTP id h15so11339434wrx.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsz4sm+F4MoieukzrqsUZ5OHpE5miA8UM9vEGMVkxxc=;
        b=1cbjY7tfg67tu92FXFJ7epeBoQrgcCZ6wOIJOTxGWdTfja+ZssNLEqitVRbw13Jgrs
         yYPPUMxAI5hdW6MRqyO4TNjt1XOOUBlF/87014iuovvcqQSz6VaHZTnTyWtqq6KViiXg
         kkL6Q9Sp6JfuODIMRcvb0Y+C48bgTQOOafPwuQvJStZ27VPkH32JOcs91oTO7bpPh24j
         dNpnemX/Ok2x8KI0JxqMCXipaq3WLO2Jxzpq50oWt6G5qYlR10+gj11OQht5a0jAoctT
         GX4OZt9ziAB1+u0ncEtv/L1WqSlkZxCgFNjCEhRDf1bThmTKyNGz0OkReqW8sDDYpdIw
         X/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsz4sm+F4MoieukzrqsUZ5OHpE5miA8UM9vEGMVkxxc=;
        b=dhCpBvrw+ynclusb84c7ijGEAlmCpN8vTsXGswqrsqgk9cgn3b5mfEXoHMbOsy2A4c
         0J9s9Hln57LpLuaKT86cuTj9MrbU2SC40EV82Hia1XHF7QDzAa9nwcp/bTERNHEn2J0n
         mDe5G1Z4C6dk21+5izjR2cWvpiwnK0q+MlNJ3/7RXihQJsoAw3GVeq4yLbDsEcTWm0wc
         JfNDJAOiCZY9CqEsjHSph6VkaqxfxQp+1L0rtmObPSvl2ULLmLw+GxIfw0JuCuzxe1vE
         TSPFABgmorJwUYIfAoGRPzVdOnEqn6HyOBtu6XwSlH0K4qyPLYD481BTHCU1Khrej8No
         nRQg==
X-Gm-Message-State: ANhLgQ0XQ9R+vUKZTjtronLdwiCabxATkfl7e64bttxWOJrxMRQB5Hjt
        Um0Vx6sV6rgaN/rG/M7M2FzfoedUBTj+kQ==
X-Google-Smtp-Source: ADFU+vvPYyB+goVFibKb/m/3VCfzk2QX/hZ9/RXzntXypkSQWTx47DsgUeFGxNc8sU6n6CnbkBCfYw==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr14683207wru.159.1585315077647;
        Fri, 27 Mar 2020 06:17:57 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w67sm7911446wmb.41.2020.03.27.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:17:56 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ] mesh: Add net key index to send_seg()
Date:   Fri, 27 Mar 2020 14:18:00 +0100
Message-Id: <20200327131800.7637-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

This patch adds net key index to send_seg(). This fixes problem with
using invalid network key to encrypt application messages.
---
 mesh/net.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 0343c4c49..c9ab843fa 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1528,7 +1528,8 @@ static void friend_ack_rxed(struct mesh_net *net, uint32_t iv_index,
 	l_queue_foreach(net->friends, enqueue_friend_pkt, &frnd_ack);
 }
 
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t seg);
+static bool send_seg(struct mesh_net *net, uint16_t net_idx,
+					struct mesh_sar *msg, uint8_t seg);
 
 static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 						uint32_t hdr, uint32_t flags)
@@ -1684,6 +1685,7 @@ static void ack_received(struct mesh_net *net, bool timeout,
 	struct mesh_sar *outgoing;
 	uint32_t seg_flag = 0x00000001;
 	uint32_t ack_copy = ack_flag;
+	uint16_t net_idx;
 	uint16_t i;
 
 	l_info("ACK Rxed (%x) (to:%d): %8.8x", seq0, timeout, ack_flag);
@@ -1734,7 +1736,9 @@ static void ack_received(struct mesh_net *net, bool timeout,
 		l_info("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
 				i, net, outgoing->remote, outgoing->app_idx);
 
-		send_seg(net, outgoing, i);
+		net_idx = appkey_net_idx(net, outgoing->app_idx);
+
+		send_seg(net, net_idx, outgoing, i);
 	}
 
 	l_timeout_remove(outgoing->seg_timeout);
@@ -3058,8 +3062,8 @@ bool mesh_net_flush(struct mesh_net *net)
 	return true;
 }
 
-/* TODO: add net key index */
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
+static bool send_seg(struct mesh_net *net, uint16_t net_idx,
+					struct mesh_sar *msg, uint8_t segO)
 {
 	struct mesh_subnet *subnet;
 	uint8_t seg_len;
@@ -3068,7 +3072,6 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 	uint8_t packet_len;
 	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
 	uint16_t seg_off = SEG_OFF(segO);
-	uint32_t key_id = 0;
 	uint32_t seq_num;
 
 	if (msg->segmented) {
@@ -3109,10 +3112,13 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
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
@@ -3272,11 +3278,11 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 
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
-- 
2.20.1

