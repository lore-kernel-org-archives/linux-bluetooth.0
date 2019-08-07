Return-Path: <SRS0=c51M=WD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD35C32751
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BC6217F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfHGUGq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:06:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:40938 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfHGUGq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Aug 2019 16:06:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 13:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="182382960"
Received: from ingas-nuc1.sea.intel.com ([10.255.95.214])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2019 13:06:42 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix double free of a pointer in mesh-io-generic
Date:   Wed,  7 Aug 2019 13:06:36 -0700
Message-Id: <20190807200636.19614-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a crash in bluetooth-meshd due to freeing the same pointer
twice. The fix is to initialize the address of freed TX buffer to NULL.
---
 mesh/mesh-io-generic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 576c5df1b..cc91f494e 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -654,8 +654,12 @@ static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 			tx = l_queue_remove_if(pvt->tx_pkts, find_by_ad_type,
 							L_UINT_TO_PTR(data[0]));
 			l_free(tx);
+
+			if (tx == pvt->tx)
+				pvt->tx = NULL;
+
 		} while (tx);
-	}  else {
+	} else {
 		struct tx_pattern pattern = {
 			.data = data,
 			.len = len
@@ -665,6 +669,10 @@ static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 			tx = l_queue_remove_if(pvt->tx_pkts, find_by_pattern,
 								&pattern);
 			l_free(tx);
+
+			if (tx == pvt->tx)
+				pvt->tx = NULL;
+
 		} while (tx);
 	}
 
-- 
2.21.0

