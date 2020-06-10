Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CABC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C4E2072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgFJRLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:11:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:8721 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgFJRLZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:11:25 -0400
IronPort-SDR: r21OQpim6oAdAs3Nr2hNDTJ8GZM8dmWq9NDpc5QLQsUWBy2umvjs2DLE9+iIQBVEffmTXgFJYt
 vvreAO8KE7DQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:11:23 -0700
IronPort-SDR: viRrnd2uNKODHgkTOIAhImwEP8n3PvNoZ5N6NqfFUYBheml73SGjg8ugo6x6/5Q+DMRRZN4ylA
 mEY6uGenEyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="259340080"
Received: from unknown (HELO ingas-nuc1.sea.intel.com) ([10.254.72.48])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2020 10:11:23 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 1/5] mesh: Delete unused function
Date:   Wed, 10 Jun 2020 10:11:17 -0700
Message-Id: <20200610171121.46910-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171121.46910-1-inga.stotland@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This deletes unused function node_is_provisioned()
---
 mesh/node.c | 5 -----
 mesh/node.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index db888d27c..d1d4da23d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -598,11 +598,6 @@ bool node_is_provisioner(struct mesh_node *node)
 	return node->provisioner;
 }
 
-bool node_is_provisioned(struct mesh_node *node)
-{
-	return (!IS_UNASSIGNED(node->primary));
-}
-
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx)
 {
diff --git a/mesh/node.h b/mesh/node.h
index 290681e28..e26d410c8 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -39,7 +39,6 @@ struct mesh_node *node_find_by_addr(uint16_t addr);
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
 struct mesh_node *node_find_by_token(uint64_t token);
 bool node_is_provisioner(struct mesh_node *node);
-bool node_is_provisioned(struct mesh_node *node);
 void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 							uint16_t app_idx);
 uint16_t node_get_primary(struct mesh_node *node);
-- 
2.26.2

