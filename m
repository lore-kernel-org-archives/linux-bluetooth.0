Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 21:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE345207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHSVsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:48:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:17684 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHSVsF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 17:48:05 -0400
IronPort-SDR: Yr3GIvBu0vxLDTBkCfzlkjEBGmK/VB5tWfs306NrcmN9eSv8egQkifc1owEYALA/MtjLY/Bnf0
 0H9GV3tA44OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142834216"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142834216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:48:04 -0700
IronPort-SDR: gkIEOAl4gQv6ZJ5AuBXrudZDx7Cjt8NL5YXekRdcuOIh6uRg+K/aBw/+FtshatbtHSTBEx20bJ
 mZTom9o58ZBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="297357612"
Received: from aupasani-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.81.12])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2020 14:48:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Send correct NetKey index in DevKeyMessageReceived
Date:   Wed, 19 Aug 2020 14:48:02 -0700
Message-Id: <20200819214802.83756-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The value of net_index in DevKeyMessageReceived() method must be set
to the value of a subnet index on which a device key encoded message
has been received. Was hard coded to 0. Fixed.
---
 mesh/model.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index b44e2f669..9529dfb2e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -965,7 +965,8 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
 				 decrypt_idx == APP_IDX_DEV_LOCAL)
 				send_dev_key_msg_rcvd(node, i, src, decrypt_idx,
-						0, forward.size, forward.data);
+							net_idx, forward.size,
+								forward.data);
 		}
 
 		/*
-- 
2.26.2

