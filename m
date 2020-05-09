Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD5C54E49
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278B0217BA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEIAA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 20:00:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:65495 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEIAA3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 20:00:29 -0400
IronPort-SDR: HKNgkBykTiYCpD300QYiRJquypcTJUx6tR10jEbTMx8Ytfd1/doOdQLEphGVrC5Ik3cpzLq+oj
 CoDoUATfkN7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 17:00:28 -0700
IronPort-SDR: nhvmxNV6WfY4j/zlroV9OY66zEWxkbldyePVncR8VYBFea9kYHChZVc/yEsSqI6ghPxBVCvreD
 3cKGV6UKK5ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="408275107"
Received: from ingas-nuc1.sea.intel.com ([10.254.110.242])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 17:00:28 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] mesh: Remove redundant call to save node configuration
Date:   Fri,  8 May 2020 17:00:24 -0700
Message-Id: <20200509000024.5704-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509000024.5704-1-inga.stotland@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes a redundant call to save node configuration in
add_local_node(): there is a number of unconditional calls to
mesh_config_write_<some_node_Setting>() within this function
which would result in the node configuration being saved implicitly.
---
 mesh/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index a96c0cae1..8914b639d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1366,8 +1366,6 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	update_net_settings(node);
 
-	mesh_config_save(node->cfg, true, NULL, NULL);
-
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 
-- 
2.21.3

