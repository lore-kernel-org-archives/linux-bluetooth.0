Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F47C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A820640
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLCVEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:04:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:15597 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfLCVEc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 16:04:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 13:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="208575193"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.44.42])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2019 13:04:32 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        prathyusha.n@samsung.com
Subject: [PATCH BlueZ v2 2/3] mesh: Rearrange PB-ACK for possible session close
Date:   Tue,  3 Dec 2019 13:04:09 -0800
Message-Id: <20191203210410.25548-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203210410.25548-1-brian.gix@intel.com>
References: <20191203210410.25548-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In certain circumstances, reception of PB-ADV messages may trigger
session close. This rearrange ACKs new verified messages before
performing call-back to avoid situations where the session no longer
exists after the message has been handled.

This caused static analysis errors during provisioning, which are now
addressed.
---
 mesh/net.c    | 1 -
 mesh/pb-adv.c | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 61dd8be32..a60327272 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2381,7 +2381,6 @@ static enum _relay_advice packet_received(void *user_data,
 		l_info("RX: App 0x%04x -> 0x%04x : TTL 0x%02x : SEQ 0x%06x",
 					net_src, net_dst, net_ttl, net_seq);
 
-		l_debug("seq:%x seq0:%x", net_seq, net_seqZero);
 		if (net_ctl) {
 			l_debug("CTL - %4.4x RX", net_seqZero);
 			if (net_opcode == NET_OP_SEG_ACKNOWLEDGE) {
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 586cd7f15..27cbc469e 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -254,7 +254,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 	uint8_t type;
 	bool first;
 
-	if (!session || pb_session != session)
+	if (!pb_session || pb_session != session)
 		return;
 
 	link_id = l_get_be32(pkt + 1);
@@ -426,14 +426,14 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 			return;
 		}
 
+		send_ack(session, session->peer_trans_num);
+
 		if (session->last_peer_trans_num != session->peer_trans_num) {
 			session->got_segs = 0;
+			session->last_peer_trans_num = session->peer_trans_num;
 			session->rx_cb(session->user_data, session->sar,
 							session->exp_len);
 		}
-
-		session->last_peer_trans_num = session->peer_trans_num;
-		send_ack(session, session->last_peer_trans_num);
 	}
 }
 
-- 
2.21.0

