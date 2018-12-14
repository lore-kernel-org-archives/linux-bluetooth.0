Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC0EC43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78B12080F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbeLNWsY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:48:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:9397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbeLNWsX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 17:48:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 14:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="100810026"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2018 14:48:22 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ 16/30] mesh: Make config model handle multiple nodes
Date:   Fri, 14 Dec 2018 14:47:39 -0800
Message-Id: <20181214224753.2892-17-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181214224753.2892-1-brian.gix@intel.com>
References: <20181214224753.2892-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/cfgmod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index bedb0c6f6..c849923ca 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -95,4 +95,4 @@
 #define OP_VEND_MODEL_APP_GET			0x804C
 #define OP_VEND_MODEL_APP_LIST			0x804E
 
-void mesh_config_srv_init(struct mesh_net *net, uint8_t ele_idx);
+void mesh_config_srv_init(struct mesh_node *node, uint8_t ele_idx);
-- 
2.14.5

