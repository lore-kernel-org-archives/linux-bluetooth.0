Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC05C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02536124C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhESSXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:23:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:32191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhESSXa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:23:30 -0400
IronPort-SDR: JYECfz9NyGyneCdTdzlBx3aFKFzyPPj0RaB6fjt0JhDkRlvq36HeKn8Dcu6ajVyoOHxJybLrfw
 5ucj7+SRWoxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188175119"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188175119"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:09 -0700
IronPort-SDR: B7XPx9d/xJ/Q3mf2CyV99hcDuj1zxRbwvjTMu8/LE/htgDv12pDrI77vUNPAivwaZcEjC77ZCt
 05JyaQS9Nc9g==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439838647"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:08 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 1/5] mesh: Fix delivery of PB-ACK to acceptors
Date:   Wed, 19 May 2021 11:21:46 -0700
Message-Id: <20210519182150.1680987-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519182150.1680987-1-brian.gix@intel.com>
References: <20210519182150.1680987-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rwmove unneeded initialization that prevented the Acceptor roll of ever
recognizing a valid PB-ACK.
---
 mesh/pb-adv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index c74dae79f..83f922aa8 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -358,7 +358,6 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		first = !session->link_id;
 		session->link_id = link_id;
 		session->last_peer_trans_num = 0xFF;
-		session->local_acked = 0xFF;
 		session->peer_trans_num = 0x00;
 		session->local_trans_num = 0x7F;
 		session->opened = true;
-- 
2.25.4

