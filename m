Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJDIZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJDIZ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:25:57 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77832252E
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:25:55 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ofdFR-0002H7-Jx
        for linux-bluetooth@vger.kernel.org; Tue, 04 Oct 2022 10:25:53 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 2948PkTd2433476;
        Tue, 4 Oct 2022 10:25:51 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 4/4] mesh: Always relay messages from Low Power nodes
Date:   Tue,  4 Oct 2022 10:25:30 +0200
Message-Id: <20221004082530.25719-5-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004082530.25719-1-isak.westin@loytec.com>
References: <20221004082530.25719-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If we receive a message from one of our Low Power nodes, which is
encrypted using frendship credentials and where the destination is not
us, we must relay that message using master credentials.
See MshPRFv1.0.1 section 3.6.6.2.
---
 mesh/net.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 577121f30..a1b586a0b 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1763,7 +1763,8 @@ not_for_friend:
 	return true;
 }
 
-static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t net_key_id)
+static uint16_t key_id_to_net_idx(struct mesh_net *net,
+				uint32_t net_key_id, bool *frnd)
 {
 	struct mesh_subnet *subnet;
 	struct mesh_friend *friend;
@@ -1771,6 +1772,9 @@ static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t net_key_id)
 	if (!net)
 		return NET_IDX_INVALID;
 
+	if (frnd)
+		*frnd = false;
+
 	subnet = l_queue_find(net->subnets, match_key_id,
 						L_UINT_TO_PTR(net_key_id));
 
@@ -1780,8 +1784,12 @@ static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t net_key_id)
 	friend = l_queue_find(net->friends, match_friend_key_id,
 						L_UINT_TO_PTR(net_key_id));
 
-	if (friend)
+	if (friend) {
+		if (frnd)
+			*frnd = true;
+
 		return friend->net_idx;
+	}
 
 	friend = l_queue_find(net->negotiations, match_friend_key_id,
 						L_UINT_TO_PTR(net_key_id));
@@ -2078,7 +2086,7 @@ static bool ctl_received(struct mesh_net *net, uint32_t net_key_id,
 			return false;
 
 		print_packet("Rx-NET_OP_FRND_REQUEST", pkt, len);
-		net_idx = key_id_to_net_idx(net, net_key_id);
+		net_idx = key_id_to_net_idx(net, net_key_id, NULL);
 		friend_request(net, net_idx, src, pkt[0], pkt[1],
 				l_get_be32(pkt + 1) & 0xffffff,
 				l_get_be16(pkt + 5), pkt[7],
@@ -2269,7 +2277,8 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 }
 
 static enum _relay_advice packet_received(void *user_data,
-				uint32_t net_key_id, uint32_t iv_index,
+				uint32_t net_key_id, uint16_t net_idx,
+				bool frnd, uint32_t iv_index,
 				const void *data, uint8_t size, int8_t rssi)
 {
 	struct mesh_net *net = user_data;
@@ -2278,16 +2287,11 @@ static enum _relay_advice packet_received(void *user_data,
 	uint8_t net_ttl, key_aid, net_segO, net_segN, net_opcode;
 	uint32_t net_seq, cache_cookie;
 	uint16_t net_src, net_dst, net_seqZero;
-	uint16_t net_idx;
 	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
 
 	memcpy(packet + 2, data, size);
 
-	net_idx = key_id_to_net_idx(net, net_key_id);
-	if (net_idx == NET_IDX_INVALID)
-		return RELAY_NONE;
-
 	print_packet("RX: Network [clr] :", packet + 2, size);
 
 	if (!mesh_crypto_packet_parse(packet + 2, size, &net_ctl, &net_ttl,
@@ -2389,6 +2393,13 @@ static enum _relay_advice packet_received(void *user_data,
 			return RELAY_DISALLOWED;
 	}
 
+	/*
+	 * Messages that are encrypted with friendship credentials
+	 * should *always* be relayed
+	 */
+	if (frnd)
+		return RELAY_ALWAYS;
+
 	/* If relay not enable, or no more hops allowed */
 	if (!net->relay.enable || net_ttl < 0x02)
 		return RELAY_NONE;
@@ -2414,7 +2425,9 @@ static void net_rx(void *net_ptr, void *user_data)
 	uint8_t *out;
 	size_t out_size;
 	uint32_t net_key_id;
+	uint16_t net_idx;
 	int8_t rssi = 0;
+	bool frnd;
 	bool ivi_net = !!(net->iv_index & 1);
 	bool ivi_pkt = !!(data->data[0] & 0x80);
 
@@ -2438,9 +2451,21 @@ static void net_rx(void *net_ptr, void *user_data)
 		rssi = data->info->rssi;
 	}
 
-	relay_advice = packet_received(net, net_key_id, iv_index, out, out_size,
-									rssi);
+	net_idx = key_id_to_net_idx(net, net_key_id, &frnd);
+
+	if (net_idx == NET_IDX_INVALID)
+		return;
+
+	relay_advice = packet_received(net, net_key_id, net_idx, frnd,
+						iv_index, out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
+		/*
+		 * If packet was encrypted with friendship credentials,
+		 * relay it using master credentials
+		 */
+		if (frnd && !mesh_net_get_key(net, false, net_idx, &net_key_id))
+			return;
+
 		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
 		data->net_key_id = net_key_id;
-- 
2.20.1





