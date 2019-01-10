Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CCAC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2573213F2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 23:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfAJXWe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:22:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:52349 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbfAJXWe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 18:22:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 15:22:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="scan'208";a="310860936"
Received: from bgix-dell-lap.sea.intel.com ([10.254.56.254])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2019 15:22:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: remove uneeded BDADDR type check
Date:   Thu, 10 Jan 2019 15:22:28 -0800
Message-Id: <20190110232229.22630-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BT_HCI_EVT_LE_ADV_REPORT only comes from legal LE events
---
 mesh/mesh-io-generic.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 48e47e7a4..670c7ab97 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -130,10 +130,6 @@ static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
 	if (evt->event_type != 0x03)
 		return;
 
-	if (evt->addr_type != BDADDR_LE_PUBLIC &&
-			evt->addr_type != BDADDR_LE_RANDOM)
-		return;
-
 	instant = get_instant();
 	adv = evt->data;
 	adv_len = evt->data_len;
-- 
2.14.5

