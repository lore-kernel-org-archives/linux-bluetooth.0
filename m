Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E2C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708DD2089F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405373AbfBNDpd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:45:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:19361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395434AbfBNDpc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 22:45:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 19:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="274927365"
Received: from ingas-nuc1.sea.intel.com ([10.254.99.167])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 19:45:31 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] mesh: Return correct error code for AppKey List command
Date:   Wed, 13 Feb 2019 19:45:27 -0800
Message-Id: <20190214034527.6310-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214034527.6310-1-inga.stotland@intel.com>
References: <20190214034527.6310-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If AppKey List command is called with a network key index that
is not valid for the node, return Invalid NetKey Index error code
---
 mesh/appkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index f799b7782..3cc1e4f0b 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -506,6 +506,9 @@ uint8_t appkey_list(struct mesh_net *net, uint16_t net_idx, uint8_t *buf,
 
 	*size = 0;
 
+	if (!mesh_net_have_key(net, net_idx))
+		return MESH_STATUS_INVALID_NETKEY;
+
 	app_keys = mesh_net_get_app_keys(net);
 	if (!app_keys || l_queue_isempty(app_keys))
 		return MESH_STATUS_SUCCESS;
-- 
2.17.2

