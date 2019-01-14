Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6DAC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029120657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 23:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANXFc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:05:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:5526 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfANXFc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 18:05:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 15:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="125889918"
Received: from bgix-nuc-2.sea.intel.com ([10.251.144.91])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2019 15:05:31 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Cleanup PB-ADV transport on Prov Close
Date:   Mon, 14 Jan 2019 15:05:24 -0800
Message-Id: <20190114230524.22506-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

PB-ADV always used for provisioning, so must always  be cleaned up.
---
 mesh/prov-acceptor.c  | 5 +----
 mesh/prov-initiator.c | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index d983991d4..3d4d93ba4 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -126,10 +126,7 @@ static void acceptor_free(void)
 	mesh_send_cancel(bec_filter, sizeof(bec_filter));
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
 
-	if (prov->trans_tx) {
-		if (prov->transport == PB_ADV)
-			pb_adv_unreg(prov->trans_data);
-	}
+	pb_adv_unreg(prov);
 
 	l_free(prov);
 	prov = NULL;
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 669cf340d..d915f2aaf 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -122,6 +122,8 @@ static void initiator_free(void)
 
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
 
+	pb_adv_unreg(prov);
+
 	l_free(prov);
 	prov = NULL;
 }
-- 
2.20.1

