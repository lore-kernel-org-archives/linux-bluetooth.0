Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348374AbiC3VTn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiC3VTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 17:19:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BA3C712
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648675076; x=1680211076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9mC0Bh5eJ1gy2H7V4iHJQZbmEXcqWdqmKL8lkkoVBy8=;
  b=Rii1F9k+Hjyy5Fr8pFx9lWvjgqL3W9yLq/1FgsNwkCgxqf4+/ibKJodv
   cpxCBN0rfzhaI0um+Ali2cpu+pRDfNVgKGuFNXxz2uUkyt75hgnFLcQNx
   DNOd4JFAtyckzTABgrGKejTNZ/b50C5g3YfULntzFG1/UldI52Abd2jLC
   aensIjMMt4f/NLG9L3XsT7+cZL1YiXyDPWBFdf1s3izSAYIGmVHsxtErk
   HFS4ESxpeoCb1s3fngZTabAwj8n+Z8jUKxTN3xFeSk7SCwrTtgvjvyvs7
   1I1NDO7uWDCqzz7SMa+xTyjNkDlXxAIrl8osPgVS8Zme8vU82Iangyno7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259832305"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259832305"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565828310"
Received: from almille1-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.169.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:17:54 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     brian.gix@intel.com, linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: use explicit uint32_t when bit shifting left
Date:   Wed, 30 Mar 2022 14:17:47 -0700
Message-Id: <20220330211747.48759-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This addresses a situation when a boolean type is represented by
an integer and performing a left shift on a boolean causes
an integer overflow.

This fixes the following runtime error:
"left shift of 1 by 31 places cannot be represented in type 'int'"
---
 mesh/crypto.c |  5 ++++-
 mesh/net.c    | 12 ++++++------
 mesh/net.h    |  8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index da227ebbb..668d16877 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -553,8 +553,11 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	n = 9;
 
 	if (!ctl) {
-		hdr = segmented << SEG_HDR_SHIFT;
+		uint32_t tmp = segmented ? 0x1 : 0;
+
+		hdr = tmp << SEG_HDR_SHIFT;
 		hdr |= (key_aid & KEY_ID_MASK) << KEY_HDR_SHIFT;
+
 		if (segmented) {
 			hdr |= szmic << SZMIC_HDR_SHIFT;
 			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
diff --git a/mesh/net.c b/mesh/net.c
index df82b2655..8ff3ef32e 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1375,7 +1375,7 @@ static void friend_ack_rxed(struct mesh_net *net, uint32_t iv_index,
 {
 	uint32_t hdr = l_get_be32(pkt) &
 		((SEQ_ZERO_MASK << SEQ_ZERO_HDR_SHIFT) | /* Preserve SeqZero */
-		 (true << RELAY_HDR_SHIFT));		/* Preserve Relay bit */
+		 ((uint32_t) 0x01 << RELAY_HDR_SHIFT)); /* Preserve Relay bit */
 	uint32_t flags = l_get_be32(pkt + 3);
 	struct mesh_friend_msg frnd_ack = {
 		.ctl = true,
@@ -1410,14 +1410,14 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 	expected = 0xffffffff >> (31 - SEG_TOTAL(hdr));
 
 	/* Clear Hdr bits that don't apply to Seg ACK */
-	hdr &= ~((true << SEG_HDR_SHIFT) |
+	hdr &= ~(((uint32_t) 0x01 << SEG_HDR_SHIFT) |
 			(OPCODE_MASK << OPCODE_HDR_SHIFT) |
-			(true << SZMIC_HDR_SHIFT) |
+			((uint32_t) 0x01 << SZMIC_HDR_SHIFT) |
 			(SEG_MASK << SEGO_HDR_SHIFT) |
 			(SEG_MASK << SEGN_HDR_SHIFT));
 
 	hdr |= NET_OP_SEG_ACKNOWLEDGE << OPCODE_HDR_SHIFT;
-	hdr |= true << RELAY_HDR_SHIFT;
+	hdr |= (uint32_t) 0x01 << RELAY_HDR_SHIFT;
 
 	/* Clear all unexpected bits */
 	flags &= expected;
@@ -1454,7 +1454,7 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 	hdr |= sar->seqZero << SEQ_ZERO_HDR_SHIFT;
 
 	if (is_lpn_friend(net, src))
-		hdr |= true << RELAY_HDR_SHIFT;
+		hdr |= (uint32_t) 0x01 << RELAY_HDR_SHIFT;
 
 	l_put_be32(hdr, msg);
 	l_put_be32(flags, msg + 3);
@@ -1726,7 +1726,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		}
 
 		if (szmic || size > 15) {
-			hdr |= true << SEG_HDR_SHIFT;
+			hdr |= (uint32_t) 0x01 << SEG_HDR_SHIFT;
 			hdr |= szmic << SZMIC_HDR_SHIFT;
 			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
 			hdr |= SEG_MAX(true, size) << SEGN_HDR_SHIFT;
diff --git a/mesh/net.h b/mesh/net.h
index 1c2b5e7c6..0bacbbbbf 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -37,7 +37,7 @@ struct mesh_node;
 #define SEGMENTED	0x80
 #define UNSEGMENTED	0x00
 #define SEG_HDR_SHIFT	31
-#define IS_SEGMENTED(hdr)	(!!((hdr) & (true << SEG_HDR_SHIFT)))
+#define IS_SEGMENTED(hdr)	(!!((hdr) & ((uint32_t) 0x1 << SEG_HDR_SHIFT)))
 
 #define KEY_ID_MASK	0x7f
 #define KEY_AID_MASK	0x3f
@@ -45,7 +45,7 @@ struct mesh_node;
 #define KEY_AID_SHIFT	0
 #define AKF_HDR_SHIFT	30
 #define KEY_HDR_SHIFT	24
-#define HAS_APP_KEY(hdr)	(!!((hdr) & (true << AKF_HDR_SHIFT)))
+#define HAS_APP_KEY(hdr)	(!!((hdr) & ((uint32_t) 0x1 << AKF_HDR_SHIFT)))
 
 #define OPCODE_MASK	0x7f
 #define OPCODE_HDR_SHIFT	24
@@ -55,8 +55,8 @@ struct mesh_node;
 #define SZMIC_HDR_SHIFT	23
 #define SEQ_ZERO_MASK	0x1fff
 #define SEQ_ZERO_HDR_SHIFT	10
-#define IS_RELAYED(hdr)	(!!((hdr) & (true << RELAY_HDR_SHIFT)))
-#define HAS_MIC64(hdr)	(!!((hdr) & (true << SZMIC_HDR_SHIFT)))
+#define IS_RELAYED(hdr)	(!!((hdr) & ((uint32_t) 0x1 << RELAY_HDR_SHIFT)))
+#define HAS_MIC64(hdr)	(!!((hdr) & ((uint32_t) 0x1 << SZMIC_HDR_SHIFT)))
 
 #define SEG_MASK	0x1f
 #define SEGO_HDR_SHIFT	5
-- 
2.35.1

