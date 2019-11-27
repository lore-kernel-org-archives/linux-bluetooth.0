Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C08C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285EF2154A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 21:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfK0Vjv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:39:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:15279 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbfK0Vju (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 16:39:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 13:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="207008629"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.135.67])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2019 13:39:50 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 1/2] mesh: clean-up Recieved Message debug output
Date:   Wed, 27 Nov 2019 13:39:38 -0800
Message-Id: <20191127213939.4526-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127213939.4526-1-brian.gix@intel.com>
References: <20191127213939.4526-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For each received packet, this change limits outputing the encrypted
version once, and the decrypted version once per applicable local node.
---
 mesh/net.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 33b498135..0283a782c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -255,6 +255,7 @@ struct net_queue_data {
 	uint32_t key_id;
 	uint32_t iv_index;
 	uint16_t len;
+	bool seen;
 };
 
 struct net_beacon_data {
@@ -2321,22 +2322,15 @@ static enum _relay_advice packet_received(void *user_data,
 	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
 	struct mesh_friend *net_frnd = NULL;
-	bool drop = false;
-
-	/* Tester--Drop 90% of packets */
-	/* l_getrandom(&iv_flag, 1); */
-	/* if (iv_flag%10<9) drop = true; */
-
 
 	memcpy(packet + 2, data, size);
 
-	if (!drop)
-		print_packet("RX: Network [clr] :", packet + 2, size);
-
 	net_idx = key_id_to_net_idx(net, key_id);
 	if (net_idx == NET_IDX_INVALID)
 		return RELAY_NONE;
 
+	print_packet("RX: Network [clr] :", packet + 2, size);
+
 	if (!mesh_crypto_packet_parse(packet + 2, size,
 					&net_ctl, &net_ttl,
 					&net_seq,
@@ -2377,11 +2371,6 @@ static enum _relay_advice packet_received(void *user_data,
 	if (is_us(net, net_src, true))
 		return RELAY_NONE;
 
-	if (drop) {
-		l_info("Dropping SEQ 0x%06x", net_seq);
-		return RELAY_NONE;
-	}
-
 	l_debug("check %08x", cache_cookie);
 
 	/* As a Relay, suppress repeats of last N packets that pass through */
@@ -2512,7 +2501,10 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (!key_id)
 		return;
 
-	print_packet("RX: Network [enc] :", data->data, data->len);
+	if (!data->seen) {
+		data->seen = true;
+		print_packet("RX: Network [enc] :", data->data, data->len);
+	}
 
 	if (data->info) {
 		net->instant = data->info->instant;
@@ -2542,6 +2534,7 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 		.data = data + 1,
 		.len = len - 1,
 		.relay_advice = RELAY_NONE,
+		.seen = false,
 	};
 
 	if (len < 9)
-- 
2.21.0

