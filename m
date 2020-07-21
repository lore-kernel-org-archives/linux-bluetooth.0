Return-Path: <SRS0=Dy9H=BA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B88C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6720771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgGUTra (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:47:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:39317 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbgGUTra (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 15:47:30 -0400
IronPort-SDR: hOJlr7WdZ/u1336KoBUTByjGS1iAk8XRJccq1UpvhKILELXzZzjp5GfPY5t5h+CI3uxY4hXNef
 Yh0xuk4DO1zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="130302173"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="130302173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 12:47:29 -0700
IronPort-SDR: HzoQ2ZMwb6biFBrO8qdJzCR27jjM7JykOxhu0AmiGiS65w6DPhUB7yEXVCMqScsKlPU31J/4wb
 LD7tYuMQ5Jrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="362476037"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.78.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2020 12:47:29 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix memory leak on provisioning timeout
Date:   Tue, 21 Jul 2020 12:47:24 -0700
Message-Id: <20200721194724.230809-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the Provision Acceptor times out without completing successfully, the
timer it was using was never freed.
---
 mesh/prov-acceptor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 5231616ee..96f7e15ad 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -143,6 +143,7 @@ static void prov_to(struct l_timeout *timeout, void *user_data)
 	if (rx_prov != prov)
 		return;
 
+	l_timeout_remove(prov->timeout);
 	prov->timeout = NULL;
 
 	if (prov->cmplt && prov->trans_tx) {
-- 
2.25.4

