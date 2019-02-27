Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6113C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B4F2186A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfB0SNF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:13:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:49398 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfB0SNF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 13:13:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 10:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="118248042"
Received: from bgix-dell-lap.sea.intel.com ([10.252.202.228])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2019 10:13:04 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ] mesh: Fix type checking for 32 vs 64 bit systems
Date:   Wed, 27 Feb 2019 10:12:55 -0800
Message-Id: <20190227181255.5982-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/cfgmod-server.c | 2 +-
 mesh/model.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 992d4ac6a..9dc82eef6 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -1129,7 +1129,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		gettimeofday(&time_now, NULL);
 		time_now.tv_sec -= hb->sub_start;
 
-		if (time_now.tv_sec >= hb->sub_period)
+		if (time_now.tv_sec >= (long int) hb->sub_period)
 			time_now.tv_sec = 0;
 		else
 			time_now.tv_sec = hb->sub_period - time_now.tv_sec;
diff --git a/mesh/model.c b/mesh/model.c
index 1e302b73b..5940f6854 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -414,15 +414,15 @@ static void cmplt(uint16_t remote, uint8_t status,
 
 	gettimeofday(&tx_end, NULL);
 	if (tx_end.tv_sec == tx_start.tv_sec) {
-		l_debug("Duration 0.%zu seconds",
+		l_debug("Duration 0.%6.6lu seconds",
 				tx_end.tv_usec - tx_start.tv_usec);
 	} else {
 		if (tx_start.tv_usec > tx_end.tv_usec)
-			l_debug("Duration %zu.%zu seconds",
+			l_debug("Duration %lu.%6.6lu seconds",
 				tx_end.tv_sec - tx_start.tv_sec - 1,
 				tx_end.tv_usec + 1000000 - tx_start.tv_usec);
 		else
-			l_debug("Duration %zu.%zu seconds",
+			l_debug("Duration %lu.%6.6lu seconds",
 					tx_end.tv_sec - tx_start.tv_sec,
 					tx_end.tv_usec - tx_start.tv_usec);
 	}
-- 
2.14.5

