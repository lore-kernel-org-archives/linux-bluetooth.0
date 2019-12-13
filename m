Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D8C4D2F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA702478A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfLMUZF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:25:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:63075 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbfLMUZF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 15:25:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 12:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="388786264"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.70.3])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2019 12:25:05 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Cleanup unused LPN code
Date:   Fri, 13 Dec 2019 12:25:02 -0800
Message-Id: <20191213202502.3504-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The daemon does not support the LPN role, and this is unreferenced code.
---
 mesh/net.c | 56 ++++++++----------------------------------------------
 mesh/net.h |  2 --
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index e708b2aa4..0485086bc 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -118,7 +118,6 @@ struct mesh_net {
 	uint32_t seq_num;
 	uint16_t src_addr;
 	uint16_t last_addr;
-	uint16_t friend_addr;
 	uint16_t tx_interval;
 	uint16_t tx_cnt;
 	uint8_t chan; /* Channel of recent Rx */
@@ -1550,10 +1549,6 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 	if (src & 0x8000)
 		return;
 
-	/* We don't ACK segments as a Low Power Node */
-	if (net->friend_addr)
-		return;
-
 	hdr = NET_OP_SEG_ACKNOWLEDGE << OPCODE_HDR_SHIFT;
 	hdr |= sar->seqZero << SEQ_ZERO_HDR_SHIFT;
 
@@ -1947,8 +1942,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 
 		if (sar_in->flags == expected) {
 			/* Re-Send ACK for full msg */
-			if (!net->friend_addr)
-				send_net_ack(net, sar_in, expected);
+			send_net_ack(net, sar_in, expected);
 			return true;
 		}
 	} else {
@@ -1966,8 +1960,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		sar_in->key_aid = key_aid;
 		sar_in->len = len;
 		sar_in->last_seg = 0xff;
-		if (!net->friend_addr)
-			sar_in->msg_timeout = l_timeout_create(MSG_TO,
+		sar_in->msg_timeout = l_timeout_create(MSG_TO,
 					inmsg_to, net, NULL);
 
 		l_debug("First Seg %4.4x", sar_in->flags);
@@ -1994,8 +1987,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 
 	if (sar_in->flags == expected) {
 		/* Got it all */
-		if (!net->friend_addr)
-			send_net_ack(net, sar_in, expected);
+		send_net_ack(net, sar_in, expected);
 
 		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
 				sar_in->remote, dst,
@@ -2014,15 +2006,12 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		l_timeout_remove(sar_in->seg_timeout);
 
 		/* if this is the largest outstanding segment, send NAK now */
-		if (!net->friend_addr) {
-			largest = (0xffffffff << segO) & expected;
-			if ((largest & sar_in->flags) == largest)
-				send_net_ack(net, sar_in, sar_in->flags);
+		largest = (0xffffffff << segO) & expected;
+		if ((largest & sar_in->flags) == largest)
+			send_net_ack(net, sar_in, sar_in->flags);
 
-			sar_in->seg_timeout = l_timeout_create(SEG_TO,
+		sar_in->seg_timeout = l_timeout_create(SEG_TO,
 				inseg_to, net, NULL);
-		} else
-			largest = 0;
 	} else
 		largest = 0;
 
@@ -2752,7 +2741,7 @@ static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
 {
-	if (!net || !IS_UNASSIGNED(net->friend_addr))
+	if (!net)
 		return false;
 
 	if (net->beacon_enable == enable)
@@ -2924,33 +2913,6 @@ void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr)
 			0, 0, 0, msg, n);
 }
 
-/* TODO: change to use net index */
-bool mesh_net_set_friend(struct mesh_net *net, uint16_t friend_addr)
-{
-	if (!net)
-		return false;
-
-	net->bea_id = 0;
-
-	l_info("Set Frnd addr: %4.4x", friend_addr);
-	if (!friend_addr)
-		trigger_heartbeat(net, FEATURE_LPN, false);
-	else
-		trigger_heartbeat(net, FEATURE_LPN, true);
-
-	net->friend_addr = friend_addr;
-
-	return true;
-}
-
-uint16_t mesh_net_get_friend(struct mesh_net *net)
-{
-	if (!net)
-		return 0;
-
-	return net->friend_addr;
-}
-
 bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst)
 {
 	struct mesh_destination *dest = l_queue_find(net->destinations,
@@ -3493,8 +3455,6 @@ uint16_t mesh_net_get_features(struct mesh_net *net)
 		features |= FEATURE_PROXY;
 	if (net->friend_enable)
 		features |= FEATURE_FRIEND;
-	if (net->friend_addr != UNASSIGNED_ADDRESS)
-		features |= FEATURE_LPN;
 
 	return features;
 }
diff --git a/mesh/net.h b/mesh/net.h
index 90ca8328b..07b87830d 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -279,8 +279,6 @@ void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq);
 uint16_t mesh_net_get_address(struct mesh_net *net);
 bool mesh_net_register_unicast(struct mesh_net *net,
 					uint16_t unicast, uint8_t num_ele);
-bool mesh_net_set_friend(struct mesh_net *net, uint16_t friend_addr);
-uint16_t mesh_net_get_friend(struct mesh_net *net);
 uint8_t mesh_net_get_num_ele(struct mesh_net *net);
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
-- 
2.21.0

