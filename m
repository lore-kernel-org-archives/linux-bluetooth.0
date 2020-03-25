Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC7C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E519206F6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYRyr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:54:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:14239 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgCYRyr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 13:54:47 -0400
IronPort-SDR: J9L4UcPBgX12KyKL4OxMe9iBMc0BZ1EyO4OhpjzIyVdqdJUcCH+mpvvL+K6HxuGgrXO87eTQnE
 ae3XNdxIejUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 10:54:46 -0700
IronPort-SDR: 7sFdqCh6kA15nLIJ8B9BSFcM8zh/cVfplr/Ml6iixtSZLAiudvsTbsuSBwOmw6PvqmU8qQS0eh
 UwsQBfCOA3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="270886572"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.164.143])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 10:54:46 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        prathyusha.n@samsung.com
Subject: [PATCH BlueZ v2] mesh: Handle close for Acceptor
Date:   Wed, 25 Mar 2020 10:54:40 -0700
Message-Id: <20200325175440.19925-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Provision complete callback is handled in provision failure case.
If link closed received abruptly with reason success, triggered
provision complete callback. Removed session timeout and session
free as they are handled in pb_adv_unreg.
---
 mesh/pb-adv.c        | 14 +-------------
 mesh/prov-acceptor.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 6ef45b8b0..291d92651 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -223,9 +223,6 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
-	l_timeout_remove(session->tx_timeout);
-	session->tx_timeout = NULL;
-
 	mesh_send_cancel(filter, sizeof(filter));
 
 	l_info("TX timeout");
@@ -392,17 +389,8 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		break;
 
 	case PB_ADV_CLOSE:
-		l_timeout_remove(session->tx_timeout);
 		l_debug("Link closed notification: %2.2x", pkt[0]);
-		/* Wrap callback for pre-cleaning */
-		if (true) {
-			mesh_prov_close_func_t cb = session->close_cb;
-			void *user_data = session->user_data;
-
-			l_queue_remove(pb_sessions, session);
-			l_free(session);
-			cb(user_data, pkt[0]);
-		}
+		session->close_cb(session->user_data, pkt[0]);
 		break;
 
 	case PB_ADV_ACK:
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 903abc2ff..5231616ee 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -120,7 +120,18 @@ static void acceptor_free(void)
 
 static void acp_prov_close(void *user_data, uint8_t reason)
 {
-	/* TODO: Handle Close */
+	struct mesh_prov_acceptor *rx_prov = user_data;
+
+	if (rx_prov != prov)
+		return;
+
+	if (reason == PROV_ERR_SUCCESS)
+		reason = PROV_ERR_UNEXPECTED_ERR;
+
+	if (prov->cmplt)
+		prov->cmplt(prov->caller_data, reason, NULL);
+
+	prov->cmplt = NULL;
 	acceptor_free();
 }
 
-- 
2.21.1

