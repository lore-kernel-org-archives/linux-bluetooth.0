Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70337C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44ED0207C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 01:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFIBdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:33:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:26321 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgFIBdb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 21:33:31 -0400
IronPort-SDR: 0zAto5SkUwtc37m5gXMWC+KBMMbxMQV87tR/D98zDcVK4xRERnoWx8lSoQvolG2ULa1ggdfh3U
 XLZrnnvqcpFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 18:33:31 -0700
IronPort-SDR: uN5KGo77NtrNl+Q/0EkntBQVCfrIm3QqmWwO0XojNajnBk4XJGeRJjT7zR+vMmnRQM8TcXcvjo
 fUrqBdnaPSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="274431346"
Received: from vrsuryad-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.38])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 18:33:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Delete unused function
Date:   Mon,  8 Jun 2020 18:33:25 -0700
Message-Id: <20200609013325.42467-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
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

