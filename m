Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368EAC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC162083D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 04:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfDRENJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:13:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:31247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfDRENJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 00:13:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 21:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; 
   d="scan'208";a="150341735"
Received: from ingas-nuc1.sea.intel.com ([10.252.198.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2019 21:13:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix network information cleanup
Date:   Wed, 17 Apr 2019 21:13:06 -0700
Message-Id: <20190418041306.18815-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes issues caused by accessing invalidated entries of nets
queue that were left around when removing network info in
mesh_net_detach()
---
 mesh/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/net.c b/mesh/net.c
index b173e1c09..9b1fbd81e 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3120,6 +3120,7 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_NET);
 
 	net->io = NULL;
+	l_queue_remove(nets, net);
 
 	return io;
 }
-- 
2.17.2

