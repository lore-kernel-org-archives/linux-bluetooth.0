Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2FC433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84D320855
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 01:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHGBik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:38:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:43991 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgHGBik (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 21:38:40 -0400
IronPort-SDR: ZhO1qK3v0M8UvGVylBiQeE+p+s/1AXu4WvB2oxZPsKKw80M8NFCb8tF5QOtJ5MBZ4Q3mgVHe1a
 OI+YHt6N1+gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140558039"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140558039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 18:38:39 -0700
IronPort-SDR: qyNlTQOi2tGnFqTthXPQL+HdbKtTsaFNNi0lL0lUCAFWhz4jYO7hyJ9AzoZ7ko/fZshmhiBRDo
 8eBfFb98kMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="397442075"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.119.50])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2020 18:38:39 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 03/10] mesh: Clean up handling of config node identity message
Date:   Thu,  6 Aug 2020 18:38:27 -0700
Message-Id: <20200807013834.123263-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807013834.123263-1-inga.stotland@intel.com>
References: <20200807013834.123263-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 992279165..82938dc83 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -777,11 +777,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_NODE_IDENTITY_SET:
-		if (size != 3 || pkt[2] > 0x01)
-			return true;
-
-		n_idx = l_get_le16(pkt);
-		if (n_idx > 0xfff)
+		if (size != 3)
 			return true;
 
 		/* Currently setting node identity not supported */
@@ -789,18 +785,15 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_NODE_IDENTITY_GET:
-		if (size < 2)
+		if (opcode == OP_NODE_IDENTITY_GET && size != 2)
 			return true;
 
 		n_idx = l_get_le16(pkt);
-		if (n_idx > 0xfff)
+		if (n_idx > NET_IDX_MAX)
 			return true;
 
 		n = mesh_model_opcode_set(OP_NODE_IDENTITY_STATUS, msg);
-
-		status = mesh_net_get_identity_mode(net, n_idx, &state);
-
-		msg[n++] = status;
+		msg[n++] = mesh_net_get_identity_mode(net, n_idx, &state);
 
 		l_put_le16(n_idx, msg + n);
 		n += 2;
-- 
2.26.2

