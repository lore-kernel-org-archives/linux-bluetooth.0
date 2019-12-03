Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766AFC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642520640
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLCVE1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:04:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:39152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfLCVE0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 16:04:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 13:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="208575178"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.44.42])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2019 13:04:25 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        prathyusha.n@samsung.com
Subject: [PATCH BlueZ v2 1/3] mesh: Fix to send close indication on timeout
Date:   Tue,  3 Dec 2019 13:04:08 -0800
Message-Id: <20191203210410.25548-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203210410.25548-1-brian.gix@intel.com>
References: <20191203210410.25548-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

If pb_session is freed in timeout, close indication will not be sent.
pb_session is freed in pb_adv_unreg() and hence removed from tx_timeout.
Added acceptor_free() in acp_prov_close() to ensure pb_session is freed.
---
 mesh/pb-adv.c        | 2 --
 mesh/prov-acceptor.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 19d14532a..586cd7f15 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -175,8 +175,6 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	l_info("TX timeout");
 	cb = pb_session->close_cb;
 	user_data = pb_session->user_data;
-	l_free(pb_session);
-	pb_session = NULL;
 	cb(user_data, 1);
 }
 
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index bca019358..03972c227 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -121,6 +121,7 @@ static void acceptor_free(void)
 static void acp_prov_close(void *user_data, uint8_t reason)
 {
 	/* TODO: Handle Close */
+	acceptor_free();
 }
 
 static void prov_to(struct l_timeout *timeout, void *user_data)
-- 
2.21.0

