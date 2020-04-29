Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86089C83004
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671C921707
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 18:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD2SFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:05:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:16766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2SFs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 14:05:48 -0400
IronPort-SDR: IA4YRqR7uzzIsd2ljz2gEfqQug+vio1PeJn/Vg9nOSc4pioLC1suXSA74VzjUdYvVm+dkk2maT
 HJ0X/8BEy6Nw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 11:05:47 -0700
IronPort-SDR: yYxHS+qGoNKZu6sjDOSslm6REKivQZvSBt333ixD2r4bRZrw5xiqkQ+J/qs3HzimBgeEAOiEm3
 OlbDBkar1pDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="249520208"
Received: from ingas-nuc1.sea.intel.com ([10.255.228.82])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 11:05:45 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix adding virtual subscription to a vendor model
Date:   Wed, 29 Apr 2020 11:05:41 -0700
Message-Id: <20200429180541.29791-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a case when a configuration server receives a virtual
subscription add/overwrite command targeting a vendor model.
Correctly set "vendor" argument before trying to save the updated
subscrition to configuration file.
---
 mesh/cfgmod-server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 856eb6b27..94825ed0e 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -358,6 +358,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 	case 22:
 		if (!virt)
 			return;
+		vendor = true;
 		mod_id = l_get_le16(pkt + 18) << 16;
 		mod_id |= l_get_le16(pkt + 20);
 		break;
-- 
2.21.1

