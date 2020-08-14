Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30747C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1213F20768
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHNTNn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:13:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:2112 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgHNTNn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:13:43 -0400
IronPort-SDR: z3XemW9hYiGKrHgEB5aSKGWEXKQ2gudejEbXDi+1beMHBsYrQVXvgo9gTA7e8+Em0LjZy53KvL
 rcO4Ddq+lDhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="218806298"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="218806298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 12:13:42 -0700
IronPort-SDR: Z+GmXw5H+Vnec/Y3umde71aF80CRFaJ7rSCcuRL56QkhSVeebWE0P9y8lqDKfPKECIE89YZOO/
 ZtyOcrKrlFyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="327983431"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.85.168])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2020 12:13:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@gmail.com,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] mesh: fix double-free of outbound tx data
Date:   Fri, 14 Aug 2020 12:13:39 -0700
Message-Id: <20200814191339.955528-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to the asyncronous multi-step process to send a packet on an HCI
socket, an outbound packet could be superceded before send procedure
is completed.  This change ensures that at any stage in the process,
that the pointer to the packet has been fully disposed.
---
 mesh/mesh-io-generic.c | 52 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 4b26b1181..67b13a1b9 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -329,6 +329,30 @@ static void scan_disable_rsp(const void *buf, uint8_t size,
 			set_recv_scan_enable, pvt, NULL);
 }
 
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool find_by_ad_type(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	uint8_t ad_type = L_PTR_TO_UINT(b);
+
+	return !ad_type || ad_type == tx->pkt[0];
+}
+
+static bool find_by_pattern(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	const struct tx_pattern *pattern = b;
+
+	if (tx->len < pattern->len)
+		return false;
+
+	return (!memcmp(tx->pkt, pattern->data, pattern->len));
+}
+
 static bool find_active(const void *a, const void *b)
 {
 	const struct pvt_rx_reg *rx_reg = a;
@@ -533,8 +557,10 @@ static void set_send_adv_data(const void *buf, uint8_t size,
 					&cmd, sizeof(cmd),
 					set_send_adv_enable, pvt, NULL);
 done:
-	if (tx->delete)
+	if (tx->delete) {
+		l_queue_remove_if(pvt->tx_pkts, simple_match, tx);
 		l_free(tx);
+	}
 
 	pvt->tx = NULL;
 }
@@ -569,8 +595,11 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 {
 	struct bt_hci_cmd_le_set_adv_enable cmd;
 
-	if (pvt->tx && pvt->tx->delete)
+	/* Delete superseded packet in favor of new packet */
+	if (pvt->tx && pvt->tx != tx && pvt->tx->delete) {
+		l_queue_remove_if(pvt->tx_pkts, simple_match, pvt->tx);
 		l_free(pvt->tx);
+	}
 
 	pvt->tx = tx;
 	pvt->interval = interval;
@@ -733,25 +762,6 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 	return true;
 }
 
-static bool find_by_ad_type(const void *a, const void *b)
-{
-	const struct tx_pkt *tx = a;
-	uint8_t ad_type = L_PTR_TO_UINT(b);
-
-	return !ad_type || ad_type == tx->pkt[0];
-}
-
-static bool find_by_pattern(const void *a, const void *b)
-{
-	const struct tx_pkt *tx = a;
-	const struct tx_pattern *pattern = b;
-
-	if (tx->len < pattern->len)
-		return false;
-
-	return (!memcmp(tx->pkt, pattern->data, pattern->len));
-}
-
 static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 {
 	struct mesh_io_private *pvt = io->pvt;
-- 
2.25.4

