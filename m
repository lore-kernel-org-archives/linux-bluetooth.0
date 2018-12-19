Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B110C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BD021871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeLSEV1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:21:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:4182 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbeLSEV1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:21:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820218"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:21:26 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 16/30] mesh: Make config model handle multiple nodes
Date:   Tue, 18 Dec 2018 20:20:02 -0800
Message-Id: <20181219042016.25538-17-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
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

