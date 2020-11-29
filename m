Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737BC3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FD12078D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2FTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 00:19:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:28965 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK2FTZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 00:19:25 -0500
IronPort-SDR: S5DoUqn3yy+cmrLVLlFve2zW153s3gJ6Sz9QAAKt2H/rchGkP8cwCfFwUUZoVDJn58OQ8fsdbC
 eVtfic2jcFXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="159565827"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="159565827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 21:18:45 -0800
IronPort-SDR: HEPtU1eXWfKbhOruL9kFRckyHlbgn/gxCpqyQ2dycbEF7Dzj7JxQGiwKH0iDDa7jp1K4a0krkq
 TKi150ivv56w==
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="548573595"
Received: from brayanix-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.42.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 21:18:44 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, sbrown@ewol.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix check for mkdir return value
Date:   Sat, 28 Nov 2020 21:18:38 -0800
Message-Id: <20201129051838.82091-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This correctly interprets the return value of mkdir():
0 for success.
---
 mesh/keyring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 1ef4fc3ef..38b0152f7 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -51,7 +51,7 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
 
-	if (!mkdir(key_file, 0755))
+	if (mkdir(key_file, 0755) != 0)
 		return false;
 
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
@@ -88,7 +88,7 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
 
-	if (!mkdir(key_file, 0755))
+	if (mkdir(key_file, 0755) != 0)
 		return false;
 
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
@@ -207,7 +207,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
 
-	if (!mkdir(key_file, 0755))
+	if (mkdir(key_file, 0755) != 0)
 		return false;
 
 	for (i = 0; i < count; i++) {
-- 
2.26.2

