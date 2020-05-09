Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD4C47255
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC93E217BA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgEIAA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 20:00:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:65492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgEIAA0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 20:00:26 -0400
IronPort-SDR: 0nQV3sRBNzkHYJ/YibmfbHq5M8LMFgUnglwxmnjlIDu/5AWXtwXdzsHqSPBy5PkTy2n8dSheOq
 ZBvKCbeKwOwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 17:00:26 -0700
IronPort-SDR: LhcSlBqa2YAPTY4Ho88ji0wupgObXiIP5BOJyVmPYhvsI1Iwp+nWlknJU2Y8gzbeW7H54AEhHb
 3WkA8ZAt2uKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="408275091"
Received: from ingas-nuc1.sea.intel.com ([10.254.110.242])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 17:00:26 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4] mesh: On node attach, verify element/model composition only
Date:   Fri,  8 May 2020 17:00:21 -0700
Message-Id: <20200509000024.5704-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509000024.5704-1-inga.stotland@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When attaching an existing node, verify only the "elements" part
of device composition, i.e., skip verification of CID/PID/VID, CRPL
and features.
---
 mesh/node.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index acda6d472..e3f9e52e3 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1378,7 +1378,7 @@ static bool check_req_node(struct managed_obj_request *req)
 {
 	uint8_t node_comp[MAX_MSG_LEN - 2];
 	uint8_t attach_comp[MAX_MSG_LEN - 2];
-
+	uint16_t offset = 10;
 	uint16_t node_len = node_generate_comp(req->node, node_comp,
 							sizeof(node_comp));
 
@@ -1389,12 +1389,10 @@ static bool check_req_node(struct managed_obj_request *req)
 		uint16_t attach_len = node_generate_comp(req->attach,
 					attach_comp, sizeof(attach_comp));
 
-		/* Ignore feature bits in Composition Compare */
-		node_comp[8] = 0;
-		attach_comp[8] = 0;
-
+		/* Verify only element/models composition */
 		if (node_len != attach_len ||
-				memcmp(node_comp, attach_comp, node_len)) {
+				memcmp(&node_comp[offset], &attach_comp[offset],
+							node_len - offset)) {
 			l_debug("Failed to verify app's composition data");
 			return false;
 		}
-- 
2.21.3

