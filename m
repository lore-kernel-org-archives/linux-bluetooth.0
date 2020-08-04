Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0FFC433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6551A207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHDURt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:17:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:64989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHDURs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 16:17:48 -0400
IronPort-SDR: QruiDq78fjaIlbxRNxYaTwQCzBEFD1B5jhfZUsy4OBco/beYh11cRtKYxH2EtDrm2GUkHgOGXf
 CbVbHPohtI8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153565377"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="153565377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 13:17:46 -0700
IronPort-SDR: 1v5ZKe0Eu8t3XtIK+GMdk/vgSrNPNWRdnPc1RU3YR/lLJbXb4eVIVNMZom93iuRjqyZZ8JOz2K
 +pqeEpsg4mxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="324783831"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.65])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 13:17:46 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 03/10] mesh: Clean up handling of config node identity message
Date:   Tue,  4 Aug 2020 13:17:37 -0700
Message-Id: <20200804201744.23327-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804201744.23327-1-inga.stotland@intel.com>
References: <20200804201744.23327-1-inga.stotland@intel.com>
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
index 35d0325a9..c501b0a52 100644
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
@@ -789,18 +785,13 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
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

