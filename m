Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E93C43600
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86A56135A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhESTLD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 15:11:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:6668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhESTLA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 15:11:00 -0400
IronPort-SDR: PPe4iNLl37GBVI2RRUi2RHEXIJOLMoiWmFvrt0BfPS1VM/1Bc5YLinYpTBMUnNxmfP8BjsgVKR
 PJqYuLPD9scQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="262284404"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262284404"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:09:38 -0700
IronPort-SDR: 8CtRwYFHadFQWVilAP6qT1tLD6/XYLROwbNwQ4ceE67jgIjFTITMsziL+BBn/bcYLR1Ld7BKtU
 Ru7N0CPT+lYw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439855277"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:09:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 6/6] mesh: Fix race condition memory leak
Date:   Wed, 19 May 2021 12:09:25 -0700
Message-Id: <20210519190925.1723012-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519190925.1723012-1-brian.gix@intel.com>
References: <20210519190925.1723012-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a minor fix of a memory leak triggered on process exit if
proceess has been killed right after requesting an outbound
advertisement be sent.  It is harmless, but will cause an occasional
static analysis failure.
---
 mesh/mesh-io-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 4eb7f27ce..6c0b8f0fd 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -462,7 +462,9 @@ static bool dev_destroy(struct mesh_io *io)
 	bt_hci_unref(pvt->hci);
 	l_timeout_remove(pvt->tx_timeout);
 	l_queue_destroy(pvt->rx_regs, l_free);
+	l_queue_remove_if(pvt->tx_pkts, simple_match, pvt->tx);
 	l_queue_destroy(pvt->tx_pkts, l_free);
+	l_free(pvt->tx);
 	l_free(pvt);
 	io->pvt = NULL;
 
-- 
2.25.4

