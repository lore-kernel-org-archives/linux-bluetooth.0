Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355920AbiASPtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:49:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:20020 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242648AbiASPtt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 10:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642607389; x=1674143389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P6j1sAIQNdblWh02gxi5FPlE5H+sTkhaZrXur8i4cJ8=;
  b=Ft0eK3MVxl+jdilbayOfp+Eq9u2R6aPy46wNM4ePVfz/pWQ43D0oAbPs
   CT8M/PF7WQ24mq9K3CqH1Lv64iVbfFWXdVD3YiHegHttxrATEdnh9pC8M
   u//umi3enYjz3JIuc/+MnpYjFWfo9j9c/G0K9a5WSkbZkcI6cbzrJBBuG
   8HeWH61wry07hk4B5NBPyvq61E7dEzY5e45nrkc6j46Xo1E7dTlO0a1T4
   EAVaqV6OJdaPjVqK5ztpJv3ulItcc0bauGMH01OcPMJuffrN1gqgo3vCi
   AigGPgaPiPxHSaiYUwR4E0ecmQpDHGz4QPwoCTnbWdyFJsWwjc3yXdZ4r
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244890820"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="244890820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:49:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="493067226"
Received: from cihalawe-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.39.215])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:49:47 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, karl.westin@loytec.com,
        inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Fix sequence number of message in friend queue
Date:   Wed, 19 Jan 2022 07:49:31 -0800
Message-Id: <20220119154931.182497-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As pointed out by https://github.com/bluez/bluez/issues/250, the last
segment of a multi-segmented message added to Friend Queue was getting
reset to the seqAuth value incorrectly. The correct sequence was set
within the preceding for loop.
---
 mesh/net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index aa220f762..dd5398487 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1325,7 +1325,6 @@ static bool friend_packet_queue(struct mesh_net *net,
 			hdr += (1 << SEGO_HDR_SHIFT);
 		}
 
-		frnd_msg->u.s12[seg_max].seq = seq;
 		frnd_msg->cnt_in = seg_max;
 		frnd_msg->last_len = size % 12;
 		if (!frnd_msg->last_len)
-- 
2.31.1

