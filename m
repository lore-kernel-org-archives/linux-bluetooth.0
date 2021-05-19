Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA86C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26B761364
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhESAL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 20:11:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:41857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234061AbhESAL7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 20:11:59 -0400
IronPort-SDR: 1NVBmOGLNw9/ZW4yFjA3ZDneuHZ/Z+2cWoU2EQ0/MmaFwnT7Yq3JMhcF2ohXZ8GP7bXpLOcI5Q
 AmpE3VKxrNXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200900089"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200900089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:36 -0700
IronPort-SDR: KUWrUWX0Zmo8BW/DvGrbL7KADaA8hFGPs2alphIb+NRo9F+eecty/UekdT4WnTUy9hfigmMK3F
 fLynP0zmTT8A==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439707707"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.0.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:34 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/4] mesh: Fix delivery of PB-ACK to acceptors
Date:   Tue, 18 May 2021 17:10:24 -0700
Message-Id: <20210519001027.1540720-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519001027.1540720-1-brian.gix@intel.com>
References: <20210519001027.1540720-1-brian.gix@intel.com>
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

