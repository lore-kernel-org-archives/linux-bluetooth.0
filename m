Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2066C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99795207E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Pwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:52:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:63644 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2Pwo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jul 2020 11:52:44 -0400
IronPort-SDR: jsfo0hs3NWOczz6wZw+AUjnj70/cbXiIqtLO+zbXxJhP6yFphSclJoLfwsEOkV5ffOp7ojS48e
 GEAZePiVxO/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149283067"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="149283067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 08:52:43 -0700
IronPort-SDR: MvvlNpOmdFWKilwNfBISpyZB4Rf0AMkkzQNWe4WoRGlP3pP9kPrE8JjtxPbbbbALyGom0T5R8d
 0TXsUzks3+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="330443559"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.114.231])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2020 08:52:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, mike@mnmoran.org
Subject: [PATCH BlueZ] mesh: Add guard against wedging outbound queue
Date:   Wed, 29 Jul 2020 08:52:34 -0700
Message-Id: <20200729155234.547679-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using HCI command chains, the first packet send that starts an
outbound sequence needs to still exist when command chain completes, or
the outbound queue will wedge.  The simplest solution is to send packets
at least twice on an empty queue, if there is a chance it could be canceled.
---
 mesh/mesh-io-generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 86952516e..4b26b1181 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -714,6 +714,14 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 			sending = !l_queue_isempty(pvt->tx_pkts);
 
 		l_queue_push_tail(pvt->tx_pkts, tx);
+
+		/*
+		 * If transmitter is idle, send packets at least twice to
+		 * guard against in-line cancelation of HCI command chain.
+		 */
+		if (info->type == MESH_IO_TIMING_TYPE_GENERAL && !sending &&
+							tx->info.u.gen.cnt == 1)
+			tx->info.u.gen.cnt++;
 	}
 
 	if (!sending) {
-- 
2.25.4

