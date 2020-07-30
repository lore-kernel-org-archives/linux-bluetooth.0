Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936C3C433E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7199B2173E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgG3UjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:39:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:35036 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgG3Ui7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 16:38:59 -0400
IronPort-SDR: LorYiRARARr8OmO+o2ztxayJe2QHnj3t7DEjCnzonglHQKFoT5EPl+TBhVRxQMaQZ07O1OCXE/
 h/B9mAxDUV1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169803099"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="169803099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 13:38:58 -0700
IronPort-SDR: 0nDAtzDAU6c8Bkc5TJmhhu+OulQY8kJo93NT6mXE+vyG2XmxCSZGmYExXaCfRsuzu3IM7V9wvA
 f5zV1La8KOeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330864957"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 13:38:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 03/10] mesh: Clean up handling of config node identity message
Date:   Thu, 30 Jul 2020 13:38:44 -0700
Message-Id: <20200730203851.32043-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730203851.32043-1-inga.stotland@intel.com>
References: <20200730203851.32043-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 6621d0935..1cd0bcdd5 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -774,11 +774,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
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
@@ -786,18 +782,13 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		/* Fall Through */
 
 	case OP_NODE_IDENTITY_GET:
-		if (size < 2)
+		if (opcode == OP_NODE_IDENTITY_GET && size != 2)
 			return true;
 
 		n_idx = l_get_le16(pkt);
-		if (n_idx > 0xfff)
-			return true;
 
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

