Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD4C43613
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDC72184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeLRWcJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:32:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:60668 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeLRWby (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704181"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:51 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 16/30] mesh: Make config model handle multiple nodes
Date:   Tue, 18 Dec 2018 14:31:25 -0800
Message-Id: <20181218223139.8041-17-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
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

